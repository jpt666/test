//
//  UploadImageRequest.h
//  CookBook
//
//  Created by zhangxi on 16/4/13.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "UploadRequest.h"

@interface UploadImageRequest : UploadRequest

@property (nonatomic, strong) NSMutableArray * arrImagesMd5;
@property (nonatomic, strong) NSMutableArray * arrImages;

-(instancetype)initWithImages:(NSMutableArray *)images;

-(void)cancel;

-(void)requestWithUrl:(NSString *)url inQueue:(dispatch_queue_t)queue;

@end
