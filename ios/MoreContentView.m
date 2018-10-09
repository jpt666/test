
//
//  MoreContentView.m
//  CookBook
//
//  Created by 你好 on 16/5/18.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "MoreContentView.h"
#import <UIButton+WebCache.h>
#import "DictButton.h"
#import <UIImageView+WebCache.h>
@implementation MoreContentView


-(instancetype)initWith:(NSMutableArray *)array nickName:(NSString *)nickname imagemd5:(NSString *)md5 cookType:(CookType)type yOffSet:(double)yOffet
{
    self=[super init];
    if (self)
    {
        if (array.count==3)
        {
            self.frame=CGRectMake(0, yOffet, ScreenWidth, 75+(ScreenWidth-20)/3*1.47+20);
        }
        else if (array.count==2)
        {
            self.frame=CGRectMake(0, yOffet, ScreenWidth, 75+(ScreenWidth-20)/3*1.47+20);
        }
        else if (array.count==1)
        {
            self.frame=CGRectMake(0, yOffet, ScreenWidth, 75+(ScreenWidth-20)/3*1.47+20);
        }
        
        UIImageView *centerImageView=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2-25,5, 50, 50)];
        centerImageView.contentMode = UIViewContentModeScaleAspectFill;
        centerImageView.layer.cornerRadius=25;
        centerImageView.clipsToBounds=YES;
        [self addSubview:centerImageView];
        
        UIImage *lineLeftImage=[UIImage imageNamed:@"moreline_left"];
        UIImage *lineRightImage=[UIImage imageNamed:@"moreline_right"];
        
        UIImageView *leftLineView=[[UIImageView alloc]initWithFrame:CGRectMake(15,29.5, ScreenWidth/2-50, lineLeftImage.size.height)];
        leftLineView.image=lineLeftImage;
        [self addSubview:leftLineView];
        
        UIImageView *rightLineView=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2+35,29.5, ScreenWidth/2-50, lineRightImage.size.height)];
        rightLineView.image=lineRightImage;
        [self addSubview:rightLineView];
        
        NSString *descStr=nil;
        if (type==CookBookType)
        {
            descStr=[NSString stringWithFormat:@"%@的更多菜谱",nickname];
        }
        else if(type==CookProductType)
        {
            descStr=[NSString stringWithFormat:@"%@的更多作品",nickname];
        }
        
        UILabel *userLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,67.5, ScreenWidth, 20)];
        userLabel.backgroundColor=[UIColor clearColor];
        userLabel.text=descStr;
        userLabel.font=[UIFont systemFontOfSize:16];
        userLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:userLabel];
        
        if (array.count==3)
        {
            for (int i=0; i<array.count; i++)
            {
                NSDictionary *dict=[array objectAtIndex:i];
                NSString *imageUrl=nil;
                NSString *userImageUrl=nil;
                NSString *labelText=nil;
                
                if (CookBookType==type)
                {
                    imageUrl=dict[kBookPropertyFrontCoverUrl];
                    userImageUrl=dict[kBookPropertyCookerIconUrl];
                    labelText=dict[kBookPropertyDishName];
                }
                else if (CookProductType==type)
                {
                    imageUrl=dict[kProductPropertyFrontCoverUrl];
                    userImageUrl=dict[kProductPropertyCookerIconUrl];
                    labelText=dict[kProductPropertyDishName];
                }
                
                [centerImageView sd_setImageWithURL:[NSURL URLWithString:userImageUrl] placeholderImage:[UIImage imageNamed:@"default_icon"]];
                
                if(i==0)
                {
                    DictButton *button=[[DictButton alloc]initWithFrame:CGRectMake(16,105, (ScreenWidth-36)/3, (ScreenWidth-36)/3*1.47)];
                    button.frame=CGRectMake(16,105, (ScreenWidth-36)/3, (ScreenWidth-36)/3*1.47);
                    button.dict=dict;
                    button.type=type;
                    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                    [[button imageView]setContentMode:UIViewContentModeScaleAspectFill];
                    [button sd_setImageWithURL:[NSURL URLWithString:imageUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:PLACE_HOLDER_COOK_IMAGE]];
                    button.descLabel.text=labelText;
                    [button.descLabel sizeToFit];
                    [self addSubview:button];
                }
                else if (i==1)
                {
                    DictButton *button=[[DictButton alloc]initWithFrame:CGRectMake(18+(ScreenWidth-36)/3,105, (ScreenWidth-36)/3, (ScreenWidth-36)/3*1.47)];
                    button.dict=dict;
                    button.type=type;
                    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                    [[button imageView]setContentMode:UIViewContentModeScaleAspectFill];
                    [button sd_setImageWithURL:[NSURL URLWithString:imageUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:PLACE_HOLDER_COOK_IMAGE]];
                    button.descLabel.text=labelText;
                    [button.descLabel sizeToFit];
                    [self addSubview:button];
                }
                else if (i==2)
                {
                    DictButton *button=[[DictButton alloc]initWithFrame:CGRectMake(20+(ScreenWidth-36)/3*2,105, (ScreenWidth-36)/3, (ScreenWidth-36)/3*1.47)];
                    button.dict=dict;
                    button.type=type;
                    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                    [[button imageView]setContentMode:UIViewContentModeScaleAspectFill];
                    [button sd_setImageWithURL:[NSURL URLWithString:imageUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:PLACE_HOLDER_COOK_IMAGE]];
                    button.descLabel.text=labelText;
                    [button.descLabel sizeToFit];
                    [self addSubview:button];
                }
            }
        }
        else if (array.count==2)
        {
            for (int i=0; i<array.count; i++)
            {

                NSDictionary *dict=[array objectAtIndex:i];
                NSString *imageUrl=nil;
                NSString *userImageUrl=nil;
                NSString *labelText=nil;
                
                if (CookBookType==type)
                {
                    imageUrl=dict[kBookPropertyFrontCoverUrl];
                    userImageUrl=dict[kBookPropertyCookerIconUrl];
                    labelText=dict[kBookPropertyDishName];
                }
                else if (CookProductType==type)
                {
                    imageUrl=dict[kProductPropertyFrontCoverUrl];
                    userImageUrl=dict[kProductPropertyCookerIconUrl];
                    labelText=dict[kProductPropertyDishName];
                }
                
                [centerImageView sd_setImageWithURL:[NSURL URLWithString:userImageUrl] placeholderImage:[UIImage imageNamed:@"default_icon"]];
                
                double space = (ScreenWidth - (ScreenWidth-36)/3*2)/3;
                
                DictButton *button=[[DictButton alloc]initWithFrame:CGRectMake(i*(ScreenWidth-36)/3+space*(i+1),105, (ScreenWidth-36)/3, (ScreenWidth-36)/3*1.47)];
                button.dict=dict;
                button.type=type;
                [[button imageView]setContentMode:UIViewContentModeScaleAspectFill];
                [button sd_setImageWithURL:[NSURL URLWithString:imageUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:PLACE_HOLDER_COOK_IMAGE]];
                [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                button.descLabel.text=labelText;
                [button.descLabel sizeToFit];
                [self addSubview:button];
            }
        }
        else if(array.count==1)
        {

            NSDictionary *dict=[array firstObject];
            NSString *imageUrl=nil;
            NSString *userImageUrl=nil;
            NSString *labelText=nil;
            
            if (CookBookType==type)
            {
                imageUrl=dict[kBookPropertyFrontCoverUrl];
                userImageUrl=dict[kBookPropertyCookerIconUrl];
                labelText=dict[kBookPropertyDishName];
            }
            else if (CookProductType==type)
            {
                imageUrl=dict[kProductPropertyFrontCoverUrl];
                userImageUrl=dict[kProductPropertyCookerIconUrl];
                labelText=dict[kProductPropertyDishName];
            }
            
            [centerImageView sd_setImageWithURL:[NSURL URLWithString:userImageUrl] placeholderImage:[UIImage imageNamed:@"default_icon"]];
            
            double space = (ScreenWidth - (ScreenWidth-36)/3)/2;
            
            DictButton *button=[[DictButton alloc]initWithFrame:CGRectMake(space, 105, (ScreenWidth-36)/3, (ScreenWidth-36)/3*1.47)];
            button.dict=dict;
            button.type=type;
            [[button imageView]setContentMode:UIViewContentModeScaleAspectFill];
            [button sd_setImageWithURL:[NSURL URLWithString:imageUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:PLACE_HOLDER_COOK_IMAGE]];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            button.descLabel.text=labelText;
            [button.descLabel sizeToFit];
            [self addSubview:button];
        }
    }
    
    return self;
    
}


-(void)buttonClick:(DictButton *)button
{
    if (_delegate && [_delegate respondsToSelector:@selector(didClickContentView:CookType:)]) {
        [_delegate didClickContentView:button.dict CookType:button.type];
    }
}


@end
