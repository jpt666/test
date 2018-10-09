//
//  SettingTableCell.m
//  CookBook
//
//  Created by 你好 on 16/6/12.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "SettingTableCell.h"

@implementation SettingTableCell

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
    self.headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 40, 40)];
    [self.contentView addSubview:self.headImageView];
    
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(60, 0, ScreenWidth-130, 50)];
    self.titleLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e"];
    self.titleLabel.font=[UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.titleLabel];
    
    self.bottomLabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-140, 0, 130, 50)];
    self.bottomLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e"];
    self.bottomLabel.font=[UIFont systemFontOfSize:16];
    self.bottomLabel.textAlignment=NSTextAlignmentRight;
    [self.contentView addSubview:self.bottomLabel];
    
    self.lineView=[[UIView alloc]initWithFrame:CGRectMake(10, 49.5, ScreenWidth-20, 0.5)];
    self.lineView.backgroundColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.3];
    [self.contentView addSubview:self.lineView];
    
}


@end
