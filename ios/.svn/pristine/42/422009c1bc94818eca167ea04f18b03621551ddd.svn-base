//
//  CustomImageTitleView.m
//  CookBook
//
//  Created by 你好 on 16/5/5.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "CustomImageTitleView.h"
@implementation CustomImageTitleView


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
    UIImage *headImage=[UIImage imageNamed:@"practice_icon"];
    self.headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, (50-headImage.size.height)/2-2, headImage.size.width, headImage.size.height)];
    [self addSubview:self.headImageView];
    
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(15+headImage.size.width, 0, ScreenWidth-15-headImage.size.width, 50)];
    self.titleLabel.backgroundColor=[UIColor clearColor];
    self.titleLabel.textColor=[UIColor colorWithHexString:@"#343434"];
    [self addSubview:self.titleLabel];
    
    self.lineView=[[UIView alloc]initWithFrame:CGRectMake(10, self.bounds.size.height-2, ScreenWidth-20, 0.5)];
    self.lineView.backgroundColor=[UIColor colorWithHexString:@"#bbbbbb" alpha:0.8];
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
