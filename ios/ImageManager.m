//
//  ImageManager.m
//  CookBook
//
//  Created by 你好 on 16/4/19.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "ImageManager.h"

@implementation ImageManager

+ (ImageManager*)shareInstance
{
    static ImageManager* instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[[self class] alloc] init];
    });
    
    return instance;
}


@end
