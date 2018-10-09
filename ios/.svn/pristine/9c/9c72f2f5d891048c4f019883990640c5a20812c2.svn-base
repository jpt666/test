//
//  BulkOrderDataRequest.m
//  CookBook
//
//  Created by zhangxi on 16/6/14.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "BulkOrderDataRequest.h"

static NSString * kParamKeyNum = @"page_size";
static NSString * kParamKeyLimitTime = @"time";


@implementation BulkOrderDataRequest
{
    NSMutableDictionary *_dictParam;
    NSString * _url;
}

-(instancetype)initWithLimitTime:(long long)limitTime
                           count:(NSInteger)count
                             url:(NSString *)url
{
    self = [super init];
    if (self) {
        _url = url;
        
        _dictParam = [NSMutableDictionary dictionary];
        
        if (limitTime > 0) {
            _dictParam[kParamKeyLimitTime] = @(limitTime);
        }
        _dictParam[kParamKeyNum] = @(count);
    }
    return self;
}

- (void)request
{
    [self getRequestWithUrl:_url andParam:_dictParam];
}

@end
