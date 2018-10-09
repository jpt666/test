//
//  ConfirmOrderCenterView.m
//  CookBook
//
//  Created by 你好 on 16/6/6.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "ConfirmOrderCenterView.h"
#import "GroupsPropertyKeys.h"
@implementation ConfirmOrderCenterView

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
    self.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    
    self.backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-10)];
    self.backView.backgroundColor=[UIColor whiteColor];
    [self addSubview:self.backView];
    
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 15, 100, 30)];
    self.titleLabel.text=@"配送方式";
    self.titleLabel.font=[UIFont boldSystemFontOfSize:17];
    self.titleLabel.textColor=[UIColor blackColor];
    [self.backView addSubview:self.titleLabel];
    
    self.leftButton=[DisableHighlightButton buttonWithType:UIButtonTypeCustom];
    self.leftButton.frame=CGRectMake(self.bounds.size.width-140,14, 60, 30);
    self.leftButton.titleLabel.font=[UIFont systemFontOfSize:15];
    [self.leftButton setTitle:@"上门自提" forState:UIControlStateNormal];
    [self.leftButton setTitleColor:[UIColor colorWithHexString:@"#4e4e4e"] forState:UIControlStateNormal];
    [self.leftButton setTitleColor:RGBACOLOR(176, 116, 67, 1) forState:UIControlStateSelected];
    [self.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.leftButton];
    
    self.rightButton=[DisableHighlightButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.frame=CGRectMake(self.bounds.size.width-70,14, 60, 30);
    self.rightButton.titleLabel.font=[UIFont systemFontOfSize:15];
    [self.rightButton setTitle:@"送货上门" forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor colorWithHexString:@"#4e4e4e"] forState:UIControlStateNormal];
    [self.rightButton setTitleColor:RGBACOLOR(176, 116, 67, 1) forState:UIControlStateSelected];
    [self.rightButton addTarget:self action:@selector(didRightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.rightButton];
    
    self.addressTable=[[UITableView alloc]initWithFrame:CGRectMake(0, 55, self.bounds.size.width, self.bounds.size.height-75) style:UITableViewStylePlain];
    self.addressTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.backView addSubview:self.addressTable];
    
    self.rightView=[[UIView alloc]initWithFrame:CGRectMake(0, 50, self.bounds.size.width, self.bounds.size.height-75)];
    self.rightView.hidden=YES;
    [self.backView addSubview:self.rightView];
    
    self.addressLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.rightView.bounds.size.width-20-90, self.rightView.bounds.size.height)];
    self.addressLabel.backgroundColor=[UIColor clearColor];
    self.addressLabel.numberOfLines=2;
    self.addressLabel.font=[UIFont systemFontOfSize:14];
    self.addressLabel.lineBreakMode=NSLineBreakByTruncatingTail;
    [self.rightView addSubview:self.addressLabel];
    
    self.replayAddressBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.replayAddressBtn.frame=CGRectMake(self.rightView.bounds.size.width-90, (self.rightView.frame.size.height-30)/2, 80, 30);
    self.replayAddressBtn.layer.borderWidth=0.5;
    self.replayAddressBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    [self.replayAddressBtn setTitle:@"选择地址" forState:UIControlStateNormal];
    [self.replayAddressBtn setTitleColor:[UIColor colorWithHexString:@"#4e4e4e"] forState:UIControlStateNormal];
    self.replayAddressBtn.layer.borderColor=[UIColor colorWithHexString:@"#4e4e4e"].CGColor;
    [self.rightView addSubview:self.replayAddressBtn];
    
    self.lineView=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth-70, 40, 60, 1)];
    self.lineView.backgroundColor=RGBACOLOR(176, 116, 67, 1);
    [self.backView addSubview:self.lineView];
    
    [self.lineView bringSubviewToFront:self];
}

-(void)configFrame
{
    self.rightView.frame=CGRectMake(0, 50, self.bounds.size.width, self.bounds.size.height-75);
    self.addressLabel.frame=CGRectMake(10, 0, self.rightView.bounds.size.width-20-90, self.rightView.bounds.size.height);
    self.replayAddressBtn.frame=CGRectMake(self.rightView.bounds.size.width-90, (self.rightView.frame.size.height-30)/2, 80, 30);
}

-(void)configData:(NSDictionary *)dict
{
    if ([dict[kGroupsPropertyRecieveMode] integerValue]==ReceiveModePickUp)
    {
        self.leftButton.frame=CGRectMake(self.bounds.size.width-70,14, 60, 30);
        self.rightButton.hidden=YES;
        self.leftButton.selected=YES;
        self.addressTable.hidden=NO;
        self.rightView.hidden=YES;
        self.leftButton.enabled=YES;
        self.rightButton.enabled=NO;
    }
    else if ([dict[kGroupsPropertyRecieveMode] integerValue]==ReceiveModeDeliver)
    {
        self.lineView.frame=CGRectMake(self.bounds.size.width-70, 40, 60, 1);
        self.leftButton.hidden=YES;
        self.rightButton.hidden=NO;
        self.rightButton.selected=YES;
        self.addressTable.hidden=YES;
        self.rightView.hidden=NO;
        self.leftButton.enabled=NO;
        self.rightButton.enabled=YES;
    }
    else if ([dict[kGroupsPropertyRecieveMode] integerValue]==ReceiveModePickUpAndDeliver)
    {
        self.lineView.frame=CGRectMake(self.bounds.size.width-140, 40, 60, 1);
        self.leftButton.selected=YES;
        self.rightButton.selected=NO;
        self.rightView.hidden=YES;
        self.leftButton.hidden=NO;
        self.rightButton.hidden=NO;
        self.leftButton.enabled=YES;
        self.rightButton.enabled=YES;
    }
}


-(void)leftButtonClick:(UIButton *)button
{
    [UIView animateWithDuration:0.15 animations:^{
        self.lineView.frame=CGRectMake(self.leftButton.frame.origin.x, 40, 60, 1);
    } completion:^(BOOL finished) {
        self.leftButton.selected=YES;
        self.rightButton.selected=NO;
    }];
    
    if (_delegate && [_delegate respondsToSelector:@selector(didLeftButtonClick:)])
    {
        [_delegate didLeftButtonClick:button];
    }
}


-(void)didRightButtonClick:(UIButton *)button
{
    [UIView animateWithDuration:0.15 animations:^{
        self.lineView.frame=CGRectMake(self.rightButton.frame.origin.x, 40, 60, 1);
    }completion:^(BOOL finished) {
        self.leftButton.selected=NO;
        self.rightButton.selected=YES;
    }];
    
    if (_delegate && [_delegate respondsToSelector:@selector(didRightButtonClick:)])
    {
        [_delegate didRightButtonClick:button];
    }
}



@end
