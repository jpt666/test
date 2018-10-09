//
//  RetrieveBulkDataRequest.h
//  CookBook
//
//  Created by zhangxi on 16/6/7.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "RetrieveRequest.h"

@interface RetrieveBulkDataRequest : RetrieveRequest

@property (nonatomic, strong) id extraData;
@property (nonatomic, strong) NSMutableDictionary * dictResult;

-(instancetype)initWithLimitTime:(long long)limitTime
                          count:(NSInteger)count
                            url:(NSString *)url;

-(instancetype)initWithLimitTime:(long long)limitTime
                           count:(NSInteger)count
                         keyword:(NSString *)keyword
                             url:(NSString *)url;

-(instancetype)initWithReseller:(NSInteger)resellerId
                      limitTime:(long long)limitTime
                           count:(NSInteger)count
                         keyword:(NSString *)keyword
                             url:(NSString *)url;


-(instancetype)initWithUrl:(NSString *)url;

@end
