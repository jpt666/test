//
//  OrderDetailReformer.m
//  CookBook
//
//  Created by zhangxi on 16/6/15.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "OrderDetailReformer.h"

const NSString * const kOrderPropertyObtainName = @"obtain_name";
const NSString * const kOrderPropertyObtainMobile = @"obtain_mob";

const NSString * const kOrderPropertyRecieveName = @"receive_name";
const NSString * const kOrderPropertyRecieveMobile = @"receive_mob";
const NSString * const kOrderPropertyRecieveAddress = @"receive_address";

const NSString * const kOrderPropertyDispatcher = @"storage";
const NSString * const kOrderPropertyFreight = @"freight";
const NSString * const kOrderPropertyGoods = @"goods";
const NSString * const kOrderPropertyWXPayUrl = @"wx_pay_request";

const NSString * const kOrderPropertyDictionaryPayInfo = @"payrequest";
const NSString * const kOrderPropertyThirdPartyFee = @"third_party_fee";
const NSString * const kOrderPropertyBalanceFee = @"balance_fee";

const NSString * const kOrderPropertyCardTitle = @"card_title";
const NSString * const kOrderPropertyCardDesc = @"card_desc";
const NSString * const kOrderPropertyCardIcon = @"card_icon";
const NSString * const kOrderPropertyCardUrl = @"card_url";
const NSString * const kOrderPropertyRelaySeq = @"seq";

@implementation OrderDetailReformer

-(NSMutableDictionary *)reformDataWithRequest:(RetrieveRequest *)request
{
    return request.rawData;
}

@end
