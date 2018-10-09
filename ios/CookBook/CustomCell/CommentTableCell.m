//
//  CommentTableCell.m
//  CookBook
//
//  Created by 你好 on 16/5/5.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "CommentTableCell.h"

@implementation CommentTableCell

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
    self.userHeadImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
    self.userHeadImageView.image=[UIImage imageNamed:@"default_icon"];
    self.userHeadImageView.clipsToBounds=YES;
    self.userHeadImageView.layer.cornerRadius=20;
    [self.contentView addSubview:self.userHeadImageView];
    
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(70, 10, (ScreenWidth-70), 20)];
    self.titleLabel.backgroundColor=[UIColor clearColor];
    self.titleLabel.text=@"1111";
    self.titleLabel.textColor=[UIColor colorWithHexString:@"#343434"];
    [self.contentView addSubview:self.titleLabel];
    
    self.contentLabel=[[UILabel alloc]initWithFrame:CGRectMake(70, 30, ScreenWidth-70, 20)];
    self.contentLabel.backgroundColor=[UIColor clearColor];
    self.contentLabel.text=@"2222";
    self.contentLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.8];
    self.contentLabel.font=[UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.contentLabel];
}

@end
