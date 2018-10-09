//
//  RetrieveDataRequest.h
//  CookBook
//
//  Created by zhangxi on 16/4/14.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "RetrieveRequest.h"

@interface RetrieveCookDataRequest : RetrieveRequest

@property (nonatomic, assign) NSInteger cookerId;
@property (nonatomic, assign) NSInteger offset;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) long long limitTime;
@property (nonatomic, strong) NSString * keyword;

@property (nonatomic, strong) NSMutableDictionary * dictResult;

-(instancetype)initWithCookerId:(NSInteger)cookerId
                      limitTime:(long long)limitTime
                          count:(NSInteger)count
                            url:(NSString *)url;

-(instancetype)initWithLimitTime:(long long)limitTime
                          count:(NSInteger)count
                             url:(NSString *)url;

-(instancetype)initWithCookerId:(NSInteger)cookerId
                         offset:(NSInteger)offset
                        count:(NSInteger)count
                            url:(NSString *)url;

-(instancetype)initWithOffset:(NSInteger)offset
                        count:(NSInteger)count
                          url:(NSString *)url;

-(instancetype)initWithKeyword:(NSString *)keyword
                         count:(NSInteger)count
                     limitTime:(long long)limitTime
                           url:(NSString *)url;

-(instancetype)initWithRelatedId:(NSNumber *)dataId
                           count:(NSInteger)count
                             url:(NSString *)url;

-(void)request;

@end
