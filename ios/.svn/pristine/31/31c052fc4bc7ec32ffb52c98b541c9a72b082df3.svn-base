//
//  OrderDetailCenterView.m
//  CookBook
//
//  Created by 你好 on 16/6/7.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "OrderDetailCenterView.h"
#import "OrderPropertyKeys.h"
#import "GroupsPropertyKeys.h"
@implementation OrderDetailCenterView

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
    
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 15, ScreenWidth-10, 30)];
    self.titleLabel.text=@"取货信息";
    self.titleLabel.font=[UIFont boldSystemFontOfSize:17];
    [self addSubview:self.titleLabel];
    
    self.consigneeLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, self.titleLabel.frame.size.height+self.titleLabel.frame.origin.y+10,(ScreenWidth-20)/2, 20)];
    self.consigneeLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e"];
    self.consigneeLabel.font=[UIFont systemFontOfSize:14];
    [self addSubview:self.consigneeLabel];
    
    self.phoneNumLabel=[[UILabel alloc]initWithFrame:CGRectMake(10+(ScreenWidth-20)/2, self.consigneeLabel.frame.origin.y, (ScreenWidth-20)/2, 25)];
    self.phoneNumLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e"];
    self.phoneNumLabel.font=[UIFont systemFontOfSize:14];
    [self addSubview:self.phoneNumLabel];
    
//    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(10, self.phoneNumLabel.frame.size.height+self.phoneNumLabel.frame.origin.y+10, ScreenWidth-25, 0.5)];
//    lineView.backgroundColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.3];
//    [self addSubview:lineView];
    
    UIImage *phoneImage=[UIImage imageNamed:@"phone_selected"];
    
    self.addressLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, self.consigneeLabel.frame.size.height+self.consigneeLabel.frame.origin.y+7.5, ScreenWidth-20, 40)];
//    self.addressLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e"];
    self.addressLabel.numberOfLines=2;
//    self.addressLabel.lineBreakMode=NSLineBreakByTruncatingTail;
//    self.addressLabel.text=@"123124123213124123123123124123213124123123123124123213124123123123124123213124123123123124123213124123123";
//    self.addressLabel.font=[UIFont systemFontOfSize:14];
//    self.addressLabel.attributedText=attrString;
    [self addSubview:self.addressLabel];
    
    self.delMethodLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, self.addressLabel.frame.origin.y+self.addressLabel.frame.size.height+7.5, ScreenWidth-25, 20)];
    self.delMethodLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.5];
    self.delMethodLabel.font=[UIFont systemFontOfSize:14];
    [self addSubview:self.delMethodLabel];
    
//    self.timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, self.addressLabel.frame.size.height+self.addressLabel.frame.origin.y+7.5, ScreenWidth-25-20-phoneImage.size.width, 20)];
//    self.timeLabel.font=[UIFont systemFontOfSize:14];
//    self.timeLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e"];
//    [self addSubview:self.timeLabel];
    
    self.phoneBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.phoneBtn.frame=CGRectMake(self.bounds.size.width-phoneImage.size.width-20, self.delMethodLabel.frame.origin.y, phoneImage.size.width, phoneImage.size.height);
    [self.phoneBtn setImage:phoneImage forState:UIControlStateNormal];
    [self addSubview:self.phoneBtn];
    
}

-(void)configData:(NSDictionary *)dict
{
//    UIImage *phoneImage=[UIImage imageNamed:@"phone_selected"];
    
    if ([dict[kGroupsPropertyRecieveMode] integerValue]==ReceiveModePickUp)
    {
        self.consigneeLabel.text=[NSString stringWithFormat:@"收货人:%@",dict[kOrderPropertyObtainName]];
        self.phoneNumLabel.text=[NSString stringWithFormat:@"%@",dict[kOrderPropertyObtainMobile]];
        self.delMethodLabel.text=@"配送方式:上门自提";
        
//        NSDateFormatter *dateFormate=[[NSDateFormatter alloc]init];
//        [dateFormate setDateFormat:@"hh:mm"];
//        if ([dict[kOrderPropertyDispatcher][kDispatcherPropertyIsCustom] boolValue]) {
//            self.timeLabel.text = @"营业时间:以团主通知为准";
//        } else {
//            NSString *startTime=[NSString stringWithFormat:@"%@:00",dict[kOrderPropertyDispatcher][kDispatcherPropertyOpenTime]];
//            NSString *endTime=[NSString stringWithFormat:@"%@:00",dict[kOrderPropertyDispatcher][kDispatcherPropertyCloseTime]];
//            self.timeLabel.text=[NSString stringWithFormat:@"营业时间:%@-%@",startTime,endTime];
//        }
        
        NSString *string=[NSString stringWithFormat:@"取货地址:%@(自提点:%@)",dict[kOrderPropertyDispatcher][kDispatcherPropertyAddress],dict[kOrderPropertyDispatcher][kDispatcherPropertyMobile]];
        
        NSMutableAttributedString *attrString=[[NSMutableAttributedString alloc]initWithString:string];
        NSMutableParagraphStyle *pargrapStyle=[[NSMutableParagraphStyle alloc]init];
        pargrapStyle.lineSpacing=5.0f;
        [pargrapStyle setLineBreakMode:NSLineBreakByTruncatingTail];
        [attrString addAttributes:@{NSParagraphStyleAttributeName:pargrapStyle,NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#4e4e4e"]} range:NSMakeRange(0, string.length)];
        
        self.addressLabel.attributedText=attrString;
        self.phoneBtn.hidden=NO;
        
    }
    else if ([dict[kGroupsPropertyRecieveMode] integerValue]==ReceiveModeDeliver)
    {
        self.consigneeLabel.text=[NSString stringWithFormat:@"收货人:%@",dict[kOrderPropertyRecieveName]];
        self.phoneNumLabel.text=[NSString stringWithFormat:@"%@",dict[kOrderPropertyRecieveMobile]];
        self.delMethodLabel.text=@"配送方式:送货上门";
        
        NSString *string=[NSString stringWithFormat:@"取货地址:%@",dict[kOrderPropertyRecieveAddress]];
        
        NSMutableAttributedString *attrString=[[NSMutableAttributedString alloc]initWithString:string];
        NSMutableParagraphStyle *pargrapStyle=[[NSMutableParagraphStyle alloc]init];
        pargrapStyle.lineSpacing=5.0f;
        [pargrapStyle setLineBreakMode:NSLineBreakByTruncatingTail];
        [attrString addAttributes:@{NSParagraphStyleAttributeName:pargrapStyle,NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#4e4e4e"]} range:NSMakeRange(0, string.length)];
        
        self.addressLabel.attributedText=attrString;
        self.phoneBtn.hidden=YES;
    }

}



@end
