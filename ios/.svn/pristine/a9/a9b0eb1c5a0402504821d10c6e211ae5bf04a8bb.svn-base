//
//  NavView.m
//  CookBook
//
//  Created by 你好 on 16/4/14.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "NavView.h"

@implementation NavView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



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
    self.backgroundColor=[UIColor whiteColor];
    
    self.centerLabel=[[UILabel alloc]initWithFrame:CGRectMake(60, 20, ScreenWidth-120, 44)];
    self.centerLabel.textAlignment=NSTextAlignmentCenter;
    self.centerLabel.backgroundColor=[UIColor clearColor];
    self.centerLabel.textColor=[UIColor blackColor];
    self.centerLabel.font=[UIFont systemFontOfSize:20];
    [self addSubview:self.centerLabel];
    
    self.leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.leftButton.frame=CGRectMake(0, 20, 50, 44);
    self.leftButton.backgroundColor=[UIColor clearColor];
    [self.leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:self.leftButton];
    
    self.rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.frame=CGRectMake(ScreenWidth-50, 20, 50, 44);
    self.rightButton.backgroundColor=[UIColor clearColor];
    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:self.rightButton];
    
    self.lineView=[[UIView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-1,self.bounds.size.width, 1)];
    self.lineView.backgroundColor=RGBACOLOR(1, 1, 1, 0.1);
    [self addSubview:self.lineView];
}

@end
