//
//  WCAlertview.h
//  WCAlertView
//
//  Created by huangwenchen on 15/2/17.
//  Copyright (c) 2015年 huangwenchen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MCALertviewDelegate<NSObject>

-(void)didClickWith:(UIView *)alertView  buttonAtIndex:(NSUInteger)buttonIndex;

@end

@interface MCAlertview : UIView

@property (nonatomic,copy)NSString *userId;
@property (nonatomic,strong)NSDictionary *dict;
@property (weak,nonatomic) id<MCALertviewDelegate> delegate;

-(instancetype)initWithMessage:(NSString *)message CancelButton:(NSString *)cancelButtonStr andCancelBtnBackGround:(UIColor *)cancelBtnBackColor  OkButton:(NSString *)onButtonStr andOkBtnColor:(UIColor *)okBtnBackColor;

- (void)show;

@end
