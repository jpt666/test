//
//  CookBook.m
//  CookBook
//
//  Created by zhangxi on 16/4/13.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "CookPhotoProxy.h"
#import "NSMutableDictionary+CookBook.h"
#import "CookBookPropertyKeys.h"
#import "FastCoder.h"
#import "NSData+md5.h"
#import "GlobalVar.h"
#import <SDWebImageManager.h>
#import "UIImage+Resize.h"


@implementation CookPhotoProxy
{
    UploadImageRequest * _uploadImageRequest;
    NSMutableArray * _arrLocalCopy;
    
    NSString * _photoDirectoryPath;
    
    BOOL _bHasDiffFront;
    
    CookPhoto * _frontPhoto;
    
    UIImage * _defaultPlaceholdImage;
    
//    UIImage * _frontImage;
}


- (instancetype)initWithImages:(NSArray *)images
{
    self = [super init];
    if (self) {
        
        _defaultPlaceholdImage = [UIImage imageNamed:PLACE_HOLDER_COOK_IMAGE];
        
        _photoDirectoryPath = [GlobalVar shareGlobalVar].photosDirectory;
        
        _bUploadFinish = NO;
//        _frontImage = [images firstObject];
        
        _frontPhoto = [[CookPhoto alloc] init];
        [_frontPhoto setCookPhoto:[images firstObject]];
        
        self.arrLoaclPhotos = [NSMutableArray array];
        for (UIImage *image in images) {
            CookPhoto * localPhoto = [[CookPhoto alloc] init];
            [localPhoto setCookPhoto:image];
            
            [self.arrLoaclPhotos addObject:localPhoto];
        }
    }
    return self;
}

- (instancetype)initWithImagesData:(NSData *)data
{
    self = [super init];
    if (self) {
        _defaultPlaceholdImage = [UIImage imageNamed:PLACE_HOLDER_COOK_IMAGE];
        
        _bUploadFinish = NO;
        _photoDirectoryPath = [GlobalVar shareGlobalVar].photosDirectory;
        
        NSMutableDictionary *d = [FastCoder objectWithData:data];
        self.cookDataId = d[@"cookDataId"];
        
        _frontPhoto = [[CookPhoto alloc] init];
        _frontPhoto.imageMd5 = d[@"frontImageMd5"];
        _frontPhoto.serverUrl = d[@"frontServerUrl"];
        
        if (_frontPhoto.serverUrl) {
            
            UIImage *image = [[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:_frontPhoto.serverUrl];
            
            if (!image) {
                [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:_frontPhoto.serverUrl] options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                    if (image) {
                        _frontPhoto.serverUrl = nil;
                        [_frontPhoto setCookPhoto:image];
                    }
                }];
            } else {
                _frontPhoto.serverUrl = nil;
                [_frontPhoto setCookPhoto:image];
            }
        }
        
//        _frontImage = [UIImage imageWithData:[NSData dataWithContentsOfFile:[[_photoDirectoryPath stringByAppendingPathComponent:self.cookDataId] stringByAppendingPathComponent:d[@"frontImagePath"]]]];
    
        NSMutableArray *arr = d[@"imagesData"];
        _arrLoaclPhotos = [NSMutableArray arrayWithCapacity:arr.count];
        for (NSMutableDictionary *d in arr) {
            CookPhoto *photo = [[CookPhoto alloc] init];
            photo.story = d[@"story"];
            photo.imageMd5 = d[@"imageMd5"];
            
            photo.serverUrl = d[@"serverUrl"];
            if (photo.serverUrl) {
                UIImage *image = [[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:photo.serverUrl];
                if (!image) {
                    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:photo.serverUrl] options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                        if (image) {
                            photo.serverUrl = nil;
                            [photo setCookPhoto:image];
                        }
                    }];
                } else {
                    photo.serverUrl = nil;
                    [photo setCookPhoto:image];
                }
            }
            
//            photo.TextHeight=[d[@"textHeight"] doubleValue];
//            photo.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:d[@"imagePath"]]];
            
//            UIImage *ima = photo.image;
            [_arrLoaclPhotos addObject:photo];
        }
    }
    return self;
}

