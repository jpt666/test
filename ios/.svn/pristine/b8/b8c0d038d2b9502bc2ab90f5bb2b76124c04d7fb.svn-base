//
//  OrderDetailTopView.m
//  CookBook
//
//  Created by 你好 on 16/6/7.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "OrderDetailTopView.h"
#import "OrderPropertyKeys.h"
@implementation OrderDetailTopView


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
    
    UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-10)];
    backView.backgroundColor=[UIColor whiteColor];
    [self addSubview:backView];
    
    self.leftLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 15, 80, 20)];
    self.leftLabel.font=[UIFont systemFontOfSize:16];
    self.leftLabel.text=@"订单提交";
    [backView addSubview:self.leftLabel];
    
    self.leftView=[[UIView alloc]initWithFrame:CGRectMake(30, 45, 15,15)];
    self.leftView.layer.cornerRadius=7.5;
    self.leftView.clipsToBounds=YES;
    self.leftView.backgroundColor=RGBACOLOR(176, 116, 67, 1);
    [backView addSubview:self.leftView];
    
    self.centerLabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-40, 15, 80, 20)];
    self.centerLabel.font=[UIFont systemFontOfSize:16];
    self.centerLabel.text=@"支付完成";
    [backView addSubview:self.centerLabel];
    
    self.centerView=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/2-10, 45, 15, 15)];
    self.centerView.layer.cornerRadius=7.5;
    self.centerView.clipsToBounds=YES;
    self.centerView.backgroundColor=RGBACOLOR(176, 116, 67, 1);
    [backView addSubview:self.centerView];
    
    self.rightLabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-80, 15, 80, 20)];
    self.rightLabel.font=[UIFont systemFontOfSize:16];
    self.rightLabel.text=@"订单完成";
    [backView addSubview:self.rightLabel];
    
    self.rightView=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth-50, 45, 15, 15)];
    self.rightView.layer.cornerRadius=7.5;
    self.rightView.clipsToBounds=YES;
    self.rightView.layer.borderWidth=1;
    self.rightView.layer.borderColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.8].CGColor;
    [backView addSubview:self.rightView];
    
    self.leftLineView=[[UIView alloc]initWithFrame:CGRectMake(self.leftView.frame.origin.x+self.leftView.frame.size.width, self.leftView.frame.origin.y+(self.leftView.frame.size.height-1)/2, self.centerView.frame.origin.x-self.leftView.frame.origin.x-self.leftView.frame.size.width, 1)];
    self.leftLineView.backgroundColor=RGBACOLOR(176, 116, 67, 1);
    [backView addSubview:self.leftLineView];
    
    self.rightLineView=[[UIView alloc]initWithFrame:CGRectMake(self.centerView.frame.origin.x+self.centerView.frame.size.width, self.centerView.frame.origin.y+(self.centerView.frame.size.height-1)/2, self.rightView.frame.origin.x-self.centerView.frame.origin.x-self.centerView.frame.size.width, 1)];
    self.rightLineView.backgroundColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.5];
    [backView addSubview:self.rightLineView];
    
    self.bottomLineView=[[UIView alloc]initWithFrame:CGRectMake(10, self.centerView.frame.origin.y+self.centerView.frame.size.height+16, ScreenWidth-20, 0.5)];
    self.bottomLineView.backgroundColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.3];
    [backView addSubview:self.bottomLineView];
    
    self.orderNumLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, self.bottomLineView.frame.origin.y+self.bottomLineView.frame.size.height+15, ScreenWidth-20, 20)];
    self.orderNumLabel.font=[UIFont systemFontOfSize:14];
    self.orderNumLabel.text=@"订单号: ";
    self.orderNumLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e"];
    [backView addSubview:self.orderNumLabel];
    
    self.orderTimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, self.orderNumLabel.frame.origin.y+self.orderNumLabel.frame.size.height+7.5, ScreenWidth-20, 20)];
    self.orderTimeLabel.font=[UIFont systemFontOfSize:14];
    self.orderTimeLabel.text=@"下单时间: ";
    self.orderTimeLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e"];
    [backView addSubview:self.orderTimeLabel];
    
//    self.paymentLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, self.orderTimeLabel.frame.origin.y+self.orderTimeLabel.frame.size.height, ScreenWidth-20, 20)];
//    self.paymentLabel.font=[UIFont systemFontOfSize:14];
//    self.paymentLabel.text=@"支付方式: 微信";
//    self.paymentLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e"];
//    [backView addSubview:self.paymentLabel];
}


-(void)configData:(NSDictionary *)dict
{
    NSDateFormatter *dateFormate=[[NSDateFormatter alloc]init];
    [dateFormate setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *timeStr=[dateFormate stringFromDate:[NSDate dateWithTimeIntervalSince1970:[dict[kOrderPropertyCreateTime] doubleValue]/1000/1000]];
    
    self.orderNumLabel.text=[NSString stringWithFormat:@"订单号: %@",dict[kOrderPropertyId]];
    self.orderTimeLabel.text=[NSString stringWithFormat:@"下单时间: %@",timeStr];
    if ([dict[kOrderPropertyStatus]integerValue]<=NotPayOrder)
    {
        self.leftView.backgroundColor=RGBACOLOR(176, 116, 67, 1);
        self.leftView.layer.borderWidth=0.0f;
        self.rightView.layer.borderWidth=1.0f;
        self.centerView.backgroundColor=[UIColor whiteColor];
        self.centerView.layer.borderColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.8].CGColor;
        self.centerView.layer.borderWidth=1.0f;
        self.leftLineView.backgroundColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.5];
    }
    else if ([dict[kOrderPropertyStatus] integerValue]>=FinishedPayOrder &&
             [dict[kOrderPropertyStatus] integerValue]< FinishOrder)
    {
        self.leftView.layer.borderWidth=0.0f;
        self.centerView.layer.borderWidth=0.0f;
        self.rightView.layer.borderWidth=1.0f;
        self.leftLineView.backgroundColor=RGBACOLOR(176, 116, 67, 1);
        self.rightView.layer.borderColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.8].CGColor;
        self.leftView.backgroundColor=RGBACOLOR(176, 116, 67, 1);
        self.centerView.backgroundColor=RGBACOLOR(176, 116, 67, 1);
        self.rightLineView.layer.borderColor = [UIColor colorWithHexString:@"#4e4e4e" alpha:0.8].CGColor;
    }
    else if ([dict[kOrderPropertyStatus] integerValue]==FinishOrder) {
        self.leftView.layer.borderWidth=0.0f;
        self.centerView.layer.borderWidth=0.0f;
        self.rightView.layer.borderWidth=0.0f;
        self.leftLineView.backgroundColor=RGBACOLOR(176, 116, 67, 1);
        self.rightView.backgroundColor=RGBACOLOR(176, 116, 67, 1);
        self.leftView.backgroundColor=RGBACOLOR(176, 116, 67, 1);
        self.centerView.backgroundColor=RGBACOLOR(176, 116, 67, 1);
        self.rightLineView.backgroundColor=RGBACOLOR(176, 116, 67, 1);
    }
}



@end
