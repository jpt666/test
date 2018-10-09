//
//  OrderDetailViewController.m
//  CookBook
//
//  Created by 你好 on 16/6/6.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "NavView.h"
#import "OrderDetailTopView.h"
#import "OrderDetailCenterView.h"
#import "GoodsListTableCell.h"
#import "GoodsPropertyKeys.h"
#import "ParticipantPropertyKeys.h"
#import "OrderPropertyKeys.h"
#import "PayViewController.h"
#import "PopView.h"
#import "WXApi.h"
#import "BulkOrderDataRequest.h"
//#import "SVProgressHUD.h"
#import "OrderPropertyKeys.h"
#import "UserManager.h"
#import "MBProgressHUD+Helper.h"
#import "MCAlertview.h"
#import <SDWebImageManager.h>
#import "WXApiRequestHandler.h"
#import "GroupsPropertyKeys.h"
#import "OrderNoteView.h"
@interface OrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource,RetrieveRequestDelegate,MCALertviewDelegate>


@end



@implementation OrderDetailViewController
{
    NavView *_navView;
    OrderDetailTopView *_topView;
    OrderDetailCenterView *_centerView;
    OrderNoteView *_orderNoteView;
    UITableView *_goodsTableView;
    UIScrollView *_scrollView;
    UIView *_bottomView;
    
    UIButton *_bvsButton;
    UIButton *_cancelOrderBtn;
    UIButton *_comfirmGoodsBtn;
    UIButton *_payButton;
    UIButton *_deleteBtn;
    UIButton *_checkTransportBtn;
    
    UIButton *_backButton;
    PopView *_popView;
    
    BulkOrderDataRequest * _cancelOrderRequest;
    BulkOrderDataRequest * _deleteOrderRequest;
    
    MCAlertview *_mcCancelAlertView;
    MCAlertview *_mcDeleteAlertView;
    
    UIWebView *_callWebview;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    _navView=[[NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navView.centerLabel.text=@"订单详情";
    [_navView.leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_navView.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navView];
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-49)];
    _scrollView.showsVerticalScrollIndicator=NO;
    _scrollView.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:_scrollView];
    
    _topView=[[OrderDetailTopView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, 165)];
    [_topView configData:self.dictOrderInfo];
    [_scrollView addSubview:_topView];
    
    if ([self.dictOrderInfo[kGroupsPropertyRecieveMode] integerValue]==ReceiveModePickUp)
    {
        _centerView=[[OrderDetailCenterView alloc]initWithFrame:CGRectMake(0, _topView.frame.size.height, ScreenWidth, 165)];
        [_centerView configData:self.dictOrderInfo];
        [_centerView.phoneBtn addTarget:self action:@selector(phoneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:_centerView];
    }
    else if ([self.dictOrderInfo[kGroupsPropertyRecieveMode] integerValue]==ReceiveModeDeliver)
    {
        _centerView=[[OrderDetailCenterView alloc]initWithFrame:CGRectMake(0, _topView.frame.size.height, ScreenWidth, 165)];
        [_centerView configData:self.dictOrderInfo];
        [_scrollView addSubview:_centerView];
    }
    
    if (self.dictOrderInfo[kGroupsPropertyComments]) {
    
        _orderNoteView=[[OrderNoteView alloc] initWithFrame:CGRectMake(0, _centerView.frame.origin.y+_centerView.frame.size.height, ScreenWidth, 93)];

        _orderNoteView.textfield.hidden=YES;
        
        CGFloat height = [_orderNoteView makeViewHeightWithContent:self.dictOrderInfo[kGroupsPropertyComments]];
        
        _orderNoteView.frame = CGRectMake(0, _centerView.frame.origin.y+_centerView.frame.size.height, ScreenWidth, height);
        _orderNoteView.backView.frame=CGRectMake(0, 10, _orderNoteView.bounds.size.width, _orderNoteView.bounds.size.height-10);
        
        [_scrollView addSubview:_orderNoteView];

    }
    
    UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 70)];
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    lineView.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    [headView addSubview:lineView];
    
    UILabel *headLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 40)];
    headLabel.text=@"  费用明细";
    headLabel.font=[UIFont boldSystemFontOfSize:17];
    [headView addSubview:headLabel];
    
    UIView *footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 130)];
    footView.backgroundColor=[UIColor whiteColor];
    
    UILabel *extraLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, ScreenWidth/2-10, 38)];
    extraLabel.font=[UIFont systemFontOfSize:14];
    extraLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.8];
    extraLabel.text=@"配送费";
    [footView addSubview:extraLabel];
    
    UILabel *extraPriceLabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2+10, 2, ScreenWidth/2-20, 38)];
    extraPriceLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.8];
    extraPriceLabel.font=[UIFont systemFontOfSize:14];
    extraPriceLabel.textAlignment=NSTextAlignmentRight;
    extraPriceLabel.text=[NSString stringWithFormat:@"¥ %.2f",[self.dictOrderInfo[kOrderPropertyFreight] doubleValue]/100];
    [footView addSubview:extraPriceLabel];
    
    UIView *topLineView=[[UIView alloc]initWithFrame:CGRectMake(10, 0, ScreenWidth-20, 0.5)];
    topLineView.backgroundColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.3];
    [footView addSubview:topLineView];
    
    UILabel *deducteLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 40, ScreenWidth/2-10, 40)];
    deducteLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.8];
    deducteLabel.font=[UIFont systemFontOfSize:14];
    deducteLabel.textAlignment=NSTextAlignmentLeft;
    deducteLabel.text=@"余额扣款";
    [footView addSubview:deducteLabel];
    
    UILabel *deductePriceLabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2+10, 40, ScreenWidth/2-20, 40)];
    deductePriceLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.8];
    deductePriceLabel.font=[UIFont systemFontOfSize:14];
    deductePriceLabel.textAlignment=NSTextAlignmentRight;
    [footView addSubview:deductePriceLabel];
    
    if(self.dictOrderInfo[kOrderPropertyDictionaryPayInfo])
    {
        deductePriceLabel.text=[NSString stringWithFormat:@"- ¥ %.2f",[self.dictOrderInfo[kOrderPropertyDictionaryPayInfo][kOrderPropertyBalanceFee] doubleValue]/100];
    }
    else
    {
        deductePriceLabel.text=[NSString stringWithFormat:@"- ¥ 0.00"];
    }

    
    UIView *thirdLineView=[[UIView alloc]initWithFrame:CGRectMake(10, 79, ScreenWidth-20,0.5)];
    thirdLineView.backgroundColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.3];
    [footView addSubview:thirdLineView];
    
    UILabel *totalLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 79, ScreenWidth/2-10, 40)];
    totalLabel.font=[UIFont systemFontOfSize:14];
    totalLabel.text=@"总计";
    totalLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.8];
    [footView addSubview:totalLabel];
    
    UIView *bottomSpaceView=[[UIView alloc]initWithFrame:CGRectMake(0, 120, ScreenWidth, 10)];
    bottomSpaceView.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    [footView addSubview:bottomSpaceView];
    
    NSString *totalPriceStr=[NSString stringWithFormat:@"¥ %.2f",[self.dictOrderInfo[@"total_fee"] doubleValue]/100];
    
    NSRange range=[totalPriceStr rangeOfString:@"."];
    NSMutableAttributedString *totalPriceAttrStr=[[NSMutableAttributedString alloc]initWithString:totalPriceStr];
    [totalPriceAttrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:RGBACOLOR(176, 116, 67, 1)} range:NSMakeRange(range.location, 3)];
    [totalPriceAttrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:RGBACOLOR(176, 116, 67, 1)} range:NSMakeRange(1, totalPriceStr.length-4)];
    [totalPriceAttrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:RGBACOLOR(176, 116, 67, 1)} range:NSMakeRange(0, 1)];
    
    UILabel *totalPriceLabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2+10, 80, ScreenWidth/2-20, 40)];
    totalPriceLabel.attributedText=totalPriceAttrStr;
    totalPriceLabel.textAlignment=NSTextAlignmentRight;
    [footView addSubview:totalPriceLabel];
    
    UIView *bottomLineView=[[UIView alloc]initWithFrame:CGRectMake(10, 39, ScreenWidth-20,0.5)];
    bottomLineView.backgroundColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.3];
    [footView addSubview:bottomLineView];
    
    _goodsTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, _centerView.frame.origin.y+_centerView.frame.size.height+_orderNoteView.bounds.size.height, ScreenWidth, [self.dictOrderInfo[kOrderPropertyGoods] count]*40+headView.bounds.size.height+footView.bounds.size.height) style:UITableViewStylePlain];
    _goodsTableView.dataSource=self;
    _goodsTableView.delegate=self;
    _goodsTableView.scrollEnabled=NO;
    _goodsTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [_scrollView addSubview:_goodsTableView];
    
    _goodsTableView.tableHeaderView=headView;
    _goodsTableView.tableFooterView=footView;
    
    _scrollView.contentSize=CGSizeMake(ScreenWidth, _goodsTableView.frame.origin.y+_goodsTableView.frame.size.height);
    
    _bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-49, ScreenWidth, 49)];
    _bottomView.backgroundColor=[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:0.9];
    [self.view addSubview:_bottomView];
    

    _bvsButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _bvsButton.frame=CGRectZero;
    [_bvsButton setTitle:@"接龙" forState:UIControlStateNormal];
    [_bvsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_bvsButton setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    _bvsButton.layer.cornerRadius=6;
    _bvsButton.layer.borderWidth=0.5f;
    _bvsButton.titleLabel.font=[UIFont systemFontOfSize:14];
    _bvsButton.layer.borderColor=[UIColor colorWithHexString:@"#4e4e4e"].CGColor;
    [_bvsButton addTarget:self action:@selector(bvsButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_bvsButton];
    
    _checkTransportBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _checkTransportBtn.frame=CGRectZero;
    [_checkTransportBtn setTitle:@"查看物流" forState:UIControlStateNormal];
    [_checkTransportBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _checkTransportBtn.layer.cornerRadius=6;
    _checkTransportBtn.layer.borderWidth=0.5f;
    _checkTransportBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    _checkTransportBtn.layer.borderColor=[UIColor colorWithHexString:@"#4e4e4e"].CGColor;
    [_checkTransportBtn addTarget:self action:@selector(checkTransportBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_checkTransportBtn];
    
    _cancelOrderBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _cancelOrderBtn.frame=CGRectZero;
    [_cancelOrderBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    [_cancelOrderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _cancelOrderBtn.layer.cornerRadius=6;
    _cancelOrderBtn.layer.borderWidth=0.5f;
    _cancelOrderBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    _cancelOrderBtn.layer.borderColor=[UIColor colorWithHexString:@"#4e4e4e"].CGColor;
    [_cancelOrderBtn addTarget:self action:@selector(cancelOrderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_cancelOrderBtn];
    
    _payButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _payButton.frame=CGRectZero;
    [_payButton setTitle:@"去支付" forState:UIControlStateNormal];
    _payButton.backgroundColor=RGBACOLOR(176, 116, 67, 1);
    _payButton.titleLabel.font=[UIFont systemFontOfSize:14];
    [_payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_payButton addTarget:self action:@selector(payButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _payButton.layer.cornerRadius=6;
    [_bottomView addSubview:_payButton];
    
    _deleteBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _deleteBtn.frame=CGRectZero;
    [_deleteBtn setTitle:@"删除订单" forState:UIControlStateNormal];
    [_deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _deleteBtn.layer.cornerRadius=6;
    _deleteBtn.layer.borderWidth=0.5f;
    _deleteBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    _deleteBtn.layer.borderColor=[UIColor colorWithHexString:@"#4e4e4e"].CGColor;
    [_deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_deleteBtn];
    
    _comfirmGoodsBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _comfirmGoodsBtn.frame=CGRectZero;
    [_comfirmGoodsBtn setTitle:@"确认收货" forState:UIControlStateNormal];
    _comfirmGoodsBtn.backgroundColor=RGBACOLOR(176, 116, 67, 1);
    _comfirmGoodsBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [_comfirmGoodsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _comfirmGoodsBtn.layer.cornerRadius=6;
    [_comfirmGoodsBtn addTarget:self action:@selector(comfirmGoodsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_comfirmGoodsBtn];
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (_bInstantPay) {
        //弹出接龙
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self createRelayView];
        });
        
        _bInstantPay  = NO;
    }
}


-(void)createRelayView
{
    if (!_backButton)
    {
        _backButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.backgroundColor=RGBACOLOR(1, 1, 1, 0.0);
        _backButton.frame=[UIScreen mainScreen].bounds;
        [_backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_backButton];
        
        _popView=[[PopView alloc]initWithFrame:CGRectMake(ScreenWidth/2, ScreenHeight/2, 0, 0)];
        _popView.dict=self.dictOrderInfo;
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


-(void)updateUI
{
    [_topView configData:self.dictOrderInfo];
    NSInteger bulkStatus = [self.dictOrderInfo[kOrderPropertyBulkStatus] integerValue];
    switch ([self.dictOrderInfo[kOrderPropertyStatus] integerValue])
    {
        case OutOfDateOrder:
        {
            _cancelOrderBtn.frame=CGRectZero;
            _comfirmGoodsBtn.frame=CGRectZero;
            _checkTransportBtn.frame=CGRectZero;
            _payButton.frame=CGRectZero;
            _bvsButton.frame=CGRectZero;
            _deleteBtn.frame=CGRectMake(ScreenWidth-90, 9.5, 80, 30);
            
            _cancelOrderBtn.hidden=YES;
            _comfirmGoodsBtn.hidden=YES;
            _checkTransportBtn.hidden=YES;
            _payButton.hidden=YES;
            _deleteBtn.hidden=NO;
            _bvsButton.hidden=YES;
        }
            break;
        case NotPayOrder:
        {
            _comfirmGoodsBtn.frame=CGRectZero;
            _checkTransportBtn.frame=CGRectZero;
            _deleteBtn.frame=CGRectZero;
            _cancelOrderBtn.frame=CGRectMake(ScreenWidth-180, 9.5, 80, 30);
            _payButton.frame=CGRectMake(ScreenWidth-90,9.5, 80, 30);
            _bvsButton.frame=CGRectMake(ScreenWidth-270,9.5, 80, 30);
            
            _bvsButton.hidden=NO;
            _bvsButton.selected = (bulkStatus>=0?NO:YES);
            _cancelOrderBtn.hidden=NO;
            _comfirmGoodsBtn.hidden=YES;
            _checkTransportBtn.hidden=YES;
            _payButton.hidden=NO;
            _deleteBtn.hidden=YES;
        }
            break;
        case FinishedPayOrder:
        {
            _bvsButton.frame=CGRectZero;
            _payButton.frame=CGRectZero;
            _deleteBtn.frame=CGRectZero;
            _cancelOrderBtn.frame=CGRectMake(ScreenWidth-180, 9.5, 80, 30);
            _bvsButton.frame=CGRectMake(ScreenWidth-270, 9.5, 80, 30);
            _comfirmGoodsBtn.frame=CGRectMake(ScreenWidth-90,9.5, 80, 30);
            
            _bvsButton.hidden=NO;
            _bvsButton.selected = (bulkStatus>=0?NO:YES);
            _cancelOrderBtn.hidden=NO;
            _comfirmGoodsBtn.hidden=NO;
            _checkTransportBtn.hidden=YES;
            _payButton.hidden=YES;
            _deleteBtn.hidden=YES;
        }
            break;
        case SendOutOrder:
        {
            _bvsButton.frame=CGRectMake(ScreenWidth-270, 9.5, 80, 30);
            _payButton.frame=CGRectZero;
            _cancelOrderBtn.frame=CGRectZero;
            _checkTransportBtn.frame=CGRectMake(ScreenWidth-180, 9.5, 80, 30);
            _comfirmGoodsBtn.frame=CGRectMake(ScreenWidth-90,9.5, 80, 30);
            _deleteBtn.frame=CGRectZero;
            
            _bvsButton.hidden=NO;
            _bvsButton.selected = (bulkStatus>=0?NO:YES);
            _cancelOrderBtn.hidden=YES;
            _comfirmGoodsBtn.hidden=NO;
            _checkTransportBtn.hidden=NO;
            _payButton.hidden=YES;
            _deleteBtn.hidden=YES;
        }
            break;
        case WaitForPickUpOrder:
        {
            _bvsButton.frame=CGRectMake(ScreenWidth-270, 9.5, 80, 30);
            _payButton.frame=CGRectZero;
            _cancelOrderBtn.frame=CGRectZero;
            _checkTransportBtn.frame=CGRectMake(ScreenWidth-180, 9.5, 80, 30);
            _comfirmGoodsBtn.frame=CGRectMake(ScreenWidth-90,9.5, 80, 30);
            _deleteBtn.frame=CGRectZero;
            
            _bvsButton.hidden=NO;
            _bvsButton.selected = (bulkStatus>=0?NO:YES);
            _cancelOrderBtn.hidden=YES;
            _comfirmGoodsBtn.hidden=NO;
            _checkTransportBtn.hidden=NO;
            _payButton.hidden=YES;
            _deleteBtn.hidden=YES;
        }
            break;
        case FinishOrder:
        {
            _payButton.frame=CGRectZero;
            _deleteBtn.frame=CGRectMake(ScreenWidth-90, 9.5, 80, 30);
            _bvsButton.frame=CGRectMake(ScreenWidth-180, 9.5, 80, 30);
            _cancelOrderBtn.frame=CGRectZero;
            _comfirmGoodsBtn.frame=CGRectZero;
            _checkTransportBtn.frame=CGRectZero;
            
            _bvsButton.hidden=NO;
            _bvsButton.selected = (bulkStatus>=0?NO:YES);
            _cancelOrderBtn.hidden=YES;
            _comfirmGoodsBtn.hidden=YES;
            _checkTransportBtn.hidden=YES;
            _payButton.hidden=YES;
            _deleteBtn.hidden=NO;
        }
            break;
        default:
            break;
    }

}

-(void)leftButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)phoneBtnClick:(UIButton *)button
{
    if(_callWebview)
    {
        [_callWebview removeFromSuperview];
        _callWebview=nil;
    }
    
    NSDictionary * dispatcher = self.dictOrderInfo[kOrderPropertyDispatcher];
    NSString * str=[NSString stringWithFormat:@"tel:%@",dispatcher[kDispatcherPropertyMobile]];
    _callWebview = [[UIWebView alloc] init];
    [_callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:_callWebview];
}


-(void)shareToWeiXin:(UIButton *)button
{
    if (![WXApi isWXAppInstalled]) {
        [MBProgressHUD showHUDAutoDismissWithString:@"您未安装微信" andDim:NO];
        return;
    }
    
    NSString * desc = self.dictOrderInfo[kOrderPropertyCardDesc];
    if (!desc.length) {
        desc = [NSString stringWithFormat:@"我是第%@位接龙者，大家快来参团吧！", self.dictOrderInfo[kOrderPropertyRelaySeq]];
    }
    
    NSString * iconUrl = self.dictOrderInfo[kOrderPropertyCardIcon];
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
            
            [WXApiRequestHandler sendLinkURL:self.dictOrderInfo[kOrderPropertyCardUrl] TagName:nil Title:self.dictOrderInfo[kOrderPropertyCardTitle] Description:desc ThumbImage:image InScene:WXSceneSession];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self backButtonClick:nil];
            });
            
        }];
    } else {
        UIImage * image = [UIImage imageNamed:@"thumb_icon"];
        
        [WXApiRequestHandler sendLinkURL:self.dictOrderInfo[kOrderPropertyCardUrl] TagName:nil Title:self.dictOrderInfo[kOrderPropertyCardTitle] Description:desc ThumbImage:image InScene:WXSceneSession];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self backButtonClick:nil];
        });
    }
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
                [_cancelOrderRequest cancel];
                _cancelOrderRequest = nil;
            }
            _cancelOrderRequest = [[BulkOrderDataRequest alloc] init];
            _cancelOrderRequest.delegate = self;
            [_cancelOrderRequest deleteRequestWithUrl:_dictOrderInfo[kOrderPropertyDetailUrl] andParam:nil];
        }
    } else if (alertView == _mcDeleteAlertView) {
        if (buttonIndex==1)
        {
            
        }
        else if(buttonIndex==2)
        {
            [MBProgressHUD showLoadingWithDim:YES];
            
            if (_deleteOrderRequest) {
                [_deleteOrderRequest cancel];
                _deleteOrderRequest = nil;
            }
            _deleteOrderRequest = [[BulkOrderDataRequest alloc] init];
            _deleteOrderRequest.delegate = self;
            [_deleteOrderRequest deleteRequestWithUrl:_dictOrderInfo[kOrderPropertyDetailUrl] andParam:nil];
        }
    }
}



