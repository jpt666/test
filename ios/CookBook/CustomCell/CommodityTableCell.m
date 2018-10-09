//
//  CommodityTableCell.m
//  CookBook
//
//  Created by 你好 on 16/6/3.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "CommodityTableCell.h"
#import <UIImageView+WebCache.h>
#import "GoodsPropertyKeys.h"

@implementation CommodityTableCell

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
    self.contentImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,200)];
    self.contentImageView.clipsToBounds=YES;
    self.contentImageView.contentMode=UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.contentImageView];
}

-(void)configData:(NSDictionary *)dict
{
    double imageHeight=[dict[@"height"] doubleValue];
    double imageWidth=[dict[@"width"] doubleValue];
    double height=(ScreenWidth*imageHeight)/imageWidth;
    self.contentImageView.frame=CGRectMake(0, 0, ScreenWidth, height);
    [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:dict[kGoodsDetailPropertyImage]] placeholderImage:[UIImage imageNamed:PLACE_HOLDER_COOK_IMAGE]];
}


@end
