//
//  DataManager.h
//  CookBook
//
//  Created by zhangxi on 16/4/11.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CookBaseProxy.h"
#import "CookBookProxy.h"

@class CookDataManager;

@protocol CookDataManagerDelegate  <NSObject>

-(void)didLocalCookDataChanged:(CookDataManager *)cookDataMng;

-(void)didCookDataUploadProgressChanged:(CookBaseProxy *)cookBaseProxy;

@end

@interface CookDataManager : NSObject<CookBaseProxyDelegate>

@property (nonatomic, weak) id<CookDataManagerDelegate> delegate;

+(CookDataManager *)shareInstance;

-(NSMutableArray *)retrieveCookDataDrafts;

-(void)recoverCookDataDraft:(NSString *)cookDataId;

-(void)clearCookDataDrafts;

-(void)recoverCookUploading;

@end
