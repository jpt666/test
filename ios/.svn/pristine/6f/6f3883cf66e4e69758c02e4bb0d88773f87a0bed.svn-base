//
//  MyCollectionViewCell.m
//  CookBook
//
//  Created by 你好 on 16/6/12.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        [self configUI];
    }
    return self;
}



-(void)configUI
{
    UIImage *image=[UIImage imageNamed:@"my_drafts_icon"];
    self.contentImageView=[[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth/3-image.size.width)/2, (ScreenWidth/3-image.size.height)/2-15, image.size.width , image.size.height)];
    [self.contentView addSubview:self.contentImageView];
    
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, self.contentImageView.frame.origin.y+self.contentImageView.frame.size.height, ScreenWidth/3, 30)];
    self.titleLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e"];
    self.titleLabel.font=[UIFont systemFontOfSize:15];
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLabel];
}



@end
