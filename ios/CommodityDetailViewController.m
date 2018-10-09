//
//  CommodityDetailViewController.m
//  CookBook
//
//  Created by 你好 on 16/6/3.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "CommodityDetailViewController.h"
#import "CommodityTableCell.h"
#import "ShoppingGoods.h"
#import "GoodsPropertyKeys.h"
#import "GroupsPropertyKeys.h"
#import "UIButton+Animation.h"
#import <UIImageView+WebCache.h>
#import "ConfirmOrderViewController.h"
#import "UserManager.h"
#import "LoginViewController.h"
#import "GroupPurDetailViewController.h"
#import "MBProgressHUD+Helper.h"
#import "GroupPurchaseViewController.h"
@interface CommodityDetailViewController()<UITableViewDelegate,UITableViewDataSource,ShoppingCartViewDelegate>

@end

@implementation CommodityDetailViewController
{
    UITableView *_tableView;
    UILabel *_titleLabel;
    UILabel *_descLabel;
    UILabel *_priceLabel;
    UILabel *_costPriceLabel;
    UILabel *_unitPriceLabel;
    UILabel *_limitLabel;
    UILabel *_remainLabel;
    UIButton *_increaseBtn;
    UIButton *_decreaseBtn;
    UILabel *_numLabel;
    UIView *_headView;
    UIButton *_bottomButton;
    NSUInteger _purchaseNum;
    NSMutableArray * _arrAnimationLayers;
    
    UIImageView *_topImageView;
    CGRect _topImageFrame;

}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.rdv_tabBarController setTabBarHidden:YES animated:NO];
    
    NSString *descStr=self.detailGoods[kGoodsPropertyDesc];
    
    _headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth,365+[self heightForText:descStr]+45)];
    _topImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _headView.bounds.size.width, 260)];
    [_topImageView sd_setImageWithURL:[NSURL URLWithString:self.detailGoods[kGoodsPropertyCover]] placeholderImage:[UIImage imageNamed:PLACE_HOLDER_COOK_IMAGE]];
    _topImageView.contentMode=UIViewContentModeScaleAspectFill;
    _topImageView.clipsToBounds=YES;
    _topImageFrame = _topImageView.frame;
    [_headView addSubview:_topImageView];
    
    NSString *title=self.detailGoods[kGoodsPropertyTitle];
    NSString *subTitle=self.detailGoods[kGoodsPropertySpecDesc];
    NSString *titleString=[NSString stringWithFormat:@"%@",title];
    
    NSMutableAttributedString *titleAttrStr=[[NSMutableAttributedString alloc]initWithString:titleString];
    [titleAttrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} range:NSMakeRange(0, title.length)];
    
    _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 275, ScreenWidth-110, 30)];
    _titleLabel.attributedText=titleAttrStr;
    [_headView addSubview:_titleLabel];

    _unitPriceLabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-70, 278, 60, 20)];
    _unitPriceLabel.backgroundColor=RGBACOLOR(176, 116, 67, 1);
    _unitPriceLabel.textColor=[UIColor whiteColor];
    _unitPriceLabel.textAlignment=NSTextAlignmentCenter;
    _unitPriceLabel.layer.cornerRadius=3;
    _unitPriceLabel.clipsToBounds=YES;
    _unitPriceLabel.font=[UIFont systemFontOfSize:12];
    _unitPriceLabel.text=subTitle;
    [_headView addSubview:_unitPriceLabel];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:7];//调整行间距
    
    
    NSMutableAttributedString *descAttrStr=[[NSMutableAttributedString alloc]initWithString:descStr];
    [descAttrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSParagraphStyleAttributeName:paragraphStyle} range:NSMakeRange(0, descStr.length)];
    
    _descLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 315,ScreenWidth-20, [self heightForText:descStr])];
    _descLabel.font=[UIFont systemFontOfSize:14];
    _descLabel.textColor=[UIColor colorWithHexString:@"4e4e4e" alpha:0.8];
    _descLabel.numberOfLines=3;
    _descLabel.lineBreakMode=NSLineBreakByTruncatingTail;
    _descLabel.attributedText=descAttrStr;
    [_headView addSubview:_descLabel];
    
    _limitLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, _descLabel.frame.origin.y+_descLabel.frame.size.height+7.5, ScreenWidth-20, 30)];
    _limitLabel.font=[UIFont systemFontOfSize:14];
    _limitLabel.textColor=RGBACOLOR(73, 142, 46, 0.8);
    _limitLabel.textAlignment=NSTextAlignmentRight;
    [_headView addSubview:_limitLabel];
    
    if (self.detailGoods[kGoodsPropertyPurchaseLimit] &&
        [self.detailGoods[kGoodsPropertyPurchaseLimit] integerValue] > 0) {
        _limitLabel.hidden = NO;
        _limitLabel.text=[NSString stringWithFormat:@"每个ID限购%@份", self.detailGoods[kGoodsPropertyPurchaseLimit]];
    } else {
        _limitLabel.hidden = YES;
    }
    
    
    UIImage *addImage=[UIImage imageNamed:@"add_icon"];
    UIImage *reduceImage=[UIImage imageNamed:@"reduce_icon"];
    
    _increaseBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _increaseBtn.frame=CGRectMake(ScreenWidth-addImage.size.width-10, _limitLabel.frame.origin.y+_limitLabel.frame.size.height+7.5, addImage.size.width, addImage.size.height);
    [_increaseBtn setImage:addImage forState:UIControlStateNormal];
    [_increaseBtn addTarget:self action:@selector(increaseButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_headView addSubview:_increaseBtn];
    
    _numLabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-40-addImage.size.width, _increaseBtn.frame.origin.y, 30, addImage.size.height)];
    _numLabel.text=@"0";
    _numLabel.textAlignment=NSTextAlignmentCenter;
    _numLabel.font=[UIFont systemFontOfSize:14];
    _numLabel.alpha = 0.0;
    [_headView addSubview:_numLabel];
    
    _decreaseBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _decreaseBtn.frame=CGRectMake(ScreenWidth-addImage.size.width*2-40, _increaseBtn.frame.origin.y, reduceImage.size.width, reduceImage.size.height);
    [_decreaseBtn setImage:reduceImage forState:UIControlStateNormal];
    [_decreaseBtn addTarget:self action:@selector(decreaseButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    _decreaseBtn.alpha = 0.0;
    [_headView addSubview:_decreaseBtn];

    
    NSString *nowPrice=[NSString stringWithFormat:@"¥ %.2f",[self.detailGoods[kGoodsPropertyUnitPrice] doubleValue]/100];
    NSString *costPrice=[NSString stringWithFormat:@"¥ %.2f",[self.detailGoods[kGoodsPropertyMarketPrice] doubleValue]/100];
    
    NSString *priceStr=[NSString stringWithFormat:@"%@",nowPrice];
    
    NSRange range1=[priceStr rangeOfString:@"."];
    
    NSMutableAttributedString *priceAttr=[[NSMutableAttributedString alloc]initWithString:priceStr];
    [priceAttr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:RGBACOLOR(176, 116, 67, 1)} range:NSMakeRange(0, 1)];
    [priceAttr addAttributes:@{NSForegroundColorAttributeName:RGBACOLOR(176, 116, 67, 1),NSFontAttributeName:[UIFont systemFontOfSize:22]} range:NSMakeRange(2, nowPrice.length-2)];
    [priceAttr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:RGBACOLOR(176, 116, 67, 1)} range:NSMakeRange(range1.location+1, 2)];
    
    NSRange range2=[costPrice rangeOfString:@"."];
    NSMutableAttributedString *costPriceAttr=[[NSMutableAttributedString alloc]initWithString:costPrice];
    [costPriceAttr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#4e4e4e" alpha:0.6],NSStrokeColorAttributeName:[UIColor colorWithHexString:@"#4e4e4e" alpha:0.6],NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle],NSFontAttributeName:[UIFont systemFontOfSize:14]} range:NSMakeRange(0, costPrice.length)];
    [costPriceAttr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#4e4e4e" alpha:0.6]} range:NSMakeRange(range2.location+1, 2)];
    
    
    NSDictionary *dic=@{NSFontAttributeName:[UIFont systemFontOfSize:22]};
    CGRect rect=[nowPrice boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil];
    
    _priceLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, _limitLabel.frame.origin.y+_limitLabel.frame.size.height+7.5, rect.size.width, 30)];
    _priceLabel.attributedText=priceAttr;
    [_headView addSubview:_priceLabel];
    
    _costPriceLabel=[[UILabel alloc]initWithFrame:CGRectMake(_priceLabel.frame.origin.x+_priceLabel.frame.size.width,_limitLabel.frame.origin.y+_limitLabel.frame.size.height+7.5, ScreenWidth-50-addImage.size.width*2, _priceLabel.frame.size.height/2)];
    _costPriceLabel.attributedText=costPriceAttr;
    [_headView addSubview:_costPriceLabel];
    
    _remainLabel=[[UILabel alloc]initWithFrame:CGRectMake(_priceLabel.frame.origin.x+_priceLabel.frame.size.width, _costPriceLabel.frame.origin.y+_costPriceLabel.frame.size.height, _costPriceLabel.frame.size.width, _costPriceLabel.frame.size.height)];
    _remainLabel.font=[UIFont systemFontOfSize:14];
    [_headView addSubview:_remainLabel];
    
    if (self.detailGoods[kGoodsPropertyStock]) {
        _remainLabel.hidden = _limitLabel.hidden;
        NSInteger remainCount = [self.detailGoods[kGoodsPropertyStock] integerValue]-[self.detailGoods[kGoodsPropertyPurchasedCount] integerValue];
        if (remainCount < 0) {
            remainCount = 0;
        }
        _remainLabel.text=[NSString stringWithFormat:@"剩余%ld份", remainCount];
    } else {
        _remainLabel.hidden = YES;
    }
    
    if (_remainLabel.isHidden) {
        CGRect frame = _costPriceLabel.frame;
        frame.origin.y += 10;
        _costPriceLabel.frame = frame;
    }
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-49) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.tableHeaderView=_headView;
    [self.view addSubview:_tableView];
    
    UIView *navView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth,64)];
    navView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:navView];
    
    UIImage *selectedBackImage=[UIImage imageNamed:@"selected_back"];
    UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame=CGRectMake(10, 30, selectedBackImage.size.width, selectedBackImage.size.height);
    leftButton.layer.cornerRadius=selectedBackImage.size.height/2;
    [leftButton setBackgroundImage:selectedBackImage forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:leftButton];
    
    if (self.vcFromType==FromMainPageVC)
    {
        _bottomButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _bottomButton.frame=CGRectMake(0, ScreenHeight-49, ScreenWidth, 49);
        _bottomButton.backgroundColor=RGBACOLOR(176, 116, 67, 1);
        [_bottomButton setTitle:@"立即参团" forState:UIControlStateNormal];
        [_bottomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_bottomButton addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_bottomButton];
        
        _increaseBtn.hidden=YES;
        _decreaseBtn.hidden=YES;
        _numLabel.hidden=YES;
    }
    else
    {
        NSInteger bulkStatus = [self.detailGroupBuy[kGroupsPropertyStatus] integerValue];
        _increaseBtn.enabled = (bulkStatus == GroupBuyInProgress)?YES:NO;
        
        if (self.shoppingCartView) {
            self.shoppingCartView.delegate = self;
        }
        
        ShoppingGoods * shoppingGoods = [self.shoppingCartView findGoodsById:self.detailGoods[kGoodsPropertyId]];
        _purchaseNum = shoppingGoods.puchaseNum;
        [self refreshPurchaseUIWithGoods:shoppingGoods];
    }

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _shoppingCartView.hidden = NO;
}



