//
//  CustomTextView.h
//  CookBook
//
//  Created by 你好 on 16/4/15.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTextView : UIView

@property (nonatomic,retain)UITextView *textView;
@property (nonatomic,retain)UIImageView *lineImageView;
@property (nonatomic,assign)id delegate;

- (void)refreshTextViewSize:(UITextView *)textView;


@end


@protocol CustomTextViewDelegate <NSObject>

-(void)updateFrame:(CGRect)frame andCustomTextView:(CustomTextView *)view;

- (void)customTextViewDidBeginEditing:(CustomTextView *)textView;

- (void)customTextViewDidEndEditing:(CustomTextView *)textView;

@end