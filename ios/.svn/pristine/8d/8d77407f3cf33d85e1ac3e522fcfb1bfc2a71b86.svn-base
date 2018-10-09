//
//  UIButton+Animation.m
//  CookBook
//
//  Created by zhangxi on 16/6/6.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "UIButton+Animation.h"

@implementation UIButton (Animation)

-(void)animationDuration:(CGFloat)duration
              startFrame:(CGRect)startFrame
               destFrame:(CGRect)DestFrame
              startAlpha:(CGFloat)startAlpha
                endAlpha:(CGFloat)endAlpah
                rotation:(CGFloat)rotation
              completion:(void (^)(BOOL finished))completion
{
    self.frame = startFrame;
    self.alpha = startAlpha;
    self.transform = CGAffineTransformMakeRotation(rotation);
    [UIView animateWithDuration:duration animations:^{
        self.transform = CGAffineTransformIdentity;
        self.frame = DestFrame;
        self.alpha = endAlpah;
        
    } completion:^(BOOL finished) {
        if (completion) {
            completion(finished);
        }
    }];
}


@end