-(void)bottomButtonClick:(UIButton *)button
{
    NSString * goodsName = self.detailGoods[kGoodsPropertyTitle];
    if (goodsName.length) {
        GroupPurchaseViewController *gpVc = [[GroupPurchaseViewController alloc] init];
        gpVc.vcType = GroupPurchaseVcSearch;
        gpVc.searchKey = goodsName;
        [self.navigationController pushViewController:gpVc animated:YES];
    }
    
//    GroupPurDetailViewController *groupPurDetailVC=[[GroupPurDetailViewController alloc]init];
//    groupPurDetailVC.detailUrl=self.detailGoods[@"bulk_url"];
//    if (groupPurDetailVC.detailUrl) {
//        [self.navigationController pushViewController:groupPurDetailVC animated:YES];
//    }
}


-(void)leftButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)animationAddGoods
{
    CGRect rect = _increaseBtn.frame;
    rect.origin = [_tableView convertPoint:rect.origin toView:self.view];
    
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor colorWithHexString:@"#ff9934"].CGColor;
    layer.bounds = CGRectInset(rect, 5, 5);
    layer.masksToBounds = YES;
    layer.cornerRadius = layer.bounds.size.height/2;
    layer.position = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    [self.view.layer addSublayer:layer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:layer.position];
    [path addQuadCurveToPoint:CGPointMake(50, ScreenHeight-49-15) controlPoint:CGPointMake(ScreenWidth/2,rect.origin.y-100)];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path.CGPath;
    animation.delegate = self;
    animation.removedOnCompletion = NO;
    animation.rotationMode = kCAAnimationRotateAuto;
    animation.duration = 0.3;
    
    if (!_arrAnimationLayers) {
        _arrAnimationLayers = [NSMutableArray array];
    }
    [layer addAnimation:animation forKey:@"shopping"];
    [_arrAnimationLayers addObject:layer];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    for (CALayer *layer in _arrAnimationLayers) {
        CAAnimation *animation = [layer animationForKey:@"shopping"];
        if (animation == anim) {
            [layer removeAllAnimations];
            [layer removeFromSuperlayer];
            [_arrAnimationLayers removeObject:layer];
            break;
        }
    }
}

