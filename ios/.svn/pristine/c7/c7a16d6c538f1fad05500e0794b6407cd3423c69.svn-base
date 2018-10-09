//
//  MyCollectionCell.m
//  CookBook
//
//  Created by 你好 on 16/6/12.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "MyCollectionCell.h"
#import "CookBookPropertyKeys.h"
#import "CookProductPropertyKeys.h"
#import <UIImageView+WebCache.h>
@implementation MyCollectionCell
{
    CAGradientLayer *_gradientLayer;
}

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
    self.contentImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (ScreenWidth-4)/2 , (ScreenWidth-4)/2*1.45)];
    self.contentImageView.image=[UIImage imageNamed:PLACE_HOLDER_COOK_IMAGE];
    self.contentImageView.contentMode=UIViewContentModeScaleAspectFill;
    self.contentImageView.clipsToBounds=YES;
    [self.contentView addSubview:self.contentImageView];
    
    _gradientLayer=[CAGradientLayer layer];
    _gradientLayer.frame=CGRectMake(0, 0,(ScreenWidth-4)/2 ,30);
    _gradientLayer.colors=[NSArray arrayWithObjects:(id)RGBACOLOR(1, 1, 1, 0.8).CGColor, (id)RGBACOLOR(1, 1, 1, 0.4), nil];
    [self.contentImageView.layer insertSublayer:_gradientLayer atIndex:0];
    
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0,self.contentImageView.bounds.size.width-10, 30)];
    self.titleLabel.textColor=[UIColor whiteColor];
    self.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.titleLabel];
    
    UIView *shadowView=[[UIView alloc]initWithFrame:CGRectMake(0, self.contentImageView.bounds.size.height-30, self.contentImageView.bounds.size.width, 30)];
    shadowView.backgroundColor=RGBACOLOR(1, 1, 1, 0.3);
    [self.contentView addSubview:shadowView];
    
    UIImage *image=[UIImage imageNamed:@"watch_icon"];
    
    self.viewBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.viewBtn.frame=CGRectMake(10, 0, 30, 30);
    [self.viewBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.viewBtn setImage:image forState:UIControlStateNormal];
    self.viewBtn.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 5);
    self.viewBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    [shadowView addSubview:self.viewBtn];
    
    self.favorBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.favorBtn.frame=CGRectMake(shadowView.bounds.size.width-80, 0, 30, 30);
    [self.favorBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.favorBtn setImage:[UIImage imageNamed:@"favor_icon"] forState:UIControlStateNormal];
    self.favorBtn.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 5);
    self.favorBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    [shadowView addSubview:self.favorBtn];
    
    self.messageBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.messageBtn.frame=CGRectMake(shadowView.bounds.size.width-40,0,30 , 30);
    [self.messageBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.messageBtn setImage:[UIImage imageNamed:@"message_icon"] forState:UIControlStateNormal];
    self.messageBtn.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 5);
    self.messageBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    [shadowView addSubview:self.messageBtn];
}



-(void)setupWithCookData:(NSMutableDictionary*)dict andType:(CookType)cookType
{
    if (cookType == CookBookType)
    {
        NSString *urlStr=dict[kBookPropertyFrontCoverUrl];
        self.titleLabel.text=dict[kBookPropertyDishName];
        [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:PLACE_HOLDER_COOK_IMAGE]];
    }
    else if(cookType == CookProductType)
    {
        NSString *urlStr=dict[kProductPropertyFrontCoverUrl];
        self.titleLabel.text=dict[kProductPropertyDishName];
        [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:PLACE_HOLDER_COOK_IMAGE]];
    }
    [self.viewBtn setTitle:@"0" forState:UIControlStateNormal];
    [self.favorBtn setTitle:@"0" forState:UIControlStateNormal];
    [self.messageBtn setTitle:@"0" forState:UIControlStateNormal];
}



@end
