//
//  BulkOrderDataRequest.h
//  CookBook
//
//  Created by zhangxi on 16/6/14.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "RetrieveRequest.h"

@interface BulkOrderDataRequest : RetrieveRequest

@property (nonatomic, strong) id extraObject;

-(instancetype)initWithLimitTime:(long long)limitTime
                          count:(NSInteger)count
                            url:(NSString *)url;

@end
