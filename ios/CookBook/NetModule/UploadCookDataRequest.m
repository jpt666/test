//
//  UploadDataRequest.m
//  CookBook
//
//  Created by zhangxi on 16/4/13.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "UploadCookDataRequest.h"

@implementation UploadCookDataRequest

-(instancetype)initWithDictionary:(NSMutableDictionary *)dict
{
    self = [super init];
    if (self) {
        _dictData = dict;
    }
    return self;
}

-(void)requestWithUrl:(NSString *)url andMethod:(RequestMethodType)method
{
    [AFHttpTool requestWithMethod:method url:url params:_dictData
    progress:^(NSProgress *progress) {
    
        self.progress = progress.fractionCompleted;
        if (self.delegate && [self.delegate respondsToSelector:@selector(diduploadDataProgress:)]) {
            [self.delegate diduploadDataProgress:self];
        }
        
    }
    success:^(id response) {
//        if ([[response objectForKey:@"code"] integerValue] == 0) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(didUploadDataSuccess:)]) {
                [self.delegate didUploadDataSuccess:self];
            }
//        } else {
//            self.error = [NSError errorWithDomain:SERVER_HOST code:[[response objectForKey:@"code"] integerValue] userInfo:[NSDictionary dictionaryWithObject:[response objectForKey:@"message"] forKey:NSLocalizedDescriptionKey]];
//            
//            if (self.delegate && [self.delegate respondsToSelector:@selector(didUploadDataFailed:)]) {
//                [self.delegate didUploadDataFailed:self];
//            }
//        }
    } failure:^(NSError *err) {
        self.error = err;
        if (self.delegate && [self.delegate respondsToSelector:@selector(didUploadDataFailed:)]) {
            [self.delegate didUploadDataFailed:self];
        }
    }];
}



@end
