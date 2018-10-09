//
//  SetUpGroupTextView.h
//  CookBook
//
//  Created by 你好 on 16/8/16.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetUpGroupTextView : UIView

@property (nonatomic,retain)UILabel *titleLabel;
@property (nonatomic,retain)UITextField *textField;

- (void)setLabelWidth:(CGFloat)width;

@end
