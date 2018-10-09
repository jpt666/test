
//
//  CookBaseProxy.m
//  CookBook
//
//  Created by zhangxi on 16/4/15.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "CookBaseProxy.h"
#import "FastCoder.h"
#import "UploadCookDataRequest.h"
#import "CookDataManager.h"
#import "UIImage+Resize.h"

@implementation CookBaseProxy
{
    UploadCookDataRequest * _uploadDataRequest;
    NSString * _baseDataRequestUrl;
    RequestMethodType _methodType;
    
    NSMutableDictionary * _dictCopyForCancel;
}

-(instancetype)initWithDictionary:(NSMutableDictionary *)dict
{
    self = [super init];
    if (self) {
        self.dictBaseInfo = dict;
        
//        self.cookPhotoProxy = [[CookPhotoProxy alloc] initWithImages:[NSMutableArray array]];
//        self.cookPhotoProxy.delegate = self;
        
        self.cookDataStatus = CookDataStatusDraft;
        self.delegate = [CookDataManager shareInstance];
    }
    return self;
}

-(instancetype)initWithImages:(NSArray *)images
{
    self = [super init];
    if (self) {
//        images = [self compressImageArray:images];
        self.cookPhotoProxy = [[CookPhotoProxy alloc] initWithImages:images];
        self.cookPhotoProxy.delegate = self;
        
        self.cookDataStatus = CookDataStatusDraft;
        
        self.delegate = [CookDataManager shareInstance];
    }
    return self;
}

-(instancetype)initWithBaseData:(NSData *)baseData imagesData:(NSData *)imagesData;
{
    self = [super init];
    if (self) {
        self.dictBaseInfo = [FastCoder objectWithData:baseData];
        self.cookPhotoProxy = [[CookPhotoProxy alloc] initWithImagesData:imagesData];
        self.cookPhotoProxy.delegate = self;
        
        self.cookDataStatus = CookDataStatusDraft;
        
        self.delegate = [CookDataManager shareInstance];
    }
    return self;
}

-(void)appendImages:(NSArray *)images
{
//    images = [self compressImageArray:images];
    [self.cookPhotoProxy appendImages:images];
}

//-(instancetype)initWithBaseData:(NSData *)baseData frontImagePath:(NSString *)frontImagePath andImagesData:(NSData *)imagesData;
//{
//    self = [super init];
//    if (self) {
//        self.dictBaseInfo = [FastCoder objectWithData:baseData];
//        self.cookPhotoProxy = [[CookPhotoProxy alloc] initWithFrontImagePath:frontImagePath andImagesData:imagesData];
//        self.cookPhotoProxy.delegate = self;
//    }
//    return self;
//}

-(NSData *)baseData
{
    return [FastCoder dataWithRootObject:self.dictBaseInfo];
}

//-(NSString *)frontImagePath
//{
//    return [self.cookPhotoProxy frontImagePath];
//}

-(NSData *)extendData
{
    return nil;
}

-(NSData *)imagesData
{
    return [self.cookPhotoProxy imagesData];
}

-(UIImage *)frontImage
{
    return [self.cookPhotoProxy getFrontImage];
}

-(void)replaceImage:(UIImage *)image atIndex:(NSInteger )index
{
//    if (image.size.width>DefaultFixScreenWidth) {
//        image = [image resizedImage:CGSizeMake(DefaultFixScreenWidth, image.size.height/(image.size.width/DefaultFixScreenWidth)) interpolationQuality:kCGInterpolationHigh];
//    }
    [self.cookPhotoProxy replaceImage:image atIndex:index];
}

-(long long)editTime
{
    return 0;
}

-(NSString *)dishName
{
    return nil;
}

-(void)setDishName:(NSString *)dishName
{
    
}

-(NSString *)cookDescription
{
    return nil;
}

-(NSMutableArray *)tips
{
    return nil;
}

-(NSMutableArray *)foodMaterials
{
    return nil;
}

-(void)prepareData
{
    
}

-(void)setRequestMethodType:(RequestMethodType)methodType
{
    _methodType = methodType;
}

-(void)setBaseDataRequestUrl:(NSString *)url
{
    _baseDataRequestUrl = url;
}

