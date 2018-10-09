//
//  ParticipantReformer.m
//  CookBook
//
//  Created by zhangxi on 16/6/7.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "ParticipantReformer.h"
#import "RetrieveBulkDataRequest.h"

const NSString * const kParticipantPropertyOrderId = @"order_id"; // 订单id
const NSString * const kParticipantPropertyBulkId = @"bulk_id";   //团购Id
const NSString * const kParticipantPropertyProductId = @"product_id";   //商品Id

const NSString * const kParticipantPropertyName = @"name";   //用户名称
const NSString * const kParticipantPropertyQuantity = @"quantity";    // 购买数量
const NSString * const kParticipantPropertySpec = @"spec";       //单位
const NSString * const kParticipantPropertyCreateTime = @"create_time";    //创建时间

@implementation ParticipantReformer

-(NSMutableDictionary *)reformDataWithRequest:(RetrieveRequest *)request
{
    RetrieveBulkDataRequest *req = (RetrieveBulkDataRequest *)request;
    return [NSMutableDictionary dictionaryWithObject:req.dictResult forKey:@"result"];
}

@end
