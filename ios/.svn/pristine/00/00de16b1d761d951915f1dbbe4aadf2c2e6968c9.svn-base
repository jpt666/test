//
//  LimitTableViewCell.m
//  CookBook
//
//  Created by 你好 on 16/9/7.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "LimitTableViewCell.h"

@implementation LimitTableViewCell

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
    UIView * keywindow = [[UIApplication sharedApplication] keyWindow];

    self.leftLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, (keywindow.frame.size.width-30)/2+10, 30)];
    self.leftLabel.font=[UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.leftLabel];
    
    self.rightLabel=[[UILabel alloc]initWithFrame:CGRectMake((keywindow.frame.size.width-30)/2+20, 0, (keywindow.frame.size.width-30)/2-30, 30)];
    self.rightLabel.font=[UIFont systemFontOfSize:16];
    self.rightLabel.textAlignment=NSTextAlignmentRight;
    [self.contentView addSubview:self.rightLabel];
}

@end
