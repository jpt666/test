//
//  MyOrderViewController.m
//  CookBook
//
//  Created by 你好 on 16/6/12.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "MyOrderViewController.h"
#import "NavView.h"
#import "MyOrderTableViewCell.h"
#import "BulkOrderDataRequest.h"
#import "OrderPropertyKeys.h"
#import "OrderListReformer.h"
#import "OrderDetailReformer.h"
#import "OrderDetailViewController.h"
#import "GlobalVar.h"
#import "MBProgressHUD+Helper.h"
#import "PayViewController.h"
#import "UserManager.h"
#import "OrderPropertyKeys.h"
#import "PopView.h"
#import "MCAlertView.h"
#import "MJRefresh.h"
#import "UIScrollView+EmptyDataSet.h"
#import <SDWebImageManager.h>
#import "WXApiRequestHandler.h"

@interface MyOrderViewController()<UITableViewDelegate,UITableViewDataSource,RetrieveRequestDelegate,MyOrderTableViewCellDelegate,MCALertviewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@end


@implementation MyOrderViewController
{
    NavView *_navView;
    UITableView *_tableView;
    NSMutableArray * _arrOrders;
    
    UIButton *_backButton;
    PopView *_popView;

    BulkOrderDataRequest * _orderRefreshRequest;
    BulkOrderDataRequest * _loadMoreOrderRequest;
    BulkOrderDataRequest * _orderDetailRequest;
    BulkOrderDataRequest * _cancelOrderRequest;
    BulkOrderDataRequest * _deleteOrderRequest;
    
    
    MCAlertview *_mcCancelAlertView;
    MCAlertview *_mcDeleteAlertView;
    
    BOOL _bNeedPayAction;
//    BulkOrderDataRequest * _LogisticsRequest;

}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.rdv_tabBarController setTabBarHidden:YES animated:NO];
    
    self.view.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    
    _navView=[[NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navView.centerLabel.text=@"我的订单";
    [_navView.leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_navView.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navView];
    
    [self setupTableView];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!_arrOrders.count) {
        [_tableView.mj_header beginRefreshing];
    } else {
        [self refreshOrderList];
    }
}

-(void)leftButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)refreshOrderList
{
    if (_orderRefreshRequest) {
        [_orderRefreshRequest cancel];
        _orderRefreshRequest = nil;
    }
    _orderRefreshRequest = [[BulkOrderDataRequest alloc] initWithLimitTime:0 count:10 url:[GlobalVar shareGlobalVar].orderUrl];
    _orderRefreshRequest.delegate = self;
    [_orderRefreshRequest request];
}

-(void)loadMoreOrders
{
    if (_loadMoreOrderRequest) {
        [_loadMoreOrderRequest cancel];
        _loadMoreOrderRequest = nil;
    }
    
    _loadMoreOrderRequest = [[BulkOrderDataRequest alloc] initWithLimitTime:[[[_arrOrders lastObject] objectForKey:kOrderPropertyCreateTime] longLongValue] count:10 url:[GlobalVar shareGlobalVar].orderUrl];
    _loadMoreOrderRequest.delegate = self;
    [_loadMoreOrderRequest request];
}

- (void)getOrderDetailWithUrl:(NSString *)url
{
    [MBProgressHUD showLoadingWithDim:YES];
    
    if (_orderDetailRequest) {
        [_orderDetailRequest cancel];
    }
    _orderDetailRequest = [[BulkOrderDataRequest alloc] init];
    _orderDetailRequest.delegate = self;
    [_orderDetailRequest getRequestWithUrl:url andParam:nil];
}



#pragma mark - RetrieveRequestDelegate

