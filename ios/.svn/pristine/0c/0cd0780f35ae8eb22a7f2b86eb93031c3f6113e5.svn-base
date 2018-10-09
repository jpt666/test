//
//  WCAlertview.h
//  WCAlertView
//
//  Created by huangwenchen on 15/2/17.
//  Copyright (c) 2015年 huangwenchen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WCALertviewDelegate<NSObject>
@optional
-(void)didClickWith:(UIView *)alertView  buttonAtIndex:(NSUInteger)buttonIndex;

@end

@interface WCAlertview : UIView

@property (nonatomic,copy)NSString *userId;
@property (weak,nonatomic) id<WCALertviewDelegate> delegate;
-(instancetype)initWithTitle:(NSString *)title WithMessage:(NSString *)message CancelButton:(NSString *)cancelButtonStr OkButton:(NSString *)okButtonStr;
- (void)show;
@end