- (instancetype)initWithPhotoStep:(NSMutableArray *)arrPhotoInfo frontUrl:(NSString *)frontUrl andFrontMd5:(NSString *)frontMd5
{
    self = [super init];
    if (self) {
        
        _defaultPlaceholdImage = [UIImage imageNamed:PLACE_HOLDER_COOK_IMAGE];
        
        _photoDirectoryPath = [GlobalVar shareGlobalVar].photosDirectory;
        
        _bUploadFinish = NO;
        
        _frontPhoto = [[CookPhoto alloc] init];
        
        UIImage *image = [[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:frontUrl];
        if (!image) {
//            image = [UIImage imageNamed:PLACE_HOLDER_COOK_IMAGE];
            _frontPhoto.serverUrl = frontUrl;
            _frontPhoto.imageMd5 = frontMd5;
            [_frontPhoto setCookPhoto:_defaultPlaceholdImage];
            
            [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:frontUrl] options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                if (image) {
                    _frontPhoto.serverUrl = nil;
                    [_frontPhoto setCookPhoto:image];
                }
            }];
            
            
        } else {
            image = [image resizedImageWithThreshold:DefaultFixScreenWidth];
            _frontPhoto.imageMd5 = frontMd5;
            [_frontPhoto setCookPhoto:image];
        }


        self.arrLoaclPhotos = [NSMutableArray array];
        for (NSMutableDictionary *d in arrPhotoInfo) {
            CookPhoto * localPhoto = [[CookPhoto alloc] init];
            
            NSString *url = d[kPhotoPropertyPhotoUrl];
            
            UIImage *image = [[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:url];
            if (!image) {
//                image = [UIImage imageNamed:PLACE_HOLDER_COOK_IMAGE];
                localPhoto.serverUrl = url;
                localPhoto.imageMd5 = d[kPhotoPropertyPhotoMd5];
                [localPhoto setCookPhoto:_defaultPlaceholdImage];
                
                [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:url] options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                    if (image) {
                        localPhoto.serverUrl = nil;
                        [localPhoto setCookPhoto:image];
                    }
                }];
                
            } else {
                image = [image resizedImageWithThreshold:DefaultFixScreenWidth];
                localPhoto.imageMd5 = d[kPhotoPropertyPhotoMd5];
                [localPhoto setCookPhoto:image];
            }
            
            localPhoto.story = d[kPhotoPropertyDescription];
            
            [self.arrLoaclPhotos addObject:localPhoto];
        }
    }
    return self;
}

//- (instancetype)initWithPhotoInfo:(NSMutableArray *)arrPhotoInfo
//{
//    self = [super init];
//    if (self) {
//        _photoDirectoryPath = [GlobalVar shareGlobalVar].photosDirectory;
//        _bUploadFinish = NO;
//
//        self.arrLoaclPhotos = [NSMutableArray array];
//        for (NSDictionary *d in arrPhotoInfo) {
//            
//            
//            
//            CookPhoto * localPhoto = [[CookPhoto alloc] init];
////            [localPhoto setImage:image];
//            
//            [self.arrLoaclPhotos addObject:localPhoto];
//        }
//    }
//    return self;
//}


- (void)appendImages:(NSArray *)arrImages
{
    if (!self.arrLoaclPhotos) {
        self.arrLoaclPhotos = [NSMutableArray array];
    }
    for (UIImage *image in arrImages) {
        CookPhoto * localPhoto = [[CookPhoto alloc] init];
        [localPhoto setCookPhoto:image];
        
        if (!self.arrLoaclPhotos.count) {
//            _frontImage = image;
            
            _frontPhoto = [[CookPhoto alloc] init];
            [_frontPhoto setCookPhoto:image];
        }
        [self.arrLoaclPhotos addObject:localPhoto];
    }
}
//- (instancetype)initWithFrontImagePath:(NSString *)frontImagePath andImagesData:(NSData *)data
//{
//    self = [super init];
//    if (self) {
//        _bUploadFinish = NO;
//        
//        if (frontImagePath) {
//            _frontImage = [UIImage imageWithData:[NSData dataWithContentsOfFile:frontImagePath]];
//        }
//        
//        NSMutableArray *arr = [FastCoder objectWithData:data];
//        _arrLoaclPhotos = [NSMutableArray arrayWithCapacity:arr.count];
//        for (NSMutableDictionary *d in arr) {
//            CookPhoto *photo = [[CookPhoto alloc] init];
//            photo.story = d[@"story"];
//            photo.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:d[@"imagePath"]]];
//            [_arrLoaclPhotos addObject:photo];
//        }
//    }
//    return self;
//}

//-(void)uploadDataForCook:(NSString *)cookId;

