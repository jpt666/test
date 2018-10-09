//
//  CategoryView.m
//  CookBook
//
//  Created by 你好 on 16/6/20.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "CategoryView.h"
#import <UIImageView+WebCache.h>
#import <UIButton+WebCache.h>
#import "GroupsPropertyKeys.h"
@implementation CategoryView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor=[UIColor whiteColor];
        self.userInteractionEnabled=YES;
        [self configUI];
    }
    return self;
}

-(void)configUI
{
    self.leftImageView=[[DictImageView alloc]init];
    self.leftImageView.frame=CGRectMake(0, 0, ScreenWidth/2, self.frame.size.height);
    [self.leftImageView setUserInteractionEnabled:YES];
    self.leftImageView.contentMode=UIViewContentModeScaleAspectFill;
    [self addSubview:self.leftImageView];
    
    self.rightTopImageView=[[DictImageView alloc]init];
    self.rightTopImageView.frame=CGRectMake(self.bounds.size.width/2, 0, self.bounds.size.width/2, self.bounds.size.height/2);
    [self.rightTopImageView setUserInteractionEnabled:YES];
    self.rightTopImageView.contentMode=UIViewContentModeScaleAspectFill;
    [self addSubview:self.rightTopImageView];
    
    self.rightBottomImageView=[[DictImageView alloc]init];
    self.rightBottomImageView.frame=CGRectMake(self.bounds.size.width/2, self.bounds.size.height/2, self.bounds.size.width/2, self.bounds.size.height/2);
    [self.rightBottomImageView setUserInteractionEnabled:YES];
    self.rightBottomImageView.contentMode=UIViewContentModeScaleAspectFill;
    [self addSubview:self.rightBottomImageView];
}


-(void)configData:(NSMutableArray *)array
{
    if (array.count==3)
    {
        for (int i=0;i<3;i++)
        {
            NSDictionary *dict=[array objectAtIndex:i];
            NSString *urlStr=[NSString stringWithFormat:@"%@",dict[@"cover_2x"]];
            if (i==0)
            {
                self.leftImageView.dict=dict;
                [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:PLACE_HOLDER_COOK_IMAGE]];
            }
            else if (i==1)
            {
                self.rightTopImageView.dict=dict;
                [self.rightTopImageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:PLACE_HOLDER_COOK_IMAGE]];
            }
            else if (i==2)
            {
                self.rightBottomImageView.dict=dict;
                [self.rightBottomImageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:PLACE_HOLDER_COOK_IMAGE]];
            }
        }
    }
}




@end
