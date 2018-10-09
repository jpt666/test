//
//  CookBookReformer.h
//  CookBook
//
//  Created by zhangxi on 16/4/11.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RetrieveRequest.h"

@interface CookBookReformer : NSObject<ReformerProtocol>

-(NSMutableArray *)reformDataWithRequest:(RetrieveRequest *)request;

+(NSMutableDictionary *)convertLocalBookDataFromNetBook:(NSDictionary *)dictData;

+(NSMutableDictionary *)reformUploadDataFromLocalData:(NSDictionary *)dict;

@end
