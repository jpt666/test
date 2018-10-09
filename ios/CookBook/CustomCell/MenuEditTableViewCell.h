//
//  MenuEditTableViewCell.h
//  CookBook
//
//  Created by 你好 on 16/4/15.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AnimationImageView.h"
#import "CookBaseProxy.h"
#import "TextView.h"
@interface MenuEditTableViewCell : UITableViewCell<UITextViewDelegate>

@property (nonatomic,retain)AnimationImageView *contentImageView;

@property (nonatomic,retain)TextView *textView;

@property (nonatomic,retain)UIImageView *rightPressView;

@property (nonatomic,assign)id delegate;

-(void)configData:(CookBaseProxy*)cookData atRow:(NSInteger)row isEditing:(BOOL)isEditing;

- (CGSize)getFitStringTextSize:(NSString *)string;

@end


@protocol TextViewDidResizeDelegate <NSObject>

-(void)didChangeTextViewSize:(double)height diff:(CGFloat)diff andCell:(MenuEditTableViewCell *)cell;

-(void)didTextViewEndEdit:(NSIndexPath *)indexPath andText:(NSString *)textStr;

-(void)didCellTextViewBeginEditing:(UITextView *)textView;

@end