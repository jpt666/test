//
//  EditLineView.m
//  CookBook
//
//  Created by 你好 on 16/5/6.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "EditLineView.h"
@implementation EditLineView


-(instancetype)initWithFrame:(CGRect)frame
{
    self= [super initWithFrame:frame];
    if (self)
    {
        [self configUI];
    }
    return self;
}

-(void)configUI
{
    self.backgroundColor=[UIColor whiteColor];
    
    self.leftLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.bounds.size.width/2-20, self.bounds.size.height-5)];
    self.leftLabel.backgroundColor=[UIColor clearColor];
    self.leftLabel.textColor=[UIColor colorWithHexString:@"#bbbbbb"];
    self.leftLabel.font=[UIFont systemFontOfSize:16];
    self.leftLabel.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.leftLabel];
    
    self.rightLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width/2+20, 0, ScreenWidth/2-20, self.bounds.size.height-5)];
    self.rightLabel.textAlignment=NSTextAlignmentLeft;
    self.rightLabel.backgroundColor=[UIColor clearColor];
    self.rightLabel.font=[UIFont systemFontOfSize:16];
    self.rightLabel.textColor=[UIColor colorWithHexString:@"#bbbbbb"];
    [self addSubview:self.rightLabel];
    
    self.lineView=[[UIView alloc]initWithFrame:CGRectMake(10, self.bounds.size.height-2, ScreenWidth-20, 0.5)];
    self.lineView.backgroundColor=[UIColor colorWithHexString:@"#bbbbbb" alpha:0.8] ;
    [self addSubview:self.lineView];
}


@end