-(NSData *)imagesData
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"cookDataId"] = self.cookDataId;
//    dict[@"frontImagePath"] = [self pathForSaveImage:_frontImage withMd5:_frontImageMd5];

    dict[@"frontImageMd5"] = [self pathForSaveImage:[_frontPhoto getImageWithCookDataId:self.cookDataId] withMd5:_frontPhoto.imageMd5];
    
    if (_frontPhoto.serverUrl) {
        dict[@"frontServerUrl"] = _frontPhoto.serverUrl;
        
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:_frontPhoto.serverUrl] options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (image) {
                _frontPhoto.serverUrl = nil;
                [_frontPhoto setCookPhoto:image];
            }
        }];
    }
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:_arrLoaclPhotos.count];
    for (CookPhoto *photo in _arrLoaclPhotos) {
        NSMutableDictionary * dictPhotoInfo = [NSMutableDictionary dictionary];
        dictPhotoInfo[@"story"] = photo.story;
        dictPhotoInfo[@"imageMd5"] = [self pathForSaveImage:[photo getImageWithCookDataId:self.cookDataId] withMd5:photo.imageMd5];
        
        if (photo.serverUrl) {
            dictPhotoInfo[@"serverUrl"] = photo.serverUrl;
            
            [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:photo.serverUrl] options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                if (image) {
                    photo.serverUrl = nil;
                    [photo setCookPhoto:image];
                }
            }];
        }
//        dictPhotoInfo[@"textHeight"]=[NSNumber numberWithDouble:photo.TextHeight];
        [arr addObject:dictPhotoInfo];
    }
    
    dict[@"imagesData"] = arr;
    return [FastCoder dataWithRootObject:dict];
}

