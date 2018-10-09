//
//  AFHttpTool.h
//  RCloud_liv_demo
//
//  Created by Liv on 14-10-22.
//  Copyright (c) 2014年 RongCloud. All rights reserved.
//


#import <Foundation/Foundation.h>


#define NET_RESULT_SUCCESS 0x000
#define error_login  0x001
#define error_logout  0x002
#define error_reset_  0x003

#define error_arguments_miss    0x010
#define error_arguments_format  0x011

#define error_auth_key_miss     0x020
#define error_auth_key_fmt      0x021
#define error_auth_key_match    0x022

#define error_user_exits   0x030
#define error_user_invalid  0x031
#define error_tel_exits    0x032

#define error_db_execute   0x040
#define error_data_unfound   0x041
#define error_data_exist   0x042
#define error_update_time  0x051
#define error_session_out  0x052

#define USER_TOKEN_EXPIRED 460
#define USER_REQUIR_AUTH 401
#define USER_TOKEN_AUTH_FAILED 461


typedef NS_ENUM(NSInteger, RequestMethodType){
    RequestMethodTypePost = 1,
    RequestMethodTypeGet = 2,
    RequestMethodTypePut = 3,
    RequestMethodTypePatch = 4,
    RequestMethodTypeDelete =5,
    RequestMethodTypeSingleUpload = 6
};

static NSString * kAFNetWorkStatusCodeKey=@"statusCode";

@interface AFHttpTool : NSObject
/*
 *  发送一个请求
 *
 *  @param methodType   请求方法
 *  @param url          请求路径
 *  @param params       请求参数
 *  @param success      请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure      请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+(void) requestWithMethod:(RequestMethodType)
                methodType url : (NSString *)url
                   params:(NSDictionary *)params
                  success:(void (^)(id response))success
                  failure:(void (^)(NSError *err))failure;


+ (void)requestWithMethod:(RequestMethodType)methodType
                      url:(NSString*)url
                   params:(NSDictionary*)params
                 progress:(void (^)(NSProgress * uploadProgress))progress
                  success:(void (^)(id response))success
                  failure:(void (^)(NSError* err))failure;


@end