-(void)didRetrieveDataSuccess:(RetrieveRequest *)request
{
    if (_orderRefreshRequest == request) {
        
        [MBProgressHUD dismissHUD];

        if ([_tableView.mj_header isRefreshing]) {
            [_tableView.mj_header endRefreshing];
        }
        
         NSMutableDictionary * dictResult = [_orderRefreshRequest fetchDataWithReformer:[[OrderListReformer alloc] init]];
        _arrOrders = [NSMutableArray arrayWithArray:dictResult[@"result"]];
        [_tableView reloadData];
    } else if (_loadMoreOrderRequest == request) {
        
        if ([_tableView.mj_footer isRefreshing]) {
            [_tableView.mj_footer endRefreshing];
        }
        
        NSMutableDictionary * dictResult = [_loadMoreOrderRequest fetchDataWithReformer:[[OrderListReformer alloc] init]];
        [_arrOrders addObjectsFromArray:dictResult[@"result"]];
        [_tableView reloadData];
        
    } else if (_orderDetailRequest == request) {
        
        [MBProgressHUD dismissHUD];
        NSMutableDictionary * dictResult = [_orderDetailRequest fetchDataWithReformer:[[OrderDetailReformer alloc] init]];
        if (_bNeedPayAction) {
            _bNeedPayAction = NO;
            
            PayViewController *payViewController=[[PayViewController alloc]init];
            payViewController.dictOrderInfo = dictResult;
            [self.navigationController pushViewController:payViewController animated:YES];
        } else {
            OrderDetailViewController *vc = [[OrderDetailViewController alloc] init];
            vc.dictOrderInfo = dictResult;
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else if (_cancelOrderRequest == request) {
        [MBProgressHUD showHUDAutoDismissWithString:@"取消订单成功" andDim:NO];
        [_arrOrders removeObject:_cancelOrderRequest.extraObject];
        [_tableView reloadData];
        [[UserManager shareInstance] refreshToken:YES];
    } else if (_deleteOrderRequest == request) {
        [MBProgressHUD showHUDAutoDismissWithString:@"删除订单成功" andDim:NO];
        
        [_arrOrders removeObject:_deleteOrderRequest.extraObject];
        [_tableView reloadData];
    }
}

-(void)didRetrieveDataFailed:(RetrieveRequest *)request
{
    if (_orderRefreshRequest == request) {

        [MBProgressHUD dismissHUD];
        
        if ([_tableView.mj_header isRefreshing]) {
            [_tableView.mj_header endRefreshing];
        }
        
    } else if (_loadMoreOrderRequest == request) {
        
        if ([_tableView.mj_footer isRefreshing]) {
            [_tableView.mj_footer endRefreshing];
        }
    } else if (_orderDetailRequest == request) {
        _bNeedPayAction = NO;

    } else if (_cancelOrderRequest == request) {

    } else if (_deleteOrderRequest == request) {
        
    }
    
    [MBProgressHUD showHUDAutoDismissWithError:request.error andDim:NO];
}

#pragma mark - UITableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cellID";
    MyOrderTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil)
    {
        cell=[[MyOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSDictionary *dict=[_arrOrders objectAtIndex:indexPath.row];
    [cell configData:dict];
    cell.delegate = self;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [_arrOrders objectAtIndex:indexPath.row];

    if ([dict[kOrderPropertyStatus] integerValue]!=OutOfDateOrder)
    {
        [self getOrderDetailWithUrl:dict[kOrderPropertyDetailUrl]];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrOrders.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *image=[UIImage imageNamed:@"right_darkArrow_icon"];
    return 230+(ScreenWidth-90-image.size.width)/5;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}




#pragma buttonClick
-(void)shareToWeiXin:(UIButton *)button
{
    
    if (![WXApi isWXAppInstalled]) {
        [MBProgressHUD showHUDAutoDismissWithString:@"您未安装微信" andDim:NO];
        return;
    }
    
    PopView *popView=(PopView *)button.superview;
    
    NSString * desc = popView.dict[kOrderPropertyCardDesc];
    if (!desc.length) {
        desc = [NSString stringWithFormat:@"我是第%@位接龙者，大家快来参团吧！", popView.dict[kOrderPropertyRelaySeq]];
    }
    
    NSString * iconUrl = popView.dict[kOrderPropertyCardIcon];
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
            
            [WXApiRequestHandler sendLinkURL:popView.dict[kOrderPropertyCardUrl] TagName:nil Title:popView.dict[kOrderPropertyCardTitle] Description:desc ThumbImage:image InScene:WXSceneSession];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self backButtonClick:nil];
            });
            
        }];
    } else {
        UIImage * image = [UIImage imageNamed:@"thumb_icon"];
    
        [WXApiRequestHandler sendLinkURL:popView.dict[kOrderPropertyCardUrl] TagName:nil Title:popView.dict[kOrderPropertyCardTitle] Description:desc ThumbImage:image InScene:WXSceneSession];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self backButtonClick:nil];
        });
    }
}

-(void)createRelayView:(NSDictionary *)dictOrder
{
    if (!_backButton)
    {
        _backButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.backgroundColor=RGBACOLOR(1, 1, 1, 0.0);
        _backButton.frame=[UIScreen mainScreen].bounds;
        [_backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_backButton];
        
        _popView=[[PopView alloc]initWithFrame:CGRectMake(ScreenWidth/2, ScreenHeight/2, 0, 0)];
        _popView.dict=dictOrder;
        [self.view addSubview:_popView];
        
        [UIView animateWithDuration:0.25 animations:^{
            _backButton.backgroundColor=RGBACOLOR(1, 1, 1, 0.5);
            _popView.frame=CGRectMake((ScreenWidth-310)/2, (ScreenHeight-330)/2, 310, 330);
        } completion:^(BOOL finished) {
            [_popView configUI];
            [_popView.sendButton addTarget:self action:@selector(shareToWeiXin:) forControlEvents:UIControlEventTouchUpInside];
            [self.view bringSubviewToFront:_popView];
        }];
    }
}

