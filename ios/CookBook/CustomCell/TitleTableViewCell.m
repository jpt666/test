//
//  TitleTableViewCell.m
//  CookBook
//
//  Created by 你好 on 16/6/7.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "TitleTableViewCell.h"

@implementation TitleTableViewCell

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
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10,0 , 80, 50)];
    self.titleLabel.font=[UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.titleLabel];
    
    self.descLabel=[[UILabel alloc]initWithFrame:CGRectMake(90, 0, ScreenWidth-100, 50)];
    self.descLabel.font=[UIFont systemFontOfSize:14];
    self.descLabel.textAlignment=NSTextAlignmentRight;
    self.descLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e"];
    [self.contentView addSubview:self.descLabel];
    
    self.lineView=[[UIView alloc]initWithFrame:CGRectMake(10, 49.5, ScreenWidth-20, 0.5)];
    self.lineView.backgroundColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.3];
    [self.contentView addSubview:self.lineView];
}

@end
