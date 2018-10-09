//
//  SetUpGroupTextView.m
//  CookBook
//
//  Created by 你好 on 16/8/16.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "SetUpGroupTextView.h"

@implementation SetUpGroupTextView

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
        self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, self.bounds.size.height)];
        [self addSubview:self.titleLabel];
        
        self.textField=[[UITextField alloc]initWithFrame:CGRectMake(110, 0, self.bounds.size.width-110, self.bounds.size.height)];
        self.textField.autocorrectionType=UITextAutocorrectionTypeNo;
        self.textField.autocapitalizationType=UITextAutocapitalizationTypeNone;
        [self addSubview:self.textField];
    }
    return self;
}

- (void)setLabelWidth:(CGFloat)width
{
    CGRect frame = self.titleLabel.frame;
    frame.size.width = width;
    self.titleLabel.frame = frame;
    
    self.textField.frame = CGRectMake(width+10, 0, self.bounds.size.width-width-10, self.bounds.size.height);
}

@end