-(void)refreshPurchaseUIWithGoods:(ShoppingGoods *)goods;
{
    if (goods.puchaseNum == 0 && _purchaseNum>0) {
        _numLabel.alpha = 0.0;
        CGRect orgRect = _decreaseBtn.frame;
        [_decreaseBtn animationDuration:0.3 startFrame:_decreaseBtn.frame destFrame:_increaseBtn.frame startAlpha:1.0 endAlpha:0.6 rotation:M_PI completion:^(BOOL finished) {
            _decreaseBtn.frame = orgRect;
            _decreaseBtn.alpha = 0.0;
        }];
    } else if (goods.puchaseNum > 0 && _purchaseNum == 0) {
        [_decreaseBtn animationDuration:0.3 startFrame:_increaseBtn.frame destFrame:_decreaseBtn.frame startAlpha:0.6 endAlpha:1.0 rotation:M_PI completion:^(BOOL finished) {
            _numLabel.alpha = 1.0;
        }];
    } else {
        if (goods.puchaseNum > 0) {
            _decreaseBtn.alpha = 1.0;
            _numLabel.alpha = 1.0;
            
        } else {
            _decreaseBtn.alpha = 0.0;;
            _numLabel.alpha = 0.0;
        }
    }
    _numLabel.text = [NSString stringWithFormat:@"%ld", goods.puchaseNum];
    _purchaseNum = goods.puchaseNum;

}

