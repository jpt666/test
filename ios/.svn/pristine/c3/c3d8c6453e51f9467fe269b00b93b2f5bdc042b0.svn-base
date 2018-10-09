//
//  RetrieveDataRequest.h
//  CookBook
//
//  Created by zhangxi on 16/4/11.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHttpTool.h"

@class RetrieveRequest;
@protocol RetrieveRequestDelegate <NSObject>

-(void)didRetrieveDataSuccess:(RetrieveRequest *)request;
-(void)didRetrieveDataFailed:(RetrieveRequest *)request;

@end

@protocol ReformerProtocol <NSObject>

-(NSMutableDictionary *)reformDataWithRequest:(RetrieveRequest *)request;

@end

@interface RetrieveRequest : NSObject

@property (nonatomic, strong) NSMutableDictionary * rawData;
@property (nonatomic, weak) id<RetrieveRequestDelegate> delegate;
@property (nonatomic, strong) NSError * error;

-(NSMutableDictionary *)fetchDataWithReformer:(id<ReformerProtocol>)reformer;

- (void)request;

- (void)restart;

- (void)cancel;

- (void)getRequestWithUrl:(NSString *)url andParam:(NSDictionary *)dict;

- (void)postRequestWithUrl:(NSString *)url andParam:(NSDictionary *)dict;

- (void)deleteRequestWithUrl:(NSString *)url andParam:(NSDictionary *)dict;

- (void)patchRequestWithUrl:(NSString *)url andParam:(NSDictionary *)dict;

@end
