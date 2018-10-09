//
//  CustomClickView.m
//  CookBook
//
//  Created by 你好 on 16/5/5.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "CustomClickView.h"

@implementation CustomClickView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        [self configUI];
    }
    return self;
}


-(void)configUI
{
    self.userInteractionEnabled=YES;
    
    self.topImageView=[[UIImageView alloc]initWithFrame:CGRectMake((self.bounds.size.width-self.topImage.size.width)/2,5, self.topImage.size.width, self.topImage.size.height)];
    self.topImageView.userInteractionEnabled=YES;
    [self addSubview:self.topImageView];
    
    self.bottomLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, self.topImage.size.height+5, self.bounds.size.width, self.bounds.size.height-self.topImage.size.height)];
    self.bottomLabel.backgroundColor=[UIColor clearColor];
    self.bottomLabel.textColor=[UIColor blackColor];
    self.bottomLabel.font=[UIFont systemFontOfSize:12];
    self.bottomLabel.textAlignment=NSTextAlignmentCenter;
    self.bottomLabel.userInteractionEnabled=YES;
    [self addSubview:self.bottomLabel];
}


@end
