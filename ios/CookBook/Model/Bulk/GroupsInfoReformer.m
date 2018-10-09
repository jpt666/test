//
//  GroupsInfoReformer.m
//  CookBook
//
//  Created by zhangxi on 16/6/7.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "GroupsInfoReformer.h"
#import "RetrieveBulkDataRequest.h"


const NSString * const kGroupsPropertyId = @"id"; // id
const NSString * const kGroupsPropertyTitle = @"title";   //标题
const NSString * const kGroupsPropertyCategory=@"category";//


const NSString * const kGroupsPropertyCovers = @"covers";   //封面图片数组
const NSString * const kGroupsPropertyDeadTime = @"dead_time";    // 截止时间
const NSString * const kGroupsPropertyArrivedTime = @"arrived_time";       //收货时间
const NSString * const kGroupsPropertyStatus = @"status";      //团购状态
const NSString * const kGroupsPropertyIsSoldout = @"soldout";
const NSString * const kGroupsPropertyCreateTime = @"create_time";    //创建时间
const NSString * const kGroupsPropertyDetailUrl = @"url";    //详情url

const NSString * const kGroupsPropertyRecieveMode = @"receive_mode";

const NSString * const kGroupsPropertyComments = @"comments";

const NSString * const kGroupsPropertyStandardTime = @"standard_time"; //服务器时间
const NSString * const kGroupsPropertyCardTitle = @"card_title"; //
const NSString * const kGroupsPropertyCardDesc = @"card_desc"; //
const NSString * const kGroupsPropertyCardIcon = @"card_icon"; //
const NSString * const kGroupsPropertyParticipant = @"participant_count"; //参与人数

const NSString * const kGroupsPropertyLocation = @"location";

const NSString * const kGroupsPropertyReseller = @"reseller"; //团主
const NSString * const kResellerPropertyId = @"id";
const NSString * const kResellerPropertyApplyState = @"state";
const NSString * const kResellerPropertyName = @"name";
const NSString * const kResellerPropertyTail = @"tail";  //个人签名
const NSString * const kResellerPropertyCreateTime = @"create_time";
const NSString * const kResellerPropertyMobile = @"mob";
const NSString * const kResellerPropertyWXHeaderUrl = @"wx_headimgurl";
const NSString * const kResellerPropertyWXNickName = @"wx_nickname";

const NSString * const kGroupsPropertyDispatchers = @"storages"; //提货点
const NSString * const kGroupsPropertyRecentDispatcher = @"recent_storage";
const NSString * const kDispatcherPropertyId = @"id";
const NSString * const kDispatcherPropertyName = @"name";
const NSString * const kDispatcherPropertyTail = @"tail";
const NSString * const kDispatcherPropertyAddress = @"address";
const NSString * const kDispatcherPropertyCreateTime = @"create_time";
const NSString * const kDispatcherPropertyMobile = @"mob";
const NSString * const kDispatcherPropertyOpenTime = @"opening_time";
const NSString * const kDispatcherPropertyCloseTime = @"closing_time";
const NSString * const kDispatcherPropertyWXNickName = @"wx_nickname";
const NSString * const kDispatcherPropertyWXHeadUrl = @"wx_headimgurl";
const NSString * const kDispatcherPropertyIsCustom = @"is_custom";
const NSString * const kDispatcherPropertyUrl = @"url";

const NSString * const kGroupsPropertyProducts = @"products"; //商品


@implementation GroupsInfoReformer

-(NSMutableDictionary *)reformDataWithRequest:(RetrieveRequest *)request
{
    RetrieveBulkDataRequest *req = (RetrieveBulkDataRequest *)request;
    return [NSMutableDictionary dictionaryWithObject:req.dictResult forKey:@"result"];
}

@end