-(void)increaseButtonClicked:(UIButton *)button
{
    ShoppingGoods * shoppingGoods = [self.shoppingCartView findGoodsById:self.detailGoods[kGoodsPropertyId]];
//    if (!shoppingGoods) {
//        shoppingGoods = [self.shoppingCartView convertDictGoods:_detailGoods];
//        [self.shoppingCartView.arrGoods addObject:shoppingGoods];
//    }
    
    if (!shoppingGoods) {
        shoppingGoods = [self.shoppingCartView convertDictGoods:_detailGoods];
    }
    
    if ([self shouldIncreaseGoodsNum:shoppingGoods]) {
    
        if (![self.shoppingCartView.arrGoods containsObject:shoppingGoods]) {
            [self.shoppingCartView.arrGoods addObject:shoppingGoods];
        }
        
        shoppingGoods.puchaseNum += 1;
        
        [self animationAddGoods];
        
        [self.shoppingCartView refreshDataWithReload:YES];
        
        [self refreshPurchaseUIWithGoods:shoppingGoods];
    }
}

-(void)decreaseButtonClicked:(UIButton *)button
{
    ShoppingGoods * shoppingGoods = [self.shoppingCartView findGoodsById:self.detailGoods[kGoodsPropertyId]];
    if (shoppingGoods.puchaseNum > 0) {
        shoppingGoods.puchaseNum -= 1;
    }
    if (shoppingGoods.puchaseNum == 0) {
        [self.shoppingCartView.arrGoods removeObject:shoppingGoods];
    }
    
    [self.shoppingCartView refreshDataWithReload:YES];
    [self refreshPurchaseUIWithGoods:shoppingGoods];
}

