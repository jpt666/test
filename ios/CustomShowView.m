//
//  CustomShowView.m
//  CookBook
//
//  Created by 你好 on 16/5/26.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "CustomShowView.h"

@implementation CustomShowView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        self.headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        [self addSubview:self.headImageView];
        
        self.numLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 0, 15, 15)];
        self.numLabel.backgroundColor=[UIColor clearColor];
        self.numLabel.textColor=[UIColor whiteColor];
        self.numLabel.font=[UIFont systemFontOfSize:14];
        [self addSubview:self.numLabel];
    }
    return self;
}

@end
