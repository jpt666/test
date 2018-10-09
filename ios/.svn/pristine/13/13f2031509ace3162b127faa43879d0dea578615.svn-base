//
//  BottomShowView.m
//  CookBook
//
//  Created by 你好 on 16/5/4.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "BottomShowView.h"

@implementation BottomShowView


-(instancetype)initWithFrame:(CGRect)frame
{
    self= [super initWithFrame:frame];
    if (self)
    {
        [self configUI];
    }
    return self;
}


-(void)configUI
{
    self.layer.borderWidth=0.5f;
    self.layer.borderColor=[UIColor lightGrayColor].CGColor;

    self.commentBtn=[[CustomClickView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/3, 49)];
    self.commentBtn.topImage=[UIImage imageNamed:@"comment_icon"];
    self.commentBtn.bottomLabel.text=@"评论";
    self.commentBtn.topImageView.frame=CGRectMake((ScreenWidth/3-self.commentBtn.topImage.size.width)/2,5, self.commentBtn.topImage.size.width, self.commentBtn.topImage.size.height);
    self.commentBtn.bottomLabel.frame=CGRectMake(0, self.commentBtn.topImage.size.height+5,  ScreenWidth/3,49-self.commentBtn.topImage.size.height-5);
    self.commentBtn.topImageView.image=[UIImage imageNamed:@"comment_icon"];
    [self addSubview:self.commentBtn];

    self.uploadWorkBtn=[[CustomClickView alloc]initWithFrame:CGRectMake(ScreenWidth/3, 0, ScreenWidth/3, 49)];
    self.uploadWorkBtn.topImage=[UIImage imageNamed:@"camera_icon"];
    self.uploadWorkBtn.bottomLabel.text=@"上传美食";
      self.uploadWorkBtn.topImageView.frame=CGRectMake((ScreenWidth/3-self.uploadWorkBtn.topImage.size.width)/2,5, self.uploadWorkBtn.topImage.size.width, self.uploadWorkBtn.topImage.size.height);
    self.uploadWorkBtn.bottomLabel.frame=CGRectMake(0, self.uploadWorkBtn.topImage.size.height+5, ScreenWidth/3, 49-self.uploadWorkBtn.topImage.size.height-5);
    self.uploadWorkBtn.topImageView.image=[UIImage imageNamed:@"camera_icon"];
    [self addSubview:self.uploadWorkBtn];
    
    self.collectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.collectBtn.frame=CGRectMake(ScreenWidth/3*2, 0, ScreenWidth/3, 49);
    [self.collectBtn setTitle:@"收 藏" forState:UIControlStateNormal];
    [self.collectBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    [self.collectBtn setImage:[UIImage imageNamed:@"collection_icon"] forState:UIControlStateNormal];
    [self.collectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    self.collectBtn.backgroundColor=RGBACOLOR(176, 116, 67, 1);
    [self addSubview:self.collectBtn];
}

@end
