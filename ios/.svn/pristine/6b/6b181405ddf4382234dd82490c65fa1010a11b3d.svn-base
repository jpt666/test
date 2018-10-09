//
//  BottomTextView.m
//  CookBook
//
//  Created by 你好 on 16/5/4.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "BottomTextView.h"

@implementation BottomTextView

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
    UIView *textBackView=[[UIView alloc]initWithFrame:CGRectMake(10, 10, ScreenWidth-70, 29)];
    textBackView.backgroundColor=RGBACOLOR(182, 182, 182, 0.8);
    textBackView.layer.cornerRadius=8;
    textBackView.clipsToBounds=YES;
    [self addSubview:textBackView];
    
    self.textFiled=[[UITextField alloc]initWithFrame:CGRectMake(10, 0,textBackView.bounds.size.width-10, textBackView.bounds.size.height)];
    self.textFiled.autocorrectionType=UITextAutocorrectionTypeNo;
    self.textFiled.autocapitalizationType=UITextAutocapitalizationTypeNone;
    self.textFiled.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"我想说两句" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    self.textFiled.tintColor=[UIColor whiteColor];
    self.textFiled.textColor=[UIColor whiteColor];
    self.textFiled.returnKeyType=UIReturnKeyDone;
    self.textFiled.font=[UIFont systemFontOfSize:16];
    [textBackView addSubview:self.textFiled];
    
    self.publishBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.publishBtn.frame=CGRectMake(ScreenWidth-60, 0, 60, 49);
    [self.publishBtn setTitle:@"发布" forState:UIControlStateNormal];
    [self.publishBtn setTitleColor:RGBACOLOR(176, 116, 67, 1) forState:UIControlStateNormal];
    [self addSubview:self.publishBtn];
}

@end
