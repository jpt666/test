//
//  PhotoCollectionViewCell.m
//  HuaBao
//
//  Created by 你好 on 16/4/11.
//  Copyright © 2016年 xyxNav. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}


-(void)configUI
{
    self.imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (ScreenWidth-6)/3, (ScreenWidth-6)/3)];
//    self.imageView.contentMode=UIViewContentModeScaleToFill;
    [self.contentView addSubview:self.imageView];
    
    self.selectView=[[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth-6)/3-35, 5, 30, 30)];
    self.selectView.hidden=YES;
    self.selectView.layer.cornerRadius=15;
    self.selectView.clipsToBounds=YES;
    self.selectView.textAlignment=NSTextAlignmentCenter;
    self.selectView.textColor=[UIColor whiteColor];
    self.selectView.backgroundColor=RGBACOLOR(251, 135, 40, 1);
    [self.contentView addSubview:self.selectView];
}
@end
