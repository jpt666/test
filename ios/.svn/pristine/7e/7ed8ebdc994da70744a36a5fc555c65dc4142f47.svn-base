//
//  CollectionReuseableView.m
//  CookBook
//
//  Created by 你好 on 16/6/12.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "CollectionReuseableView.h"

@implementation CollectionReuseableView

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
    self.topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    self.topView.backgroundColor=RGBACOLOR(207, 207, 207, 1);
    [self addSubview:self.topView];
    
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, ScreenWidth-20, self.bounds.size.height-10)];
    self.titleLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e"];
    [self addSubview:self.titleLabel];
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(10, self.bounds.size.height-1, ScreenWidth-20, 0.5)];
    lineView.backgroundColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.3];
    [self addSubview:lineView];
}

@end
