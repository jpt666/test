//
//  ShoppingCartView.m
//  CookBook
//
//  Created by zhangxi on 16/6/3.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "ShoppingCartView.h"
#import "GoodsPropertyKeys.h"
#import "UIButton+Animation.h"


@interface ShoppingCartView()<UITableViewDelegate,UITableViewDataSource, ShoppingGoodsTableCellDelegate>

@end

@implementation ShoppingCartView
{
    UIView * _maskBgView;
    UIView * _bgView;
    
    UITableView * _tableView;
    UIView * _containerView;
    UIView * _titleView;
    
    
    UIView * _bottomView;
    UIView * _bottomContainerView;
    
    UIImageView * _quantityImageView;
    
    UIButton * _cartButton;
    UILabel * _quantityLabel;
    UIButton * _confirmButton;
    UILabel * _totalPrice;
    
    CGFloat _bottomViewHeight;
    CGFloat _bottomMargin;
    CGFloat _titleViewHeight;
    CGFloat _tableCellHeight;
    
    CGRect _orgFrame;
    
    BOOL _bExpand;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}


-(void)configUI
{
    _bExpand = NO;
    _orgFrame = self.frame;
    
    _bottomViewHeight = 49;
    _bottomMargin = 10;
    _tableCellHeight = 50;
    _titleViewHeight = 51;
    
    [self setupMaskBgView];

    [self setupContainerView];
    [self setupBottomView];

    [self layoutGUI];
}

-(void)setupMaskBgView
{
    _maskBgView = [[UIView alloc] init];
//    _maskBgView.userInteractionEnabled = YES;
    _maskBgView.backgroundColor = [UIColor blackColor];
    _maskBgView.alpha = 0.5;
    [self addSubview:_maskBgView];

    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _bgView.backgroundColor = [UIColor clearColor];
    _bgView.userInteractionEnabled = YES;
    [self addSubview:_bgView];
    
    UITapGestureRecognizer * tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnMaskView:)];
    [_bgView addGestureRecognizer:tapGes];
    
}

-(void)setupContainerView
{
    _containerView = [[UIView alloc] init];
//    _containerView.userInteractionEnabled = YES;
    _containerView.clipsToBounds = YES;

    
    [self setupTitleView];
    
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
//    _tableView.backgroundColor = [UIColor redColor];
    
    [_containerView addSubview:_tableView];
    UITapGestureRecognizer * tapGes = [[UITapGestureRecognizer alloc] init];
    [_containerView addGestureRecognizer:tapGes];
    
    [_bgView addSubview:_containerView];
    
}

