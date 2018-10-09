//
//  RecommendImageView.m
//  CookBook
//
//  Created by 你好 on 16/5/19.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "RecommendImageView.h"

@implementation RecommendImageView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        self.userInteractionEnabled=YES;
        
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
        tapGesture.numberOfTapsRequired=1;
        tapGesture.numberOfTouchesRequired=1;
        [self addGestureRecognizer:tapGesture];
        
    }
    return self;
}



-(void)tapGesture:(UITapGestureRecognizer *)tapGesture
{
    if (_delegate && [_delegate respondsToSelector:@selector(didClickImageView:)]) {
        [_delegate didClickImageView:self];
    }
}

@end
