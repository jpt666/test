//
//  CookBookError.m
//  CookBook
//
//  Created by zhangxi on 16/6/30.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "CookBookError.h"

@implementation CookBookError

+ (NSDictionary *)errorDictionary
{
    static NSDictionary *s_errorDictionary;
    if (s_errorDictionary==nil) {
        s_errorDictionary = @{@(-999):@"网络未连接，请检查网络",
                              @(-1001):@"网络不给力，请稍后再试吧！",
                              @(-1009):@"网络未连接，请检查网络",
                              @(502):@"服务器繁忙，请稍后再试！",
                              @(500):@"服务器繁忙，请稍后再试！",
                              @(-9999):@"无效的请求地址"};
    }
    
    return s_errorDictionary;
}

+ (NSString *)descriptionForIntCode:(NSInteger)code
{
    NSDictionary *dict = [CookBookError errorDictionary];
    return [dict objectForKey:[NSNumber numberWithInteger:code]];
}

//+ (NSString *)descriptionForStringCode:(NSString *)strCode
//{
//    NSDictionary *dict = [CookBookError errorDictionary];
//    return [dict objectForKey:strCode];
//}

@end
