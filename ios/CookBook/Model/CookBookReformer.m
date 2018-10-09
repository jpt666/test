//
//  CookBookReformer.m
//  CookBook
//
//  Created by zhangxi on 16/4/11.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "CookBookReformer.h"
#import "RetrieveCookDataRequest.h"
#import "GlobalVar.h"

const NSString * const kBookPropertyServerId            =       @"kBServerId";
const NSString * const kBookPropertyBookId              =       @"kBCookBookId";
const NSString * const kBookPropertyCookerId            =       @"kBCookerId";
const NSString * const kBookPropertyCookerNickName      =       @"kBNickName";
const NSString * const kBookPropertyCookerIconUrl       =       @"kBIconUrl";
const NSString * const kBookPropertyDishName            =       @"kBDishName";
const NSString * const kBookPropertyFrontCoverUrl       =       @"kBFrontCoverUrl";
const NSString * const kBookPropertyFrontCoverMd5       =       @"kBFrontCoverMd5";
const NSString * const kBookPropertyTimeNeeded          =       @"kBTimeNeeded";
const NSString * const kBookPropertyDescription         =       @"kBDescription";
const NSString * const kBookPropertyStepNumbers         =       @"kBStepNums";
const NSString * const kBookPropertyTopic               =       @"kBTopic";
const NSString * const kBookPropertyTags                =       @"kBTags";
const NSString * const kBookPropertyTips                =       @"kBTips";
const NSString * const kBookPropertyKind                =       @"kBKind";
const NSString * const kBookPropertySubKind             =       @"kBSubKind";
const NSString * const kBookPropertyVisitNumbers        =       @"kBVisitNums";
const NSString * const kBookPropertyFavorNumbers        =       @"kBFavorNums";
const NSString * const kBookPropertyFollowMadeNumbers   =       @"kBFollowMadeNums";
const NSString * const kBookPropertyIsPublish           =       @"kBIsPublish";
const NSString * const kBookPropertyCreateTime          =       @"kBCreateTime";
const NSString * const kBookPropertyEditTime            =       @"kBEditTime";
const NSString * const kBookPropertyVideoUrl            =       @"kBVideoUrl";
const NSString * const kBookPropertyScore               =       @"kBScore";
const NSString * const kBookPropertyUrl                 =       @"kBUrl";
const NSString * const kBookPropertyCardUrl             =       @"kBCardUrl";
const NSString * const kBookPropertyCookSteps           =       @"kBCookSteps";           //NSMutableArray
const NSString * const kBookPropertyFoodMaterials       =       @"kBFoodMaterials";        //NSMutableArray

//cook steps
const NSString * const kPhotoPropertySerialNumber       =       @"kPhotoSerialNum";
const NSString * const kPhotoPropertyPhotoUrl           =       @"kPhotoUrl";
const NSString * const kPhotoPropertyPhotoMd5           =       @"kPhotoMd5";
const NSString * const kPhotoPropertyDescription        =       @"kPhotoDescription";
const NSString * const kPhotoPropertyWidth              =       @"kPhotoWidth";
const NSString * const kPhotoPropertyHeight             =       @"kPhotoHeight";
const NSString * const kPhotoPropertyMoreText           =       @"kPhotoMoreText";
//const NSString * const kPhotoPropertyImageData          =       @"kPhotoImageData";

//food materials
const NSString * const kBookFoodPropertySerialNumber    =       @"kBFSerialNum";
const NSString * const kBookFoodPropertyFoodName        =       @"kBFName";
const NSString * const kBookFoodPropertyQuantity        =       @"kBFQuantity";
const NSString * const kBookFoodPropertyPurchaseUrl     =       @"kBFPurchaseUrl";

