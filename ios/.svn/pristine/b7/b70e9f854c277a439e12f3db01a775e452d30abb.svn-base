//
//  PayTableViewCell.m
//  CookBook
//
//  Created by 你好 on 16/6/7.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "PayTableViewCell.h"

@implementation PayTableViewCell

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
    UIImage *headImage=[UIImage imageNamed:@"balance_dark"];
    self.headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, (50-headImage.size.height)/2, headImage.size.width, headImage.size.height)];
    self.headImageView.image=headImage;
    [self.contentView addSubview:self.headImageView];

    UIImage *bottomImage=[UIImage imageNamed:@"selected_green_icon"];
    self.bottomImageView=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-bottomImage.size.width-10, (50-bottomImage.size.height)/2, bottomImage.size.width, bottomImage.size.height)];
    self.bottomImageView.image=bottomImage;
    [self.contentView addSubview:self.bottomImageView];
    
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(20+self.headImageView.frame.size.width, 5, ScreenWidth-40-self.headImageView.frame.size.width-self.bottomImageView.frame.size.width, 20)];
    self.titleLabel.font=[UIFont systemFontOfSize:14];
    self.titleLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e"];
    [self.contentView addSubview:self.titleLabel];
    
    self.descLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.titleLabel.frame.origin.x, 25, self.titleLabel.frame.size.width, 20)];
    self.descLabel.font=[UIFont systemFontOfSize:12];
    self.descLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.5];
    [self.contentView addSubview:self.descLabel];
    
}

@end
