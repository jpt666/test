//
//  SelectPickUpTableCell.h
//  CookBook
//
//  Created by 你好 on 16/8/11.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SelectPickUpTableCell;
@protocol SelectPickUpTableCellDelegate <NSObject>

-(void)editButtonClicked:(SelectPickUpTableCell *)cell;

@end

@interface SelectPickUpTableCell : UITableViewCell

@property (nonatomic,retain)UIImageView *headImageView;
@property (nonatomic,retain)UIButton *editButton;
@property (nonatomic,retain)UILabel *typeLabel;
@property (nonatomic,retain)UIImageView *locationImageView;
@property (nonatomic,retain)UIImageView *timeImageView;
@property (nonatomic,retain)UIImageView *phoneImageView;
@property (nonatomic,retain)UILabel *addressLabel;
@property (nonatomic,retain)UILabel *timeLabel;
@property (nonatomic,retain)UILabel *phoneLabel;
@property (nonatomic,retain)UIView *lineView;
@property (nonatomic,strong)NSDictionary *dict;
@property (nonatomic, weak) id<SelectPickUpTableCellDelegate> delegate;

-(void)configData:(NSDictionary *)dict;

-(void)setChecked:(BOOL)bChecked;

@end
