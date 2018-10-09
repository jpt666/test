//
//  PopView.m
//  CookBook
//
//  Created by 你好 on 16/6/16.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "PopView.h"

@implementation PopView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}


-(void)configUI
{
    UIImage *iconImage=[UIImage imageNamed:@"logo_icon"];
    self.imageView=[[UIImageView alloc]initWithFrame:CGRectMake((self.bounds.size.width-iconImage.size.width)/2, 55, iconImage.size.width, iconImage.size.height)];
    self.imageView.image=iconImage;
    [self addSubview:self.imageView];
    
    self.sendButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.sendButton.frame=CGRectMake(10, self.bounds.size.height-60, self.bounds.size.width-20, 40);
    self.sendButton.backgroundColor=[UIColor orangeColor];
    [self.sendButton setTitle:@"分享到微信群，邀请好友接龙!" forState:UIControlStateNormal];
    [self addSubview:self.sendButton];
    
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, self.imageView.frame.origin.y+self.imageView.frame.size.height+30, self.bounds.size.width-20, self.bounds.size.height-self.imageView.frame.origin.y-self.imageView.frame.size.height-70)];
    self.titleLabel.text=[NSString stringWithFormat:@"恭喜您成为第%@位接龙者,快去邀请小伙伴参团吧!",self.dict[@"seq"]];
    self.titleLabel.numberOfLines=2;
    self.titleLabel.lineBreakMode=NSLineBreakByWordWrapping;
    [self addSubview:self.titleLabel];
}

-(void)hideUI
{
    self.imageView.hidden=YES;
    self.sendButton.hidden=YES;
    self.titleLabel.hidden=YES;
}


@end
