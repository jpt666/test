//
//  ShoppingGoodsTableCell.m
//  CookBook
//
//  Created by zhangxi on 16/6/3.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "ShoppingGoodsTableCell.h"

@implementation ShoppingGoodsTableCell
{
    UILabel * _labelName;
    UILabel * _labelPrice;
    CGFloat _width;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self configUI];
    }
    return self;
}

-(void)configUI
{
    _width = [UIScreen mainScreen].bounds.size.width;
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    lineView.alpha = 0.8;
    [self.contentView addSubview:lineView];
    
    
    UIImage *increaseImage=[UIImage imageNamed:@"add_icon_min"];
    UIImage *reduceImage=[UIImage imageNamed:@"reduce_icon_min"];
    
    _increaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _increaseBtn.frame = CGRectMake(_width-increaseImage.size.width-10, (50-reduceImage.size.height)/2, increaseImage.size.width, increaseImage.size.height);
    [_increaseBtn addTarget:self action:@selector(increaseBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_increaseBtn setImage:increaseImage forState:UIControlStateNormal];
    [self.contentView addSubview:_increaseBtn];
    
    _labelQuantity = [[UILabel alloc] initWithFrame:CGRectMake(_increaseBtn.frame.origin.x-30, 0, 30, 50)];
    _labelQuantity.textAlignment = NSTextAlignmentCenter;
    _labelQuantity.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_labelQuantity];
    
    _reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _reduceBtn.frame = CGRectMake(_labelQuantity.frame.origin.x-reduceImage.size.width, _increaseBtn.frame.origin.y, reduceImage.size.width, reduceImage.size.height);
    [_reduceBtn addTarget:self action:@selector(reduceBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_reduceBtn setImage:reduceImage forState:UIControlStateNormal];
    [self.contentView addSubview:_reduceBtn];
    

    _labelPrice = [[UILabel alloc] initWithFrame:CGRectMake(_reduceBtn.frame.origin.x-80, 0, 80, 50)];
    _labelPrice.textAlignment = NSTextAlignmentCenter;
    _labelPrice.textColor = RGBACOLOR(176, 116, 67, 1);
    _labelPrice.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_labelPrice];
    
    _labelName = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, _width-_labelPrice.bounds.size.width-_reduceBtn.bounds.size.width-_increaseBtn.bounds.size.width-_labelQuantity.bounds.size.width-10-10-10, 50)];
    _labelName.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_labelName];
    
}

- (void)setShoppingGoods:(ShoppingGoods *)shoppingGoods
{
    _shoppingGoods = shoppingGoods;
    
    _labelName.text = shoppingGoods.goodsName;
    _labelPrice.text = [NSString stringWithFormat:@"¥%0.2f", shoppingGoods.unitPrice*shoppingGoods.puchaseNum/100.0];
    _labelQuantity.text = [NSString stringWithFormat:@"%ld", shoppingGoods.puchaseNum];
}

- (void)increaseBtnClicked:(UIButton *)btn
{
    if (_delegate && [_delegate respondsToSelector:@selector(didIncreaseGoodsNum:)]){
        [_delegate didIncreaseGoodsNum:self];
    }
}

- (void)reduceBtnClicked:(UIButton *)btn
{
    if (_delegate && [_delegate respondsToSelector:@selector(didDecreaseGoodsNum:)]){
        [_delegate didDecreaseGoodsNum:self];
    }
}



@end
