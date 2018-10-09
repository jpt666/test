//
//  PayViewController.m
//  CookBook
//
//  Created by 你好 on 16/6/6.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "PayViewController.h"
#import "NavView.h"
#import "TitleTableViewCell.h"
#import "PayTableViewCell.h"
#import "PayTypeTableCell.h"
#import "OrderDetailViewController.h"
#import "WXApi.h"
#import "WXApiManager.h"
#import "BulkOrderDataRequest.h"
#import "PayRequest.h"
#import "OrderDetailReformer.h"
#import "OrderPropertyKeys.h"
//#import "SVProgressHUD.h"
#import "MBProgressHUD+Helper.h"
#import "UserManager.h"
#import "MCAlertview.h"
#import "ListAlertView.h"

@interface PayViewController()<UITableViewDelegate,UITableViewDataSource,WXApiManagerDelegate,RetrieveRequestDelegate,MCALertviewDelegate>

@end


typedef NS_ENUM(NSUInteger, ThirdPayMethod){
    BalancePay = 0,
    WeiXinPay,
    AliPay
};

@implementation PayViewController
{
    UITableView *_tableView;
    NavView *_navView;
    UIButton *_bottomButton;
    UILabel *_countdownLabel;
    
    NSString * _detailOrderUrl;
    NSString * _wxPayUrl;
    
    PayRequest * _wxPayRequest;
    PayRequest * _aliPayRequest;
    BulkOrderDataRequest * _refreshPayResultRequest;
    
    BulkOrderDataRequest * _refreshStatusRequest;
    
    ThirdPayMethod _payMethod;
    
    MCAlertview * _cancelPayAlert;
    
    BOOL _bUseBalance;
    BOOL _bBalanceEnough;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    
    _navView=[[NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navView.centerLabel.text=@"在线支付";
    [_navView.leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_navView.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navView];
    
//    _countdownLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, 20)];
//    _countdownLabel.backgroundColor=RGBACOLOR(241, 255, 169, 1);
//    _countdownLabel.textColor=[UIColor orangeColor];
//    _countdownLabel.font=[UIFont systemFontOfSize:12];
//    _countdownLabel.textAlignment=NSTextAlignmentCenter;
//    _countdownLabel.text=@"支付剩余时间：28分48秒";
//    [self.view addSubview:_countdownLabel];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-49) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    [self.view addSubview:_tableView];
    
    
    _bottomButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _bottomButton.frame=CGRectMake(0,ScreenHeight-49, ScreenWidth, 49);
    _bottomButton.backgroundColor=RGBACOLOR(176, 116, 67, 1);
    [_bottomButton setTitle:@"确认支付" forState:UIControlStateNormal];
    [_bottomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_bottomButton addTarget:self action:@selector(payButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_bottomButton];
    
    _payMethod = WeiXinPay;
    
    [self configUrl];
    
    if ([UserManager shareInstance].curUser.balanceMoney>0)
    {
        _bUseBalance = YES;
    }
    
    if ([UserManager shareInstance].curUser.balanceMoney>[_dictOrderInfo[kOrderPropertyTotalFee] integerValue])
    {
        _bBalanceEnough = YES;
        _payMethod = BalancePay;
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

-(void)updateUI
{
    
}

- (void)configUrl
{
    _detailOrderUrl = _dictOrderInfo[kOrderPropertyDetailUrl];
    _wxPayUrl = _dictOrderInfo[kOrderPropertyWXPayUrl];
}

-(void)makeWeixinPayWithPayInfo:(NSDictionary *)dictPayInfo
{
    
    [WXApiManager sharedManager].delegate = self;
    
    PayReq* req             = [[PayReq alloc] init];
    req.partnerId           = [dictPayInfo objectForKey:@"partnerid"];
    req.prepayId            = [dictPayInfo objectForKey:@"prepayid"];
    req.nonceStr            = [dictPayInfo objectForKey:@"noncestr"];
    req.timeStamp           = [[dictPayInfo objectForKey:@"timestamp"] intValue];
    req.package             = [dictPayInfo objectForKey:@"package"];
    req.sign                = [dictPayInfo objectForKey:@"sign"];
    [WXApi sendReq:req];

}

-(void)refreshOrderStatus
{
    if (_refreshStatusRequest) {
        [_refreshStatusRequest cancel];
    }
    _refreshStatusRequest = [[BulkOrderDataRequest alloc] init];
    _refreshStatusRequest.delegate = self;
    [_refreshStatusRequest getRequestWithUrl:_detailOrderUrl andParam:nil];
}


-(void)didClickWith:(UIView *)alertView  buttonAtIndex:(NSUInteger)buttonIndex;
{
    if (alertView == _cancelPayAlert)
    {
        if (buttonIndex==1)
        {
            
        }
        else if(buttonIndex==2)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

-(void)leftButtonClick:(UIButton *)button
{
    _cancelPayAlert =[[MCAlertview alloc] initWithMessage:@"确认取消支付吗？" CancelButton:@"取消" andCancelBtnBackGround:nil OkButton:@"确定" andOkBtnColor:nil];
    _cancelPayAlert.delegate=self;
    [_cancelPayAlert show];
}


-(void)payButtonClick:(UIButton *)button
{
    switch (_payMethod) {
        case BalancePay:
            if (_bUseBalance && _bBalanceEnough) {
                [MBProgressHUD showLoadingWithDim:YES];
                
                _wxPayRequest = [[PayRequest alloc] init];
                _wxPayRequest.delegate = self;
                [_wxPayRequest getRequestWithUrl:_wxPayUrl andParam:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:_bUseBalance] forKey:@"balance"]];
            } else if(_bUseBalance){
                [MBProgressHUD showHUDAutoDismissWithString:@"余额不足" andDim:NO];
            } else {
                [MBProgressHUD showHUDAutoDismissWithString:@"请选择支付方式" andDim:NO];
            }
            break;
        case WeiXinPay:
        {
            if ([WXApi isWXAppInstalled]) {
                [MBProgressHUD showLoadingWithDim:YES];
                
                _wxPayRequest = [[PayRequest alloc] init];
                _wxPayRequest.delegate = self;
                [_wxPayRequest getRequestWithUrl:_wxPayUrl andParam:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:_bUseBalance] forKey:@"balance"]];
            } else {
                [MBProgressHUD showHUDAutoDismissWithString:@"您需要安装微信才能继续" andDim:NO];
            }
        }
            break;
        case AliPay:
            break;
        default:
            [MBProgressHUD showHUDAutoDismissWithString:@"请选择支付方式" andDim:NO];
            break;
    }
}

- (void)popPayViewContollerAnimated:(BOOL)animated
{
    [[UserManager shareInstance] refreshToken:YES];
    
    OrderDetailViewController *orderDetailVC;
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[OrderDetailViewController class]]) {
            orderDetailVC = (OrderDetailViewController *)vc;
            break;
        }
    }
    
    if (orderDetailVC) {
        orderDetailVC.dictOrderInfo = _dictOrderInfo;
        orderDetailVC.bInstantPay = YES;
        [self.navigationController popToViewController:orderDetailVC animated:YES];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UITableViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _tableView)
    {
        CGFloat sectionHeaderHeight = 10;
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0)
        {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        }
        else if(scrollView.contentOffset.y>=sectionHeaderHeight)
        {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        static NSString *cellIDE=@"cellIDE";
        TitleTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIDE];
        if (cell==nil)
        {
            cell=[[TitleTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIDE];
        }
        
        if (indexPath.row==0)
        {
            cell.titleLabel.text=@"订单编号";
            cell.descLabel.text=self.dictOrderInfo[kOrderPropertyId];
            cell.lineView.hidden=NO;
        }
        else if (indexPath.row==1)
        {
            cell.titleLabel.text=@"支付金额";
            NSString *totalPriceStr=[NSString stringWithFormat:@"¥ %.2f",[self.dictOrderInfo[kOrderPropertyTotalFee] doubleValue]/100];
            
            NSRange range=[totalPriceStr rangeOfString:@"."];
            NSMutableAttributedString *totalPriceAttrStr=[[NSMutableAttributedString alloc]initWithString:totalPriceStr];
            [totalPriceAttrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:RGBACOLOR(176, 116, 67, 1)} range:NSMakeRange(range.location, 3)];
            [totalPriceAttrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:RGBACOLOR(176, 116, 67, 1)} range:NSMakeRange(1, totalPriceStr.length-4)];
            [totalPriceAttrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:RGBACOLOR(176, 116, 67, 1)} range:NSMakeRange(0, 1)];
            cell.descLabel.attributedText=totalPriceAttrStr;
            cell.lineView.hidden=YES;
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.section==1)
    {
        static NSString *cellID=@"cellID";
        PayTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil)
        {
            cell=[[PayTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.titleLabel.text=@"账户余额";
        if ([UserManager shareInstance].curUser.balanceMoney>0)
        {
            cell.headImageView.image=[UIImage imageNamed:@"balance_selected"];
            cell.descLabel.textColor=RGBACOLOR(176, 116, 67, 1);
        }
        else
        {
            cell.headImageView.image=[UIImage imageNamed:@"balance_dark"];
            cell.descLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.5];
        }
        cell.bottomImageView.image = _bUseBalance?[UIImage imageNamed:@"selected_green_icon"]:[UIImage imageNamed:@"normal_round_icon"];
        cell.descLabel.text=[NSString stringWithFormat:@"可用金额 ¥%.2f",[UserManager shareInstance].curUser.balanceMoney/100.0f];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.section==2)
    {
        static NSString *cellIDER=@"cellIDER";
        PayTypeTableCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIDER];
        if (cell==nil)
        {
            cell=[[PayTypeTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIDER];
        }
        if (indexPath.row==0)
        {
            cell.headImageView.image=[UIImage imageNamed:@"weixinpay_icon"];
            cell.titleLabel.text=@"微信支付";
            cell.bottomImageView.image = ((_payMethod == WeiXinPay)?[UIImage imageNamed:@"selected_green_icon"]:[UIImage imageNamed:@"normal_round_icon"]);
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1)
    {
        if ([UserManager shareInstance].curUser.balanceMoney>0)
        {
            _bUseBalance = !_bUseBalance;
            PayTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.bottomImageView.image = _bUseBalance?[UIImage imageNamed:@"selected_green_icon"]:[UIImage imageNamed:@"normal_round_icon"];
            
            if (_bUseBalance && _bBalanceEnough) {
                _payMethod = BalancePay;
                [_tableView reloadData];
            }
        }
    }
    else if (indexPath.section==2)
    {
        
        if (_bBalanceEnough)
        {
            _payMethod = ((_payMethod == BalancePay)?WeiXinPay:BalancePay);
            PayTypeTableCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.bottomImageView.image = (_payMethod == WeiXinPay)?[UIImage imageNamed:@"selected_green_icon"]:[UIImage imageNamed:@"normal_round_icon"];
            
            if (_payMethod == WeiXinPay &&  _bUseBalance) {
                _bUseBalance = NO;
                [_tableView reloadData];
            }
        }
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==1)
    {
        return 60;
    }
    else if (section==2)
    {
        return 70;
    }
    else if(section==0)
    {
        return 10;
    }
    else
    {
        return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==2)
    {
        return 10;
    }
    else
    {
        return 0;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==2)
    {
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
        view.backgroundColor=[UIColor whiteColor];
        return view;
    }
    else
    {
        return nil;
    }
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==1)
    {
        UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
        headView.backgroundColor=[UIColor whiteColor];
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
        lineView.backgroundColor=RGBACOLOR(207, 207, 207, 0.5);
        [headView addSubview:lineView];
        UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, ScreenWidth-10, 40)];
        titleLabel.font=[UIFont systemFontOfSize:16];
        [headView addSubview:titleLabel];
        titleLabel.text=@"余额支付";
        return headView;
    }
    else if (section==2)
    {
        UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];
        headView.backgroundColor=[UIColor whiteColor];
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 10, ScreenWidth, 10)];
        lineView.backgroundColor=RGBACOLOR(207, 207, 207, 0.5);
        [headView addSubview:lineView];
        UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 30, ScreenWidth-10, 35)];
        titleLabel.font=[UIFont systemFontOfSize:16];
        [headView addSubview:titleLabel];
        titleLabel.text=@"还需支付";
        return headView;
    }
    else if (section==0)
    {
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
        view.backgroundColor=RGBACOLOR(230, 230, 230, 1);
        return view;
    }
    
    return nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return 2;
    }
    else if (section==1)
    {
        return 1;
    }
    else if (section==2)
    {
        return 1;
    }
    
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - WXApiManagerDelegate
- (void)managerDidRecvPayResonse:(PayResp *)response
{
    switch (response.errCode)
    {
        case -1://错误
            [MBProgressHUD showHUDAutoDismissWithString:@"支付失败，请重试！" andDim:NO];
            break;
        case -2://用户取消
            [MBProgressHUD showHUDAutoDismissWithString:@"支付取消" andDim:NO];
            break;
        case 0://成功
        {
            
            OrderDetailViewController *orderDetailVC;
            for (UIViewController *vc in self.navigationController.viewControllers)
            {
                if ([vc isKindOfClass:[OrderDetailViewController class]])
                {
                    orderDetailVC = (OrderDetailViewController *)vc;
                    break;
                }
            }
            
            if (!orderDetailVC) {
                orderDetailVC = [[OrderDetailViewController alloc] init];
                orderDetailVC.dictOrderInfo = _dictOrderInfo;
                orderDetailVC.bInstantPay = YES;
                
                NSMutableArray *arrVc = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
                
                [arrVc insertObject:orderDetailVC atIndex:arrVc.count-1];
                [self.navigationController setViewControllers:arrVc animated:NO];
            }
            
            
//            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
//            [SVProgressHUD show];
            
            [MBProgressHUD showLoadingWithDim:YES];
            
            _refreshPayResultRequest = [[BulkOrderDataRequest alloc] init];
            _refreshPayResultRequest.delegate = self;
            [_refreshPayResultRequest getRequestWithUrl:_detailOrderUrl andParam:nil];
        }
            break;
        default:
            break;
    }
}

