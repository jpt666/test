//
//  EditSingleVIew.m
//  CookBook
//
//  Created by 你好 on 16/5/6.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "EditSingleVIew.h"

@implementation EditSingleVIew

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
    
    UIImage *headImage=[UIImage imageNamed:@"practice_icon"];
    self.headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, (50-headImage.size.height)/2-2, headImage.size.width, headImage.size.height)];
    [self addSubview:self.headImageView];
    
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(15+headImage.size.width, 0, ScreenWidth-15-headImage.size.width, self.bounds.size.height-5)];
    self.titleLabel.backgroundColor=[UIColor clearColor];
    self.titleLabel.textColor=[UIColor colorWithHexString:@"#343434"];
    [self addSubview:self.titleLabel];
    
    
    UIImage *lineImage=[UIImage imageNamed:@"dotted_line"];
    self.lineImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, self.bounds.size.height-lineImage.size.height, ScreenWidth-20, lineImage.size.height)];
    self.lineImageView.image=lineImage;
    [self addSubview:self.lineImageView];
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
