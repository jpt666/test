//
//  CookProductReformer.m
//  CookBook
//
//  Created by zhangxi on 16/4/11.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "CookProductReformer.h"
#import "CookBookPropertyKeys.h"
#import "RetrieveCookDataRequest.h"
#import "GlobalVar.h"

const NSString * const kProductPropertyServerId         =       @"kPServerId";
const NSString * const kProductPropertyProductId        =       @"kPProuctId";
const NSString * const kProductPropertyCookerId         =       @"kPCookerId";
const NSString * const kProductPropertyCookerNickName   =       @"kPNickName";
const NSString * const kProductPropertyCookerIconUrl    =       @"kPIconUrl";
const NSString * const kProductPropertyDishName         =       @"kPDishName";
const NSString * const kProductPropertyDescription      =       @"kPDescription";
const NSString * const kProductPropertyFollowBookId     =       @"kPFollowBookId";
const NSString * const kProductPropertyPhotoNumbers     =       @"kPPhotoNums";
const NSString * const kProductPropertyFrontCoverUrl    =       @"kPFrontCoverUrl";
const NSString * const kProductPropertyFrontCoverMd5    =       @"kPFrontCoverMd5";
const NSString * const kProductPropertyTopic            =       @"kPTopic";
const NSString * const kProductPropertyKind             =       @"kPKind";
const NSString * const kProductPropertySubKind          =       @"kPSubKind";
const NSString * const kProductPropertyIsPublished      =       @"kPIsPublished";
const NSString * const kProductPropertyTags             =       @"kPTags";
const NSString * const kProductPropertyTips             =       @"kPTips";
const NSString * const kProductPropertyCreateTime       =       @"kPCreateTime";
const NSString * const kProductPropertyEditTime         =       @"kPEditTime";
const NSString * const kProductPropertyScore            =       @"kPScore";
const NSString * const kProductPropertyVisitNumbers     =       @"kPVisitNum";
const NSString * const kProductPropertyFavorNumbers     =       @"kPFavorNum";
const NSString * const kProductPropertyCommentNumbers   =       @"kPCommentNum";
const NSString * const kProductPropertyUrl              =       @"kPUrl";
const NSString * const kProductPropertyCardUrl          =       @"kPCardUrl";
const NSString * const kProductPropertyPhotos           =       @"kPPhotos";       //NSMutableArray


@implementation CookProductReformer

-(NSMutableDictionary *)reformDataWithRequest:(RetrieveRequest *)request
{
    if([request isKindOfClass:[RetrieveCookDataRequest class]]) {
        NSMutableArray * arrOrg = (NSMutableArray *)request.rawData;
        NSMutableArray * arrNew = [NSMutableArray array];
        for (NSDictionary *dOrg in arrOrg) {
            NSMutableDictionary *dNew = [CookProductReformer convertLocalProductDataFromNetProduct:dOrg];
            [arrNew addObject:dNew];
        }
        
        return [NSMutableDictionary dictionaryWithObject:arrNew forKey:@"products"];
    }
    return nil;
}

+(NSMutableDictionary *)convertLocalProductDataFromNetProduct:(NSDictionary *)dictData
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[kProductPropertyServerId] = dictData[@"id"];
    dict[kProductPropertyProductId] = [GlobalVar getUUID];
    dict[kProductPropertyDishName] = dictData[@"name"];
    dict[kProductPropertyDescription] = dictData[@"desc"];
    dict[kProductPropertyFrontCoverUrl] = dictData[@"cover"];
    dict[kProductPropertyFrontCoverMd5] = dictData[@"cover_md5"];
    dict[kProductPropertyTags] = dictData[@"tag"];
    dict[kProductPropertyTips] = dictData[@"tips"];
    dict[kProductPropertyCreateTime] = dictData[@"create_time"];
    
    //step
    dict[kProductPropertyPhotoNumbers] = dictData[@"step_num"];
    NSArray * arrOrgSteps = dictData[@"steps"];
    NSMutableArray *arrNewSteps = [NSMutableArray array];
    
    for (NSDictionary *dOrg in arrOrgSteps) {
        NSMutableDictionary *dNew = [NSMutableDictionary dictionary];
        dNew[kPhotoPropertyPhotoUrl] = dOrg[@"image"];
        dNew[kPhotoPropertyPhotoMd5] = dOrg[@"md5"];
        dNew[kPhotoPropertyDescription] = dOrg[@"plain"];
        dNew[kPhotoPropertySerialNumber] = dOrg[@"seq"];
        dNew[kPhotoPropertyWidth] = dOrg[@"width"];
        dNew[kPhotoPropertyHeight] = dOrg[@"height"];
        
        [arrNewSteps addObject:dNew];
    }
    dict[kProductPropertyPhotos] = arrNewSteps;
    
    
    //user
    dict[kProductPropertyCookerId] = dictData[@"user"][@"id"];
    dict[kProductPropertyCookerNickName] = dictData[@"user"][@"name"];
    dict[kProductPropertyCookerIconUrl] = dictData[@"user"][@"wx_headimgurl"];
    
    dict[kProductPropertyUrl] = dictData[@"url"];
    
    dict[kProductPropertyCardUrl] = dictData[@"card_url"];
    
    return dict;
}

+(NSMutableDictionary *)reformUploadDataFromLocalData:(NSDictionary *)dictData
{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    
    dict[@"name"] = dictData[kProductPropertyDishName]?dictData[kProductPropertyDishName]:@"";
    dict[@"desc"] = dictData[kProductPropertyDescription]?dictData[kProductPropertyDescription]:@"";
    dict[@"cover"] = dictData[kProductPropertyFrontCoverUrl]?dictData[kProductPropertyFrontCoverUrl]:@"";
    dict[@"tips"] = dictData[kProductPropertyTips]?dictData[kProductPropertyTips]:[NSMutableArray array];
    dict[@"tag"] = dictData[kProductPropertyTags]?dictData[kProductPropertyTags]:@"";
    
    dict[@"recipe"] = dictData[kProductPropertyFollowBookId];
    
    NSArray * arrOrgSteps = dictData[kProductPropertyPhotos];
    NSMutableArray *arrNewSteps = [NSMutableArray array];
    
    for (NSDictionary *dOrg in arrOrgSteps) {
        NSMutableDictionary *dNew = [NSMutableDictionary dictionary];
        dNew[@"image"] = dOrg[kPhotoPropertyPhotoUrl];
        dNew[@"plain"] = dOrg[kPhotoPropertyDescription];
        dNew[@"seq"] = dOrg[kPhotoPropertySerialNumber];
        
        [arrNewSteps addObject:dNew];
    }
    dict[@"steps"] = arrNewSteps;

    return dict;
}

@end
