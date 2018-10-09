//
//  ProfileTableViewCell.m
//  CookBook
//
//  Created by 你好 on 16/5/3.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "ProfileTableViewCell.h"

@implementation ProfileTableViewCell


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
    self.headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 50,50)];
    self.headImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.headImageView.clipsToBounds=YES;
    self.headImageView.layer.cornerRadius=self.headImageView.bounds.size.width/2;
    [self.contentView addSubview:self.headImageView];
    
    
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(90, 20, ScreenWidth-90, 30)];
    self.titleLabel.backgroundColor=[UIColor clearColor];
    [self.contentView addSubview:self.titleLabel];
}


@end