-(void)uploadBaseData
{
    [self prepareData];
    
    if (_uploadDataRequest) {
        [_uploadDataRequest cancel];
    }
    _uploadDataRequest = [[UploadCookDataRequest alloc] initWithDictionary:self.dictUploadParams];
    _uploadDataRequest.delegate = self;
    [_uploadDataRequest requestWithUrl:_baseDataRequestUrl andMethod:_methodType];
}

-(void)uploadCookData
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didCookWillUpload:)]) {
        [self.delegate didCookWillUpload:self];
    }
    
    [self.cookPhotoProxy uploadImagesData];
}


-(void)saveCookDataAndUploading:(BOOL)bUploading
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didCookPreparedForSave:willUploading:)])
    {
        [self.delegate didCookPreparedForSave:self willUploading:bUploading];
    }
    
    if (bUploading)
    {
        [self uploadCookData];
    }
}

-(void)deleteCookData
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didCookNeedDelete:)]) {
        [self.delegate didCookNeedDelete:self];
    }
}



-(void)getUploadedPhotoInfo:(CookPhotoProxy *)cookPhotoProxy
{
    
}
-(void)cancelUpload
{
    [_cookPhotoProxy cancelUpload];
    
    if (_uploadDataRequest) {
        [_uploadDataRequest cancel];
        _uploadDataRequest = nil;
    }
}

-(void)startEdit
{
    [_cookPhotoProxy startEdit];
}

-(void)cancelEdit
{
    [_cookPhotoProxy cancelEdit];
}

-(BOOL)dataIsReady
{
    return [_cookPhotoProxy dataIsReady];
}

-(NSArray *)compressImageArray:(NSArray *)arrOrg
{
    return arrOrg;
    
//    NSMutableArray * arrNew = [NSMutableArray array];
//    for (UIImage *image in arrOrg) {
//        UIImage *newImage = image;
//        if (image.size.width>DefaultFixScreenWidth) {
//            newImage = [image resizedImage:CGSizeMake(DefaultFixScreenWidth, image.size.height/(image.size.width/DefaultFixScreenWidth)) interpolationQuality:kCGInterpolationHigh];
//        }
//        [arrNew addObject:newImage];
//    }
//    
//    return arrNew;
}

#pragma mark CookPhotoProxyDelegate

-(void)didPhotoUploadSuccess:(CookPhotoProxy *)cookPhotoProxy
{
    if (cookPhotoProxy != self.cookPhotoProxy) {
        return;
    }
    [self getUploadedPhotoInfo:cookPhotoProxy];
    
    [self uploadBaseData];
}

-(void)didPhotoUploadFailed:(CookPhotoProxy *)cookPhotoProxy
{
    if (cookPhotoProxy != self.cookPhotoProxy) {
        return;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didCookUploadFailed:)]) {
        [self.delegate didCookUploadFailed:self];
    }
}

-(void)didPhotoUploadProgress:(CookPhotoProxy *)cookPhotoProxy
{
    if (cookPhotoProxy != self.cookPhotoProxy) {
        return;
    }
    
    self.uploadingProgress = cookPhotoProxy.progress*0.99;
    NSLog(@"======%f", self.uploadingProgress);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didCookUploadProcess:)]) {
        [self.delegate didCookUploadProcess:self];
    }
    
}

#pragma mark UploadRequestDelegate
-(void)didUploadDataSuccess:(UploadRequest *)request
{
    if (request != _uploadDataRequest) {
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.delegate && [self.delegate respondsToSelector:@selector(didCookUploadSuccess:)]) {
            [self.delegate didCookUploadSuccess:self];
        }
    });
}

-(void)didUploadDataFailed:(UploadRequest *)request
{
    if (request != _uploadDataRequest) {
        return;
    }
    
//    [self uploadBaseData];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didCookUploadFailed:)]) {
        [self.delegate didCookUploadFailed:self];
    }
}

-(void)diduploadDataProgress:(UploadRequest *)request
{
    if (request != _uploadDataRequest) {
        return;
    }
    
    self.uploadingProgress += (request.progress*0.01);
    
    NSLog(@"======%f", self.uploadingProgress);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didCookUploadProcess:)]) {
        [self.delegate didCookUploadProcess:self];
    }
}
@end
