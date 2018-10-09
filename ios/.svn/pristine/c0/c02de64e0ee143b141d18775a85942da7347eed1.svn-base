//
//  ShopAddressTableCell.m
//  CookBook
//
//  Created by 你好 on 16/6/14.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "ShopAddressTableCell.h"

@implementation ShopAddressTableCell


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
    UIImage *shopAddressImage=[UIImage imageNamed:@"shoppingAddress_edit"];
    
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 100, 50)];
    self.titleLabel.font=[UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.titleLabel];
    
    self.phoneLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.titleLabel.frame.origin.x+self.titleLabel.frame.size.width+10, 0, ScreenWidth-self.titleLabel.frame.size.width-40-shopAddressImage.size.width, 50)];
    self.phoneLabel.font=[UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.phoneLabel];
    
    self.addresslabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 42.5, ScreenWidth-70,55)];
    self.addresslabel.font=[UIFont systemFontOfSize:12];
    self.addresslabel.numberOfLines=2;
    self.addresslabel.textColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.5];
    self.addresslabel.lineBreakMode=NSLineBreakByWordWrapping|NSLineBreakByTruncatingTail;
    [self.contentView addSubview:self.addresslabel];
    
    self.bottomButton=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-50, 25,50, 50)];
    [self.bottomButton setAdjustsImageWhenHighlighted:NO];
    [self.bottomButton setImage:shopAddressImage forState:UIControlStateNormal];
    [self.contentView addSubview:self.bottomButton];
    
    self.lineView=[[UIView alloc]initWithFrame:CGRectMake(10, 99.5, ScreenWidth-20, 0.5)];
    self.lineView.backgroundColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.3];
    [self.contentView addSubview:self.lineView];
}


-(double)heightForText:(NSString *)str
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];//调整行间距
    
    CGRect rect= [str boundingRectWithSize:CGSizeMake(ScreenWidth-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSParagraphStyleAttributeName:paragraphStyle} context:nil];
    
    double height=rect.size.height;
    if (height>55)
    {
        height=55;
    }
    return height;
}



-(void)configData:(NSDictionary *)dict
{
    self.titleLabel.text=dict[@"name"];
    self.phoneLabel.text=dict[@"mob"];
    
    NSString *descStr=dict[@"address"];
//    UIImage *shopAddressImage=[UIImage imageNamed:@"shoppingAddress_edit"];
    
//    self.addresslabel.frame=CGRectMake(20, 42.5, ScreenWidth-shopAddressImage.size.width-45,[self heightForText:descStr]);
//    self.lineView.frame=CGRectMake(10, self.addresslabel.frame.origin.y+self.addresslabel.frame.size.height+2, ScreenWidth-20, 0.5);
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];//调整行间距
    paragraphStyle.lineBreakMode = self.addresslabel.lineBreakMode;
    
    NSMutableAttributedString *descAttrStr=[[NSMutableAttributedString alloc]initWithString:descStr];
    [descAttrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSParagraphStyleAttributeName:paragraphStyle} range:NSMakeRange(0, descStr.length)];
    
    self.addresslabel.attributedText=descAttrStr;
    
//    self.addresslabel.text = descStr;
}



@end