-(void)backButtonClick:(UIButton *)button
{
    [_popView hideUI];
    [UIView animateWithDuration:0.25 animations:^{
        _popView.frame=CGRectMake(ScreenWidth/2, ScreenHeight/2, 0, 0);
        _backButton.alpha=0.0f;
    } completion:^(BOOL finished) {
        [_popView removeFromSuperview];
        _popView=nil;
        [_backButton removeFromSuperview];
        _backButton=nil;
    }];
}




//去支付
-(void)payButtonClicked:(NSDictionary *)dictOrder
{
    _bNeedPayAction = YES;
    [self getOrderDetailWithUrl:dictOrder[kOrderPropertyDetailUrl]];
}


-(void)didClickWith:(UIView *)alertView  buttonAtIndex:(NSUInteger)buttonIndex;
{
    if (alertView == _mcCancelAlertView)
    {
        if (buttonIndex==1)
        {
            
        }
        else if(buttonIndex==2)
        {
            [MBProgressHUD showLoadingWithDim:YES];
            if (_cancelOrderRequest) {
                _cancelOrderRequest.extraObject = nil;
                [_cancelOrderRequest cancel];
                _cancelOrderRequest = nil;
            }
            _cancelOrderRequest = [[BulkOrderDataRequest alloc] init];
            _cancelOrderRequest.delegate = self;
            _cancelOrderRequest.extraObject = ((MCAlertview *)alertView).dict;
            [_cancelOrderRequest deleteRequestWithUrl:((MCAlertview *)alertView).dict[kOrderPropertyDetailUrl] andParam:nil];
        }
    } else if (alertView == _mcDeleteAlertView) {
        
        if (buttonIndex==1)
        {
            
        }
        else if(buttonIndex==2)
        {
            [MBProgressHUD showLoadingWithDim:YES];
            if (_deleteOrderRequest) {
                _deleteOrderRequest.extraObject = nil;
                [_deleteOrderRequest cancel];
                _deleteOrderRequest = nil;
            }
            _deleteOrderRequest = [[BulkOrderDataRequest alloc] init];
            _deleteOrderRequest.delegate = self;
            _deleteOrderRequest.extraObject = ((MCAlertview *)alertView).dict;
            [_deleteOrderRequest deleteRequestWithUrl:((MCAlertview *)alertView).dict[kOrderPropertyDetailUrl] andParam:nil];
        }
    }
}



//取消订单
-(void)cancelButtonClicked:(NSDictionary *)dictOrder
{
    _mcCancelAlertView=[[MCAlertview alloc]initWithMessage:@"是否取消订单？" CancelButton:@"否" andCancelBtnBackGround:nil  OkButton:@"是" andOkBtnColor:nil];
    _mcCancelAlertView.dict=dictOrder;
    _mcCancelAlertView.delegate=self;
    [_mcCancelAlertView show];
}


//确认收货
-(void)confirmButtonClicked:(NSDictionary *)dictOrder
{
    
}

//查看物流
-(void)checkTransportBtnClicked:(NSDictionary *)dictOrder
{
    
}

//删除订单
-(void)deleteBtnClicked:(NSDictionary *)dictOrder
{
    _mcDeleteAlertView=[[MCAlertview alloc]initWithMessage:@"确认删除该订单吗？" CancelButton:@"取消" andCancelBtnBackGround:nil OkButton:@"确定" andOkBtnColor:nil];
    _mcDeleteAlertView.delegate=self;
    _mcDeleteAlertView.dict=dictOrder;
    [_mcDeleteAlertView show];
}

//接龙
-(void)ETABtnClicked:(NSDictionary *)dictOrder
{
    [self createRelayView:dictOrder];
}


-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)setupTableView
{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.emptyDataSetSource = self;
    _tableView.emptyDataSetDelegate = self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, -MJRefreshFooterHeight, 0);
    _tableView.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    [self.view addSubview:_tableView];
    
    __weak typeof(self) wSelf = self;
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        if (![self searchCookDataWithRefresh:YES]) {
//            [_bookRetTable.mj_header endRefreshing];
//        }
        [wSelf refreshOrderList];
    }];
    
    [header setTitle:@"正在获取数据中..." forState:MJRefreshStateRefreshing];
    
    _tableView.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (!_arrOrders.count) {
            [_tableView.mj_footer endRefreshing];
            return ;
        }
        
        [wSelf loadMoreOrders];
    }];
    
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    footer.refreshingTitleHidden=YES;
    footer.automaticallyHidden=YES;
    
    _tableView.mj_footer = footer;
}


@end
