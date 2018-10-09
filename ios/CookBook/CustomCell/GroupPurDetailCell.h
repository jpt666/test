//
//  GroupPurDetailCell.h
//  CookBook
//
//  Created by 你好 on 16/6/3.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserListView.h"


@class GroupPurDetailCell;

@protocol GroupPurDetailCellDelegate <NSObject>

- (void)didNeedIncreaseGoods:(GroupPurDetailCell *)cell;
- (void)didNeedDecreaseGoods:(GroupPurDetailCell *)cell;;

@end


@interface GroupPurDetailCell : UITableViewCell

@property (nonatomic,retain)UIImageView *contentImageView;
@property (nonatomic,retain)UIImageView *markImageView;
@property (nonatomic,retain)UILabel *titleLabel;
@property (nonatomic,retain)UILabel *descLabel;
@property (nonatomic,retain)UILabel *costPriceLabel;
@property (nonatomic,retain)UIButton *priceButton;
@property (nonatomic,retain)UIButton *addButton;
@property (nonatomic,retain)UIButton *reduceButton;
@property (nonatomic,retain)UILabel *numLabel;
@property (nonatomic,retain)UserListView *userListView;
@property (nonatomic,assign)NSUInteger purchaseNum;
@property (nonatomic,retain)UIButton *tagButton;
@property (nonatomic,retain)UIButton *specButton;
@property (nonatomic,retain)UIView *topLineView;
@property (nonatomic,retain)UIView *bottomLineView;
@property (nonatomic,retain)UIView *backView;
@property (nonatomic,retain)UILabel *limitLabel;
@property (nonatomic,retain)UILabel *remainLabel;


@property (nonatomic,weak) id<GroupPurDetailCellDelegate> delegate;
@property (nonatomic,weak) NSDictionary * dictGoods;

-(void)increaseGoodsToNum:(NSUInteger)num;
-(void)decreseGoodsToNum:(NSUInteger)num;

- (void)setupWithDictGoods:(NSDictionary *)dictGoods withNum:(NSUInteger)num;
@end