#pragma mark - RetrieveRequestDelegate

-(void)didRetrieveDataSuccess:(RetrieveRequest *)request
{
    if (_refreshPayResultRequest == request) {
        
        NSDictionary * dict = [_refreshPayResultRequest fetchDataWithReformer:[[OrderDetailReformer alloc] init]];
        if ([dict[kOrderPropertyStatus] integerValue] == FinishedPayOrder) {
            
            [MBProgressHUD showHUDAutoDismissWithString:@"支付成功" andDim:NO];
            
            _dictOrderInfo = dict;
            [self popPayViewContollerAnimated:YES];
            
        } else {
            static int errCnt = 0;
            if (errCnt > 2) {
                errCnt = 0;
                
                [MBProgressHUD showHUDAutoDismissWithString:@"支付异常" andDim:NO];
                
                return;
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [_refreshPayResultRequest getRequestWithUrl:_detailOrderUrl andParam:nil];
                errCnt++;
            });
        }
    } else if(_refreshStatusRequest == request) {
        
        _dictOrderInfo = [_refreshStatusRequest fetchDataWithReformer:[[OrderDetailReformer alloc] init]];
        
        
    } else if(_wxPayRequest == request) {
        [MBProgressHUD dismissHUD];
        
        NSDictionary * dictPayInfo = _wxPayRequest.rawData;
        
        NSNumber *errCode = dictPayInfo[kOrderPropertyErrorCode];
        
        if (!errCode) {
            BOOL needThirdPay = [dictPayInfo[@"require_third_party_payment"] boolValue];
            if (needThirdPay) {
                [self makeWeixinPayWithPayInfo:dictPayInfo[@"pay_request_json"]];
            } else {
                _dictOrderInfo = dictPayInfo[@"order"];
                [self popPayViewContollerAnimated:YES];
            }
        } else if (errCode.integerValue == ErrorGoodsLimit) {    //超过限购
            ListAlertView *listAlertView=[[ListAlertView  alloc]initWithArray:dictPayInfo[kOrderPropertyDetail]];
            listAlertView.alertType = AlertTypeLimit;
//            listAlertView.delegate=self;
            [listAlertView show];
        } else if (errCode.integerValue == ErrorGoodsNotEnough) {    //剩余数量不足
            ListAlertView *listAlertView=[[ListAlertView  alloc]initWithArray:dictPayInfo[kOrderPropertyDetail]];
            listAlertView.alertType = AlertTypeNotEnough;
//            listAlertView.delegate=self;
            [listAlertView show];
        }

    } else if(_aliPayRequest == request) {
        
    }
}

-(void)didRetrieveDataFailed:(RetrieveRequest *)request
{
    if (request == _refreshPayResultRequest) {
        static int errCnt = 0;
        if (errCnt >= 2) {
            errCnt = 0;
            [MBProgressHUD showHUDAutoDismissWithError:request.error andDim:NO];
            return;
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_refreshPayResultRequest getRequestWithUrl:_detailOrderUrl andParam:nil];
            errCnt++;
        });
        
    } else if (_refreshStatusRequest == request) {
        [MBProgressHUD showHUDAutoDismissWithError:request.error andDim:NO];
        
    } else if (_wxPayRequest == request) {
//        [SVProgressHUD setMinimumDismissTimeInterval:1.0f];
//        [SVProgressHUD showErrorWithStatus:[request.error localizedDescription]];
        [MBProgressHUD showHUDAutoDismissWithError:request.error andDim:NO];
        
//        [self refreshOrderStatus];
        //alert error
    } else if (_aliPayRequest == request) {
        
    }
}


@end
