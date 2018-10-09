//
//  UploadImageRequest.m
//  CookBook
//
//  Created by zhangxi on 16/4/13.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "UploadImageRequest.h"
#import "SDWebImageManager.h"
#import "NSData+md5.h"
#import "UIImage+ImageCompress.h"
#import "AFHttpTool.h"


@implementation UploadImageRequest
{
    NSString * _url;
    BOOL _bCanceled;
    dispatch_queue_t _queue;
}

-(instancetype)initWithImages:(NSMutableArray *)images
{
    self = [super init];
    if (self) {
        _bCanceled = NO;
        _arrImages = images;
        _arrImagesMd5 = [NSMutableArray arrayWithCapacity:images.count];
    }
    return self;
}

-(BOOL)checkImageMd5:(NSString *)imageMd5str url:(NSString *)url
//-(BOOL)checkImage:(UIImage*)image md5:(NSString *)imageMd5str url:(NSString *)url
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url, imageMd5str]]];
    request.HTTPMethod=@"GET";
    
    NSHTTPURLResponse *response;
    NSError * err;
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    NSDictionary *dict = nil;
    if (data) {
        dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    }
    if (response.statusCode == 200) {
//        [_arrImageUrls addObject:imageMd5str];
//        [[SDWebImageManager sharedManager] saveImageToCache:image forURL:[NSURL URLWithString:dict[@"image"]]];
        
        return YES;
    }
    return NO;
}

-(BOOL)checkImageExist:(NSString *)imageMd5str url:(NSString *)url
{
//    NSString *baseStr = [imageData base64EncodedStringWithOptions:0];
//    NSString *baseString = (__bridge NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)baseStr,NULL,CFSTR(":/?#[]@!$&’()*+,;="),kCFStringEncodingUTF8);
    
    //           NSString *postString = [NSString stringWithFormat:UPLOADIMAGE_POST_STRING, [imageData md5], baseString];
    NSMutableDictionary * d = [NSMutableDictionary dictionary];
    d[@"imagemd5"] = imageMd5str;
    
    NSData * postData = [NSJSONSerialization dataWithJSONObject:d options:0 error:nil];
    //            NSData * postData = [postString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)postData.length];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    [request setTimeoutInterval:20];
    
    NSURLResponse *response;
    NSError * err;
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    NSDictionary *dict = nil;
    if (data) {
        dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    }
    
    if (dict && error_data_exist == [[dict objectForKey:@"code"] integerValue]) {
        return YES;
    }

    return NO;
}

-(void)requestWithUrl:(NSString *)url inQueue:(dispatch_queue_t)queue
{
    _url = url;
    _queue = queue;
    
    dispatch_async(queue, ^{
        int cnt = 0;
        for (NSDictionary *dImage in _arrImages) {
//        for (UIImage *orgImage in _arrImages) {
            if (_bCanceled) {
                return;
            }
            
            __block NSString * imageMd5Str = dImage[@"md5"];
            UIImage * orgImage = dImage[@"image"];
            
            NSData *imageData = [UIImage dataForCompressImage:orgImage compressRatio:1.0 maxCompressRatio:0.65];
            
            if (!imageMd5Str) {
                imageMd5Str = [imageData md5];
            }
            
            NSMutableDictionary * d = [NSMutableDictionary dictionary];

            __block dispatch_semaphore_t sema = dispatch_semaphore_create(0);
            
            if (![self checkImageMd5:imageMd5Str url:url]) {
//            if (![self checkImage:tmpImage md5:imageMd5Str url:url]) {
                
                d[@"file"] = imageData;
                
                [AFHttpTool requestWithMethod:RequestMethodTypeSingleUpload url:_url params:d progress:^(NSProgress *uploadProgress) {
                    
                    
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        self.progress = (CGFloat)uploadProgress.fractionCompleted/_arrImages.count+(CGFloat)cnt/_arrImages.count;
                        
                        if (self.delegate && [self.delegate respondsToSelector:@selector(diduploadDataProgress:)]) {
                            [self.delegate diduploadDataProgress:self];
                        }
                    });
                    
                } success:^(id response) {
                    
                    imageMd5Str = response[@"md5"];
                    
                    dispatch_semaphore_signal(sema);
                    
//                    [_arrImageUrls addObject:imageMd5Str];
//                    [[SDWebImageManager sharedManager] saveImageToCache:tmpImage forURL:[NSURL URLWithString:response[@"image"]]];
                    
//                    if (NET_RESULT_SUCCESS != [[response objectForKey:@"code"] integerValue] &&
//                     error_data_exist != [[response objectForKey:@"code"] integerValue]) {
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            _bCanceled = NO;
//                            self.error = [NSError errorWithDomain:SERVER_HOST code:[[response objectForKey:@"code"] integerValue] userInfo:[NSDictionary dictionaryWithObject:[response objectForKey:@"message"] forKey:NSLocalizedDescriptionKey]];
//                            if (self.delegate && [self.delegate respondsToSelector:@selector(didUploadDataFailed:)]) {
//                                [self.delegate didUploadDataFailed:self];
//                            }
//                        });
//                        return;
//                    }
                } failure:^(NSError *err) {
                    dispatch_semaphore_signal(sema);
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        _bCanceled = NO;
                        self.error = err;
                        if (self.delegate && [self.delegate respondsToSelector:@selector(didUploadDataFailed:)]) {
                            [self.delegate didUploadDataFailed:self];
                        }
                    });
                    return;
                }];
                
                dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        
            }
 
            [_arrImagesMd5 addObject:imageMd5Str];

            cnt++;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.delegate && [self.delegate respondsToSelector:@selector(diduploadDataProgress:)]) {
                    self.progress = (CGFloat)cnt/_arrImages.count;
                    
                    [self.delegate diduploadDataProgress:self];
                }
            });
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            _bCanceled = NO;
            if (self.delegate && [self.delegate respondsToSelector:@selector(didUploadDataSuccess:)]) {
                [self.delegate didUploadDataSuccess:self];
            }
        });
    });
}

-(void)cancel
{
    _bCanceled = YES;
    if (self.delegate) {
        self.delegate = nil;
    }
}

-(void)restart
{
    [_arrImagesMd5 removeAllObjects];
    self.error = nil;
    _bCanceled = NO;
    
    [self requestWithUrl:_url inQueue:_queue];
}

@end
