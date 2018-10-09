//
//  DataManager.m
//  CookBook
//
//  Created by zhangxi on 16/4/11.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "CookDataManager.h"
#import "NSMutableDictionary+CookBook.h"
#import "CookBookProxy.h"
#import "CookProductProxy.h"
#import "DBManager.h"
#import "UserManager.h"
#import "GlobalVar.h"



@implementation CookDataManager
{
    NSMutableDictionary * _dictCookDataForUpload;
    NSMutableDictionary * _dictCookDraft;
}

+(CookDataManager *)shareInstance
{
    static CookDataManager * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class]alloc] init];        
    });
    return instance;
}

-(void)recoverCookUploading
{
    if (!_dictCookDataForUpload) {
        _dictCookDataForUpload = [NSMutableDictionary dictionary];
    }
    
    [self retrieveCookDataDrafts];
    
    for (CookBaseProxy * cbProxy in [_dictCookDraft allValues]) {
        if (cbProxy.cookDataStatus == CookDataStatusUploadError) {
            [cbProxy uploadCookData];
        }
    }
}

-(CookBaseProxy *)convertCookDataFromDictionary:(NSMutableDictionary *)dict
{
    if (!dict) {
        return nil;
    }
    CookType type = [dict[kDBKeyCookType] integerValue];
    CookBaseProxy * cbProxy;
    if (type == CookBookType) {
        cbProxy = [[CookBookProxy alloc] initWithBaseData:dict[kDBKeyBaseData] imagesData:dict[kDBKeyImagesData]];
    } else if (type == CookProductType) {
        cbProxy = [[CookProductProxy alloc] initWithBaseData:dict[kDBKeyBaseData] imagesData:dict[kDBKeyImagesData]];
    }
    cbProxy.cookDataStatus = [dict[kDBKeyStatus] integerValue];
    
    return cbProxy;
}

-(NSArray *)retrieveCookDataDrafts
{
    if (!_dictCookDraft) {
        _dictCookDraft = [NSMutableDictionary dictionary];
        _dictCookDataForUpload = [NSMutableDictionary dictionary];

        NSMutableArray *arr = [[DBManager shareInstance] queryCookDataWithCookerId:[NSString stringWithFormat:@"%ld",[UserManager shareInstance].curUser.userId]];
        for (NSMutableDictionary *d in arr) {
            
            CookBaseProxy * cbProxy = [self convertCookDataFromDictionary:d];

//            if (cbProxy.cookDataStatus != CookDataStatusUploading) {
                _dictCookDraft[cbProxy.cookBaseId] = cbProxy;
//            } else
                if (cbProxy.cookDataStatus == CookDataStatusUploading &&
                ![_dictCookDataForUpload objectForKey:cbProxy.cookBaseId]) {
                
                [cbProxy uploadCookData];
            }
        }
    }
    
    return [_dictCookDraft allValues];
}

-(void)clearCookDataDrafts
{
    [_dictCookDraft removeAllObjects];
    _dictCookDraft = nil;
}

-(void)clearPhotoForCookData:(NSString *)cookDataId
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *imagesDir = [[GlobalVar shareGlobalVar].photosDirectory stringByAppendingPathComponent:cookDataId];
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:imagesDir error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    NSString *filename;
    while ((filename = [e nextObject])) {
        [fileManager removeItemAtPath:[imagesDir stringByAppendingPathComponent:filename] error:NULL];
    }
}

-(void)recoverCookDataDraft:(NSString *)cookDataId
{
    NSMutableDictionary * d = [[DBManager shareInstance] queryCookDataDraft:cookDataId];
    CookBaseProxy * cbProxy = [self convertCookDataFromDictionary:d];
    
    if (cbProxy) {
    
//    if (cbProxy && cbProxy.cookDataStatus != CookDataStatusUploading) {
        _dictCookDraft[cbProxy.cookBaseId] = cbProxy;
//    } else {
//    }
    }
}


