//
//  ParticipantReformer.h
//  CookBook
//
//  Created by zhangxi on 16/6/7.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RetrieveRequest.h"

@interface ParticipantReformer : NSObject<ReformerProtocol>

-(NSMutableDictionary *)reformDataWithRequest:(RetrieveRequest *)request;

@end