//const NSString * const kBookPropertyBookId              =       @"kBCookBookId";
//const NSString * const kBookPropertyCookerId            =       @"kBCookerId";
//const NSString * const kBookPropertyCookerNickName      =       @"kBNickName";
//const NSString * const kBookPropertyCookerIconUrl       =       @"kBIconUrl";
//const NSString * const kBookPropertyDishName            =       @"kBDishName";
//const NSString * const kBookPropertyFrontCoverUrl       =       @"kBFrontCoverUrl";
//const NSString * const kBookPropertyTimeNeeded          =       @"kBTimeNeeded";
//const NSString * const kBookPropertyDescription         =       @"kBDescription";
//const NSString * const kBookPropertyStepNumbers         =       @"kBStepNums";
//const NSString * const kBookPropertyTopic               =       @"kBTopic";
//const NSString * const kBookPropertyTags                =       @"kBTags";
//const NSString * const kBookPropertyTips                =       @"kBTips";
//const NSString * const kBookPropertyKind                =       @"kBKind";
//const NSString * const kBookPropertySubKind             =       @"kBSubKind";
//const NSString * const kBookPropertyVisitNumbers        =       @"kBVisitNums";
//const NSString * const kBookPropertyFavorNumbers        =       @"kBFavorNums";
//const NSString * const kBookPropertyFollowMadeNumbers   =       @"kBFollowMadeNums";
//const NSString * const kBookPropertyIsPublish           =       @"kBIsPublish";
//const NSString * const kBookPropertyCreateTime          =       @"kBCreateTime";
//const NSString * const kBookPropertyEditTime            =       @"kBEditTime";
//const NSString * const kBookPropertyVideoUrl            =       @"kBVideoUrl";
//const NSString * const kBookPropertyScore               =       @"kBScore";
//const NSString * const kBookPropertyCookSteps           =       @"kBCookSteps";           //NSMutableArray
//const NSString * const kBookPropertyFoodMaterials       =       @"kBFoodMaterials";        //NSMutableArray
//
////cook steps
//const NSString * const kPhotoPropertySerialNumber       =       @"kPhotoSerialNum";
//const NSString * const kPhotoPropertyPhotoUrl           =       @"kPhotoUrl";
//const NSString * const kPhotoPropertyDescription        =       @"kPhotoDescription";
//const NSString * const kPhotoPropertyWidth              =       @"kPhotoWidth";
//const NSString * const kPhotoPropertyHeight             =       @"kPhotoHeight";
//const NSString * const kPhotoPropertyMoreText           =       @"kPhotoMoreText";
////const NSString * const kPhotoPropertyImageData          =       @"kPhotoImageData";
//
////food materials
//const NSString * const kBookFoodPropertySerialNumber    =       @"kBFSerialNum";
//const NSString * const kBookFoodPropertyFoodName        =       @"kBFName";
//const NSString * const kBookFoodPropertyQuantity        =       @"kBFQuantity";
//const NSString * const kBookFoodPropertyPurchaseUrl     =       @"kBFPurchaseUrl";

@implementation CookBookReformer

-(NSMutableDictionary *)reformDataWithRequest:(RetrieveRequest *)request
{
    if([request isKindOfClass:[RetrieveCookDataRequest class]]) {
        NSMutableArray * arrOrg = (NSMutableArray *)request.rawData;
        NSMutableArray * arrNew = [NSMutableArray array];
        for (NSDictionary *dOrg in arrOrg) {
            NSMutableDictionary *dNew = [CookBookReformer convertLocalBookDataFromNetBook:dOrg];
            [arrNew addObject:dNew];
        }
        
        return [NSMutableDictionary dictionaryWithObject:arrNew forKey:@"cuisinebooks"];
    }
    return nil;
}

