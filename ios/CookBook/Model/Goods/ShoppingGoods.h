//
//  ShoppingGoods.h
//  CookBook
//
//  Created by zhangxi on 16/6/3.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingGoods : NSObject

@property (nonatomic, strong) NSNumber * goodsId;
@property (nonatomic, strong) NSString * goodsName;
@property (nonatomic, assign) CGFloat unitPrice;
@property (nonatomic, assign) NSInteger puchaseNum;
@property (nonatomic, assign) NSInteger limitCount;
@property (nonatomic, assign) NSInteger remainCount;
@property (nonatomic, assign) NSInteger specification;
@property (nonatomic, strong) NSString *specDesc;

@end
