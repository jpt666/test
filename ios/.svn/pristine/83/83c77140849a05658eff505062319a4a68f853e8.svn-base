//
//  ListAlertView.h
//  CookBook
//
//  Created by 你好 on 16/9/7.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ListAlertViewDelegate <NSObject>

-(void)didClickButton:(UIView *)listAlertView;

@end

@interface ListAlertView : UIView

typedef NS_ENUM(NSInteger, AlertType) {
    AlertTypeLimit,
    AlertTypeNotEnough
};

@property (weak,nonatomic) id<ListAlertViewDelegate> delegate;
@property (nonatomic, assign) AlertType alertType;

-(instancetype)initWithArray:(NSMutableArray *)dataArray;


-(void)show;


@end
