//
//  GroupPurDetailViewController.m
//  CookBook
//
//  Created by 你好 on 16/6/3.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "GroupPurDetailViewController.h"
#import "NavView.h"
#import "GroupPurTopView.h"
#import "GroupPurDetailCell.h"
#import "ShoppingCartView.h"
#import "GoodsPropertyKeys.h"
#import "CommodityDetailViewController.h"
#import "OrderRecordViewController.h"
#import "ConfirmOrderViewController.h"
#import "RetrieveBulkDataRequest.h"
#import "GroupsDetailsReformer.h"
#import "GroupsPropertyKeys.h"
#import "ConfirmOrderViewController.h"
#import "UserManager.h"
#import "LoginViewController.h"
#import "MBProgressHUD+Helper.h"
#import "OrderPropertyKeys.h"
#import "WXApiRequestHandler.h"
#import "MJRefresh.h"
#import <SDWebImageManager.h>


@interface GroupPurDetailViewController()<UITableViewDelegate,UITableViewDataSource,GroupPurDetailCellDelegate, ShoppingCartViewDelegate,UINavigationControllerDelegate,UserListViewDelegate, RetrieveRequestDelegate>



@end

@implementation GroupPurDetailViewController
{
    NavView *_navView;
    GroupPurTopView *_topView;
    UITableView *_tableView;
    UIView *_shareView;
    UIButton *_backButton;
    
    ShoppingCartView * _spCartView;
    NSString * _groupBuyId;
    NSMutableDictionary * _dictGroupBuyId2ShoppingCart;
    
    NSMutableArray * _arrShoppingGoods;
    
    NSMutableArray * _arrProducts;
    NSMutableArray * _arrAnimationLayers;
    
    RetrieveBulkDataRequest * _bulkDetailRequest;
    NSDictionary * _detailGroupBuy;
    
    NSInteger _bulkStatus;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    
    [self.rdv_tabBarController setTabBarHidden:YES animated:NO];
    
    self.navigationController.delegate = self;
    
    _navView=[[NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    [_navView.leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_navView.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    if ([WXApi isWXAppInstalled])
//    {
        [_navView.rightButton setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
        [_navView.rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    }
    [self.view addSubview:_navView];
    
    _topView=[[GroupPurTopView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth,80)];
    [self.view addSubview:_topView];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,144, ScreenWidth, ScreenHeight-144-49) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    [self.view addSubview:_tableView];
    
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshBulkDetail];
    }];
    _tableView.mj_header = header;
    
    _arrShoppingGoods = _dictGroupBuyId2ShoppingCart[_groupBuyId];
    if (!_arrShoppingGoods) {
        _arrShoppingGoods = [NSMutableArray array];
    }
    
    [self setupShoppingCartView];
    _spCartView.hidden = YES;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setupShoppingCartView];
    
    if (!_detailGroupBuy) {
        [MBProgressHUD showLoadingWithDim:NO];
        [self refreshBulkDetail];
    } else {
        [_tableView reloadData];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _spCartView.hidden = NO;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    _spCartView.hidden = YES;
}

- (void)applicationDidBecomeActive:(NSNotification *)notify
{
    [self refreshBulkDetail];
}


