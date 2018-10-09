//
//  CommentPointTableCell.h
//  CookBook
//
//  Created by 你好 on 16/9/6.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UnEditTextView.h"

@interface CommentPointTableCell : UITableViewCell

@property (nonatomic,retain)UIImageView *headImageView;
@property (nonatomic,retain)UIImageView *locationImageView;
@property (nonatomic,retain)UIImageView *timeImageView;
@property (nonatomic,retain)UIImageView *phoneImageView;
@property (nonatomic,retain)UnEditTextView *addressTextView;
@property (nonatomic,retain)UILabel *timeLabel;
@property (nonatomic,retain)UILabel *phoneLabel;
@property (nonatomic,retain)UIView *lineView;

-(void)configData:(NSDictionary *)dict;

-(void)setChecked:(BOOL)bChecked;

@end
