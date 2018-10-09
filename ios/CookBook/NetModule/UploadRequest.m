//
//  UploadDataRequest.m
//  CookBook
//
//  Created by zhangxi on 16/4/11.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "UploadRequest.h"

@implementation UploadRequest

-(void)cancel
{
    if (self.delegate) {
        self.delegate = nil;
    }
}

-(void)restart
{
    
}

-(void)request
{
    
}

@end