-(void)leftButtonClick:(UIButton *)button
{
    [self removeShopingCartView];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightButtonClick:(UIButton *)button
{
    [self createShareView];
}

-(void)createShareView
{
    _backButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    _backButton.backgroundColor=RGBACOLOR(1, 1, 1, 0.3);
    [_backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backButton];
    
    
    if (!_shareView)
    {
        _shareView=[[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 150)];
        _shareView.backgroundColor=RGBACOLOR(235, 235, 235, 1);
        [self.view addSubview:_shareView];
        
        UIButton *cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame=CGRectMake(0, _shareView.frame.size.height-45, _shareView.frame.size.width, 45);
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        cancelBtn.titleLabel.font=[UIFont systemFontOfSize:16];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cancelBtn.backgroundColor=[UIColor whiteColor];
        [cancelBtn addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_shareView addSubview:cancelBtn];
        
        UIImage *timeLineImage=[UIImage imageNamed:@"timeline_icon"];
        
        double space=(ScreenWidth-timeLineImage.size.width*2)/3;
        
        if ([WXApi isWXAppInstalled])
        {
            for (int i=0; i<2; i++)
            {
                UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
                button.frame=CGRectMake(space*(i+1)+i*timeLineImage.size.width, 15, timeLineImage.size.width, timeLineImage.size.height);
                
                UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(button.frame.origin.x-5, button.frame.origin.y+button.frame.size.height-3, button.frame.size.width+10, 30)];
                label.textAlignment=NSTextAlignmentCenter;
                label.font=[UIFont systemFontOfSize:12];
                label.userInteractionEnabled=YES;
                label.backgroundColor=[UIColor clearColor];
                if (i==0)
                {
                    label.text=@"微信";
                    [button setImage:[UIImage imageNamed:@"weixin_icon"] forState:UIControlStateNormal];
                    [button addTarget:self action:@selector(shareToWeiXin:) forControlEvents:UIControlEventTouchUpInside];
                }
                else if(i==1)
                {
                    label.text=@"朋友圈";
                    [button setImage:[UIImage imageNamed:@"timeline_icon"] forState:UIControlStateNormal];
                    [button addTarget:self action:@selector(shareToTimeline:) forControlEvents:UIControlEventTouchUpInside];
                }
                [_shareView addSubview:label];
                [_shareView addSubview:button];
            }
        }
    }
    _spCartView.hidden=YES;
    [self.view bringSubviewToFront:_shareView];
    [UIView animateWithDuration:0.25 animations:^{
        _shareView.frame=CGRectMake(0, ScreenHeight-150, ScreenWidth, 150);
    }];
    
}

-(void)shareToWeiXin:(UIButton *)button
{
    NSString * iconUrl = _detailGroupBuy[kOrderPropertyCardIcon];
    if (iconUrl.length) {
        
        [MBProgressHUD showLoadingWithDim:YES];
        
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:iconUrl] options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            
            [MBProgressHUD dismissHUD];
            
            if (error) {
                image = [UIImage imageNamed:@"thumb_icon"];
            } else {
                CGFloat width = 100.0f;
                CGFloat height = image.size.height * width/ image.size.width;
                UIGraphicsBeginImageContext(CGSizeMake(width, height));
                [image drawInRect:CGRectMake(0, 0, width, height)];
                image = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
            }
            
            [WXApiRequestHandler sendLinkURL:_detailGroupBuy[kOrderPropertyCardUrl] TagName:nil Title:_detailGroupBuy[kOrderPropertyCardTitle] Description:_detailGroupBuy[kOrderPropertyCardDesc] ThumbImage:image InScene:WXSceneSession];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self backButtonClick:nil];
            });
        }];
    } else {
        
        UIImage * image = [UIImage imageNamed:@"thumb_icon"];
        [WXApiRequestHandler sendLinkURL:_detailGroupBuy[kOrderPropertyCardUrl] TagName:nil Title:_detailGroupBuy[kOrderPropertyCardTitle] Description:_detailGroupBuy[kOrderPropertyCardDesc] ThumbImage:image InScene:WXSceneSession];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self backButtonClick:nil];
        });
        
    }
}

-(void)shareToTimeline:(UIButton *)button
{
    NSString * iconUrl = _detailGroupBuy[kOrderPropertyCardIcon];
    if (iconUrl.length) {
        
        [MBProgressHUD showLoadingWithDim:YES];
        
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:iconUrl] options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            
            [MBProgressHUD dismissHUD];
            
            if (error) {
                image = [UIImage imageNamed:@"thumb_icon"];
            } else {
                CGFloat width = 100.0f;
                CGFloat height = image.size.height * width/ image.size.width;
                UIGraphicsBeginImageContext(CGSizeMake(width, height));
                [image drawInRect:CGRectMake(0, 0, width, height)];
                image = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
            }
            
            [WXApiRequestHandler sendLinkURL:_detailGroupBuy[kOrderPropertyCardUrl] TagName:nil Title:_detailGroupBuy[kOrderPropertyCardTitle] Description:_detailGroupBuy[kOrderPropertyCardDesc] ThumbImage:image InScene:WXSceneTimeline];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self backButtonClick:nil];
            });
        }];
    } else {
        
        UIImage * image = [UIImage imageNamed:@"thumb_icon"];
        [WXApiRequestHandler sendLinkURL:_detailGroupBuy[kOrderPropertyCardUrl] TagName:nil Title:_detailGroupBuy[kOrderPropertyCardTitle] Description:_detailGroupBuy[kOrderPropertyCardDesc] ThumbImage:image InScene:WXSceneTimeline];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self backButtonClick:nil];
        });
        
    }

}