+(NSMutableDictionary *)convertLocalBookDataFromNetBook:(NSDictionary *)dictData
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[kBookPropertyServerId] = dictData[@"id"];
    dict[kBookPropertyBookId] = [GlobalVar getUUID];
    dict[kBookPropertyDishName] = dictData[@"name"];
    dict[kBookPropertyDescription] = dictData[@"desc"];
    dict[kBookPropertyFrontCoverUrl] = dictData[@"cover"];
    dict[kBookPropertyFrontCoverMd5] = dictData[@"cover_md5"];
    dict[kBookPropertyTags] = dictData[@"tag"];
    dict[kBookPropertyTips] = dictData[@"tips"];
    dict[kBookPropertyCreateTime] = dictData[@"create_time"];
    
    //step
    dict[kBookPropertyStepNumbers] = dictData[@"step_num"];
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
    dict[kBookPropertyCookSteps] = arrNewSteps;
    
    //material
    NSArray * arrOrgMaterials = dictData[@"ingredients"];
    NSMutableArray *arrNewMaterials = [NSMutableArray array];
    
    for (NSDictionary *dOrg in arrOrgMaterials) {
        NSMutableDictionary *dNew = [NSMutableDictionary dictionary];
        dNew[kBookFoodPropertyFoodName] = dOrg[@"name"];
        dNew[kBookFoodPropertyQuantity] = dOrg[@"quantity"];
        dNew[kBookFoodPropertySerialNumber] = dOrg[@"seq"];
        
        [arrNewMaterials addObject:dNew];
    }
    dict[kBookPropertyFoodMaterials] = arrNewMaterials;
    
    //user
    dict[kBookPropertyCookerId] = dictData[@"user"][@"id"];
    dict[kBookPropertyCookerNickName] = dictData[@"user"][@"name"];
    dict[kBookPropertyCookerIconUrl] = dictData[@"user"][@"wx_headimgurl"];
    
    dict[kBookPropertyUrl] = dictData[@"url"];
    dict[kBookPropertyCardUrl] = dictData[@"card_url"];

    return dict;
}

+(NSMutableDictionary *)reformUploadDataFromLocalData:(NSDictionary *)dictData
{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
//    dict[kBookPropertyBookId] = dictData[kBookPropertyBookId];
    
    dict[@"name"] = dictData[kBookPropertyDishName]?dictData[kBookPropertyDishName]:@"";
    dict[@"desc"] = dictData[kBookPropertyDescription]?dictData[kBookPropertyDescription]:@"";
    dict[@"cover"] = dictData[kBookPropertyFrontCoverUrl]?dictData[kBookPropertyFrontCoverUrl]:@"";
    dict[@"tips"] = dictData[kBookPropertyTips]?dictData[kBookPropertyTips]:[NSMutableArray array];
    dict[@"tag"] = dictData[kBookPropertyTags]?dictData[kBookPropertyTags]:@"";
    
    NSArray * arrOrgSteps = dictData[kBookPropertyCookSteps];
    NSMutableArray *arrNewSteps = [NSMutableArray array];
    
    for (NSDictionary *dOrg in arrOrgSteps) {
        NSMutableDictionary *dNew = [NSMutableDictionary dictionary];
        dNew[@"image"] = dOrg[kPhotoPropertyPhotoUrl];
        dNew[@"plain"] = dOrg[kPhotoPropertyDescription];
        dNew[@"seq"] = dOrg[kPhotoPropertySerialNumber];
        
        [arrNewSteps addObject:dNew];
    }
    dict[@"steps"] = arrNewSteps;
    
    
    NSArray * arrOrgMaterials = dictData[kBookPropertyFoodMaterials];
    NSMutableArray *arrNewMaterials = [NSMutableArray array];
    
    for (NSDictionary *dOrg in arrOrgMaterials) {
        NSMutableDictionary *dNew = [NSMutableDictionary dictionary];
        dNew[@"name"] = dOrg[kBookFoodPropertyFoodName];
        dNew[@"quantity"] = dOrg[kBookFoodPropertyQuantity];
        dNew[@"seq"] = dOrg[kBookFoodPropertySerialNumber];
        
        [arrNewMaterials addObject:dNew];
    }
    dict[@"ingredients"] = arrNewMaterials;
    
    
    return dict;
}

@end