//删除订单
-(void)deleteBtnClick:(UIButton *)button
{
    _mcDeleteAlertView =[[MCAlertview alloc]initWithMessage:@"确认删除该订单吗？" CancelButton:@"取消" andCancelBtnBackGround:nil OkButton:@"确定" andOkBtnColor:RGBACOLOR(176, 116, 67, 1)];
    _mcDeleteAlertView.delegate=self;
    [_mcDeleteAlertView show];
}

//接龙
-(void)bvsButtonClick:(UIButton *)button
{
    if (button.isSelected) {
        return;
    }
    [self createRelayView];
}

//取消订单
-(void)cancelOrderBtnClick:(UIButton *)button
{
    _mcCancelAlertView=[[MCAlertview alloc]initWithMessage:@"是否取消订单？" CancelButton:@"否" andCancelBtnBackGround:nil OkButton:@"是" andOkBtnColor:nil];
    _mcCancelAlertView.delegate=self;
    [_mcCancelAlertView show];
}

//去支付
-(void)payButtonClick:(UIButton *)button
{
    PayViewController *payVc = [[PayViewController alloc] init];
    payVc.dictOrderInfo = self.dictOrderInfo;
    [self.navigationController pushViewController:payVc animated:YES];
}

//确认收货
-(void)comfirmGoodsBtnClick:(UIButton *)button
{
//    [self cancelOrderBtnClick:button];
}

