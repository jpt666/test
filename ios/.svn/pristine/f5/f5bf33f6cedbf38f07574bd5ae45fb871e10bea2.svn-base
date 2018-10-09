//
//  ShoppingGoodsTableCell.h
//  CookBook
//
//  Created by zhangxi on 16/6/3.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingGoods.h"

@class ShoppingGoodsTableCell;

@protocol ShoppingGoodsTableCellDelegate <NSObject>

- (void)didIncreaseGoodsNum:(ShoppingGoodsTableCell *)cell;
- (void)didDecreaseGoodsNum:(ShoppingGoodsTableCell *)cell;

@end


@interface ShoppingGoodsTableCell : UITableViewCell

@property (nonatomic, strong) UIButton * reduceBtn;
@property (nonatomic, strong) UIButton * increaseBtn;
@property (nonatomic, strong) UILabel * labelQuantity;

@property (nonatomic, weak) id<ShoppingGoodsTableCellDelegate> delegate;
@property (nonatomic, weak) ShoppingGoods * shoppingGoods;


@end
