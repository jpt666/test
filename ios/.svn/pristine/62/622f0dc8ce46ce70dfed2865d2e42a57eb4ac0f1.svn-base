//
//  MyOrderView.m
//  CookBook
//
//  Created by 你好 on 16/6/12.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "MyOrderView.h"
#import <UIImageView+WebCache.h>
@implementation MyOrderView
{
    UIImageView *_bottomImageView;
}


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor=RGBACOLOR(224, 224, 224, 0.25);

//        UIImage *image=[UIImage imageNamed:@"right_darkArrow_icon"];
//        _bottomImageView=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-10-image.size.width, (self.bounds.size.height-10-image.size.width)/2, image.size.width, image.size.height)];
//        _bottomImageView.image=image;
//        [self addSubview:_bottomImageView];
    }
    return self;
}


-(void)configData:(NSMutableArray *)array
{
    UIImage *image=[UIImage imageNamed:@"right_darkArrow_icon"];
    
    for (UIImageView *imageView in self.subviews)
    {
        [imageView removeFromSuperview];
    }
  
    double x=0.0;
    
    if (array.count>0)
    {
        int index=(ScreenWidth-20)/((ScreenWidth-100-image.size.width)/5+15);
        
        for (int i=0; i<array.count; i++)
        {
            if(index>=i+1)
            {
                x=5*i+((ScreenWidth-100-image.size.width)/5+10)*i+10;
                NSString *urlStr=[array objectAtIndex:i];
                UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(x, 10 , (ScreenWidth-100-image.size.width)/5+10, (ScreenWidth-100-image.size.width)/5+10)];
                imageView.contentMode=UIViewContentModeScaleAspectFill;
                imageView.clipsToBounds=YES;
                [imageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
                imageView.userInteractionEnabled=YES;
                [self addSubview:imageView];
            }
        }
    }
}


@end
