//
//  RetrieveDataRequest.m
//  CookBook
//
//  Created by zhangxi on 16/4/11.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "RetrieveRequest.h"

@implementation RetrieveRequest
{
    NSString * _url;
    NSDictionary * _dictParam;
}

-(void)cancel
{
    if (self.delegate) {
        self.delegate = nil;
    }
}

-(NSMutableDictionary *)fetchDataWithReformer:(id<ReformerProtocol>)reformer
{
    if (reformer) {
        return [reformer reformDataWithRequest:self];
    }
    
    return self.rawData;
}

-(void)request
{
    
}

-(void)restart
{
    [self request];
}

- (void)getRequestWithUrl:(NSString *)url andParam:(NSDictionary *)dictParam
{
    _url = url;
    
    [AFHttpTool requestWithMethod:RequestMethodTypeGet url:_url params:dictParam success:^(id response) {
        _rawData = response;
        if (self.delegate && [self.delegate respondsToSelector:@selector(didRetrieveDataSuccess:)]) {
            [self.delegate didRetrieveDataSuccess:self];
        }
        
    } failure:^(NSError *err) {
        
        self.error = err;
        if (self.delegate && [self.delegate respondsToSelector:@selector(didRetrieveDataFailed:)]) {
            [self.delegate didRetrieveDataFailed:self];
        }
    }];
}

- (void)postRequestWithUrl:(NSString *)url andParam:(NSDictionary *)dictParam
{
    _url = url;
    _dictParam = dictParam;
    
    [AFHttpTool requestWithMethod:RequestMethodTypePost url:_url params:_dictParam success:^(id response) {
        _rawData = response;
        if (self.delegate && [self.delegate respondsToSelector:@selector(didRetrieveDataSuccess:)]) {
            [self.delegate didRetrieveDataSuccess:self];
        }

    } failure:^(NSError *err) {
        
        self.error = err;
        if (self.delegate && [self.delegate respondsToSelector:@selector(didRetrieveDataFailed:)]) {
            [self.delegate didRetrieveDataFailed:self];
        }
    }];
}

- (void)deleteRequestWithUrl:(NSString *)url andParam:(NSDictionary *)dict
{
    _url = url;
    _dictParam = dict;
    
    [AFHttpTool requestWithMethod:RequestMethodTypeDelete url:_url params:_dictParam success:^(id response) {
        _rawData = response;
        if (self.delegate && [self.delegate respondsToSelector:@selector(didRetrieveDataSuccess:)]) {
            [self.delegate didRetrieveDataSuccess:self];
        }
        
    } failure:^(NSError *err) {
        
        self.error = err;
        if (self.delegate && [self.delegate respondsToSelector:@selector(didRetrieveDataFailed:)]) {
            [self.delegate didRetrieveDataFailed:self];
        }
    }];
}

- (void)patchRequestWithUrl:(NSString *)url andParam:(NSDictionary *)dict
{
    _url = url;
    _dictParam = dict;
    
    [AFHttpTool requestWithMethod:RequestMethodTypePatch url:_url params:_dictParam success:^(id response) {
        _rawData = response;
        if (self.delegate && [self.delegate respondsToSelector:@selector(didRetrieveDataSuccess:)]) {
            [self.delegate didRetrieveDataSuccess:self];
        }
        
    } failure:^(NSError *err) {
        
        self.error = err;
        if (self.delegate && [self.delegate respondsToSelector:@selector(didRetrieveDataFailed:)]) {
            [self.delegate didRetrieveDataFailed:self];
        }
    }];
}


@end
