//
//  CookInfoProxy.m
//  CookBook
//
//  Created by zhangxi on 16/4/14.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "CookBookProxy.h"
#import "NSMutableDictionary+CookBook.h"
#import "CookBookPropertyKeys.h"
//#import "CookProductPropertyKeys.h"
#import "CookPhotosPropertyKeys.h"
#import "CookBookReformer.h"
#import "GlobalVar.h"

//#import "UploadDataRequest.h"
//#import "FastCoder.h"

@implementation CookBookProxy


-(instancetype)initWithImages:(NSArray *)images
{
    self = [super initWithImages:images];
    if (self) {
        self.dictBaseInfo = [NSMutableDictionary dictionaryForDefaultCookBook];
        self.cookBaseId = self.dictBaseInfo[kBookPropertyBookId];
        
        self.cookPhotoProxy.cookDataId = self.cookBaseId;
    }
    
    return self;
}

-(instancetype)initWithBaseData:(NSData *)baseData imagesData:(NSData *)imagesData
{
    self = [super initWithBaseData:baseData imagesData:imagesData];
    if (self) {
        self.cookBaseId = self.dictBaseInfo[kBookPropertyBookId];
        
        self.cookPhotoProxy.cookDataId = self.cookBaseId;
    }
    return self;
}

-(instancetype)initWithDictionary:(NSMutableDictionary *)dict
{
    NSMutableArray* arrPhotoInfo = dict[kBookPropertyCookSteps];
    if (!arrPhotoInfo) {
        return nil;
    }
    
    self = [super initWithDictionary:dict];
    if (self) {
        
        self.cookBaseId = self.dictBaseInfo[kBookPropertyBookId];

        NSString *frontUrl = dict[kBookPropertyFrontCoverUrl];
        NSString *frontMd5 = dict[kBookPropertyFrontCoverMd5];
        self.cookPhotoProxy = [[CookPhotoProxy alloc] initWithPhotoStep:arrPhotoInfo frontUrl:frontUrl andFrontMd5:frontMd5];
        self.cookPhotoProxy.delegate = self;
        
        self.cookPhotoProxy.cookDataId = self.cookBaseId;
    }
    return self;
}

-(long long)editTime
{
    return [self.dictBaseInfo[kBookPropertyEditTime] longLongValue];
}

-(NSString *)dishName
{
    return self.dictBaseInfo[kBookPropertyDishName];
}

-(void)setDishName:(NSString *)dishName
{
    self.dictBaseInfo[kBookPropertyDishName] = dishName;
}

-(NSString *)cookDescription
{
    return self.dictBaseInfo[kBookPropertyDescription];
}

-(NSString *)tips
{
    return self.dictBaseInfo[kBookPropertyTips];
}

-(NSMutableArray *)foodMaterials
{
    return self.dictBaseInfo[kBookPropertyFoodMaterials];
}


-(void)prepareData
{
//    NSMutableArray *arr = [NSMutableArray array];
//    NSMutableDictionary *d = [NSMutableDictionary dictionary];
//    d[kBookFoodPropertySerialNumber] = @(0);
//    d[kBookFoodPropertyFoodName] = @"食物0";
//    d[kBookFoodPropertyQuantity] = @"数量0";
//    d[kBookFoodPropertyPurchaseUrl] = @"http://url0";
//    [arr addObject:d];
//    
//    d = [NSMutableDictionary dictionary];
//    d[kBookFoodPropertySerialNumber] = @(1);
//    d[kBookFoodPropertyFoodName] = @"食物1";
//    d[kBookFoodPropertyQuantity] = @"数量1";
//    d[kBookFoodPropertyPurchaseUrl] = @"http://url1";
//    [arr addObject:d];
//    
//    d = [NSMutableDictionary dictionary];
//    d[kBookFoodPropertySerialNumber] = @(2);
//    d[kBookFoodPropertyFoodName] = @"食物2";
//    d[kBookFoodPropertyQuantity] = @"数量2";
//    d[kBookFoodPropertyPurchaseUrl] = @"http://url2";
//    [arr addObject:d];
//    
//    d = [NSMutableDictionary dictionary];
//    d[kBookFoodPropertySerialNumber] = @(3);
//    d[kBookFoodPropertyFoodName] = @"食物3";
//    d[kBookFoodPropertyQuantity] = @"数量3";
//    d[kBookFoodPropertyPurchaseUrl] = @"http://url3";
//    [arr addObject:d];
//    
//    self.dictBaseInfo[kBookPropertyFoodMaterials] = arr;
//    
//    self.dictBaseInfo[kBookPropertyDishName] = @"菜谱名";
//    self.dictBaseInfo[kBookPropertyTimeNeeded] = @"";
//    self.dictBaseInfo[kBookPropertyDescription] = @"菜谱描述";
//    self.dictBaseInfo[kBookPropertyStepNumbers] = @(4);
//    self.dictBaseInfo[kBookPropertyTopic] = @"参与话题";
//    self.dictBaseInfo[kBookPropertyTags] = @"标签";
//    self.dictBaseInfo[kBookPropertyTips] = @"贴士内容";
//    self.dictBaseInfo[kBookPropertyKind] = @"分类";
//    self.dictBaseInfo[kBookPropertySubKind] = @"子分类";
//    self.dictBaseInfo[kBookPropertyVisitNumbers] = @(0);
//    self.dictBaseInfo[kBookPropertyFavorNumbers] = @(0);
//    self.dictBaseInfo[kBookPropertyFollowMadeNumbers] = @(0);
//    self.dictBaseInfo[kBookPropertyIsPublish] = @(YES);
    self.dictBaseInfo[kBookPropertyCreateTime] = @([[NSDate date] timeIntervalSince1970]);
//    self.dictBaseInfo[kBookPropertyVideoUrl] = @"http://videoUrl";
    
    self.dictUploadParams = [CookBookReformer reformUploadDataFromLocalData:self.dictBaseInfo];
    
    if (self.dictBaseInfo[kBookPropertyServerId]) {
        [self setRequestMethodType:RequestMethodTypePut];
        [self setBaseDataRequestUrl:self.dictBaseInfo[kBookPropertyUrl]];
    } else {
        [self setRequestMethodType:RequestMethodTypePost];
        [self setBaseDataRequestUrl:[GlobalVar shareGlobalVar].cookRecipesUrl];
    }
}

-(void)getUploadedPhotoInfo:(CookPhotoProxy *)cookPhotoProxy
{
    self.dictBaseInfo[kBookPropertyFrontCoverUrl] = [cookPhotoProxy getFrontImageMd5];
    self.dictBaseInfo[kBookPropertyCookSteps] = cookPhotoProxy.arrCookPhotosInfo;
}

@end
