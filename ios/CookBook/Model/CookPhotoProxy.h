//
//  CookBook.h
//  CookBook
//
//  Created by zhangxi on 16/4/13.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CookPhoto.h"
#import "UploadImageRequest.h"

@class CookPhotoProxy;

@protocol CookPhotoProxyDelegate <NSObject>

-(void)didPhotoUploadSuccess:(CookPhotoProxy *)cookPhotoProxy;
-(void)didPhotoUploadFailed:(CookPhotoProxy *)cookPhotoProxy;
-(void)didPhotoUploadProgress:(CookPhotoProxy *)cookPhotoProxy;

@end


@interface CookPhotoProxy : NSObject<UploadRequestDelegate>

@property (nonatomic, weak) id<CookPhotoProxyDelegate> delegate;
@property (nonatomic, strong) NSMutableArray<CookPhoto *> *arrLoaclPhotos;
@property (nonatomic, strong) NSMutableArray<NSMutableDictionary *> *arrCookPhotosInfo;
//@property (nonatomic, strong) UIImage *  frontImage;
//@property (nonatomic, strong) NSString * frontImageMd5;

@property (nonatomic, strong) NSString * cookDataId;

@property (nonatomic, assign) BOOL bUploadFinish;

@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, strong) NSError * error;

- (instancetype)initWithImages:(NSArray *)images;

//- (instancetype)initWithFrontImagePath:(NSString *)frontImagePath andImagesData:(NSData *)data;

- (instancetype)initWithImagesData:(NSData *)data;


- (instancetype)initWithPhotoStep:(NSMutableArray *)arrPhotoInfo frontUrl:(NSString *)frontUrl andFrontMd5:(NSString *)frontMd5;

//- (instancetype)initWithPhotoInfo:(NSMutableArray *)arrPhotoInfo;
//-(void)uploadDataForCook:(NSString *)cookId;

-(void)appendImages:(NSArray *)arrImages;

-(void)uploadImagesData;

-(void)cancelUpload;

-(NSData *)imagesData;

-(NSString *)getFrontImageMd5;

-(UIImage *)getFrontImage;

-(void)setFrontImage:(UIImage *)image;

-(void)replaceImage:(UIImage *)image atIndex:(NSInteger )index;

-(void)exchangeImageIndex:(NSInteger)fromTndex withImageIndex:(NSInteger)toIndex;

-(void)removeImageAtIndex:(NSInteger)index;

-(void)startEdit;

-(void)cancelEdit;

-(BOOL)dataIsReady;

//-(NSString *)frontImagePath;
//
//-(void)imagesFromData:(NSData *)data;

//- (void)test;

@end
