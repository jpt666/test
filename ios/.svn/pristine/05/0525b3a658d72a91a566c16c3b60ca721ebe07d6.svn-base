//
//  SingleSelectTableCell.m
//  CookBook
//
//  Created by 你好 on 16/8/10.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "SingleSelectTableCell.h"

@implementation SingleSelectTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        self.headImageView.image=[UIImage imageNamed:@"selected_green_icon"];
    } else {
        self.headImageView.image=[UIImage imageNamed:@"normal_round_icon"];
    }
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
    
    UIImage *image=[UIImage imageNamed:@"normal_round_icon"];
    
    self.headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, (60.5-image.size.height)/2, image.size.width, image.size.height)];
    self.headImageView.image=image;
    [self.contentView addSubview:self.headImageView];
    
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(20+image.size.width, 0, ScreenWidth-20-image.size.width, 60)];
    [self.contentView addSubview:self.titleLabel];
    
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(10, 60, ScreenWidth-20, 0.5)];
    lineView.backgroundColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.3];
    [self.contentView addSubview:lineView];
}


@end
