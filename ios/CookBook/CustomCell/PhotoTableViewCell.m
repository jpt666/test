//
//  PhotoTableViewCell.m
//  HuaBao
//
//  Created by 你好 on 16/4/12.
//  Copyright © 2016年 xyxNav. All rights reserved.
//

#import "PhotoTableViewCell.h"

@implementation PhotoTableViewCell


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
    self.headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, (ScreenWidth-6)/4, (ScreenWidth-6)/4)];
    [self.contentView addSubview:self.headImageView];
    
    self.albumLabel=[[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth-6)/4+15,((ScreenWidth-6)/4-40)/2, ScreenWidth-(ScreenWidth-6)/4-10, 40)];
    self.albumLabel.backgroundColor=[UIColor clearColor];
    self.albumLabel.textColor=[UIColor colorWithHexString:@"#343434"];
    [self.contentView addSubview:self.albumLabel];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
