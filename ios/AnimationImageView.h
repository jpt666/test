//
//  AnimationImageView.h
//  CookBook
//
//  Created by 你好 on 16/4/18.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AnimationImageViewDelegate <NSObject>

-(void)exChangeBtnClick:(UIImageView *)view;
-(void)deleteBtnClick:(UIImageView *)view;
-(void)puzzleBtnClick:(UIImageView *)view;
-(void)animationImageClick:(UIImageView *)view;


@end


@interface AnimationImageView : UIImageView

@property (nonatomic,assign)id delegate;

-(void)hideSubView;

@end
