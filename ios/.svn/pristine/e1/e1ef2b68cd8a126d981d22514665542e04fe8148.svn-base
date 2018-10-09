//
//  UploadDataRequest.h
//  CookBook
//
//  Created by zhangxi on 16/4/11.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHttpTool.h"

@class UploadRequest;
@protocol UploadRequestDelegate <NSObject>

-(void)didUploadDataSuccess:(UploadRequest *)request;
-(void)didUploadDataFailed:(UploadRequest *)request;
-(void)diduploadDataProgress:(UploadRequest *)request;

@end

@interface UploadRequest : NSObject

@property (nonatomic, weak) id<UploadRequestDelegate> delegate;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, strong) NSError * error;

- (void)cancel;

- (void)request;

-(void)restart;

@end
