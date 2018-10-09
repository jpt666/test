//
//  PickUpAddressView.m
//  CookBook
//
//  Created by 你好 on 16/8/11.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "PickUpAddressView.h"
#import "GroupsPropertyKeys.h"
@implementation PickUpAddressView

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
        self.backgroundColor=[UIColor whiteColor];
        
        self.leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
        self.leftButton.frame=CGRectMake(0, 0, self.bounds.size.width/2, self.bounds.size.height);
        [self.leftButton setTitle:@"固定自提点" forState:UIControlStateNormal];
        [self.leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.leftButton setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [self.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.leftButton];
        
        self.rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
        self.rightButton.frame=CGRectMake(self.bounds.size.width/2, 0, self.bounds.size.width/2, self.bounds.size.height);
        [self.rightButton setTitle:@"临时自提点" forState:UIControlStateNormal];
        [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.rightButton setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [self.rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.rightButton];
        
        self.centerButton=[DisableHighlightButton buttonWithType:UIButtonTypeCustom];
        self.centerButton.frame=CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        [self.centerButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        self.centerButton.hidden=YES;
        [self addSubview:self.centerButton];
        
        self.lineView=[[UIView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-2, self.bounds.size.width/2, 1.5)];
        self.lineView.backgroundColor=[UIColor orangeColor];
        [self addSubview:self.lineView];
        
        self.leftButton.selected=YES;
        
    }
    return self;
}

-(void)configViewForOrder:(NSDictionary *)dict
{
    if ([dict[kGroupsPropertyRecieveMode] integerValue]==ReceiveModePickUp)
    {
        self.centerButton.hidden=NO;
        self.leftButton.hidden=YES;
        self.rightButton.hidden=YES;
        [self.centerButton setTitle:@"自提点自提" forState:UIControlStateNormal];
        self.lineView.frame=CGRectMake(0, self.bounds.size.height-2, self.bounds.size.width, 1.5);
    }
    else if ([dict[kGroupsPropertyRecieveMode] integerValue]==ReceiveModeDeliver)
    {
        self.centerButton.hidden=NO;
        self.leftButton.hidden=YES;
        self.rightButton.hidden=YES;
        [self.centerButton setTitle:@"送货上门" forState:UIControlStateNormal];
        self.lineView.frame=CGRectMake(0, self.bounds.size.height-2, self.bounds.size.width, 1.5);
    }
    else if ([dict[kGroupsPropertyRecieveMode] integerValue]==ReceiveModePickUpAndDeliver)
    {
        self.centerButton.hidden=YES;
        self.leftButton.hidden=NO;
        self.rightButton.hidden=NO;
        [self.centerButton setTitle:@"" forState:UIControlStateNormal];
        [self.leftButton setTitle:@"自提点自提" forState:UIControlStateNormal];
        [self.rightButton setTitle:@"送货上门" forState:UIControlStateNormal];
        self.lineView.frame=CGRectMake(0, self.bounds.size.height-2, self.bounds.size.width/2, 1.5);
    }
}


-(void)setLeftButtonSeleted
{
    self.leftButton.selected=YES;
    self.rightButton.selected=NO;
    [UIView animateWithDuration:0.15 animations:^{
        self.lineView.frame=CGRectMake(0, self.bounds.size.height-1, self.bounds.size.width/2, 1);
    }];
    
    if (_delegate && [_delegate respondsToSelector:@selector(fixedButtonClick:)]) {
        [_delegate fixedButtonClick:self];
    }
}

-(void)setRightButtonSeleted
{
    self.leftButton.selected=NO;
    self.rightButton.selected=YES;
    [UIView animateWithDuration:0.15 animations:^{
        self.lineView.frame=CGRectMake(self.bounds.size.width/2, self.bounds.size.height-1, self.bounds.size.width/2, 1);
    }];
    
    if (_delegate && [_delegate respondsToSelector:@selector(tempButtonClick:)]) {
        [_delegate tempButtonClick:self];
    }
}

-(void)leftButtonClick:(UIButton *)button
{
    [self setLeftButtonSeleted];
}

-(void)rightButtonClick:(UIButton *)button
{
    [self setRightButtonSeleted];
}


@end
