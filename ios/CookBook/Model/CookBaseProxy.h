//
//  CookBaseProxy.h
//  CookBook
//
//  Created by zhangxi on 16/4/15.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CookPhotoProxy.h"

typedef NS_ENUM(NSInteger, CookDataStatus) {
    CookDataStatusDraft = 0,
    CookDataStatusUploading = 1,
    CookDataStatusUploadError = 2
};

typedef NS_ENUM(NSInteger, CookType) {
    CookBookType = 0,
    CookProductType = 1
};

@class CookBaseProxy;

@protocol CookBaseProxyDelegate <NSObject>

-(void)didCookWillUpload:(CookBaseProxy *)cookBaseProxy;
-(void)didCookUploadSuccess:(CookBaseProxy *)cookBaseProxy;
-(void)didCookUploadFailed:(CookBaseProxy *)cookBaseProxy;
-(void)didCookPreparedForSave:(CookBaseProxy *)cookBaseProxy willUploading:(BOOL)bUploading;
-(void)didCookNeedDelete:(CookBaseProxy *)cookBaseProxy;
-(void)didCookUploadProcess:(CookBaseProxy *)cookBaseProxy;
//-(void)SaveCookData:(CookBaseProxy *)cookBaseProxy;

@end

//@protocol CookBaseProxyDataSource <NSObject>
//
//-(NSData *)baseDataForCookProxy:(CookBaseProxy *)cookProxy;
//-(NSString *)frontImagePathForCookProxy:(CookBaseProxy *)cookProxy;
//-(NSData *)ImagesDataForCookProxy:(CookBaseProxy *)cookProxy;
//
//@end


@interface CookBaseProxy : NSObject<UploadRequestDelegate, CookPhotoProxyDelegate>

@property (nonatomic, weak) id<CookBaseProxyDelegate> delegate;
//@property (nonatomic, weak) id<CookBaseProxyDataSource> dataSource;
@property (nonatomic, strong) NSMutableDictionary * dictBaseInfo;
@property (nonatomic, strong) NSMutableDictionary * dictUploadParams;
@property (nonatomic, strong) CookPhotoProxy * cookPhotoProxy;
@property (nonatomic, strong) NSString * cookBaseId;
@property (nonatomic, assign) CookDataStatus cookDataStatus;
@property (nonatomic, assign) CGFloat uploadingProgress;


-(instancetype)initWithImages:(NSArray *)images;

-(instancetype)initWithBaseData:(NSData *)baseData imagesData:(NSData *)imageData;

-(instancetype)initWithDictionary:(NSMutableDictionary *)dict;

-(void)appendImages:(NSArray *)images;

-(NSData *)baseData;

-(NSData *)imagesData;

-(NSData *)extendData;

//-(NSString *)frontImagePath;

-(UIImage *)frontImage;

-(void)replaceImage:(UIImage *)image atIndex:(NSInteger )index;

-(long long)editTime;

-(NSString *)dishName;

-(void)setDishName:(NSString *)dishName;

-(NSString *)cookDescription;

-(NSMutableArray *)foodMaterials;

-(NSMutableArray *)tips;

//-(void)uploadBaseData;

-(void)setRequestMethodType:(RequestMethodType)methodType;

-(void)setBaseDataRequestUrl:(NSString *)url;

-(void)uploadCookData;

-(void)saveCookDataAndUploading:(BOOL)bUploading;

-(void)deleteCookData;

-(void)cancelUpload;

-(void)startEdit;

-(void)cancelEdit;

-(BOOL)dataIsReady;

@end