-(void)didShoppingCartGoodsChanged:(ShoppingCartView *)shoppingCartView
{
    ShoppingGoods * shoppingGoods = [self.shoppingCartView findGoodsById:self.detailGoods[kGoodsPropertyId]];
    [self refreshPurchaseUIWithGoods:shoppingGoods];
}

-(void)didShoppingConfirmed:(ShoppingCartView *)shoppingCartView
{
    _shoppingCartView.hidden = YES;
    if ([UserManager shareInstance].bIsLogin) {
        ConfirmOrderViewController *confirmOrderVC=[[ConfirmOrderViewController alloc]init];
        confirmOrderVC.detailGroupBuy = _detailGroupBuy;
        confirmOrderVC.arrGoods = _shoppingCartView.arrGoods;
        [self.navigationController pushViewController:confirmOrderVC animated:YES];
    } else {
        CATransition* transition = [CATransition animation];
        transition.type = kCATransitionPush;//可更改为其他方式
        transition.subtype = kCATransitionFromTop;
        
        LoginViewController *loginVc = [[LoginViewController alloc] init];
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        [self.navigationController pushViewController:loginVc animated:NO];
    }
}

-(BOOL)shouldIncreaseGoodsNum:(ShoppingGoods *)goods
{
    if (goods.puchaseNum >= goods.limitCount) {
        [MBProgressHUD showHUDAutoDismissWithString:[NSString stringWithFormat:@"每个ID限购%ld份", goods.limitCount] andDim:NO];
        return NO;
    }
    if (goods.puchaseNum >= goods.remainCount) {
        [MBProgressHUD showHUDAutoDismissWithString:[NSString stringWithFormat:@"此商品仅剩%ld份", (long)goods.remainCount] andDim:NO];
        return NO;
    }
    return YES;
}

-(BOOL)shouldDecreaseGoodsNum:(ShoppingGoods *)goods
{
    if (goods.puchaseNum > 0) {
        return YES;
    } else {
        return NO;
    }
}


-(double)heightForText:(NSString *)str
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:7];//调整行间距
    
    CGRect rect= [str boundingRectWithSize:CGSizeMake(ScreenWidth-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSParagraphStyleAttributeName:paragraphStyle} context:nil];
    
    double height=rect.size.height;
    if (height>70)
    {
        height=70;
    }
    return height;
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _tableView) {
        if (_tableView.contentOffset.y<0) {
            CGRect rect = CGRectMake(0, _topImageFrame.origin.y +_tableView.contentOffset.y, _topImageFrame.size.width, _topImageFrame.size.height-_tableView.contentOffset.y);
            _topImageView.frame = rect;
        } else {
            _topImageView.frame = _topImageFrame;
        }
    }
}

#pragma mark - UITableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cellID";
    CommodityTableCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil)
    {
        cell=[[CommodityTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSDictionary *dict=[self.detailGoods[kGoodsPropertyDetails] objectAtIndex:indexPath.row];
    [cell configData:dict];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.detailGoods[kGoodsPropertyDetails] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict=[self.detailGoods[kGoodsPropertyDetails] objectAtIndex:indexPath.row];
    double imageHeight=[dict[@"height"] doubleValue];
    double imageWidth=[dict[@"width"] doubleValue];
    double height=(ScreenWidth*imageHeight)/imageWidth;
    return height;
}




-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
