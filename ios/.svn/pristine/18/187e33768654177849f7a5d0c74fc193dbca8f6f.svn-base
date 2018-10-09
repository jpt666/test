//
//  TextView.m
//  CookBook
//
//  Created by 你好 on 16/5/13.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "TextView.h"

@implementation TextView


-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        UIImage *lineImage=[UIImage imageNamed:@"dotted_line"];
        self.lineImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-lineImage.size.height, self.bounds.size.width, lineImage.size.height)];
        self.lineImageView.image=lineImage;
        [self addSubview:self.lineImageView];
    }
    return self;
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
//    CGContextMoveToPoint(context, 0, self.bounds.size.height-2);
//    CGContextAddLineToPoint(context, ScreenWidth-20,self.bounds.size.height-2);
//    CGContextStrokePath(context);
//    CGContextClosePath(context);
//}


@end
