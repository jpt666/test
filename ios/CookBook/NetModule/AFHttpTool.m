//
//  AFHttpTool.m
//  RCloud_liv_demo
//
//  Created by Liv on 14-10-22.
//  Copyright (c) 2014年 RongCloud. All rights reserved.
//


#import "AFHttpTool.h"
#import "AFNetworking.h"
#import "UserManager.h"
#import "GlobalVar.h"

//#define ContentType @"text/plain"
#define ContentType @"text/html"


@implementation AFHttpTool

+ (void)requestWithMethod:(RequestMethodType)methodType
                      url:(NSString*)url
                   params:(NSDictionary*)params
                  success:(void (^)(id response))success
                  failure:(void (^)(NSError* err))failure
{
    [self requestWithMethod:methodType url:url params:params progress:nil success:success failure:failure];
}

+ (void)requestWithMethod:(RequestMethodType)methodType
                      url:(NSString*)url
                   params:(NSDictionary*)params
                 progress:(void (^)(NSProgress * uploadProgress))progress
                  success:(void (^)(id response))success
                  failure:(void (^)(NSError* err))failure
{
    if (!url) {
        NSDictionary * dict = @{NSLocalizedDescriptionKey:@"无效的请求地址",
                                kAFNetWorkStatusCodeKey:@(-9999)};
        NSError * err = [NSError errorWithDomain:SERVER_HOST code:-9999 userInfo:dict];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (failure) {
                failure(err);
            }
        });
        
        return;

    }
    
    if ([GlobalVar shareGlobalVar].bNetworkInitialed
        &&![[AFNetworkReachabilityManager sharedManager] isReachable]) {
        
        NSDictionary * dict = @{NSLocalizedDescriptionKey:@"网络未连接，请检查网络",
                                kAFNetWorkStatusCodeKey:@(-999)};
        NSError * err = [NSError errorWithDomain:SERVER_HOST code:-999 userInfo:dict];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (failure) {
                failure(err);
            }
        });

        return;
    }

    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.requestSerializer = [[AFJSONRequestSerializer alloc] init];
    mgr.requestSerializer.timeoutInterval = 15;
    
    if ([UserManager shareInstance].bIsLogin && [UserManager shareInstance].curUser.token) {
        [mgr.requestSerializer setValue:[NSString stringWithFormat:@"JWT %@",[UserManager shareInstance].curUser.token]forHTTPHeaderField:@"Authorization"];
    }
    
    mgr.requestSerializer.HTTPShouldHandleCookies = YES;
    mgr.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    ((AFJSONResponseSerializer *)mgr.responseSerializer).removesKeysWithNullValues = YES;
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json",nil];
    
    
    switch (methodType) {
        case RequestMethodTypeGet:
        {
            //GET请求
            [mgr GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                if (progress) {
                    progress(downloadProgress);
                }
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
#ifdef DEBUG
                NSString * str = [[NSString alloc] initWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding];
#endif
                
                NSError * err = [self processError:error withResponse:(NSHTTPURLResponse *)task.response];
                if (failure) {
                    failure(err);
                }
            }];
        }
            break;
        case RequestMethodTypePost:
        {
            //POST请求
            [mgr POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                if (progress) {
                    progress(uploadProgress);
                }
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
#ifdef DEBUG
                NSString * str = [[NSString alloc] initWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding];
#endif
                
                NSError * err = [self processError:error withResponse:(NSHTTPURLResponse *)task.response];
                if (failure) {
                    failure(err);
                }
            }];
        }
            break;
            
        case RequestMethodTypePatch:
        {
            [mgr PATCH:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                NSError * err = [self processError:error withResponse:(NSHTTPURLResponse *)task.response];
                if (failure) {
                    failure(err);
                }
            }];
        }
            break;
            
        case RequestMethodTypePut:
        {
            [mgr PUT:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSError * err = [self processError:error withResponse:(NSHTTPURLResponse *)task.response];
                if (failure) {
                    failure(err);
                }
            }];
        }
            break;
        
        case RequestMethodTypeDelete:
        {
            [mgr DELETE:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSError * err = [self processError:error withResponse:(NSHTTPURLResponse *)task.response];
                if (failure) {
                    failure(err);
                }
            }];
        }
            break;
        case RequestMethodTypeSingleUpload:
        {
            [mgr POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                [formData appendPartWithFileData:params[@"file"] name:@"file" fileName:@"img" mimeType:@"image/png"];
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                if (progress) {
                    progress(uploadProgress);
                }
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSError * err = [self processError:error withResponse:(NSHTTPURLResponse *)task.response];
                if (failure) {
                    failure(err);
                }
            }];
        }
        default:
            break;
    }
    
}

+ (NSError *)processError:(NSError *)error withResponse:(NSHTTPURLResponse *)resp
{
 
    if (resp.statusCode == USER_TOKEN_EXPIRED ||
        resp.statusCode == USER_TOKEN_AUTH_FAILED ||
        resp.statusCode == USER_REQUIR_AUTH) {
        [[GlobalVar shareGlobalVar] notifyEvent:UI_EVENT_USER_AUTH_FAILED object:error];
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:error.userInfo];
    if (error.code == -1001 ||
        error.code == -1009) {
        dict[kAFNetWorkStatusCodeKey] = @(error.code);
    } else {
        dict[kAFNetWorkStatusCodeKey] = @(resp.statusCode);
    }
    NSError *err = [NSError errorWithDomain:error.domain code:error.code userInfo:dict];
    
    return err;
}



@end
