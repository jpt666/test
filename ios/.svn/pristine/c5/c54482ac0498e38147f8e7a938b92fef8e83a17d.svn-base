//
//  MineMenuTableViewCell.m
//  CookBook
//
//  Created by 你好 on 16/4/26.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "MineMenuTableViewCell.h"

@implementation MineMenuTableViewCell

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
    
    self.backImageView=[[UIImageView alloc]initWithFrame:CGRectMake(9, 0, ScreenWidth-18, (ScreenWidth-18)/16*9)];
    self.backImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.backImageView.clipsToBounds = YES;
    [self.contentView addSubview:self.backImageView];
    
    UIView *shadowView=[[UIView alloc]initWithFrame:CGRectMake(9, 0+(ScreenWidth-18)/16*9-30, ScreenWidth-18, 30)];
    shadowView.backgroundColor=RGBACOLOR(1, 1, 1, 0.4);
    [self.contentView addSubview:shadowView];
    
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10,0, self.backImageView.bounds.size.width-150, 30)];
    self.titleLabel.textColor=[UIColor whiteColor];
    self.titleLabel.backgroundColor=[UIColor clearColor];
    [shadowView addSubview:self.titleLabel];
    
    UIImage *image=[UIImage imageNamed:@"watch_icon"];
    
    self.watchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.watchBtn.frame=CGRectMake(self.backImageView.bounds.size.width-120, 0, 30, 30);
    [self.watchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.watchBtn setImage:image forState:UIControlStateNormal];
    self.watchBtn.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 5);
    self.watchBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    [shadowView addSubview:self.watchBtn];
    
    self.favorBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.favorBtn.frame=CGRectMake(self.backImageView.bounds.size.width-80, 0, 30, 30);
    [self.favorBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.favorBtn setImage:[UIImage imageNamed:@"favor_icon"] forState:UIControlStateNormal];
    self.favorBtn.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 5);
    self.favorBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    [shadowView addSubview:self.favorBtn];
    
    self.messageBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.messageBtn.frame=CGRectMake(self.backImageView.bounds.size.width-40,0,30 , 30);
    [self.messageBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.messageBtn setImage:[UIImage imageNamed:@"message_icon"] forState:UIControlStateNormal];
    self.messageBtn.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 5);
    self.messageBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    [shadowView addSubview:self.messageBtn];
    
}

@end