-(void)setupTitleView
{
    _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, _titleViewHeight)];
    _titleView.backgroundColor = [UIColor colorWithHexString:@"#e3e3e3"];
    
    UIImage * image = [UIImage imageNamed:@"orderLabel"];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 18, image.size.width, image.size.height)];
    imageView.image = image;
    [_titleView addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, (_titleView.bounds.size.height-34)/2, 80, 34)];
    label.text = @"订单信息";
    [_titleView addSubview:label];
    
    image = [UIImage imageNamed:@"shoppingClear"];
    UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [clearBtn setImage:image forState:UIControlStateNormal];
    [clearBtn setTitle:@"清空" forState:UIControlStateNormal];
    [clearBtn setTitleColor:[UIColor colorWithHexString:@"#626262"] forState:UIControlStateNormal];
    [clearBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    clearBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    clearBtn.frame = CGRectMake(_titleView.bounds.size.width-80, (_titleView.bounds.size.height-35)/2, 80, 35);
    [clearBtn addTarget:self action:@selector(clearBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_titleView addSubview:clearBtn];
    [_containerView addSubview:_titleView];
}

-(void)setupBottomView
{
    _bottomContainerView = [[UIView alloc] initWithFrame:self.bounds];
    _bottomContainerView.userInteractionEnabled = YES;
    _bottomContainerView.backgroundColor = [UIColor clearColor];
    [self addSubview:_bottomContainerView];
    
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, _bottomMargin, self.bounds.size.width, _bottomViewHeight)];
    _bottomView.userInteractionEnabled = YES;
    _bottomView.backgroundColor = [UIColor whiteColor];
    _bottomView.alpha = 0.8;
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    lineView.alpha = 0.8;
    lineView.layer.cornerRadius = 5;
    [_bottomView addSubview:lineView];
    [_bottomContainerView addSubview:_bottomView];
    
    
    UIImage *image = [UIImage imageNamed:@"shoppingCartBtn"];
    _cartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cartButton.frame = CGRectMake(15, 0, image.size.width, image.size.height);
    [_cartButton setImage:image forState:UIControlStateNormal];
    [_cartButton addTarget:self action:@selector(cartButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomContainerView addSubview:_cartButton];
    
    
    image = [UIImage imageNamed:@"cartNum"];
    _quantityImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_cartButton.bounds.size.width-image.size.width-10, 10, image.size.width, image.size.height)];
    _quantityImageView.image = image;
    _quantityImageView.hidden = YES;
    [_cartButton addSubview:_quantityImageView];
    
    CGRect _quantityBounds = _quantityImageView.bounds;
    
    _quantityLabel = [[UILabel alloc] initWithFrame:CGRectMake(_quantityBounds.origin.x-3, _quantityBounds.origin.y-3, _quantityBounds.size.width+6, _quantityBounds.size.width+6)];
    _quantityLabel.textAlignment = NSTextAlignmentCenter;
    _quantityLabel.textColor = [UIColor whiteColor];
    _quantityLabel.font = [UIFont boldSystemFontOfSize:9];
    [_quantityImageView addSubview:_quantityLabel];
    
    
    _totalPrice = [[UILabel alloc] initWithFrame:CGRectMake(_cartButton.bounds.size.width+30, _bottomMargin, _bottomContainerView.bounds.size.width/2, 49)];
    [_bottomContainerView addSubview:_totalPrice];
    
    image = [UIImage imageNamed:@"shoppingConfirm"];
    _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_confirmButton setBackgroundImage:image forState:UIControlStateNormal];
    _confirmButton.frame = CGRectMake(self.bounds.size.width-image.size.width-13, (_bottomContainerView.bounds.size.height-image.size.height+_bottomMargin)/2, image.size.width, image.size.height);
    [_confirmButton addTarget:self action:@selector(confirmBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [_confirmButton setTitle:@"选好了" forState:UIControlStateNormal];
    [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _confirmButton.exclusiveTouch = YES;

    [_bottomContainerView addSubview:_confirmButton];
    
}

-(void)layoutContainerView
{
    if (_bExpand) {
        NSInteger cnt = _arrGoods.count;
        if (cnt > 5) {
            cnt = 5;
        }
        CGRect f = _containerView.frame;
        f.size.height = cnt*_tableCellHeight+_titleViewHeight;
        f.origin.y = _bgView.bounds.size.height-f.size.height-_bottomViewHeight;
        _containerView.frame = f;
        
        f = _tableView.frame;
        f.size.height = cnt*_tableCellHeight;
        _tableView.frame = f;
    }
}

-(void)layoutGUI
{
    if (_bExpand) {
        
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        _maskBgView.frame = self.bounds;
        CGRect f =  _maskBgView.frame;
        f.origin.y = self.bounds.size.height;
//        _maskBgView.frame = f;
        _bgView.frame = f;
        
        [self layoutContainerView];

        f=_bottomContainerView.frame;
        f.origin.y = self.bounds.size.height - _bottomContainerView.bounds.size.height;
        _bottomContainerView.frame = f;
        
        [UIView animateWithDuration:0.3 animations:^{
            CGRect f = _bgView.frame;
            f.origin.y = 0;
//            _maskBgView.frame = f;
            _maskBgView.alpha = 0.5;
            _bgView.frame = f;
        }];
        
    } else {
        
        [UIView animateWithDuration:0.3 animations:^{
            CGRect f= _bgView.frame;
            f.origin.y = self.bounds.size.height;
//            _maskBgView.frame = f;
            _maskBgView.alpha = 0.0;
            _bgView.frame =f;
        } completion:^(BOOL finished) {
            
            self.frame = _orgFrame;
            _bottomContainerView.frame = self.bounds;
            
            _maskBgView.frame = CGRectMake(0, _bottomMargin, self.bounds.size.width, 0);
            _bgView.frame = _maskBgView.frame;
            _containerView.frame = CGRectMake(0, 0, self.bounds.size.width, 0);
            _tableView.frame = CGRectMake(0, _titleView.bounds.size.height, _containerView.bounds.size.width, 0);
        }];
    }
}

-(void)cartButtonClicked:(UIButton *)btn
{
    if (!_arrGoods.count) {
        return;
    }
    _bExpand = !_bExpand;

    [self layoutGUI];
}

-(void)tapOnMaskView:(UITapGestureRecognizer *)tapGes
{
    if (_bExpand) {
        _bExpand = NO;
        [self layoutGUI];
    }
}

-(void)clearBtnClicked:(UIButton *)btn
{
    [_arrGoods removeAllObjects];
    
    if (_bExpand) {
        _bExpand = NO;
        [self layoutGUI];
    }
    
    [self refreshDataWithReload:YES];
    if (_delegate && [_delegate respondsToSelector:@selector(didShoppingCartGoodsChanged:)]) {
        [_delegate didShoppingCartGoodsChanged:self];
    }
}

-(void)confirmBtnClicked:(UIButton *)btn
{
    if (_delegate && [_delegate respondsToSelector:@selector(didShoppingConfirmed:)]) {
        [_delegate didShoppingConfirmed:self];
    }
}

- (ShoppingGoods *)convertDictGoods:(NSDictionary *)dictGoods
{
    ShoppingGoods *goods = [[ShoppingGoods alloc] init];
    
    goods.goodsId = dictGoods[kGoodsPropertyId];
    goods.goodsName = dictGoods[kGoodsPropertyTitle];
    goods.unitPrice = [dictGoods[kGoodsPropertyUnitPrice] floatValue];
    goods.puchaseNum = 0;
    
    if (dictGoods[kGoodsPropertyPurchaseLimit] &&
        [dictGoods[kGoodsPropertyPurchaseLimit] integerValue]> 0) {
        goods.limitCount = [dictGoods[kGoodsPropertyPurchaseLimit] unsignedIntegerValue];
    }
    
    if (dictGoods[kGoodsPropertyStock] &&
        dictGoods[kGoodsPropertyPurchasedCount]) {
        goods.remainCount = [dictGoods[kGoodsPropertyStock] integerValue] - [dictGoods[kGoodsPropertyPurchasedCount] integerValue];
        
        if (goods.remainCount < 0) {
            goods.remainCount = 0;
        }
    }
    

    goods.specDesc = dictGoods[kGoodsPropertyDesc];
    
    return goods;
}

//- (BOOL)increaseGoodsWithDictGoods:(NSDictionary *)dictGoods
//{
////    ShoppingGoods *goods = [self findGoodsById:dictGoods[kGoodsPropertyId]];
////    if (!goods) {
////        goods = [self convertDictGoods:dictGoods];
////        [_arrGoods addObject:goods];
////    }
////    goods.puchaseNum += 1;
////    [self refreshData];
//    
//    return YES;
//}
//
//- (BOOL)decreaseGoodsWithDictGoods:(NSDictionary *)dictGoods
//{
//    ShoppingGoods *goods = [self findGoodsById:dictGoods[kGoodsPropertyId]];
//    if (goods && goods.puchaseNum > 0) {
//        goods.puchaseNum -= 1;
//        
//        if (goods.puchaseNum == 0) {
//            [_arrGoods removeObject:goods];
//        }
//        
//        [self refreshData];
//        return YES;
//    }
//    
//    return NO;
//}

- (ShoppingGoods *)findGoodsById:(NSNumber *)goodsId
{
    for (ShoppingGoods *sp in _arrGoods) {
        if (sp.goodsId.integerValue ==  goodsId.integerValue) {
            return sp;
        }
    }
    return nil;
}

-(void)refreshDataWithReload:(BOOL)bReload
{
    if (_bExpand && _arrGoods.count == 0) {
        _bExpand = NO;
        [self layoutGUI];
    }
    
    if (bReload) {
        [_tableView reloadData];
    }
    
    NSUInteger num = 0;
    CGFloat price = 0;
    for (ShoppingGoods *goods in _arrGoods) {
        num += goods.puchaseNum;
        price += goods.puchaseNum * goods.unitPrice;
    }
    
    _quantityImageView.hidden = num?NO:YES;
 
    _totalPrice.text = [NSString stringWithFormat:@"合计：%0.2f",price/100.0];
    _quantityLabel.text = [NSString stringWithFormat:@"%ld", num];
    
    _confirmButton.enabled = _arrGoods.count?YES:NO;
}

- (void)enableGroupBuyWithStatus:(GroupBuyStatus)bulkStatus
{
    if (GroupBuyInProgress == bulkStatus ||
        GroupBuyNotStart == bulkStatus) {
        _confirmButton.enabled = _arrGoods.count?YES:NO;
        [_confirmButton setTitle:@"选好了" forState:UIControlStateNormal];
//        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        _confirmButton.enabled = NO;
        NSString *title = @"已结束";
        [_confirmButton setTitle:title forState:UIControlStateNormal];
//        [_confirmButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
}

#pragma mark ShoppingGoodsTableCellDelegate

- (void)didIncreaseGoodsNum:(ShoppingGoodsTableCell *)cell
{
    if (_delegate && [_delegate respondsToSelector:@selector(shouldIncreaseGoodsNum:)]) {
        if([_delegate shouldIncreaseGoodsNum:cell.shoppingGoods]) {
            cell.shoppingGoods.puchaseNum += 1;
            
            [self refreshDataWithReload:YES];
            if (_delegate && [_delegate respondsToSelector:@selector(didShoppingCartGoodsChanged:)]) {
                [_delegate didShoppingCartGoodsChanged:self];
            } 
        }
    }
}

- (void)didDecreaseGoodsNum:(ShoppingGoodsTableCell *)cell
{
    if (_delegate && [_delegate respondsToSelector:@selector(shouldDecreaseGoodsNum:)]) {
        
        if ([_delegate shouldDecreaseGoodsNum:cell.shoppingGoods]) {
            cell.shoppingGoods.puchaseNum -= 1;
            
            if (cell.shoppingGoods.puchaseNum == 0) {
                
                cell.labelQuantity.hidden = YES;
                CGRect orgRect = cell.reduceBtn.frame;
                [cell.reduceBtn animationDuration:0.3 startFrame:cell.reduceBtn.frame destFrame:cell.increaseBtn.frame startAlpha:1.0 endAlpha:0.4 rotation:M_PI completion:^(BOOL finished) {
                    cell.reduceBtn.frame = orgRect;
                    cell.reduceBtn.alpha = 0.0;
                    
                    [_tableView beginUpdates];
                    [_arrGoods removeObject:cell.shoppingGoods];
                    [_tableView deleteRowsAtIndexPaths:@[[_tableView indexPathForCell:cell]] withRowAnimation:UITableViewRowAnimationNone];
                    [_tableView endUpdates];
                    
                    [UIView animateWithDuration:0.2 animations:^{
                        [self layoutContainerView];
                    } completion:^(BOOL finished) {
                        
                    }];
                    
                    [self refreshDataWithReload:NO];
                    
//
//                    if (_delegate && [_delegate respondsToSelector:@selector(didShoppingCartGoodsChanged:)]) {
//                        [_delegate didShoppingCartGoodsChanged:self];
//                    }
                }];
            } else {
                cell.labelQuantity.hidden = NO;
                [self refreshDataWithReload:YES];
            }
                if (_delegate && [_delegate respondsToSelector:@selector(didShoppingCartGoodsChanged:)]) {
                    [_delegate didShoppingCartGoodsChanged:self];
                }
//            }
        }
    }
    

}


#pragma mark UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrGoods.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"ShoppingGoodsTableCell";
    ShoppingGoodsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ShoppingGoodsTableCell alloc] init];
    }
    
    cell.delegate = self;
    cell.shoppingGoods = [_arrGoods objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _tableCellHeight;
}

@end