-(NSString *)pathForSaveImage:(UIImage *)image withMd5:(NSString *)md5String
{
//    NSData *imageData = UIImagePNGRepresentation(image);
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    if (!md5String) {
        md5String = [imageData md5];
    }
    
    NSString *imagesDir = [_photoDirectoryPath stringByAppendingPathComponent:self.cookDataId];
    [[NSFileManager defaultManager] createDirectoryAtPath:imagesDir withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *photoFilePath = [imagesDir stringByAppendingPathComponent:md5String];
    if (![[NSFileManager defaultManager] fileExistsAtPath:photoFilePath]) {
        [imageData writeToFile:photoFilePath atomically:YES];
    }
    return md5String;
}

-(NSString *)getFrontImageMd5
{
    return _frontPhoto.imageMd5;
}

-(void)setFrontImage:(UIImage *)image
{
    _frontPhoto = [[CookPhoto alloc] init];
    [_frontPhoto setCookPhoto:image];
//    _frontImage = image;
}

-(UIImage *)getFrontImage
{
    if (!_frontPhoto) {
        _frontPhoto = [[CookPhoto alloc] init];
        CookPhoto *firstPhoto = [_arrLoaclPhotos firstObject];
        _frontPhoto.imageMd5 = firstPhoto.imageMd5;
        [_frontPhoto setCookPhoto:[firstPhoto getImageWithCookDataId:self.cookDataId]];
    }
    
    return [_frontPhoto getImageWithCookDataId:self.cookDataId];;
//    if (!_frontImage) {
//        CookPhoto *photo = [_arrLoaclPhotos firstObject];
//        _frontImage = [photo getImageWithCookDataId:self.cookDataId];
//    }
//    return _frontImage;
}

-(void)replaceImage:(UIImage *)image atIndex:(NSInteger )index
{
    CookPhoto *cookPhoto = [self.arrLoaclPhotos objectAtIndex:index];
    if (!cookPhoto) {
        return;
    }
    
    if (0 ==index) {
        _frontPhoto = [[CookPhoto alloc] init];
        [_frontPhoto setCookPhoto:image];
    }
    
//    if (0 == index) {
//        _frontImage = image;
//    }
    
    CookPhoto *newCookPhoto = [[CookPhoto alloc] init];
    [newCookPhoto setCookPhoto:image];
    newCookPhoto.story = cookPhoto.story;
    [self.arrLoaclPhotos replaceObjectAtIndex:index withObject:newCookPhoto];
    
//    [cookPhoto setCookPhoto:image];
}

-(void)exchangeImageIndex:(NSInteger)fromTndex withImageIndex:(NSInteger)toIndex
{
    if (fromTndex < 0 || fromTndex >= self.arrLoaclPhotos.count ||
        toIndex < 0 || toIndex >= self.arrLoaclPhotos.count) {
        return;
    }
    [self.arrLoaclPhotos exchangeObjectAtIndex:fromTndex withObjectAtIndex:toIndex];
    
    if (0 == fromTndex ||
        0 == toIndex) {
        CookPhoto *cookPhoto = [self.arrLoaclPhotos objectAtIndex:0];
        
        _frontPhoto = [[CookPhoto alloc] init];
        [_frontPhoto setCookPhoto:[cookPhoto getImageWithCookDataId:self.cookDataId]];
        _frontPhoto.imageMd5 = cookPhoto.imageMd5;
//        _frontImage = [cookPhoto getImageWithCookDataId:self.cookDataId];
    }
}

-(void)removeImageAtIndex:(NSInteger)index
{
    if (index < 0 || index >= self.arrLoaclPhotos.count) {
        return;
    }
    
    [self.arrLoaclPhotos removeObjectAtIndex:index];
    
    if (0 == index && self.arrLoaclPhotos.count) {
        CookPhoto *cookPhoto = [self.arrLoaclPhotos objectAtIndex:0];
        
        _frontPhoto = [[CookPhoto alloc] init];
        [_frontPhoto setCookPhoto:[cookPhoto getImageWithCookDataId:self.cookDataId]];
        _frontPhoto.imageMd5 = cookPhoto.imageMd5;
//        _frontImage = [cookPhoto getImageWithCookDataId:self.cookDataId];
    }
}

-(void)uploadImagesData
{
    //    self.cookId = cookId;
    
    _bUploadFinish = NO;
    _bHasDiffFront = NO;
    
    _arrLocalCopy = [self.arrLoaclPhotos mutableCopy];
    
    NSString *frontMd5 = [UIImagePNGRepresentation([_frontPhoto getImageWithCookDataId:self.cookDataId]) md5];
    NSString *firstMd5 = [UIImagePNGRepresentation([[_arrLoaclPhotos firstObject] getImageWithCookDataId:self.cookDataId]) md5];
    
    NSMutableArray *arrImages = [NSMutableArray arrayWithCapacity:_arrLocalCopy.count];
    for (CookPhoto *locPhoto in _arrLocalCopy)
    {
        NSMutableDictionary *dictImage = [NSMutableDictionary dictionary];
        dictImage[@"md5"] = locPhoto.imageMd5;
        dictImage[@"image"] = [locPhoto getImageWithCookDataId:self.cookDataId];
        
        [arrImages addObject:dictImage];
//        [arrImages addObject:[locPhoto getImageWithCookDataId:self.cookDataId]];
    }
    
//    NSString * frontMd5 = [UIImagePNGRepresentation(_frontImage) md5];
//    NSString * firstMd5 = [UIImagePNGRepresentation([arrImages firstObject]) md5];
    if (![frontMd5 isEqualToString:firstMd5]) {
        _bHasDiffFront = YES;
        
        NSMutableDictionary *dictImage = [NSMutableDictionary dictionary];
        dictImage[@"md5"] = _frontPhoto.imageMd5;
        dictImage[@"image"] = [_frontPhoto getImageWithCookDataId:self.cookDataId];
        
        [arrImages insertObject:dictImage atIndex:0];
//        [arrImages insertObject:_frontImage atIndex:0];
    }
    
    if (_uploadImageRequest) {
        [_uploadImageRequest cancel];
    }
    
    _uploadImageRequest = [[UploadImageRequest alloc] initWithImages:arrImages];
    _uploadImageRequest.delegate = self;
    
    dispatch_queue_t queue = [GlobalVar shareGlobalVar].uploadImagesQueue;
    [_uploadImageRequest requestWithUrl:[GlobalVar shareGlobalVar].imagesUrl inQueue:queue];
}


-(void)cancelUpload
{
    if (_uploadImageRequest) {
        [_uploadImageRequest cancel];
        _uploadImageRequest = nil;
    }
}

-(void)startEdit
{
    
}

-(void)cancelEdit
{
    
}

-(BOOL)dataIsReady
{
    BOOL bReady = YES;
    if (_frontPhoto.serverUrl)
    {
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:_frontPhoto.serverUrl] options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (image) {
                _frontPhoto.serverUrl = nil;
                [_frontPhoto setCookPhoto:image];
            }
        }];
        
        bReady = NO;
    }

    
    for (CookPhoto *photo in _arrLoaclPhotos) {
        if (photo.serverUrl) {
            
            [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:photo.serverUrl] options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                if (image) {
                    photo.serverUrl = nil;
                    [photo setCookPhoto:image];
                }
            }];
            
            bReady = NO;
        }
    }
    
    return bReady;
}

