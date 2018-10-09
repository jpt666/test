//
//  ShowCookingSkillView.h
//  CookBook
//
//  Created by zhangxi on 16/4/12.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShowCookingSkillView;

@protocol ShowCookingSkillViewDelegate <NSObject>
@required
- (void)didView:(ShowCookingSkillView *)view expanded:(BOOL)bExpanded;
@end

@protocol ShowCookingSkillViewDataSource <NSObject>
@required

-(UIButton *)leftButtonForView:(ShowCookingSkillView *)view;
-(UIButton *)rightButtonForView:(ShowCookingSkillView *)view;
@end

@interface ShowCookingSkillView : UIView

@property (nonatomic, weak) id<ShowCookingSkillViewDelegate> delegate;
@property (nonatomic, weak) id<ShowCookingSkillViewDataSource> dataSource;
@property (nonatomic) Boolean  bExpand;


- (void)setupGUIWithControlButtonImage:(UIImage *)image forState:(UIControlState)state;

- (void)hideView;

- (void)showView;

- (void)folderView;

@end