-(void)backButtonClick:(UIButton *)button
{
    [UIView animateWithDuration:0.25 animations:^{
        _shareView.frame=CGRectMake(0, ScreenHeight, ScreenWidth, 150);
    } completion:^(BOOL finished) {
        [_backButton removeFromSuperview];
        _backButton=nil;
        _spCartView.hidden=NO;
    }];
}



-(void)updateUI
{
    //刷新ui
    _topView.hidden=NO;
    [_topView configData:_detailGroupBuy];
    
    [_spCartView enableGroupBuyWithStatus:_bulkStatus];

}

-(void)setupShoppingCartView
{
    if (!_spCartView) {
        _spCartView = [[ShoppingCartView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-49-10, self.view.bounds.size.width, 49+10)];
        [self.navigationController.view addSubview:_spCartView];
        _spCartView.arrGoods = _arrShoppingGoods;
        [_spCartView refreshDataWithReload:YES];
    }
    _spCartView.hidden = NO;
    _spCartView.delegate = self;
}

-(void)removeShopingCartView
{
    if (_spCartView) {
        [_spCartView removeFromSuperview];
        _spCartView = nil;
    }
}

-(void)refreshBulkDetail
{
    if (_bulkDetailRequest) {
        [_bulkDetailRequest cancel];
    }
    _bulkDetailRequest = [[RetrieveBulkDataRequest alloc] initWithUrl:self.detailUrl];
    _bulkDetailRequest.delegate = self;
    [_bulkDetailRequest request];
}



