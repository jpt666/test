//
//  SetGroupTimeView.m
//  CookBook
//
//  Created by 你好 on 16/8/11.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "SetGroupTimeView.h"

@implementation SetGroupTimeView

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
    if(self)
    {
        [self configUI];
    }
    return self;
}

-(void)configUI
{
    self.backgroundColor=[UIColor whiteColor];
    
    self.leftLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, (self.bounds.size.width-20)/3, self.bounds.size.height-0.5)];
    [self addSubview:self.leftLabel];
    
    self.centerLabel=[[UILabel alloc]initWithFrame:CGRectMake(10+(self.bounds.size.width-20)/3, 0, (self.bounds.size.width-20)/3, self.bounds.size.height-0.5)];
    self.centerLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.5];
    self.centerLabel.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.centerLabel];
    
    self.rightLabel=[[UILabel alloc]initWithFrame:CGRectMake(10+(self.bounds.size.width-20)/3*2, 0, (self.bounds.size.width-20)/3, self.bounds.size.height-0.5)];
    self.rightLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.5];
    self.rightLabel.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.rightLabel];
    
    self.bottomLineView=[[UIView alloc]initWithFrame:CGRectMake(10, self.bounds.size.height-0.5, self.bounds.size.width-20, 0.5)];
    self.bottomLineView.backgroundColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.3];
    [self addSubview:self.bottomLineView];
}

-(void)setDate:(NSDate *)date
{
    _date = date;
    
    NSDateFormatter *dateFormate=[[NSDateFormatter alloc]init];
    [dateFormate setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString *dateStr=[dateFormate stringFromDate:date];
    NSRange range=[dateStr rangeOfString:@" "];
    NSString *centerStr=[dateStr substringToIndex:range.location];
    NSString *rightStr=[dateStr substringWithRange:NSMakeRange(range.location+1, dateStr.length-centerStr.length-1)];
    self.centerLabel.text=centerStr;
    self.rightLabel.text=rightStr;
}


@end
