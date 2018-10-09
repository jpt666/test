//
//  DatePickerView.m
//  CookBook
//
//  Created by 你好 on 16/8/12.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "DatePickerView.h"

@implementation DatePickerView

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
        [self configUI];
    }
    return self;
}


-(void)configUI
{
    self.backgroundColor=[UIColor whiteColor];
    
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 50)];
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
    
    [self addSubview:self.titleLabel];
    
    self.finishButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.finishButton.frame=CGRectMake(10, self.bounds.size.height-60, self.bounds.size.width-20, 50);
    self.finishButton.layer.borderColor=RGBACOLOR(191, 192, 191, 1).CGColor;
    self.finishButton.backgroundColor=RGBACOLOR(232, 233, 232, 1);
    self.finishButton.layer.borderWidth=1.0f;
    self.finishButton.layer.cornerRadius=25;
    [self.finishButton setTitle:@"完成" forState:UIControlStateNormal];
    [self.finishButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:self.finishButton];
    
    self.datePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 50, self.bounds.size.width, self.bounds.size.height-110)];
    self.datePicker.datePickerMode=UIDatePickerModeDateAndTime;
    [self addSubview:self.datePicker];
    
}

@end
