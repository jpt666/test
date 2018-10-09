//
//  GoodsListTableViewCell.m
//  CookBook
//
//  Created by 你好 on 16/8/10.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "GoodsListTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "GoodsPropertyKeys.h"
#import "ParticipantPropertyKeys.h"
@implementation GoodsListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


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
    self.headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
    self.headImageView.contentMode=UIViewContentModeScaleAspectFill;
    self.headImageView.clipsToBounds=YES;
    [self.contentView addSubview:self.headImageView];
    
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(60, 0, ScreenWidth/2-40, 60.5)];
    [self.contentView addSubview:self.titleLabel];
    
    self.unitLabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2+20, 0, 70, 60.5)];
    [self.contentView addSubview:self.unitLabel];
    
    self.priceLabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2+90, 0, ScreenWidth/2-100, 60.5)];
    self.priceLabel.textAlignment=NSTextAlignmentRight;
    [self.contentView addSubview:self.priceLabel];
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(10, 60, ScreenWidth-20, 0.5)];
    lineView.backgroundColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.3];
    [self.contentView addSubview:lineView];
}



-(void)configData:(NSDictionary *)dict
{
    NSString *priceStr=[NSString stringWithFormat:@"¥ %.2f",[dict[@"total_price"] doubleValue]/100];
    NSString *unitStr=[NSString stringWithFormat:@"%@",dict[kParticipantPropertyQuantity]];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:dict[kGoodsPropertyCover]] placeholderImage:[UIImage imageNamed:@"1"]];
    self.titleLabel.text=dict[kGoodsPropertyTitle];
    self.priceLabel.text=priceStr;
    self.unitLabel.text=unitStr;
}

@end