//-(NSString *)frontImagePath
//{
//    if (_frontImage) {
//        NSData *imageData = UIImagePNGRepresentation(_frontImage);
//        
//    }
////    else {
////        CookPhoto *photo = [_arrLoaclPhotos firstObject];
////        if (photo) {
////            return UIImagePNGRepresentation(photo.image);
////        }
////    }
//    return nil;
//}

//-(void)imagesFromData:(NSData *)data
//{
//    NSMutableArray *arr = [FastCoder objectWithData:data];
//    
////    _bUploadFinish = [dict[@"bUploadFinish"] boolValue];
////    NSMutableArray *arr = dict[@"images"];
//    
//    _arrLoaclPhotos = [NSMutableArray arrayWithCapacity:arr.count];
//    
//    for (NSMutableDictionary *d in arr) {
//        CookPhoto *photo = [[CookPhoto alloc] init];
//        photo.story = d[@"story"];
//        photo.image = [UIImage imageWithData:d[@"imageData"]];
//        
//        [_arrLoaclPhotos addObject:photo];
//    }
//    _cookPhotosInfo = dict[@"imagesInfo"];
//}


#pragma mark UploadRequestDelegate

-(void)didUploadDataSuccess:(UploadRequest *)request
{
    if (_uploadImageRequest != request) {
        return;
    }
    
    if (_uploadImageRequest.arrImagesMd5.count != _arrLocalCopy.count+_bHasDiffFront) {
 //       [_uploadImageRequest restart];
        return;
    }
    
//    _frontImageMd5 = [_uploadImageRequest.arrImageUrls firstObject];
    _frontPhoto.imageMd5 = [_uploadImageRequest.arrImagesMd5 firstObject];
    if (_uploadImageRequest.arrImagesMd5.count == _arrLoaclPhotos.count+1) {
        [_uploadImageRequest.arrImagesMd5 removeObjectAtIndex:0];
//        [_uploadImageRequest.arrImageUrls removeObject:_frontImageMd5];
    }
    
    self.arrCookPhotosInfo = [NSMutableArray arrayWithCapacity:_uploadImageRequest.arrImagesMd5.count];
    
    int i = 0;
    for (NSString *imageMd5 in _uploadImageRequest.arrImagesMd5) {
        NSMutableDictionary *dictPhoto = [NSMutableDictionary dictionary];
        dictPhoto[kPhotoPropertySerialNumber] = @(i);
        dictPhoto[kPhotoPropertyPhotoUrl] = imageMd5;
        
        CookPhoto *localPhoto = [_arrLocalCopy objectAtIndex:i];
        
        UIImage *localImage = [localPhoto getImageWithCookDataId:self.cookDataId];
        
        dictPhoto[kPhotoPropertyDescription] = localPhoto.story?localPhoto.story:@"";
//        dictPhoto[kPhotoPropertyMoreText] = @"";
        
        dictPhoto[kPhotoPropertyWidth] = @(localImage.size.width*localImage.scale);
        dictPhoto[kPhotoPropertyHeight] = @(localImage.size.height*localImage.scale);
        
        [self.arrCookPhotosInfo addObject:dictPhoto];
        i++;
    }
    
    _bUploadFinish = YES;
    
    if(_delegate && [_delegate respondsToSelector:@selector(didPhotoUploadSuccess:)]) {
        [_delegate didPhotoUploadSuccess:self];
    }
}

-(void)didUploadDataFailed:(UploadRequest *)request
{
    if (_uploadImageRequest != request) {
        return;
    }
    
//    [_uploadImageRequest restart];
    
    if(_delegate && [_delegate respondsToSelector:@selector(didPhotoUploadFailed:)]) {
        [_delegate didPhotoUploadFailed:self];
    }
}

-(void)diduploadDataProgress:(UploadRequest *)request
{
    if (_uploadImageRequest != request) {
        return;
    }
    
    _progress = _uploadImageRequest.progress;
    if(_delegate && [_delegate respondsToSelector:@selector(didPhotoUploadProgress:)]) {
        [_delegate didPhotoUploadProgress:self];
    }
}

@end
