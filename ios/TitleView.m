//
//  TitleView.m
//  CookBook
//
//  Created by 你好 on 16/6/20.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "TitleView.h"

@implementation TitleView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor=[UIColor whiteColor];
        [self configUI];
    }
    return self;
}



-(void)configUI
{
    self.frontView=[[UIView alloc]initWithFrame:CGRectMake(9, 10, 5, self.bounds.size.height-20)];
    self.frontView.layer.cornerRadius=3;
    self.frontView.clipsToBounds=YES;
    [self addSubview:self.frontView];
    
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(25, 0, ScreenWidth-25, self.bounds.size.height)];
    self.titleLabel.font=[UIFont boldSystemFontOfSize:17];
    [self addSubview:self.titleLabel];
}

@end
