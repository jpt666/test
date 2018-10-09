//
//  CustomSingleLineView.m
//  CookBook
//
//  Created by 你好 on 16/4/19.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "CustomSingleLineView.h"

@implementation CustomSingleLineView



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
//    self.backgroundColor=[UIColor whiteColor];
    
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, ScreenWidth-20, self.bounds.size.height-0.5)];
    self.titleLabel.backgroundColor=[UIColor clearColor];
    self.titleLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e"];
    [self addSubview:self.titleLabel];
    
    
    self.lineView=[[UIView alloc]initWithFrame:CGRectMake(10, self.bounds.size.height-2, ScreenWidth-20, 0.5)];
    self.lineView.backgroundColor=[UIColor lightGrayColor];
    [self addSubview:self.lineView];
}

//-(void)drawRect:(CGRect)rect
//{
//    CGContextRef context =UIGraphicsGetCurrentContext();
//    CGContextBeginPath(context);
//    CGContextSetLineWidth(context, 1.0);
//    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
//    CGFloat lengths[] = {3,3};
//    CGContextSetLineDash(context, 0, lengths,2);
//    CGContextMoveToPoint(context, 10.0, self.bounds.size.height-2.5);
//    CGContextAddLineToPoint(context, ScreenWidth-10,self.bounds.size.height-2.5);
//    CGContextStrokePath(context);
//    CGContextClosePath(context);
//}


@end
