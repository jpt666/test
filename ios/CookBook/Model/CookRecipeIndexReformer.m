//
//  CookRecipeIndexReformer.m
//  CookBook
//
//  Created by zhangxi on 16/6/24.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "CookRecipeIndexReformer.h"

@implementation CookRecipeIndexReformer

-(NSMutableDictionary *)reformDataWithRequest:(RetrieveRequest *)request
{
    return request.rawData;
}

@end
