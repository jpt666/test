//
//  CustomLineView.m
//  CookBook
//
//  Created by 你好 on 16/4/15.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "CustomLineView.h"

@implementation CustomLineView


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
    
    self.leftLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.bounds.size.width/2-20, self.bounds.size.height)];
    self.leftLabel.backgroundColor=[UIColor clearColor];
    self.leftLabel.textColor=[UIColor lightGrayColor];
    self.leftLabel.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.leftLabel];
    
    self.rightLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width/2+20, 0, self.bounds.size.width/2-20, self.bounds.size.height)];
    self.rightLabel.textAlignment=NSTextAlignmentLeft;
    self.rightLabel.backgroundColor=[UIColor clearColor];
    self.rightLabel.textColor=[UIColor lightGrayColor];
    [self addSubview:self.rightLabel];
    
    UIImage *lineImage=[UIImage imageNamed:@"dotted_line"];
    self.lineImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, self.bounds.size.height-lineImage.size.height, ScreenWidth-20, lineImage.size.height)];
    self.lineImageView.image=lineImage;
    [self addSubview:self.lineImageView];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_delegate && [_delegate respondsToSelector:@selector(customLineViewClick:)])
    {
        [_delegate customLineViewClick:self];
    }
}


//-(void)drawRect:(CGRect)rect
//{
//    [super drawRect:rect];
//
//    CGContextRef context =UIGraphicsGetCurrentContext();
//    CGContextBeginPath(context);
//    CGContextSetLineWidth(context, 1.0);
//    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
//    CGFloat lengths[] = {3,3};
//    CGContextSetLineDash(context, 0, lengths,2);
//    CGContextMoveToPoint(context, 10.0, self.bounds.size.height-2);
//    CGContextAddLineToPoint(context, ScreenWidth-10,self.bounds.size.height-2);
//    CGContextStrokePath(context);
//    CGContextClosePath(context);
//}

@end
