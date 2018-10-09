//
//  ConfirmOrderCenterView.h
//  CookBook
//
//  Created by 你好 on 16/6/6.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DisableHighlightButton.h"
@interface ConfirmOrderCenterView : UIView

@property (nonatomic,retain)UILabel *titleLabel;
@property (nonatomic,retain)DisableHighlightButton *leftButton;
@property (nonatomic,retain)DisableHighlightButton *rightButton;
@property (nonatomic,retain)UITableView *addressTable;
@property (nonatomic,retain)UIView *rightView;
@property (nonatomic,retain)UILabel *addressLabel;
@property (nonatomic,retain)UIButton *replayAddressBtn;
@property (nonatomic,retain)UIView *backView;
@property (nonatomic,retain)UIView *lineView;
@property (nonatomic,assign)id delegate;

-(void)configFrame;
-(void)configData:(NSDictionary *)dict;

@end


@protocol ConfirmOrderCenterViewDelegate <NSObject>

-(void)didLeftButtonClick:(UIButton *)leftButton;

-(void)didRightButtonClick:(UIButton *)rightButton;

@end