//查看物流
-(void)checkTransportBtnClick:(UIButton *)button
{
    
}


#pragma mark - UITableViewDelegate


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_goodsTableView)
    {
        static NSString *cellIDE=@"cellIDE";
        GoodsListTableCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIDE];
        if (cell==nil)
        {
            cell = [[GoodsListTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIDE];
        }
        
        NSDictionary *dict=[self.dictOrderInfo[@"goods"] objectAtIndex:indexPath.row];
        if (indexPath.row==[self.dictOrderInfo[@"goods"] count]-1)
        {
            cell.bottomImageView.hidden=YES;
        }
        else
        {
            cell.bottomImageView.hidden=NO;
        }
        
        [cell configByDict:dict andIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView ==_goodsTableView)
    {
        return 40;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   if(tableView == _goodsTableView)
    {
        return [self.dictOrderInfo[kOrderPropertyGoods] count];
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView == _goodsTableView)
    {
        return 1;
    }
    return 0;
}



-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - RetrieveRequestDelegate

-(void)didRetrieveDataSuccess:(RetrieveRequest *)request
{
    if (_cancelOrderRequest == request ||
        _deleteOrderRequest == request) {
//        [SVProgressHUD dismiss];
        [MBProgressHUD dismissHUD];
        
        if (_dictOrderInfo[kOrderPropertyStatus] > 0) {
            [[UserManager shareInstance] refreshToken:YES];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)didRetrieveDataFailed:(RetrieveRequest *)request
{
    if (_cancelOrderRequest == request ||
        _deleteOrderRequest == request) {
//        [SVProgressHUD setMinimumDismissTimeInterval:1.0f];
//        [SVProgressHUD showErrorWithStatus:[request.error localizedDescription]];
    }
    
    [MBProgressHUD showHUDAutoDismissWithError:request.error andDim:NO];
}


@end
