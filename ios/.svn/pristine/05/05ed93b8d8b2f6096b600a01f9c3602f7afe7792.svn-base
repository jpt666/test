//
//  ShoppingCartView.h
//  CookBook
//
//  Created by zhangxi on 16/6/3.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingGoods.h"
#import "ShoppingGoodsTableCell.h"
#import "GroupsPropertyKeys.h"

@class ShoppingCartView;

@protocol ShoppingCartViewDelegate <NSObject>

-(void)didShoppingCartGoodsChanged:(ShoppingCartView *)shoppingCartView;
-(BOOL)shouldIncreaseGoodsNum:(ShoppingGoods *)goods;
-(BOOL)shouldDecreaseGoodsNum:(ShoppingGoods *)goods;
-(void)didShoppingConfirmed:(ShoppingCartView *)shoppingCartView;
//-(void)didIncreaseGoodsNum:(ShoppingGoodsTableCell *)cell;
//-(void)didDecreaseGoodsNum:(ShoppingGoodsTableCell *)cell;

@end

@interface ShoppingCartView : UIView

@property (nonatomic, weak) id<ShoppingCartViewDelegate> delegate;
@property (nonatomic, strong) NSMutableArray * arrGoods;

//- (BOOL)increaseGoodsWithDictGoods:(NSDictionary *)dictGoods;
//
//- (BOOL)decreaseGoodsWithDictGoods:(NSDictionary *)dictGoods;

- (ShoppingGoods *)convertDictGoods:(NSDictionary *)dictGoods;

- (ShoppingGoods *)findGoodsById:(NSString *)goodsId;

- (void)enableGroupBuyWithStatus:(GroupBuyStatus)bulkStatus;

- (void)refreshDataWithReload:(BOOL)bReload;

@end