#pragma mark - UITableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"GroupPurDetailCell";
    GroupPurDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil)
    {
        cell=[[GroupPurDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    
    NSDictionary * dictGoods = [_arrProducts objectAtIndex:indexPath.row];
    ShoppingGoods *goods = [_spCartView findGoodsById:dictGoods[kGoodsPropertyId]];
    
    if (cell.dictGoods == dictGoods) {
        if (goods.puchaseNum == 0 && cell.purchaseNum > 0) {
            [cell decreseGoodsToNum:0];
        } else if (goods.puchaseNum > 0 && cell.purchaseNum == 0) {
            [cell increaseGoodsToNum:goods.puchaseNum];
        } else {
            [cell setupWithDictGoods:dictGoods withNum:goods.puchaseNum];
        }
    } else {
        [cell setupWithDictGoods:dictGoods withNum:goods.puchaseNum];
    }

    cell.addButton.enabled = (_bulkStatus==GroupBuyInProgress)?YES:NO;
    cell.userListView.delegate=self;
    cell.userListView.orderListUrl = dictGoods[kGoodsPropertyHistoryUrl];

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrProducts.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dictGoods = [_arrProducts objectAtIndex:indexPath.row];
    UIImage *priceBackImage=[UIImage imageNamed:@"price_back_icon"];
    NSString *descStr=dictGoods[kGoodsPropertyDesc];
    return ScreenWidth/16*9+201+priceBackImage.size.height+[self heightForText:descStr];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableView) {
        
        NSDictionary * dictGoods = [_arrProducts objectAtIndex:indexPath.row];
        CommodityDetailViewController *commdityVC=[[CommodityDetailViewController alloc]init];
        commdityVC.detailGroupBuy = _detailGroupBuy;
        commdityVC.detailGoods = dictGoods;
        commdityVC.vcFromType=FromGroupPurDetailVC;
        commdityVC.shoppingCartView = _spCartView;
        [self.navigationController pushViewController:commdityVC animated:YES];
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


#pragma mark -GroupPurDetailCellDelegate
- (void)didNeedIncreaseGoods:(GroupPurDetailCell *)cell
{
    ShoppingGoods *goods = [_spCartView findGoodsById:cell.dictGoods[kGoodsPropertyId]];
    
//    if (!goods) {
//        goods = [_spCartView convertDictGoods:cell.dictGoods];
//        [_spCartView.arrGoods addObject:goods];
//    }
    
    if (!goods) {
        goods = [_spCartView convertDictGoods:cell.dictGoods];
    }
    
    if ([self shouldIncreaseGoodsNum:goods]) {
        
        if (![_spCartView.arrGoods containsObject:goods]) {
            [_spCartView.arrGoods addObject:goods];
        }
        
        goods.puchaseNum += 1;
        
        [self animationAddGoodsWithCell:cell];
        
        [cell increaseGoodsToNum:goods.puchaseNum];
        [_spCartView refreshDataWithReload:YES];
    }
}

- (void)didNeedDecreaseGoods:(GroupPurDetailCell *)cell
{
    ShoppingGoods *goods = [_spCartView findGoodsById:cell.dictGoods[kGoodsPropertyId]];
    
    if (goods && goods.puchaseNum > 0) {
        goods.puchaseNum -= 1;
        
        if (goods.puchaseNum == 0) {
            [_spCartView.arrGoods removeObject:goods];
        }
        
        [cell decreseGoodsToNum:goods.puchaseNum];
        [_spCartView refreshDataWithReload:YES];
    }
}

- (void)animationAddGoodsWithCell:(GroupPurDetailCell *)cell
{
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    CGRect rect = [_tableView rectForRowAtIndexPath:indexPath];
    rect.origin.x += cell.addButton.frame.origin.x;
    rect.origin.y += cell.addButton.frame.origin.y;
    rect.size = cell.addButton.bounds.size;
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

#pragma mark RetrieveDataDelegate
-(void)didRetrieveDataSuccess:(RetrieveRequest *)request
{
    if (request == _bulkDetailRequest) {
        [MBProgressHUD dismissHUD];
        
        if ([_tableView.mj_header isRefreshing]) {
            [_tableView.mj_header endRefreshing];
        }
        
        _detailGroupBuy = [_bulkDetailRequest fetchDataWithReformer:[[GroupsDetailsReformer alloc] init]];
        
        _bulkStatus = [_detailGroupBuy[kGroupsPropertyStatus] integerValue];
        
        _arrProducts = [NSMutableArray arrayWithArray:_detailGroupBuy[kGroupsPropertyProducts]];
        [_tableView reloadData];
        
        _navView.centerLabel.text=_detailGroupBuy[@"title"];
        
//        if ([_detailGroupBuy[kGroupsPropertyStandardTime] longLongValue] >=
//            [_detailGroupBuy[kGroupsPropertyDeadTime] longLongValue]) {
//            [MBProgressHUD showHUDAutoDismissWithString:@"该团购已结束" andDim:YES];
//            
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self.navigationController popViewControllerAnimated:YES];
//            });
//        }
        
        
        [self updateUI];
    }
}

-(void)didRetrieveDataFailed:(RetrieveRequest *)request
{
    if (request == _bulkDetailRequest) {
        if ([_tableView.mj_header isRefreshing]) {
            [_tableView.mj_header endRefreshing];
        }
    }
    
    [MBProgressHUD showHUDAutoDismissWithError:request.error andDim:NO];
}

#pragma mark -ShoppingCartViewDelegate

-(void)didShoppingCartGoodsChanged:(ShoppingCartView *)shoppingCartView
{
    [_tableView reloadData];
}

-(void)didShoppingConfirmed:(ShoppingCartView *)shoppingCartView
{
    _spCartView.hidden = YES;
    
    if ([UserManager shareInstance].bIsLogin) {
        ConfirmOrderViewController *confirmOrderVC=[[ConfirmOrderViewController alloc]init];
        confirmOrderVC.detailGroupBuy = _detailGroupBuy;
        confirmOrderVC.arrGoods = _spCartView.arrGoods;
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

#pragma mark - UserListViewDelegate

-(void)didClickUserListView:(UserListView *)view
{
    _spCartView.hidden = YES;
    OrderRecordViewController *orderRecordVC=[[OrderRecordViewController alloc]init];
    orderRecordVC.orderListUrl = view.orderListUrl;
    [self.navigationController pushViewController:orderRecordVC animated:YES];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [self removeShopingCartView];
}

@end
