//
//  EditAddressTextViewCell.h
//  CookBook
//
//  Created by 你好 on 16/6/12.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditShopAddressViewController.h"

@interface EditAddressTextViewCell : UITableViewCell<UITextViewDelegate>


@property (nonatomic,retain)UILabel *titleLabel;
@property (nonatomic,retain)UITextView *textView;
@property (nonatomic,assign)id delegate;

- (CGSize)getFitStringTextSize:(NSString *)string;

-(void)configData:(NSDictionary *)dict andType:(AddressType)type;


@end


@protocol EditAddressTextViewCellDelegate<NSObject>

-(void)didChangeTextViewSize:(CGRect)frame andDiff:(CGFloat)diff andTextView:(UITextView *)textView;
-(void)didEndEditTextView:(UITextView *)textView;

//-(void)didChangeTextViewSize:(double)height diff:(CGFloat)diff andCell:(EditAddressTextViewCell *)cell;


@end
