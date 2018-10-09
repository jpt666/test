//
//  CookProductReformer.h
//  CookBook
//
//  Created by zhangxi on 16/4/11.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RetrieveRequest.h"

@interface CookProductReformer : NSObject<ReformerProtocol>

-(NSMutableDictionary *)reformDataWithRequest:(RetrieveRequest *)request;

+(NSMutableDictionary *)convertLocalProductDataFromNetProduct:(NSDictionary *)dictData;

+(NSMutableDictionary *)reformUploadDataFromLocalData:(NSDictionary *)dict;

@end
