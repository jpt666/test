//
//  MainPageTableCell.m
//  CookBook
//
//  Created by 你好 on 16/4/13.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "MainPageTableCell.h"
#import "UserManager.h"
#import "CookBookPropertyKeys.h"
#import "CookProductPropertyKeys.h"
#import <UIImageView+WebCache.h>

@implementation MainPageTableCell


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

    self.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    self.contentView.clipsToBounds = YES;
    
    UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth/16*9+75)];
    backView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:backView];
    
    self.backImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, backView.bounds.size.width,  ScreenWidth/16*9)];
    self.backImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.backImageView.clipsToBounds = YES;
    [backView addSubview:self.backImageView];
    
    self.userIconImageView=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-70, self.backImageView.frame.origin.y+self.backImageView.frame.size.height-30, 50,50)];
    self.userIconImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.userIconImageView.layer.cornerRadius=25;
    self.userIconImageView.clipsToBounds=YES;
    self.userIconImageView.layer.borderColor=[UIColor whiteColor].CGColor;
    self.userIconImageView.layer.borderWidth=1.0f;
    [backView addSubview:self.userIconImageView];
    
    self.userLabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-70, self.backImageView.frame.origin.y+self.backImageView.frame.size.height+25, 50, 20)];
    self.userLabel.backgroundColor=[UIColor clearColor];
    self.userLabel.textAlignment=NSTextAlignmentCenter;
    self.userLabel.font=[UIFont systemFontOfSize:13];
    self.userLabel.textColor=[UIColor colorWithHexString:@"#343434"];
    [backView addSubview:self.userLabel];
    
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, self.backImageView.frame.origin.y+self.backImageView.frame.size.height+10, ScreenWidth-75, 30)];
    self.titleLabel.backgroundColor=[UIColor clearColor];
    self.titleLabel.textAlignment=NSTextAlignmentLeft;
    self.titleLabel.font=[UIFont systemFontOfSize:17];
    self.titleLabel.textColor=[UIColor colorWithHexString:@"#343434"];
    [backView addSubview:self.titleLabel];
    
    self.detailLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, self.backImageView.frame.origin.y+self.backImageView.frame.size.height+40, ScreenWidth-75, 20)];
    self.detailLabel.backgroundColor=[UIColor clearColor];
    self.detailLabel.textAlignment=NSTextAlignmentLeft;
    self.detailLabel.font=[UIFont systemFontOfSize:13];
    self.detailLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e"];
    [backView addSubview:self.detailLabel];
}

- (void)setupWithCookData:(NSMutableDictionary*)dict andType:(CookType)cookType
{
    if (cookType == CookBookType)
    {
        NSString *urlStr=dict[kBookPropertyFrontCoverUrl];
        NSString *iconUrl=dict[kBookPropertyCookerIconUrl];
        self.titleLabel.text=dict[kBookPropertyDishName];
        NSString *desc=[NSString stringWithFormat:@"%ld人浏览 %ld收藏",[dict[kBookPropertyFollowMadeNumbers]integerValue],[dict[kBookPropertyFavorNumbers] integerValue]];
        self.detailLabel.text=desc;
        self.userLabel.text=dict[kBookPropertyCookerNickName];
        [self.backImageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:PLACE_HOLDER_COOK_IMAGE] options:SDWebImageRetryFailed];
        [self.userIconImageView sd_setImageWithURL:[NSURL URLWithString:iconUrl] placeholderImage:[UIImage imageNamed:@"default_icon"] options:SDWebImageRetryFailed];
    }
    else if (cookType == CookProductType)
    {
        NSString *urlStr=dict[kProductPropertyFrontCoverUrl];
        NSString *iconUrl=dict[kProductPropertyCookerIconUrl];
        self.titleLabel.text=dict[kProductPropertyDishName];
        NSString *desc=[NSString stringWithFormat:@"%ld人浏览 %ld收藏",[dict[kProductPropertyVisitNumbers]integerValue],[dict[kProductPropertyFavorNumbers] integerValue]];
        self.detailLabel.text=desc;
        self.userLabel.text=dict[kProductPropertyCookerNickName];
        [self.userIconImageView sd_setImageWithURL:[NSURL URLWithString:iconUrl] placeholderImage:[UIImage imageNamed:@"default_icon"] options:SDWebImageRetryFailed];
        [self.backImageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:PLACE_HOLDER_COOK_IMAGE] options:SDWebImageRetryFailed];
    }
    
    self.selectionStyle=UITableViewCellSelectionStyleNone;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
