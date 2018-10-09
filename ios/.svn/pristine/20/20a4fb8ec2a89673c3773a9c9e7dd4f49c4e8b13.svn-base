//
//  DictButton.m
//  CookBook
//
//  Created by 你好 on 16/5/18.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "DictButton.h"

@implementation DictButton
{
    CAGradientLayer *_gradientLayer;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self= [super initWithFrame:frame];
    if (self)
    {
        _gradientLayer=[CAGradientLayer layer];
        _gradientLayer.frame=CGRectMake(0, 0, frame.size.width, frame.size.height/2);
        _gradientLayer.colors=[NSArray arrayWithObjects:(id)RGBACOLOR(1, 1, 1, 0.6).CGColor,(id)RGBACOLOR(1, 1, 1, 0.4).CGColor, (id)RGBACOLOR(1, 1, 1, 0.2), nil];
        [self.layer insertSublayer:_gradientLayer atIndex:0];
        
        self.descLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, frame.size.width-20, 30)];
        self.descLabel.font=[UIFont systemFontOfSize:16];
        self.descLabel.backgroundColor=[UIColor clearColor];
        self.descLabel.textColor=[UIColor whiteColor];
        self.descLabel.numberOfLines=2;
        self.descLabel.lineBreakMode=NSLineBreakByTruncatingTail;
        self.descLabel.userInteractionEnabled=YES;
        [self addSubview:self.descLabel];
    }
    return self;
}

@end
