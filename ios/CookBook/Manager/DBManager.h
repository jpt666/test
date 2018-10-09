//
//  DBManager.h
//  CookBook
//
//  Created by zhangxi on 16/4/11.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *kDBKeyCookDataId = @"CookDataId";
static NSString *kDBKeyCookerId = @"CookerId";
static NSString *kDBKeyCookType = @"CookType";
static NSString *kDBKeyBaseData = @"BaseData";
static NSString *kDBKeyImagesData = @"ImagesData";
static NSString *kDBKeyExtendData = @"ExtendData";
static NSString *kDBKeyStatus = @"Status";
//const static NSString *kDBkeyFrontImage = @"FrontImage";

@interface DBManager : NSObject

+ (DBManager *)shareInstance;

- (NSMutableArray *)queryCookDataWithCookerId:(NSString *)cooker;

- (NSMutableDictionary *)queryCookDataDraft:(NSString *)cookDataId;

- (BOOL)saveCookDataDraft:(NSMutableDictionary *)dict;

- (BOOL)clearAllCookDataDraft;

- (BOOL)deleteCookDataDraft:(NSString *)cookDataId;

- (BOOL)updateCookDataDraft:(NSString *)cookDataId withStatus:(NSInteger)status;

- (BOOL)updateUnCookerData:(NSString *)cookerId;

@end
