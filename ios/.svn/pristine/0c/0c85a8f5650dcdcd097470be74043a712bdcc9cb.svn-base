//
//  PayTypeTableCell.m
//  CookBook
//
//  Created by 你好 on 16/6/7.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "PayTypeTableCell.h"

@implementation PayTypeTableCell

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
    UIImage *headImage=[UIImage imageNamed:@"alipay_icon"];
    self.headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, (50-headImage.size.height)/2, headImage.size.width, headImage.size.height)];
    [self.contentView addSubview:self.headImageView];
    
    UIImage *bottomImage=[UIImage imageNamed:@"normal_round_icon"];
    self.bottomImageView=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-10-bottomImage.size.width, (50-bottomImage.size.height)/2, bottomImage.size.width, bottomImage.size.height)];
    self.bottomImageView.image=bottomImage;
    [self.contentView addSubview:self.bottomImageView];
    
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.headImageView.frame.origin.x+self.headImageView.frame.size.width+10, 0, ScreenWidth-self.headImageView.frame.origin.y-self.headImageView.frame.size.width-20-self.bottomImageView.frame.size.width, 50)];
    self.titleLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e"];
    self.titleLabel.font=[UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.titleLabel];

}


@end
