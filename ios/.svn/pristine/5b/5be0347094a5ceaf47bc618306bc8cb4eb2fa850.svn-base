//
//  RetrieveDataRequest.m
//  CookBook
//
//  Created by zhangxi on 16/4/14.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "RetrieveCookDataRequest.h"
#import "AFHttpTool.h"

static NSString * kParamKeyNum = @"page_size";
static NSString * kParamKeyLimitTime = @"time";
static NSString * kParamKeySearchWord = @"search";
static NSString * kParamKeyCookerId = @"user_id";
static NSString * kParamKeyRelatedId = @"more";



@implementation RetrieveCookDataRequest
{
    NSMutableDictionary *_dictParam;
    NSString * _url;
}

-(instancetype)initWithCookerId:(NSInteger)cookerId
                      limitTime:(long long)limitTime
                          count:(NSInteger)count
                            url:(NSString *)url
{
    self = [super init];
    if (self) {
        _url = url;
        
        _dictParam = [NSMutableDictionary dictionary];
        if (cookerId > 0) {
            _dictParam[kParamKeyCookerId] = @(cookerId);
        }
        _dictParam[kParamKeyLimitTime] = @(limitTime);
        _dictParam[kParamKeyNum] = @(count);
    }
    return self;
}

-(instancetype)initWithLimitTime:(long long)limitTime
                           count:(NSInteger)count
                             url:(NSString *)url
{
   return [self initWithCookerId:0 limitTime:limitTime count:count url:url];
}

-(instancetype)initWithCookerId:(NSInteger)cookerId
                         offset:(NSInteger)offset
                          count:(NSInteger)count
                            url:(NSString *)url
{
    self = [super init];
    if (self) {
        _url = url;
        
        _dictParam = [NSMutableDictionary dictionary];
        if (cookerId > 0) {
            _dictParam[kParamKeyCookerId] = @(cookerId);
        }
//        _dictParam[kParamKeyOffset] = @(offset);
        _dictParam[kParamKeyNum] = @(count);
    }
    return self;
}

-(instancetype)initWithOffset:(NSInteger)offset
                        count:(NSInteger)count
                          url:(NSString *)url
{
    return [self initWithCookerId:0 offset:offset count:count url:url];
}

-(instancetype)initWithKeyword:(NSString *)keyword
                         count:(NSInteger)count
                     limitTime:(long long)limitTime
                           url:(NSString *)url
{
    self = [super init];
    if (self) {
        _url = url;
        
        _dictParam = [NSMutableDictionary dictionary];
        _dictParam[kParamKeySearchWord] = keyword;
        _dictParam[kParamKeyNum] = @(count);
        if (limitTime) {
            _dictParam[kParamKeyLimitTime] = @(limitTime);
        }
    }
    return self;
}

-(instancetype)initWithRelatedId:(NSNumber *)dataId
                           count:(NSInteger)count
                             url:(NSString *)url
{
    self = [super init];
    if (self) {
        _url = url;
        
        _dictParam = [NSMutableDictionary dictionary];
        _dictParam[kParamKeyRelatedId] = dataId;
        if (count <= 0) {
            count = 3;
        }
        _dictParam[kParamKeyNum] = @(count);

    }
    return self;
}

-(void)request
{
    [AFHttpTool requestWithMethod:RequestMethodTypeGet url:_url params:_dictParam success:^(id response) {
        self.rawData = response;
        
//        if ([_dictResult[@"code"] integerValue] == 0) {
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
