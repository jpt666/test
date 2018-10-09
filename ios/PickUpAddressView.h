//
//  PickUpAddressView.h
//  CookBook
//
//  Created by 你好 on 16/8/11.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DisableHighlightButton.h"

@interface PickUpAddressView : UIView

@property (nonatomic,retain)UIButton *leftButton;
@property (nonatomic,retain)UIButton *rightButton;
@property (nonatomic,retain)UIButton *centerButton;
@property (nonatomic,retain)UIView *lineView;
@property (nonatomic,assign)id delegate;

-(void)configViewForOrder:(NSDictionary *)dict;

-(void)setLeftButtonSeleted;
-(void)setRightButtonSeleted;

@end

@protocol PickUpAddressViewDelegate <NSObject>

-(void)fixedButtonClick:(PickUpAddressView *)pickUpView;

-(void)tempButtonClick:(PickUpAddressView *)pickUpView;

@end