- (BOOL)saveCookData:(CookBaseProxy *)cookBaseProxy
{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[kDBKeyCookDataId] = cookBaseProxy.cookBaseId;
    dict[kDBKeyCookerId] = [NSString stringWithFormat:@"%ld",[UserManager shareInstance].curUser.userId];
    dict[kDBKeyBaseData] = [cookBaseProxy baseData];
//    dict[kDBkeyFrontImage] = [cookBookProxy frontImagePath];
    dict[kDBKeyImagesData] = [cookBaseProxy imagesData];
    dict[kDBKeyExtendData] = [cookBaseProxy extendData];
    dict[kDBKeyStatus] = @(cookBaseProxy.cookDataStatus);
    
    if ([cookBaseProxy isKindOfClass:[CookBookProxy class]]) {
        dict[kDBKeyCookType] = @(CookBookType);
    } else if ([cookBaseProxy isKindOfClass:[CookProductProxy class]]) {
        dict[kDBKeyCookType] = @(CookProductType);
    }
    
    return [[DBManager shareInstance] saveCookDataDraft:dict];
}

#pragma mark CookBaseProxyDelegate

-(void)didCookPreparedForSave:(CookBaseProxy *)cookBaseProxy willUploading:(BOOL)bUploading
{
    cookBaseProxy.cookDataStatus = CookDataStatusDraft;
    _dictCookDraft[cookBaseProxy.cookBaseId] = cookBaseProxy;
    [self saveCookData:cookBaseProxy];
    
//    if (!bUploading) {
        if (_delegate && [_delegate respondsToSelector:@selector(didLocalCookDataChanged:)]) {
            [_delegate didLocalCookDataChanged:self];
        }
//    }
}

-(void)didCookWillUpload:(CookBaseProxy *)cookBaseProxy
{
    cookBaseProxy.cookDataStatus = CookDataStatusUploading;
    cookBaseProxy.uploadingProgress = 0.0;
    
//    [_dictCookDraft removeObjectForKey:cookBaseProxy.cookBaseId];
    _dictCookDataForUpload[cookBaseProxy.cookBaseId] = cookBaseProxy;
    [[DBManager shareInstance] updateCookDataDraft:cookBaseProxy.cookBaseId withStatus:CookDataStatusUploading];
    
    if (_delegate && [_delegate respondsToSelector:@selector(didLocalCookDataChanged:)]) {
        [_delegate didLocalCookDataChanged:self];
    }
}

-(void)didCookUploadSuccess:(CookBaseProxy *)cookBaseProxy
{
    if ([cookBaseProxy isKindOfClass:[CookBookProxy class]]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_REFRESH_COOK_CUISINE object:nil];
    } else if ([cookBaseProxy isKindOfClass:[CookProductProxy class]]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_REFRESH_COOK_PRODUCT object:nil];
    }
    
    [[DBManager shareInstance] deleteCookDataDraft:cookBaseProxy.cookBaseId];
    [_dictCookDraft removeObjectForKey:cookBaseProxy.cookBaseId];
    [_dictCookDataForUpload removeObjectForKey:cookBaseProxy.cookBaseId];
    
    [self clearPhotoForCookData:cookBaseProxy.cookBaseId];
    
    if (_delegate && [_delegate respondsToSelector:@selector(didLocalCookDataChanged:)]) {
        [_delegate didLocalCookDataChanged:self];
    }
    
}

-(void)didCookUploadFailed:(CookBaseProxy *)cookBaseProxy
{
    cookBaseProxy.cookDataStatus = CookDataStatusUploadError;
//    [_dictCookDataForUpload removeObjectForKey:cookBaseProxy.cookBaseId];
//    _dictCookDraft[cookBaseProxy.cookBaseId] = cookBaseProxy;
    [[DBManager shareInstance] updateCookDataDraft:cookBaseProxy.cookBaseId withStatus:CookDataStatusUploadError];
    
    if (_delegate && [_delegate respondsToSelector:@selector(didLocalCookDataChanged:)]) {
        [_delegate didLocalCookDataChanged:self];
    }
}

-(void)didCookNeedDelete:(CookBaseProxy *)cookBaseProxy
{
    [self didCookUploadSuccess:cookBaseProxy];
}

-(void)didCookUploadProcess:(CookBaseProxy *)cookBaseProxy
{
    if (_delegate && [_delegate respondsToSelector:@selector(didCookDataUploadProgressChanged:)]) {
        [_delegate didCookDataUploadProgressChanged:cookBaseProxy];
    }
}


@end
