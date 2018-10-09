//
//  UserListView.h
//  CookBook
//
//  Created by 你好 on 16/6/3.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserListView : UIView

@property (nonatomic,retain)UIImageView *headImageView;
@property (nonatomic,retain)UILabel *numLabel;
@property (nonatomic,retain)NSString * orderListUrl;
@property (nonatomic,assign)id delegate;

-(void)configData:(NSMutableArray *)array  andAllCount:(NSInteger)allCount;

@end


@protocol UserListViewDelegate <NSObject>

-(void)didClickUserListView:(UserListView *)view;

@end