//
//  PTStoryBoardView.h
//  PinTuDemo
//
//  Created by zhangxi on 16/5/18.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PTStoryboardViewDelegate <NSObject>

- (void)didSelectedStoryboardIndex:(NSInteger)storyboardIndex forImagesCount:(NSInteger)imagesCount;

@end

@interface PTStoryBoardView : UIView

@property (nonatomic, strong) UIScrollView  *storyboardView;
@property (nonatomic, assign) id<PTStoryboardViewDelegate> delegate;
@property (nonatomic, assign) NSInteger      imagesCount;
@property (nonatomic, assign) NSInteger      storyboardIndex;

- (id)initWithFrame:(CGRect)frame imagesCount:(NSInteger)imagesCount;

@end
