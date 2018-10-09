//
//  CookProductProxy.m
//  CookBook
//
//  Created by zhangxi on 16/4/18.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "CookProductProxy.h"
#import "NSMutableDictionary+CookBook.h"
#import "CookProductPropertyKeys.h"
#import "CookPhotosPropertyKeys.h"
#import "CookProductReformer.h"
#import "GlobalVar.h"

@implementation CookProductProxy



-(instancetype)initWithImages:(NSArray *)images
{
    self = [super initWithImages:images];
    if (self) {
        self.dictBaseInfo = [NSMutableDictionary dictionaryForDefaultCookProduct];
        self.cookBaseId = self.dictBaseInfo[kProductPropertyProductId];
    }
    
    return self;
}

-(instancetype)initWithBaseData:(NSData *)baseData imagesData:(NSData *)imagesData
{
    self = [super initWithBaseData:baseData imagesData:imagesData];
    if (self) {
        self.cookBaseId = self.dictBaseInfo[kProductPropertyProductId];
    }
    return self;
}

-(instancetype)initWithDictionary:(NSMutableDictionary *)dict
{
   
    NSMutableArray * arrPhotoInfo = dict[kProductPropertyPhotos];
    if (!arrPhotoInfo) {
        return nil;
    }
    
    self = [super initWithDictionary:dict];
    if (self) {
        
        self.cookBaseId = self.dictBaseInfo[kProductPropertyProductId];
                
        NSString *frontUrl = dict[kProductPropertyFrontCoverUrl];
        NSString *frontMd5 = dict[kProductPropertyFrontCoverMd5];
        
        self.cookPhotoProxy = [[CookPhotoProxy alloc] initWithPhotoStep:arrPhotoInfo frontUrl:frontUrl andFrontMd5:frontMd5];
        self.cookPhotoProxy.delegate = self;
        

    }
    return self;
}

-(long long)editTime
{
    return [self.dictBaseInfo[kProductPropertyEditTime] longLongValue];
}

-(NSString *)dishName
{
    return self.dictBaseInfo[kProductPropertyDishName];
}

-(void)setDishName:(NSString *)dishName
{
    self.dictBaseInfo[kProductPropertyDishName] = dishName;
}


-(NSString *)cookDescription
{
    return self.dictBaseInfo[kProductPropertyDescription];
}

-(NSMutableArray *)tips
{
    return self.dictBaseInfo[kProductPropertyTips];
}

-(void)prepareData
{
//    self.dictBaseInfo[kProductPropertyDishName] = @"菜谱名";
//    self.dictBaseInfo[kProductPropertyFollowBookId] = @"aa-bb-cc";
//    self.dictBaseInfo[kProductPropertyPhotoNumbers] = @(4);
//    self.dictBaseInfo[kProductPropertyTopic] = @"参与话题";
//    self.dictBaseInfo[kProductPropertyTags] = @"标签";
//    self.dictBaseInfo[kProductPropertyTips] = @"贴士内容";
//    self.dictBaseInfo[kProductPropertyKind] = @"分类";
//    self.dictBaseInfo[kProductPropertySubKind] = @"子分类";
//    self.dictBaseInfo[kProductPropertyIsPublished] = @(YES);
//    self.dictBaseInfo[kProductPropertyCreateTime] = NSNumber numberWithLongLong:[NSDate date] timeIntervalSince1970]*1000;
    
    self.dictUploadParams = [CookProductReformer reformUploadDataFromLocalData:self.dictBaseInfo];
    
    if (self.dictBaseInfo[kProductPropertyServerId]) {
        [self setRequestMethodType:RequestMethodTypePut];
        [self setBaseDataRequestUrl:self.dictBaseInfo[kProductPropertyUrl]];
    } else {
        [self setRequestMethodType:RequestMethodTypePost];
        [self setBaseDataRequestUrl:[GlobalVar shareGlobalVar].cookDishsUrl];
    }
}

-(void)getUploadedPhotoInfo:(CookPhotoProxy *)cookPhotoProxy
{
    self.dictBaseInfo[kProductPropertyFrontCoverUrl] = [cookPhotoProxy getFrontImageMd5];
    self.dictBaseInfo[kProductPropertyPhotos] = cookPhotoProxy.arrCookPhotosInfo;
}

@end
