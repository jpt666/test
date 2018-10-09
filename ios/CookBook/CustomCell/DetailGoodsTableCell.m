//
//  DetailGoodsTableCell.m
//  CookBook
//
//  Created by 你好 on 16/8/11.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "DetailGoodsTableCell.h"
#import "GlobalVar.h"
#import <UIImageView+WebCache.h>
#import "GoodsPropertyKeys.h"
#import "GroupsPropertyKeys.h"
@implementation DetailGoodsTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier isEditable:(BOOL)isEditable
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self configUIByEditable:isEditable];
    }
    return self;
}




-(void)configUIByEditable:(BOOL)isEditable
{
    CGFloat offset = 0;
    if (isEditable) {
        offset = 35;
        
        self.labelSeq = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 35, 60)];
        self.labelSeq.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.labelSeq];
    }
    
    self.headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10+offset,10 , 60, 60)];
    self.headImageView.contentMode=UIViewContentModeScaleAspectFill;
    self.headImageView.clipsToBounds=YES;
    self.headImageView.image=[UIImage imageNamed:@"default_icon"];
    [self.contentView addSubview:self.headImageView];
    
    self.typeLabel=[[UILabel alloc]initWithFrame:CGRectMake(85+offset, 10, 30, 18)];
    self.typeLabel.font = [UIFont systemFontOfSize:12];
    self.typeLabel.textColor=[UIColor whiteColor];
    self.typeLabel.layer.cornerRadius=3;
    self.typeLabel.clipsToBounds=YES;
    self.typeLabel.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:self.typeLabel];
    
    UIImage *bottomImage=[UIImage imageNamed:@"normal_round_icon"];
    if (!isEditable) {
        self.bottomImageView=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-bottomImage.size.width-10, (80-bottomImage.size.height)/2, bottomImage.size.width, bottomImage.size.height)];
        self.bottomImageView.image=[UIImage imageNamed:@"normal_round_icon"];
        [self.contentView addSubview:self.bottomImageView];
    }
    
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.typeLabel.frame.origin.x+self.typeLabel.frame.size.width+5, self.typeLabel.frame.origin.y-1, ScreenWidth-bottomImage.size.width-135, 20)];
    [self.contentView addSubview:self.titleLabel];
    
    self.specLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.typeLabel.frame.origin.x, self.typeLabel.frame.origin.y+self.typeLabel.frame.size.height+3,(ScreenWidth-bottomImage.size.width-100)/2-35, 15)];
    self.specLabel.font=[UIFont systemFontOfSize:14];
    self.specLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.5];
    [self.contentView addSubview:self.specLabel];
    
    self.priceLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.specLabel.frame.origin.x, self.specLabel.frame.size.height+self.specLabel.frame.origin.y+5, self.specLabel.frame.size.width+30, 20)];
    [self.contentView addSubview:self.priceLabel];
    
    self.limitLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.specLabel.frame.origin.x+self.specLabel.frame.size.width, self.specLabel.frame.origin.y, self.specLabel.frame.size.width+35, self.specLabel.frame.size.height)];
    self.limitLabel.font=[UIFont systemFontOfSize:14];
    self.limitLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.5];
    [self.contentView addSubview:self.limitLabel];
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(10, 80, ScreenWidth-20, 0.5)];
    lineView.backgroundColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.3];
    [self.contentView addSubview:lineView];
    
}

-(void)setSequenceNum:(NSInteger)num
{
    if (self.labelSeq) {
        self.labelSeq.text = [NSString stringWithFormat:@"%ld", num];
    }
}

-(void)configData:(NSDictionary *)dict
{
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:dict[kGoodsPropertyCover]] placeholderImage:[UIImage imageNamed:PLACE_HOLDER_COOK_IMAGE]];
    self.typeLabel.text=dict[kGroupsPropertyCategory];
    self.titleLabel.text=dict[kGoodsPropertyTitle];
    self.specLabel.text=dict[kGoodsPropertySpecDesc];
    
    if ([dict[kGoodsPropertyPurchaseLimit] integerValue] > 0) {
        self.limitLabel.hidden = NO;
        self.limitLabel.text=[NSString stringWithFormat:@"每个ID限购%@个",dict[kGoodsPropertyPurchaseLimit]];
    } else {
        self.limitLabel.hidden = YES;
    }
    
    
    NSString *priceStr=[NSString stringWithFormat:@"¥ %.2f",[dict[kGoodsPropertyUnitPrice] doubleValue]/100];
    NSRange range=[priceStr rangeOfString:@"."];
    NSMutableAttributedString *totalPriceAttrStr=[[NSMutableAttributedString alloc]initWithString:priceStr];
    [totalPriceAttrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:RGBACOLOR(176, 116, 67, 1)} range:NSMakeRange(range.location, 3)];
    [totalPriceAttrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:RGBACOLOR(176, 116, 67, 1)} range:NSMakeRange(1, priceStr.length-4)];
    [totalPriceAttrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:RGBACOLOR(176, 116, 67, 1)} range:NSMakeRange(0, 1)];
    self.priceLabel.attributedText=totalPriceAttrStr;
    
    UIImage *bottomImage=[UIImage imageNamed:@"normal_round_icon"];

    if ([dict[@"tag_color"] isEqualToString:@"red"])
    {
        self.typeLabel.backgroundColor=RGBACOLOR(235, 27, 40, 1);
    }
    else if ([dict[@"tag_color"] isEqualToString:@"green"])
    {
        self.typeLabel.backgroundColor=RGBACOLOR(252, 190, 30, 1);
    }
    else if([dict[@"tag_color"] isEqualToString:@"yellow"])
    {
        self.typeLabel.backgroundColor=RGBACOLOR(122, 212, 51, 1);
    }
    else if([dict[@"tag_color"] isEqualToString:@"orange"])
    {
        self.typeLabel.backgroundColor=RGBACOLOR(249, 68, 25, 1);
    }
    else if([dict[@"tag_color"] length]<=0)
    {
        self.typeLabel.hidden=YES;
        self.titleLabel.frame=CGRectMake(self.typeLabel.frame.origin.x, self.typeLabel.frame.origin.y-1, ScreenWidth-bottomImage.size.width-100, 20);
    }
}





@end
