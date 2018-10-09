//
//  MyOrderTableViewCell.m
//  CookBook
//
//  Created by 你好 on 16/6/12.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "MyOrderTableViewCell.h"
#import "OrderPropertyKeys.h"
#import "GroupsPropertyKeys.h"
#import <UIImageView+WebCache.h>
@implementation MyOrderTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self configUI];
    }
    return self;
}



-(void)configUI
{
    self.headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 50, 50)];
    self.headImageView.layer.cornerRadius=25;
    self.headImageView.clipsToBounds=YES;
    [self.contentView addSubview:self.headImageView];
    
    self.userLabel=[[UILabel alloc]initWithFrame:CGRectMake(70, 15, ScreenWidth-130, 30)];
    self.userLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e"];
    [self.contentView addSubview:self.userLabel];
    
    self.orderTimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.userLabel.frame.origin.x, self.userLabel.frame.origin.y+self.userLabel.frame.size.height, self.userLabel.frame.size.width, 20)];
    self.orderTimeLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.5];
    self.orderTimeLabel.font=[UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.orderTimeLabel];
    
    self.orderStatusLabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-65, 25, 50, 30)];
    self.orderStatusLabel.font=[UIFont systemFontOfSize:14];
    self.orderStatusLabel.textAlignment=NSTextAlignmentRight;
    [self.contentView addSubview:self.orderStatusLabel];
    
    UIImage *image=[UIImage imageNamed:@"right_darkArrow_icon"];
    
    self.myOrderView=[[MyOrderView alloc]initWithFrame:CGRectMake(0, 80, ScreenWidth, (ScreenWidth-90-image.size.width)/5+30)];
    [self.contentView addSubview:self.myOrderView];
    
    self.totalPriceLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, self.myOrderView.frame.origin.y+self.myOrderView.frame.size.height+10, ScreenWidth, 30)];
    self.totalPriceLabel.textAlignment=NSTextAlignmentRight;
    [self.contentView addSubview:self.totalPriceLabel];
    
    self.lineView=[[UIView alloc]initWithFrame:CGRectMake(10, self.totalPriceLabel.frame.origin.y+self.totalPriceLabel.frame.size.height+10, ScreenWidth-20, 0.5)];
    self.lineView.backgroundColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.3];
    [self.contentView addSubview:self.lineView];
    
    self.cancelButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton.frame=CGRectZero;
    [self.cancelButton setTitle:@"取消订单" forState:UIControlStateNormal];
    self.cancelButton.layer.cornerRadius=6;
    self.cancelButton.titleLabel.font=[UIFont systemFontOfSize:14];
    self.cancelButton.layer.borderWidth=0.5;
    self.cancelButton.layer.borderColor=[UIColor colorWithHexString:@"#4e4e4e"].CGColor;
    [self.cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.cancelButton];
    
    self.payButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.payButton.frame=CGRectZero;
    self.payButton.layer.cornerRadius=6;
    [self.payButton setTitle:@"去支付" forState:UIControlStateNormal];
    self.payButton.titleLabel.font=[UIFont systemFontOfSize:14];
    self.payButton.backgroundColor=RGBACOLOR(176, 116, 67, 1);
    self.payButton.layer.borderColor=[UIColor colorWithHexString:@"#4e4e4e"].CGColor;
    [self.payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.payButton addTarget:self action:@selector(payButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.payButton];
    
    self.cofirmButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.cofirmButton.frame=CGRectZero;
    [self.cofirmButton setTitle:@"确认收货" forState:UIControlStateNormal];
    self.cofirmButton.layer.cornerRadius=6;
    self.cofirmButton.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.cofirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.cofirmButton.backgroundColor=RGBACOLOR(176, 116, 67, 1);
    [self.cofirmButton addTarget:self action:@selector(confirmButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.cofirmButton];
    
    self.checkTransportBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.checkTransportBtn.frame=CGRectZero;
    [self.checkTransportBtn setTitle:@"查看物流" forState:UIControlStateNormal];
    self.checkTransportBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.checkTransportBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.checkTransportBtn.layer.borderWidth=0.5;
    self.checkTransportBtn.layer.cornerRadius=6;
    self.checkTransportBtn.layer.borderColor=[UIColor colorWithHexString:@"#4e4e4e"].CGColor;
    [self.checkTransportBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.checkTransportBtn addTarget:self action:@selector(checkTransportBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.checkTransportBtn];
    
    self.deleteButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteButton.frame=CGRectZero;
    [self.deleteButton setTitle:@"删除订单" forState:UIControlStateNormal];
    self.deleteButton.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.deleteButton.layer.borderWidth=0.5;
    self.deleteButton.layer.cornerRadius=6;
    self.deleteButton.layer.borderColor=[UIColor colorWithHexString:@"#4e4e4e"].CGColor;
    [self.deleteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.deleteButton addTarget:self action:@selector(deleteBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.deleteButton];
    
    self.ETAButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.ETAButton.frame=CGRectZero;
    [self.ETAButton setTitle:@"接龙" forState:UIControlStateNormal];
    self.ETAButton.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.ETAButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.ETAButton setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    self.ETAButton.layer.borderWidth=0.5;
    self.ETAButton.layer.cornerRadius=6;
    self.ETAButton.layer.borderColor=[UIColor colorWithHexString:@"#4e4e4e"].CGColor;
    [self.ETAButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.ETAButton addTarget:self action:@selector(ETABtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.ETAButton];
    
    
    UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake(0,  self.lineView.frame.origin.y+self.lineView.frame.size.height+10+30+20, ScreenWidth, 10)];
    bottomView.backgroundColor=RGBACOLOR(207, 207, 207, 0.5);
    [self.contentView addSubview:bottomView];
}



-(void)configData:(NSDictionary *)dict
{
    _dictOrder = dict;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:dict[kOrderPropertyReseller][kDispatcherPropertyWXHeadUrl]] placeholderImage:[UIImage imageNamed:@"default_icon"]];
    
    NSDateFormatter *dateFormate=[[NSDateFormatter alloc]init];
    [dateFormate setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *userStr=[NSString stringWithFormat:@"%@  团主",dict[kOrderPropertyReseller][kDispatcherPropertyName]];
    NSRange nameRange=[userStr rangeOfString:@"团主"];
    NSMutableAttributedString *userAttrStr=[[NSMutableAttributedString alloc]initWithString:userStr];
    [userAttrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} range:NSMakeRange(0, userStr.length-2)];
    [userAttrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} range:NSMakeRange(nameRange.location, nameRange.length)];
    self.userLabel.attributedText=userAttrStr;
    
    [self.myOrderView configData:dict[kOrderPropertyCovers]];
    
    NSString *orderTimeStr=[dateFormate stringFromDate:[NSDate dateWithTimeIntervalSince1970:[dict[kOrderPropertyCreateTime] doubleValue]/1000/1000]];
    self.orderTimeLabel.text=[NSString stringWithFormat:@"下单时间:%@",orderTimeStr];
    
    NSString *numStr=[NSString stringWithFormat:@"共%ld件商品  合计: ",[dict[kOrderPropertyCount] integerValue]];
    NSString *priceStr=[NSString stringWithFormat:@"¥%.2f",[dict[kOrderPropertyTotalFee] doubleValue]/100];
    NSString *freightStr=[NSString stringWithFormat:@"（含运费¥0.00）"];
    
    NSString *finalStr=[NSString stringWithFormat:@"%@%@%@",numStr,priceStr,freightStr];
    
    NSRange range=[finalStr rangeOfString:priceStr];
    NSMutableAttributedString *attrString=[[NSMutableAttributedString alloc]initWithString:finalStr];
    [attrString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:RGBACOLOR(176, 116, 67, 1)} range:range];
    [attrString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#4e4e4e"]} range:NSMakeRange(0, range.location)];
    [attrString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#4e4e4e" alpha:0.5]} range:NSMakeRange(range.location+range.length, freightStr.length)];
    self.totalPriceLabel.attributedText=attrString;

//    typedef enum _OrderStatus{
//        OutOfDateOrder=-1,//已过期
//        NotPayOrder=0,//未支付
//        FinishedPayOrder=1,//已支付
//        SendOutOrder=2,//已发货
//        WaitForPickUpOrder=3,//待取货
//        FinishOrder=4//已完成
//    }OrderStatus;
    
    NSInteger bulkStatus = [dict[kOrderPropertyBulkStatus] integerValue];
    switch ([dict[kOrderPropertyStatus] integerValue])
    {
        case OutOfDateOrder:
        {
            self.orderStatusLabel.text=@"已过期";
            
            self.cancelButton.frame=CGRectZero;
            self.cofirmButton.frame=CGRectZero;
            self.checkTransportBtn.frame=CGRectZero;
            self.payButton.frame=CGRectZero;
            self.ETAButton.frame=CGRectZero;
            self.deleteButton.frame=CGRectMake(ScreenWidth-90, self.lineView.frame.origin.y+self.lineView.frame.size.height+15, 80, 30);
            
            self.cancelButton.hidden=YES;
            self.cofirmButton.hidden=YES;
            self.checkTransportBtn.hidden=YES;
            self.payButton.hidden=YES;
            self.deleteButton.hidden=NO;
            self.ETAButton.hidden=YES;
        }
            break;
        case NotPayOrder:
        {
            self.orderStatusLabel.text=@"未支付";
            self.cofirmButton.frame=CGRectZero;
            self.checkTransportBtn.frame=CGRectZero;
            self.deleteButton.frame=CGRectZero;
            self.cancelButton.frame=CGRectMake(ScreenWidth-180, self.lineView.frame.origin.y+self.lineView.frame.size.height+15, 80, 30);
            self.payButton.frame=CGRectMake(ScreenWidth-90,self.lineView.frame.origin.y+self.lineView.frame.size.height+15, 80, 30);
            self.ETAButton.frame=CGRectMake(ScreenWidth-270, self.lineView.frame.origin.y+self.lineView.frame.size.height+15, 80, 30);
            
            self.ETAButton.hidden=NO;
            self.ETAButton.selected = (bulkStatus>=0?NO:YES);
            self.cancelButton.hidden=NO;
            self.cofirmButton.hidden=YES;
            self.checkTransportBtn.hidden=YES;
            self.payButton.hidden=NO;
            self.deleteButton.hidden=YES;
        }
            break;
        case FinishedPayOrder:
        {
            self.orderStatusLabel.text=@"已支付";
            self.ETAButton.frame=CGRectZero;
            self.payButton.frame=CGRectZero;
            self.deleteButton.frame=CGRectZero;
            self.cancelButton.frame=CGRectMake(ScreenWidth-180, self.lineView.frame.origin.y+self.lineView.frame.size.height+15, 80, 30);
            self.ETAButton.frame=CGRectMake(ScreenWidth-270, self.lineView.frame.origin.y+self.lineView.frame.size.height+15, 80, 30);
            self.cofirmButton.frame=CGRectMake(ScreenWidth-90,self.lineView.frame.origin.y+self.lineView.frame.size.height+15, 80, 30);
            
            self.ETAButton.hidden=NO;
            self.ETAButton.selected = (bulkStatus>=0?NO:YES);
            self.cancelButton.hidden=NO;
            self.cofirmButton.hidden=NO;
            self.checkTransportBtn.hidden=YES;
            self.payButton.hidden=YES;
            self.deleteButton.hidden=YES;
        }
            break;
        case SendOutOrder:
        {
            self.orderStatusLabel.text=@"已发货";
            self.ETAButton.frame=CGRectMake(ScreenWidth-270, self.lineView.frame.origin.y+self.lineView.frame.size.height+15, 80, 30);
            self.payButton.frame=CGRectZero;
            self.cancelButton.frame=CGRectZero;
            self.checkTransportBtn.frame=CGRectMake(ScreenWidth-180, self.lineView.frame.origin.y+self.lineView.frame.size.height+15, 80, 30);
            self.cofirmButton.frame=CGRectMake(ScreenWidth-90,self.lineView.frame.origin.y+self.lineView.frame.size.height+15, 80, 30);
            self.deleteButton.frame=CGRectZero;
            
            self.ETAButton.hidden=NO;
            self.ETAButton.selected = (bulkStatus>=0?NO:YES);
            self.cancelButton.hidden=YES;
            self.cofirmButton.hidden=NO;
            self.checkTransportBtn.hidden=NO;
            self.payButton.hidden=YES;
            self.deleteButton.hidden=YES;
        }
            break;
        case WaitForPickUpOrder:
        {
            self.orderStatusLabel.text=@"待取货";
            self.ETAButton.frame=CGRectMake(ScreenWidth-270, self.lineView.frame.origin.y+self.lineView.frame.size.height+15, 80, 30);
            self.payButton.frame=CGRectZero;
            self.cancelButton.frame=CGRectZero;
            self.checkTransportBtn.frame=CGRectMake(ScreenWidth-180, self.lineView.frame.origin.y+self.lineView.frame.size.height+15, 80, 30);
            self.cofirmButton.frame=CGRectMake(ScreenWidth-90,self.lineView.frame.origin.y+self.lineView.frame.size.height+15, 80, 30);
            self.deleteButton.frame=CGRectZero;
            
            self.ETAButton.hidden=NO;
            self.ETAButton.selected = (bulkStatus>=0?NO:YES);
            self.cancelButton.hidden=YES;
            self.cofirmButton.hidden=NO;
            self.checkTransportBtn.hidden=NO;
            self.payButton.hidden=YES;
            self.deleteButton.hidden=YES;
        }
            break;
        case FinishOrder:
        {
            self.orderStatusLabel.text=@"已完成";
            self.payButton.frame=CGRectZero;
            self.deleteButton.frame=CGRectMake(ScreenWidth-90, self.lineView.frame.origin.y+self.lineView.frame.size.height+15, 80, 30);
            self.ETAButton.frame=CGRectMake(ScreenWidth-180, self.lineView.frame.origin.y+self.lineView.frame.size.height+15, 80, 30);
            self.cancelButton.frame=CGRectZero;
            self.cofirmButton.frame=CGRectZero;
            self.checkTransportBtn.frame=CGRectZero;
            
            self.ETAButton.hidden=NO;
            self.ETAButton.selected = (bulkStatus>=0?NO:YES);
            self.cancelButton.hidden=YES;
            self.cofirmButton.hidden=YES;
            self.checkTransportBtn.hidden=YES;
            self.payButton.hidden=YES;
            self.deleteButton.hidden=NO;
        }
            break;
        default:
            break;
    }
}

- (void)cancelButtonClicked:(UIButton *)button
{
    if (_delegate && [_delegate respondsToSelector:@selector(cancelButtonClicked:)]) {
        [_delegate cancelButtonClicked:_dictOrder];
    }
}

- (void)payButtonClicked:(UIButton *)button
{
    if (_delegate && [_delegate respondsToSelector:@selector(payButtonClicked:)]) {
        [_delegate payButtonClicked:_dictOrder];
    }
}

- (void)confirmButtonClicked:(UIButton *)button
{
    if (_delegate && [_delegate respondsToSelector:@selector(confirmButtonClicked:)]) {
        [_delegate confirmButtonClicked:_dictOrder];
    }
}

- (void)checkTransportBtnClicked:(UIButton *)button
{
    if (_delegate && [_delegate respondsToSelector:@selector(checkTransportBtnClicked:)]) {
        [_delegate checkTransportBtnClicked:_dictOrder];
    }
}

- (void)deleteBtnClicked:(UIButton *)button
{
    if (_delegate &&[_delegate respondsToSelector:@selector(deleteBtnClicked:)]) {
        [_delegate deleteBtnClicked:_dictOrder];
    }
}

- (void)ETABtnClicked:(UIButton *)button
{
    if (button.isSelected) {
        return;
    }
    if (_delegate &&[_delegate respondsToSelector:@selector(ETABtnClicked:)]) {
        [_delegate ETABtnClicked:_dictOrder];
    }
}


@end
