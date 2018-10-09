//
//  GoodsListTableCell.m
//  CookBook
//
//  Created by 你好 on 16/6/7.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "GoodsListTableCell.h"
#import "GoodsPropertyKeys.h"
#import "ParticipantPropertyKeys.h"
@implementation GoodsListTableCell

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
    self.contentLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, ScreenWidth/2-10, 40)];
    self.contentLabel.font=[UIFont systemFontOfSize:14];
    self.contentLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.8];
    [self.contentView addSubview:self.contentLabel];
    
    self.unitLabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2+60, 0, 40, 40)];
    self.unitLabel.font=[UIFont systemFontOfSize:14];
    self.unitLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.8];
    [self.contentView addSubview:self.unitLabel];
    
    self.priceLabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2+100, 0, ScreenWidth/2-110, 40)];
    self.priceLabel.font=[UIFont systemFontOfSize:14];
    self.priceLabel.textAlignment=NSTextAlignmentRight;
    self.priceLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.8];
    [self.contentView addSubview:self.priceLabel];
    
    UIImage *bottomImage=[UIImage imageNamed:@"line_space"];
    self.bottomImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 40-bottomImage.size.height, ScreenWidth-20, bottomImage.size.height)];
    self.bottomImageView.image=bottomImage;
    self.bottomImageView.hidden=YES;
    [self.contentView addSubview:self.bottomImageView];
}

-(void)configData:(ShoppingGoods *)goods  andIndexPath:(NSIndexPath *)indexPath
{
    self.contentLabel.text=[NSString stringWithFormat:@"%ld %@",indexPath.row+1,goods.goodsName];
    self.unitLabel.text=[NSString stringWithFormat:@"X%ld",goods.puchaseNum];
    self.priceLabel.text=[NSString stringWithFormat:@"¥ %.2f",(goods.unitPrice/100)*(goods.puchaseNum)];
}

-(void)configByDict:(NSDictionary *)dict andIndexPath:(NSIndexPath *)indexPath
{
    self.contentLabel.text=[NSString stringWithFormat:@"%ld %@",indexPath.row+1,dict[kGoodsPropertyTitle]] ;
    self.unitLabel.text=[NSString stringWithFormat:@"X%ld",[dict[kParticipantPropertyQuantity] integerValue]];
    self.priceLabel.text=[NSString stringWithFormat:@"¥ %.2f",([dict[kGoodsPropertyUnitPrice] doubleValue]/100)*([dict[kParticipantPropertyQuantity] integerValue])];
}


@end
