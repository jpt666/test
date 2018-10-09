//
//  GroupBuyTableViewCell.h
//  CookBook
//
//  Created by 你好 on 16/8/10.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GradientImageView.h"
#import "GroupTapView.h"

@class GroupBuyTableViewCell;
@protocol GroupBuyTableViewCellDelegate <NSObject>

-(void)delButtonClick:(GroupBuyTableViewCell *)cell;
-(void)terminateButtonClick:(GroupBuyTableViewCell *)cell;
-(void)submitButtonClick:(GroupBuyTableViewCell *)cell;
-(void)deliverButtonClick:(GroupBuyTableViewCell *)cell;

@end

@interface GroupBuyTableViewCell : UITableViewCell

@property (nonatomic,retain)GradientImageView *contentImageView;
@property (nonatomic,strong)UIImageView * statusImageView;
@property (nonatomic,retain)UIButton *userButton;
@property (nonatomic,retain)UILabel *nameLabel;
@property (nonatomic,retain)UILabel *timeLabel;
@property (nonatomic,retain)UIView *lineView;

@property (nonatomic,retain)UIImageView *addressImageView;
@property (nonatomic,retain)UILabel *addressLabel;
@property (nonatomic,retain)GroupTapView *tapView;
//@property (nonatomic,retain)UILabel *groupPurLabel;
//@property (nonatomic,retain)UILabel *descLabel;

@property (nonatomic,retain)UILabel *titleLabel;
@property (nonatomic,retain)UILabel *subTitleLabel;
@property (nonatomic,retain)UIView *bottomLineView;
//@property (nonatomic,retain)UILabel *endLabel;

@property (nonatomic,retain)UILabel *alertLabel;
@property (nonatomic,retain)UIButton *delButton;
@property (nonatomic,retain)UIButton *editButton;
@property (nonatomic,retain)UIButton *terminateButton;
@property (nonatomic,retain)UIButton *submitButton;
@property (nonatomic,retain)UIButton *deliverButton;

@property (nonatomic,strong)NSMutableDictionary *dictData;
@property (nonatomic,strong)id<GroupBuyTableViewCellDelegate> delegate;

-(void)configData:(NSDictionary *)dict;

@end
