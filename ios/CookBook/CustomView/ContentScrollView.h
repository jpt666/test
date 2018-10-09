//
//  ContentScrollView.h
//  CookBook
//
//  Created by zhangxi on 16/4/18.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ContentScrollView;

@protocol ContentScrollViewDataSource <NSObject>

@required
- (NSInteger)numberOfPagesInContentScrollView:(ContentScrollView *)contentScrollView;

- (NSMutableArray *)arrayTableViewForContentScrollView:(ContentScrollView *)contentScrollView;

- (NSMutableArray *)arrayButtonForContentScrollView:(ContentScrollView *)contentScrollView;

- (NSInteger)initialSelectedIndex:(ContentScrollView *)contentScrollView;

- (NSInteger)titleBottomLineInsetX:(ContentScrollView *)contentScrollView;

- (NSInteger)tableViewTopOffset:(ContentScrollView *)contentScrollView;

@optional

- (CGFloat)titleHeight:(ContentScrollView *)contentScrollView;
//- (UIView *)headerViewForContentScrollView:(ContentScrollView *)contentScrollView
//                                     atTableViewIndex:(NSInteger)index;
//
//- (CGFloat)heightForContentScrollView:(ContentScrollView *)contentScrollView
//                     atTableViewIndex:(NSInteger)index;

@end

@protocol ContentScrollViewDelegate <NSObject>

-(void)didContentScrollView:(ContentScrollView *)contentScrollView
              showTableView:(UITableView *)tableView
          indexOfTableviews:(NSInteger)index;

@end

@interface ContentScrollView : UIView<UIScrollViewDelegate>

@property (nonatomic, weak) id<ContentScrollViewDataSource> dataSource;
@property (nonatomic, weak) id<ContentScrollViewDelegate> delegate;

- (void)setSelectIndex:(NSInteger)index;

- (void)setTitleAlpha:(CGFloat)alpha;

- (CGFloat)getTitleHeight;

- (void)setTitleBackgroundColor:(UIColor *)color;
//@property (nonatomic, assign) BOOL scrollEnabled;

@end
