//
//  GoodListBottomView.m
//  CookBook
//
//  Created by 你好 on 16/8/10.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "GoodListBottomView.h"

@implementation GoodListBottomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        [self configUI];
    }
    return self;
}



-(void)configUI
{
    self.backgroundColor=[UIColor whiteColor];
    
    UIImage *image=[UIImage imageNamed:@"count_icon"];
    UIImageView *headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10+(40-image.size.width)/2, (self.bounds.size.height-image.size.height)/2, image.size.width, image.size.height)];
    headImageView.image=image;
    [self addSubview:headImageView];
    
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width/4-10, 0, self.bounds.size.width/4, self.bounds.size.height)];
    titleLabel.textAlignment=NSTextAlignmentLeft;
    titleLabel.text=@"总计";
    [self addSubview:titleLabel];
    
    self.totalLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width/2, 0, self.bounds.size.width/4, self.bounds.size.height)];
    self.totalLabel.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.totalLabel];
    
    self.totalPriceLabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-self.bounds.size.width/4, 0, self.bounds.size.width/4-10, self.bounds.size.height)];
    self.totalPriceLabel.textAlignment=NSTextAlignmentRight;
    [self addSubview:self.totalPriceLabel];
    
}



@end
