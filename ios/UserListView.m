//
//  UserListView.m
//  CookBook
//
//  Created by 你好 on 16/6/3.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "UserListView.h"
#import <UIImageView+WebCache.h>
@implementation UserListView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        self.userInteractionEnabled=YES;
        
        UIImage *saleImage=[UIImage imageNamed:@"sale_icon"];

        self.headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(5, 7.5, 30, 30)];
        self.headImageView.image=saleImage;
        self.headImageView.layer.cornerRadius=saleImage.size.width/2;
        self.headImageView.clipsToBounds=YES;
        self.headImageView.userInteractionEnabled=YES;
        [self addSubview:self.headImageView];
        
        self.numLabel=[[UILabel alloc]initWithFrame:CGRectMake(35, 0, 20, self.bounds.size.height)];
        self.numLabel.backgroundColor=[UIColor clearColor];
        self.numLabel.font=[UIFont systemFontOfSize:16];
        self.numLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.8];
        self.numLabel.textAlignment=NSTextAlignmentRight;
        [self addSubview:self.numLabel];

        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
        tapGesture.numberOfTapsRequired=1;
        tapGesture.numberOfTouchesRequired=1;
        [self addGestureRecognizer:tapGesture];
    
    }
    return self;
}


-(void)configData:(NSMutableArray *)array  andAllCount:(NSInteger)allCount
{
    for (UIView *view in self.subviews)
    {
        if (view!=self.headImageView)
        {
            [view removeFromSuperview];
        }
    }
    
    
    double x=0.0;
    
    if (array.count>0)
    {
        int index=(ScreenWidth-55)/40;
        
        for (int i=1; i<=array.count; i++)
        {
            if(index+1>i)
            {
                x=5*(i+1)+35*i;
                NSString *urlStr=[array objectAtIndex:i-1];
                UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(x, 7.5, 35, 35)];
                [imageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"default_icon"]];
                imageView.layer.cornerRadius=17.5;
                imageView.clipsToBounds=YES;
                imageView.userInteractionEnabled=YES;
                [self addSubview:imageView];
            }
            
            if (array.count==i)
            {
                self.numLabel=[[UILabel alloc]initWithFrame:CGRectMake(x+40, 0, 20, self.bounds.size.height)];
                self.numLabel.font=[UIFont systemFontOfSize:16];
                self.numLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.8];
                self.numLabel.textAlignment=NSTextAlignmentCenter;
                [self addSubview:self.numLabel];
            }
        }
    }
    else
    {
        self.numLabel=[[UILabel alloc]initWithFrame:CGRectMake(35, 0, 20, self.bounds.size.height)];
        self.numLabel.backgroundColor=[UIColor clearColor];
        self.numLabel.font=[UIFont systemFontOfSize:16];
        self.numLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.8];
        self.numLabel.textAlignment=NSTextAlignmentRight;
        [self addSubview:self.numLabel];
    }
    
    
    self.numLabel.text=[NSString stringWithFormat:@"%ld",(long)allCount];
    [self bringSubviewToFront:self.numLabel];
}

-(void)tapGesture:(UITapGestureRecognizer *)tapGesture
{
    if (_delegate && [_delegate respondsToSelector:@selector(didClickUserListView:)])
    {
        [_delegate didClickUserListView:self];
    }
}



@end
