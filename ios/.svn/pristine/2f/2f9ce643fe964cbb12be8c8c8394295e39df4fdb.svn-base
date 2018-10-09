//
//  NSMutableDictionary+CookBook.m
//  CookBook
//
//  Created by zhangxi on 16/4/11.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "NSMutableDictionary+CookBook.h"
#import "CookBookPropertyKeys.h"
#import "CookProductPropertyKeys.h"
#import "UserManager.h"
#import "GlobalVar.h"

@implementation NSMutableDictionary (CookBook)

+ (NSMutableDictionary *)dictionaryForDefaultCookBook
{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    
    dict[kBookPropertyBookId] = [GlobalVar getUUID];
//    dict[kBookPropertyCookerId] = [UserManager shareInstance].curUser.userId;
//    dict[kBookPropertyCookerNickName] = [[UserManager shareInstance].curUser getNickName];
//    dict[kBookPropertyCookerIconUrl] = [[UserManager shareInstance].curUser getUserPhotoUrl];
    
    
    NSMutableArray * arrFoods = [NSMutableArray array];
    NSMutableArray * arrTips =[NSMutableArray array];
    dict[kBookPropertyFoodMaterials] = arrFoods;
    dict[kBookPropertyTips]=arrTips;
//    dict[kBookPropertyFoodMaterials] = [NSMutableArray array];
    
    return dict;
}

- (NSMutableDictionary *)dictionaryForDefaultPhotoInfo
{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    
//    dict[kBookStepPropertySerialNumber] = @(0);
//    dict[kBookStepPropertyPhotoUrl] = @"";
//    dict[kBookStepPropertyDescription] = @"";
//    dict[kBookStepPropertyMoreText] = @"";
    
    return dict;
}

+ (NSMutableDictionary *)dictionaryForDefaultFoodMaterials
{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    
    dict[kBookFoodPropertySerialNumber] = @(0);
    dict[kBookFoodPropertyFoodName] = @"";
    dict[kBookFoodPropertyQuantity] = @"";
    dict[kBookFoodPropertyPurchaseUrl] = @"";
    
    return dict;
}

+ (NSMutableDictionary *)dictionaryForDefaultCookProduct
{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    
    dict[kProductPropertyProductId] = [GlobalVar getUUID];
    dict[kProductPropertyCookerId] = @([UserManager shareInstance].curUser.userId);
    dict[kProductPropertyCookerNickName] = [[UserManager shareInstance].curUser getNickName];
    dict[kProductPropertyCookerIconUrl] = [[UserManager shareInstance].curUser getUserPhotoUrl];
    
    NSMutableArray *arrTips=[NSMutableArray array];
    dict[kProductPropertyTips]=arrTips;
    
    return dict;
}

@end

@implementation NSDictionary (CookBook)

- (NSMutableDictionary *)mutableCopyForBook
{
    NSMutableDictionary *dictRet = [NSMutableDictionary dictionaryWithDictionary:self];
    NSMutableArray *arrSteps = [NSMutableArray array];
    
    for (NSDictionary *d in self[kBookPropertyCookSteps]) {
        NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:d];
        [arrSteps addObject:mutableDict];
    }
    dictRet[kBookPropertyCookSteps] = arrSteps;
    
    NSMutableArray *arrFoods = [NSMutableArray array];
    
    for (NSDictionary *d in self[kBookPropertyFoodMaterials]) {
        NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:d];
        [arrFoods addObject:mutableDict];
    }
    dictRet[kBookPropertyFoodMaterials] = arrFoods;
    
    NSMutableArray *arrTips = [NSMutableArray arrayWithArray:self[kBookPropertyTips]];
    dictRet[kBookPropertyTips] = arrTips;
    
    return dictRet;
}


- (NSMutableDictionary *)mutableCopyForProduct
{
    NSMutableDictionary *dictRet = [NSMutableDictionary dictionaryWithDictionary:self];
    
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *d in self[kProductPropertyPhotos]) {
        NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:d];
        [arr addObject:mutableDict];
    }

    dictRet[kProductPropertyPhotos] = arr;
    return dictRet;
}

@end
