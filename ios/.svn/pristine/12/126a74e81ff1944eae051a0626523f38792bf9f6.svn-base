//
//  OrderListReformer.m
//  CookBook
//
//  Created by zhangxi on 16/6/15.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "OrderListReformer.h"

const NSString * const kOrderPropertyId = @"id"; // id
const NSString * const kOrderPropertyStatus = @"status";
const NSString * const kOrderPropertyTotalFee = @"total_fee";

const NSString * const kOrderPropertyReseller = @"reseller";   //团主

const NSString * const kOrderPropertyCount = @"count";    //
const NSString * const kOrderPropertyCovers = @"covers";

const NSString * const kOrderPropertyCreateTime = @"create_time";    //创建时间
const NSString * const kOrderPropertyDetailUrl = @"url";    //详情url

const NSString * const kOrderPropertyBulkStatus = @"bulk_status";

const NSString * const kOrderPropertyErrorCode = @"errcode";
const NSString * const kOrderPropertyDetail = @"detail";


@implementation OrderListReformer

-(NSMutableDictionary *)reformDataWithRequest:(RetrieveRequest *)request
{
    return [NSMutableDictionary dictionaryWithObject:request.rawData forKey:@"result"];
}

@end
