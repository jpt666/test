//
//  RetrieveBulkDataRequest.m
//  CookBook
//
//  Created by zhangxi on 16/6/7.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "RetrieveBulkDataRequest.h"

static NSString * kParamKeyResellerId = @"reseller_id";
static NSString * kParamKeyNum = @"page_size";
static NSString * kParamKeyLimitTime = @"time";
static NSString * kParamKeySearchWord = @"search";


@implementation RetrieveBulkDataRequest
{
    NSMutableDictionary *_dictParam;
    NSString * _url;
}

-(instancetype)initWithLimitTime:(long long)limitTime
                           count:(NSInteger)count
                             url:(NSString *)url
{
    return [self initWithLimitTime:limitTime count:count keyword:nil url:url];
}

-(instancetype)initWithLimitTime:(long long)limitTime
                           count:(NSInteger)count
                         keyword:(NSString *)keyword
                             url:(NSString *)url
{
//    self = [super init];
//    if (self) {
//        _url = url;
//        
//        _dictParam = [NSMutableDictionary dictionary];
//        if (limitTime > 0) {
//            _dictParam[kParamKeyLimitTime] = @(limitTime);
//        }
//        if (count > 0) {
//            _dictParam[kParamKeyNum] = @(count);
//        }
//        if (keyword) {
//            _dictParam[kParamKeySearchWord] = keyword;
//        }
//    }
    return [self initWithReseller:0 limitTime:limitTime count:count keyword:keyword url:url];
}

-(instancetype)initWithReseller:(NSInteger)resellerId
                      limitTime:(long long)limitTime
                          count:(NSInteger)count keyword:(NSString *)keyword
                            url:(NSString *)url
{
    self = [super init];
    if (self) {
        _url = url;
        
        _dictParam = [NSMutableDictionary dictionary];
        
        if (resellerId > 0) {
            _dictParam[kParamKeyResellerId] = @(resellerId);
        }
        
        if (limitTime > 0) {
            _dictParam[kParamKeyLimitTime] = @(limitTime);
        }
        if (count > 0) {
            _dictParam[kParamKeyNum] = @(count);
        }
        if (keyword) {
            _dictParam[kParamKeySearchWord] = keyword;
        }
    }
    return self;
}

-(instancetype)initWithUrl:(NSString *)url
{
    return [self initWithLimitTime:0 count:0 url:url];
}

-(void)request
{
    [AFHttpTool requestWithMethod:RequestMethodTypeGet url:_url params:_dictParam success:^(id response) {
        _dictResult = response;
        
 //       if ([_dictResult[@"code"] integerValue] == 0) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(didRetrieveDataSuccess:)]) {
                [self.delegate didRetrieveDataSuccess:self];
            }
//        } else {
//            self.error = [NSError errorWithDomain:SERVER_HOST code:[_dictResult[@"code"] integerValue] userInfo:[NSDictionary dictionaryWithObject:[_dictResult objectForKey:@"message"] forKey:NSLocalizedDescriptionKey]];
//            if (self.delegate && [self.delegate respondsToSelector:@selector(didRetrieveDataFailed:)]) {
//                [self.delegate didRetrieveDataFailed:self];
//            }
//        }
    } failure:^(NSError *err) {
        
        self.error = err;
        if (self.delegate && [self.delegate respondsToSelector:@selector(didRetrieveDataFailed:)]) {
            [self.delegate didRetrieveDataFailed:self];
        }
    }];
}

@end
