//
//  UIButton+Animation.h
//  CookBook
//
//  Created by zhangxi on 16/6/6.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Animation)

-(void)animationDuration:(CGFloat)duration
              startFrame:(CGRect)startFrame
               destFrame:(CGRect)DestFrame
              startAlpha:(CGFloat)startAlpha
                endAlpha:(CGFloat)endAlpah
                rotation:(CGFloat)rotation
              completion:(void (^)(BOOL finished))completion;

@end
