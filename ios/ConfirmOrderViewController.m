//
//  ConfirmViewController.m
//  CookBook
//
//  Created by 你好 on 16/6/6.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "ConfirmOrderViewController.h"
#import "NavView.h"
#import "ConfirmOrderTopView.h"
#import "ConfirmOrderCenterView.h"
#import "AddressTableViewCell.h"
#import "GoodsListTableCell.h"
#import "PayViewController.h"
#import "ShopAddressViewController.h"
#import "UserManager.h"
#import "GroupsPropertyKeys.h"
#import "ShoppingGoods.h"
#import "BulkOrderDataRequest.h"
#import "OrderDetailViewController.h"
#import "MBProgressHUD+Helper.h"
#import "OrderDetailReformer.h"
#import "OrderNoteView.h"
#import "OrderPropertyKeys.h"
#import "MixAddressViewController.h"
#import "ListAlertView.h"
@interface ConfirmOrderViewController()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,RetrieveRequestDelegate,UINavigationControllerDelegate,ConfirmOrderCenterViewDelegate,ListAlertViewDelegate>


@end


@implementation ConfirmOrderViewController
{
    NavView *_navView;
    ConfirmOrderTopView *_topView;
//    ConfirmOrderCenterView *_centerView;
    OrderNoteView *_orderNoteView;
    UITableView *_goodsTableView;
    UIButton *_bottomButton;
    UIView *_footView;
    UIView *_headView;
    UIScrollView *_scrollView;
//    NSMutableArray *_addressArray;
    NSMutableArray *_shipAddressArray;
    BulkOrderDataRequest * _confirmOrderRequest;
    
    NSDictionary * _dictOrderInfo;
    
    ReceiveMode _supportRecieveMode;
    ReceiveMode _curReciveMode;
//    NSNumber * _curShipId;
    NSDictionary * _selectedAddress;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=RGBACOLOR(230, 230, 230, 1);
//    _addressArray=[[NSMutableArray alloc]initWithCapacity:0];
    
//    _shopAddressArray=[[NSMutableArray alloc]initWithCapacity:0];
    
    _navView=[[NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navView.centerLabel.text=@"确认订单";
    [_navView.leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_navView.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navView];
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-49)];
    _scrollView.showsVerticalScrollIndicator=NO;
    _scrollView.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:_scrollView];
    
    _topView=[[ConfirmOrderTopView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 130)];
    _topView.nameTextField.delegate=self;
    _topView.phoneTextField.delegate=self;
//    _topView.nameTextField.text=[UserManager shareInstance].curUser.recentObtainName;
//    _topView.phoneTextField.text=[UserManager shareInstance].curUser.recentObtainMobile;
    _topView.editButton.enabled = NO;
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] init];
    tapGes.numberOfTapsRequired = 1;
    tapGes.numberOfTouchesRequired = 1;
    [tapGes addTarget:self action:@selector(editReceiveInfo:)];
    [_topView addGestureRecognizer:tapGes];
    
//    [_topView.editButton addTarget:self action:@selector(editReceiveInfo:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_topView];
    
//    for (NSDictionary *dict in self.detailGroupBuy[kGroupsPropertyDispatchers])
//    {
//        NSMutableDictionary *addressDict=[[NSMutableDictionary alloc]initWithDictionary:dict];
//        if ([dict[kDispatcherPropertyId] integerValue]==[self.detailGroupBuy[kGroupsPropertyRecentDispatcher] integerValue])
//        {
//            [addressDict setObject:[NSNumber numberWithBool:YES] forKey:@"isSeleted"];
//        }
//        else
//        {
//            [addressDict setObject:[NSNumber numberWithBool:NO] forKey:@"isSeleted"];
//        }
//        [_addressArray addObject:addressDict];
//    }
//    
//    if (_addressArray.count>0)
//    {
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %@", @"isSelected", [NSNumber numberWithBool:YES]];
//        NSArray *array=[_addressArray filteredArrayUsingPredicate:predicate];
//        
//        if (array.count<=0)
//        {
//            NSMutableDictionary *dict=[_addressArray firstObject];
//            [dict setObject:[NSNumber numberWithBool:YES] forKey:@"isSelected"];
//
//            _topView.nameTextField.text=dict[@"name"];
//            _topView.phoneTextField.text=dict[@"mob"];
//            NSString *str=[NSString stringWithFormat:@"收货地址:请选择收货地址"];
//            NSRange range=[str rangeOfString:@":"];
//            NSMutableAttributedString *attrString=[[NSMutableAttributedString alloc]initWithString:str];
//            [attrString addAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]} range:NSMakeRange(range.location+1, str.length-5)];
//            _topView.addressLabel.attributedText=attrString;
//        }
//    }
    
    [self resetAddressLabel];
    _supportRecieveMode = [self.detailGroupBuy[kGroupsPropertyRecieveMode] integerValue];
    
    
    if (_supportRecieveMode==ReceiveModePickUp ||
        _supportRecieveMode==ReceiveModePickUpAndDeliver)
    {
        _curReciveMode = ReceiveModeNone;
        if (_supportRecieveMode==ReceiveModePickUpAndDeliver) {
            [[UserManager shareInstance]getShopAddress];
        }
        
        _topView.nameTextField.text=[UserManager shareInstance].curUser.recentObtainName;
        _topView.phoneTextField.text=[UserManager shareInstance].curUser.recentObtainMobile;
        
        if (!_topView.nameTextField.text.length) {
            _topView.nameTextField.text = [UserManager shareInstance].curUser.nickName;
        }
        if (!_topView.nameTextField.text.length) {
            _topView.nameTextField.text = [UserManager shareInstance].curUser.mobileNumber;
        }
        if (!_topView.phoneTextField.text.length) {
            _topView.phoneTextField.text = [UserManager shareInstance].curUser.mobileNumber;
        }
        
        NSInteger defaultShipId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"DefaultPickUpId"] integerValue];
        
        BOOL bContained = NO;
        for (NSDictionary *d in self.detailGroupBuy[kGroupsPropertyDispatchers]) {
            if ([d[@"id"] integerValue] == defaultShipId) {
                _selectedAddress = d;
                _curReciveMode = ReceiveModePickUp;
                bContained = YES;
                break;
            }
        }
    
        if (bContained) {
            _topView.addressLabel.text=[NSString stringWithFormat:@"收货地址:%@",_selectedAddress[@"address"]];
        }

    
        _topView.deliverLabel.text=[NSString stringWithFormat:@"配送方式:自提点自提"];
//        if (_addressArray.count>3)
//        {
//            _centerView=[[ConfirmOrderCenterView alloc]initWithFrame:CGRectMake(0, _topView.frame.origin.y+_topView.frame.size.height, ScreenWidth, 230)];
//            _centerView.delegate=self;
//            [_centerView.replayAddressBtn addTarget:self action:@selector(replayAddressBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//            _centerView.addressTable.dataSource=self;
//            _centerView.addressTable.delegate=self;
//            _centerView.addressTable.scrollEnabled=YES;
//            [_centerView configData:self.detailGroupBuy];
//            [_scrollView addSubview:_centerView];
//        }
//        else
//        {
//            _centerView=[[ConfirmOrderCenterView alloc]initWithFrame:CGRectMake(0,  _topView.frame.origin.y+_topView.frame.size.height, ScreenWidth, 65+55*_addressArray.count)];
//            _centerView.delegate=self;
//            [_centerView.replayAddressBtn addTarget:self action:@selector(replayAddressBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//            _centerView.addressTable.dataSource=self;
//            _centerView.addressTable.delegate=self;
//            _centerView.addressTable.scrollEnabled=NO;
//            [_centerView configData:self.detailGroupBuy];
//            [_scrollView addSubview:_centerView];
//        }
    }
    else if(_supportRecieveMode==ReceiveModeDeliver)
    {
        _curReciveMode = ReceiveModeDeliver;
        
        [[UserManager shareInstance]getShopAddress];
        
        _topView.deliverLabel.text=[NSString stringWithFormat:@"配送方式:送货上门"];
//        _centerView=[[ConfirmOrderCenterView alloc]initWithFrame:CGRectMake(0,  _topView.frame.origin.y+_topView.frame.size.height, ScreenWidth, 155)];
//        _centerView.delegate=self;
//        [_centerView.replayAddressBtn addTarget:self action:@selector(replayAddressBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        _centerView.addressTable.dataSource=self;
//        _centerView.addressTable.delegate=self;
//        _centerView.addressTable.scrollEnabled=NO;
//        [_centerView configData:self.detailGroupBuy];
//        [_scrollView addSubview:_centerView];
    }
    
    _orderNoteView=[[OrderNoteView alloc]initWithFrame:CGRectMake(0, _topView.frame.origin.y+_topView.frame.size.height, ScreenWidth, 100)];
    _orderNoteView.contentLabel.hidden=YES;
    [_scrollView addSubview:_orderNoteView];
    
    _headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    _headView.backgroundColor=[UIColor whiteColor];
    
    UILabel *headLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 15, ScreenWidth, 30)];
    headLabel.text=@"  费用明细";
    headLabel.font=[UIFont boldSystemFontOfSize:17];
    headLabel.backgroundColor=[UIColor whiteColor];
    [_headView addSubview:headLabel];
    
    _footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 85)];
    _footView.backgroundColor=[UIColor whiteColor];
    
    UILabel *extraLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 2, ScreenWidth/2-10, 38)];
    extraLabel.font=[UIFont systemFontOfSize:14];
    extraLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.8];
    extraLabel.text=@"配送费";
    [_footView addSubview:extraLabel];
    
    UILabel *extraPriceLabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2+10, 2, ScreenWidth/2-20, 38)];
    extraPriceLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.8];
    extraPriceLabel.font=[UIFont systemFontOfSize:14];
    extraPriceLabel.textAlignment=NSTextAlignmentRight;
    extraPriceLabel.text=@"¥ 0.00";
    [_footView addSubview:extraPriceLabel];
    
    UIView *topLineView=[[UIView alloc]initWithFrame:CGRectMake(10, 2, ScreenWidth-20, 0.5)];
    topLineView.backgroundColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.3];
    [_footView addSubview:topLineView];
    
    UILabel *totalLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 42, ScreenWidth/2-10, 40)];
    totalLabel.font=[UIFont systemFontOfSize:14];
    totalLabel.text=@"总计";
    totalLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.8];
    [_footView addSubview:totalLabel];
    
   
    double totalPrice=0.0;
    for (ShoppingGoods *shopGoods in self.arrGoods)
    {
        totalPrice=totalPrice+(shopGoods.unitPrice*shopGoods.puchaseNum/100);
    }
    
    
    totalPrice=totalPrice+0.00;
    NSString *totalPriceStr=[NSString stringWithFormat:@"¥ %.2f",totalPrice];
    
    NSRange range=[totalPriceStr rangeOfString:@"."];
    NSMutableAttributedString *totalPriceAttrStr=[[NSMutableAttributedString alloc]initWithString:totalPriceStr];
    [totalPriceAttrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:RGBACOLOR(176, 116, 67, 1)} range:NSMakeRange(range.location, 3)];
    [totalPriceAttrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:RGBACOLOR(176, 116, 67, 1)} range:NSMakeRange(1, totalPriceStr.length-4)];
    [totalPriceAttrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:RGBACOLOR(176, 116, 67, 1)} range:NSMakeRange(0, 1)];
    
    UILabel *totalPriceLabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2+10, 42, ScreenWidth/2-20, 40)];
    totalPriceLabel.attributedText=totalPriceAttrStr;
    totalPriceLabel.textAlignment=NSTextAlignmentRight;
    [_footView addSubview:totalPriceLabel];
    
    UIView *bottomLineView=[[UIView alloc]initWithFrame:CGRectMake(10, 41, ScreenWidth-20,0.5)];
    bottomLineView.backgroundColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.3];
    [_footView addSubview:bottomLineView];
    
    _goodsTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, _orderNoteView.frame.origin.y+_orderNoteView.frame.size.height, ScreenWidth, self.arrGoods.count*40+_headView.frame.size.height+_footView.frame.size.height) style:UITableViewStylePlain];
    _goodsTableView.dataSource=self;
    _goodsTableView.delegate=self;
    _goodsTableView.scrollEnabled=NO;
    _goodsTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [_scrollView addSubview:_goodsTableView];

    _goodsTableView.tableHeaderView=_headView;
    _goodsTableView.tableFooterView=_footView;
    
    _scrollView.contentSize=CGSizeMake(ScreenWidth, _goodsTableView.frame.origin.y+_goodsTableView.frame.size.height+10);
    
    _bottomButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _bottomButton.frame=CGRectMake(0,ScreenHeight-49, ScreenWidth, 49);
    _bottomButton.backgroundColor=RGBACOLOR(176, 116, 67, 1);
    _bottomButton.exclusiveTouch = YES;
    [_bottomButton setTitle:@"去支付" forState:UIControlStateNormal];
    [_bottomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_bottomButton addTarget:self action:@selector(payButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_bottomButton];
    
//    if (([self.detailGroupBuy[kGroupsPropertyRecieveMode] integerValue]==ReceiveModeDeliver)||([self.detailGroupBuy[kGroupsPropertyRecieveMode] integerValue]==ReceiveModePickUpAndDeliver))
//    {
//        [[UserManager shareInstance]getShopAddress];
//    }
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

-(void)resetAddressLabel
{
    NSString *str=[NSString stringWithFormat:@"收货地址:请选择地址"];
    NSRange range=[str rangeOfString:@":"];
    NSMutableAttributedString *attrStr=[[NSMutableAttributedString alloc]initWithString:str];
    [attrStr addAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]} range:NSMakeRange(range.location+1, str.length-5)];
    _topView.addressLabel.attributedText=attrStr;
}

-(BOOL)checkOrderInfomation
{
    BOOL flag=NO;
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %@", @"isSelected", [NSNumber numberWithBool:YES]];
//    NSArray *array=[_addressArray filteredArrayUsingPredicate:predicate];
    
    if (_topView.nameTextField.text.length<=0)
    {
        [MBProgressHUD showHUDAutoDismissWithString:@"收货人不能为空" andDim:NO];
    }
    else if (_topView.phoneTextField.text.length<=0)
    {
        [MBProgressHUD showHUDAutoDismissWithString:@"手机号不能为空" andDim:NO];
    }
    else if (![self validatePhone:_topView.phoneTextField.text])
    {
        [MBProgressHUD showHUDAutoDismissWithString:@"手机号格式不合法" andDim:NO];
    }
//    else if ((_centerView.rightView.hidden)&&(array.count<=0))
    else if (_curReciveMode == ReceiveModePickUp && !_selectedAddress)
    {
        [MBProgressHUD showHUDAutoDismissWithString:@"请选择上门自提地址" andDim:NO];
    }
//    else if ((!_centerView.rightView.hidden)&&(_centerView.addressLabel.text.length<=0))
    else if (_curReciveMode == ReceiveModeDeliver && !_selectedAddress)
    {
        [MBProgressHUD showHUDAutoDismissWithString:@"请选择送货上门地址" andDim:NO];
    }
    else if (_curReciveMode == ReceiveModeNone) {
        [MBProgressHUD showHUDAutoDismissWithString:@"请选择收货地址" andDim:NO];
    }
    else
    {
        flag=YES;
    }
    return flag;
}


-(void)payButtonClick:(UIButton *)button
{
//    NSLog(@"%d",[self checkOrderInfomation]);
    
    if (![self checkOrderInfomation]) {
        return;
    }
    
//    if (_dictOrderInfo) {
//        PayViewController *payViewController=[[PayViewController alloc]init];
//        payViewController.dictOrderInfo = _dictOrderInfo;
//        [self.navigationController pushViewController:payViewController animated:YES];
//        
//    } else {
        NSDictionary * dict = [self constructOrderInfo];
    
//        [MBLoadingView showLoadingViewWithDimBackground:YES];
        [MBProgressHUD showLoadingWithDim:YES];
        
        _confirmOrderRequest = [[BulkOrderDataRequest alloc] init];
        _confirmOrderRequest.delegate = self;
        [_confirmOrderRequest postRequestWithUrl:[GlobalVar shareGlobalVar].orderUrl andParam:dict];
//    }

}

-(NSDictionary *)constructOrderInfo
{
    NSMutableArray * arr = [NSMutableArray array];
    for (ShoppingGoods *goods in _arrGoods) {
        NSMutableDictionary *d = [NSMutableDictionary dictionary];
        d[@"product_id"] = goods.goodsId;
        d[@"quantity"] = @(goods.puchaseNum);
        [arr addObject:d];
    }
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"ip_address"] = @"127.0.0.1";
    
    if (_curReciveMode != ReceiveModeDeliver) {
        dict[@"obtain_name"] = _topView.nameTextField.text;
        dict[@"obtain_mob"] = _topView.phoneTextField.text;
    }
    dict[@"bulk_id"] = _detailGroupBuy[kGroupsPropertyId];
    dict[@"goods"] = arr;
    
    dict[@"receive_mode"] = @(_curReciveMode);
    
    if (_curReciveMode == ReceiveModePickUp) {
//        for (NSMutableDictionary *dictDispatcher in _addressArray)
//        {
//            if ([[dictDispatcher objectForKey:@"isSelected"] boolValue])
//            {
//                dict[@"storage_id"] = dictDispatcher[kDispatcherPropertyId];
//                break;
//            }
//        }
        dict[@"storage_id"] = _selectedAddress[@"id"];
    } else if (_curReciveMode == ReceiveModeDeliver) {
        dict[@"shippingaddress_id"] = _selectedAddress[@"id"];
    }
    
    NSString * remark = [_orderNoteView.textfield.text stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
    if (remark.length) {
        dict[@"comments"] = remark;
    }
    
    
    return dict;
}

//-(void)replayAddressBtnClick:(UIButton *)button
//{
//    ShopAddressViewController *shopAddressVC=[[ShopAddressViewController alloc]init];
//    shopAddressVC.enterAddressType=SelectShoppingAddress;
//    shopAddressVC.backValue=^(NSDictionary *dict){
//        _selectedDeliverAddress = dict;
//        
//        _topView.nameTextField.text=dict[@"name"];
//        _topView.phoneTextField.text=dict[@"mob"];
//        _topView.addressLabel.text=[NSString stringWithFormat:@"收货地址:%@",dict[@"address"]];
////        _centerView.addressLabel.text=dict[@"address"];
////        _centerView.addressLabel.textColor=[UIColor blackColor];
//    };
//    CATransition* transition = [CATransition animation];
//    transition.type = kCATransitionPush;//可更改为其他方式
//    transition.subtype = kCATransitionFromTop;//可更改为其他方式
//    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
//    [self.navigationController pushViewController:shopAddressVC animated:NO];
//}


-(void)leftButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)pushPayViewController:(UIViewController *)vc animated:(BOOL)animated
{
    NSMutableArray *arr = [NSMutableArray arrayWithObject:[self.navigationController.viewControllers firstObject]];

    OrderDetailViewController * orderVc = [[OrderDetailViewController alloc] init];
    orderVc.dictOrderInfo = _dictOrderInfo;
    [arr addObject:orderVc];
    [arr addObject:vc];
    [self.navigationController setViewControllers:arr animated:animated];
}

- (void)updateShipAddressView
{
    if (_curReciveMode == ReceiveModeDeliver && _selectedAddress) {
        _topView.nameTextField.text=_selectedAddress[@"name"];
        _topView.phoneTextField.text=_selectedAddress[@"mob"];
        _topView.addressLabel.text=[NSString stringWithFormat:@"收货地址:%@",_selectedAddress[@"address"]];
    }
}

-(void)checkSelectedWithShipAddress:(NSMutableArray *)arrShipAddress
{
    if (!arrShipAddress) {
        _shipAddressArray = arrShipAddress;
    }
    if (_curReciveMode == ReceiveModeDeliver && _selectedAddress && arrShipAddress) {
        BOOL bContained = NO;
        for (NSDictionary *d in arrShipAddress) {
            if ([d[@"id"] integerValue] == [_selectedAddress[@"id"] integerValue]) {
                bContained = YES;
                _selectedAddress = d;
                [self updateShipAddressView];
                break;
            }
        }
        
        if (!bContained) {
            _selectedAddress = nil;
            _curReciveMode = ReceiveModeNone;
            [self resetAddressLabel];
        }
    }
}

-(void)saveDefaultShipAddress
{
    if (_curReciveMode == ReceiveModeDeliver) {
        [[NSUserDefaults standardUserDefaults] setObject:_selectedAddress[@"id"] forKey:@"DefaultShipId"];
    } else if (_curReciveMode == ReceiveModePickUp) {
        [[NSUserDefaults standardUserDefaults] setObject:_selectedAddress[@"id"] forKey:@"DefaultPickUpId"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)editReceiveInfo:(UIButton *)button
{
    CATransition* transition = [CATransition animation];
    transition.type = kCATransitionPush;//可更改为其他方式
    transition.subtype = kCATransitionFromTop;//可更改为其他方式
    MixAddressViewController *mixAddressVC=[[MixAddressViewController alloc]init];
    mixAddressVC.dict=self.detailGroupBuy;
    //    mixAddressVC.arrShipAddress = _shipAddressArray;
    //    mixAddressVC.curShipId = _curShipId;
    mixAddressVC.selecetAddrCompleted = ^(ReceiveMode receiveMode, NSDictionary *dict, NSString *selectedName, NSString * selectedMob, NSMutableArray * arrShipAddress) {
        
        [self checkSelectedWithShipAddress:arrShipAddress];
        
        if (selectedName && selectedMob) {
            if (receiveMode == ReceiveModePickUp ||
                _curReciveMode != ReceiveModeDeliver ) {
                _topView.nameTextField.text = selectedName;
                _topView.phoneTextField.text = selectedMob;
            }
            
            if (receiveMode != ReceiveModeDeliver) {
                [UserManager shareInstance].curUser.recentObtainName = selectedName;
                [UserManager shareInstance].curUser.recentObtainMobile = selectedMob;
            }
        }
        
        if (receiveMode == ReceiveModeNone || !dict) {
            return ;
        }
        
        _curReciveMode = receiveMode;
        _selectedAddress = dict;
        _topView.addressLabel.text=[NSString stringWithFormat:@"收货地址:%@",dict[@"address"]];
        
        if (_curReciveMode == ReceiveModeDeliver) {
            _topView.nameTextField.text=dict[@"name"];
            _topView.phoneTextField.text=dict[@"mob"];
            _topView.deliverLabel.text=[NSString stringWithFormat:@"配送方式:送货上门"];
            
        } else if (_curReciveMode == ReceiveModePickUp) {
            _topView.deliverLabel.text=[NSString stringWithFormat:@"配送方式:自提点自提"];
        }
        
//        if (selectedName && selectedMob) {
//            if (_curReciveMode != ReceiveModeDeliver ) {
//                _topView.nameTextField.text = selectedName;
//                _topView.phoneTextField.text = selectedMob;
//            }
//
//            [UserManager shareInstance].curUser.recentObtainName = selectedName;
//            [UserManager shareInstance].curUser.recentObtainMobile = selectedMob;
//        }
        
        [self saveDefaultShipAddress];
    };
    
    mixAddressVC.cancelSelect = ^(NSMutableArray *arrShipAddress) {
        [self checkSelectedWithShipAddress:arrShipAddress];
    };
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:mixAddressVC animated:NO];
}

#pragma mark -ConfirmOrderCenterViewDelegate
-(void)didLeftButtonClick:(UIButton *)leftButton
{
//    _curReciveMode = ReceiveModePickUp;
//    
//    _topView.nameTextField.text=[UserManager shareInstance].curUser.recentObtainName;
//    _topView.phoneTextField.text=[UserManager shareInstance].curUser.recentObtainMobile;
    
//    [UIView animateWithDuration:0.2 animations:^{
//        
//    
//        if (_addressArray.count>3)
//        {
//            _centerView.frame=CGRectMake(0, 90, ScreenWidth, 230);
//        }
//        else
//        {
//            _centerView.frame=CGRectMake(0, 90, ScreenWidth, 65+55*_addressArray.count);
//        }
//        
//        _centerView.backView.frame=CGRectMake(0, 0, _centerView.bounds.size.width, _centerView.bounds.size.height-10);
//        
//        _orderNoteView.frame = CGRectMake(0, _centerView.frame.origin.y+_centerView.frame.size.height, ScreenWidth, 100);
//        
//        _goodsTableView.frame=CGRectMake(0, _orderNoteView.frame.origin.y+_orderNoteView.frame.size.height, ScreenWidth, self.arrGoods.count*40+_headView.frame.size.height+_footView.frame.size.height);
//        _scrollView.contentSize=CGSizeMake(ScreenWidth, _goodsTableView.frame.origin.y+_goodsTableView.frame.size.height);
//        _centerView.addressTable.hidden=NO;
//        _centerView.rightView.hidden=YES;
//    }];
    


}

-(void)didRightButtonClick:(UIButton *)rightButton
{
//    _curReciveMode = ReceiveModeDeliver;
//    
//    if (_selectedAddress) {
//        
//        [_topView.nameTextField resignFirstResponder];
//        [_topView.phoneTextField resignFirstResponder];
//        
//        _topView.nameTextField.text=_selectedAddress[@"name"];
//        _topView.phoneTextField.text=_selectedAddress[@"mob"];
//        _topView.addressLabel.text=[NSString stringWithFormat:@"收货地址:%@",_selectedAddress[@"address"]];
//    }
    
//    [UIView animateWithDuration:0.2 animations:^{
//        
//    _centerView.frame=CGRectMake(0, 90, ScreenWidth, 155);
//    [_centerView configFrame];
//    _centerView.backView.frame=CGRectMake(0, 0, _centerView.bounds.size.width, _centerView.bounds.size.height-10);
//    _centerView.rightView.frame=CGRectMake(0, 50, _centerView.bounds.size.width, _centerView.bounds.size.height-75);
//    _orderNoteView.frame = CGRectMake(0, _centerView.frame.origin.y+_centerView.frame.size.height, ScreenWidth, 100);
//    _goodsTableView.frame=CGRectMake(0, _orderNoteView.frame.origin.y+_orderNoteView.frame.size.height, ScreenWidth, self.arrGoods.count*40+_headView.frame.size.height+_footView.frame.size.height);
//    _scrollView.contentSize=CGSizeMake(ScreenWidth, _goodsTableView.frame.origin.y+_goodsTableView.frame.size.height);
//        
//        _centerView.rightView.hidden=NO;
//        _centerView.addressTable.hidden=YES;
//    }];
    
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
        
        ShoppingGoods *shopGood=[self.arrGoods objectAtIndex:indexPath.row];
        [cell configData:shopGood andIndexPath:indexPath];
        if (indexPath.row==self.arrGoods.count-1)
        {
            cell.bottomImageView.hidden=YES;
        }
        else
        {
            cell.bottomImageView.hidden=NO;
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
//    else if(tableView == _centerView.addressTable)
//    {
//        static NSString *cellID=@"cellID";
//        AddressTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
//        if (cell==nil)
//        {
//            cell=[[AddressTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//        }
//        
//        NSDictionary *dict=[_addressArray objectAtIndex:indexPath.row];
//        [cell configData:dict];
//        if (indexPath.row==_addressArray.count-1)
//        {
//            cell.lineView.hidden=YES;
//        }
//        else
//        {
//            cell.lineView.hidden=NO;
//        }
//        cell.selectionStyle=UITableViewCellSelectionStyleNone;
//        return cell;
//    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (tableView==_centerView.addressTable)
//    {
//        for (NSMutableDictionary *dict in _addressArray)
//        {
//            if ([[dict objectForKey:@"isSelected"] boolValue])
//            {
//                [dict setObject:[NSNumber numberWithBool:NO] forKey:@"isSelected"];
//            }
//        }
//        NSMutableDictionary *selectedDict=[_addressArray objectAtIndex:indexPath.row];
//        [selectedDict setObject:[NSNumber numberWithBool:YES] forKey:@"isSelected"];
//        [_centerView.addressTable reloadData];
//    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (tableView==_centerView.addressTable)
//    {
//        return 55;
//    }
//    else
    
    if(tableView ==_goodsTableView)
    {
        return 40;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (tableView==_centerView.addressTable)
//    {
//        return _addressArray.count;
//    }
//    else
    
    if(tableView == _goodsTableView)
    {
        return self.arrGoods.count;
    }
    
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    if (tableView==_centerView.addressTable)
//    {
//        return 1;
//    }
//    else
    
    if(tableView == _goodsTableView)
    {
        return 1;
    }
    return 0;
}


#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ((textField == _topView.nameTextField ||
        textField == _topView.phoneTextField) &&
        _supportRecieveMode == ReceiveModeDeliver) {
        return NO;
    }
    return YES;
}

-(void)textFieldDidChange:(NSNotification *)nsnotification
{
    if (_topView.phoneTextField.text.length>11)
    {
        _topView.phoneTextField.text=[_topView.phoneTextField.text substringToIndex:11];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//正则判断手机号码格式
-(BOOL)validatePhone:(NSString *)phone
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:phone] == YES)
        || ([regextestcm evaluateWithObject:phone] == YES)
        || ([regextestct evaluateWithObject:phone] == YES)
        || ([regextestcu evaluateWithObject:phone] == YES))
    {
        if([regextestcm evaluateWithObject:phone] == YES) {
            NSLog(@"China Mobile");
        } else if([regextestct evaluateWithObject:phone] == YES) {
            NSLog(@"China Telecom");
        } else if ([regextestcu evaluateWithObject:phone] == YES) {
            NSLog(@"China Unicom");
        } else {
            NSLog(@"Unknow");
        }
        
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark - onEventAction
-(void)onEventAction:(AppEventType)type object:(id)object
{
    [super onEventAction:type object:object];
    
    switch (type)
    {
        case UI_EVENT_USER_GET_SHOPPINGADRESS_SUCC:
        {
            if(((NSArray *)object).count>0)
            {
                _shipAddressArray=object;
                NSDictionary *dict=[_shipAddressArray firstObject];
                
                if (_curReciveMode == ReceiveModeDeliver) {
                    
                    NSInteger defaultShipId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"DefaultShipId"] integerValue];
                    
                    BOOL bContained = NO;
                    for (NSDictionary *d in _shipAddressArray) {
                        if ([d[@"id"] integerValue] == defaultShipId) {
                            _selectedAddress = d;
                            bContained = YES;
                            break;
                        }
                    }
                    
                    if (!bContained) {
                        _selectedAddress = dict;
                    }
                    
                    [self updateShipAddressView];
                }
            }
            else
            {
                _topView.nameTextField.text=[UserManager shareInstance].curUser.recentObtainName;
                _topView.phoneTextField.text=[UserManager shareInstance].curUser.recentObtainMobile;
                
                if (!_topView.nameTextField.text.length) {
                    _topView.nameTextField.text = [UserManager shareInstance].curUser.nickName;
                }
                if (!_topView.nameTextField.text.length) {
                    _topView.nameTextField.text = [UserManager shareInstance].curUser.mobileNumber;
                }
                if (!_topView.phoneTextField.text.length) {
                    _topView.phoneTextField.text = [UserManager shareInstance].curUser.mobileNumber;
                }

//                if (_curReciveMode == ReceiveModeDeliver) {
//                    [self resetAddressLabel];
//                }
            }
        }
            break;
        case UI_EVENT_USER_GET_SHOPPINGADRESS_FAILED:
        {
//            if (_curReciveMode == ReceiveModeDeliver) {
//                [self resetAddressLabel];
//            }
        }
            break;
        default:
            break;
    }
}




#pragma mark - RetrieveRequestDelegate

-(void)didRetrieveDataSuccess:(RetrieveRequest *)request
{
    if (request == _confirmOrderRequest) {
        [MBProgressHUD dismissHUD];
        
        if (_curReciveMode != ReceiveModeDeliver) {
            [UserManager shareInstance].curUser.recentObtainName = _topView.nameTextField.text;
            [UserManager shareInstance].curUser.recentObtainMobile = _topView.phoneTextField.text;
        }
        
        _dictOrderInfo = [_confirmOrderRequest fetchDataWithReformer:[[OrderDetailReformer alloc] init]];
        
        NSNumber *errCode = _dictOrderInfo[kOrderPropertyErrorCode];
        
        if (!errCode) {
            PayViewController *payViewController=[[PayViewController alloc]init];
            payViewController.dictOrderInfo = _dictOrderInfo;
            
            [self pushPayViewController:payViewController animated:YES];
        } else if (errCode.integerValue == ErrorGoodsLimit) {    //超过限购
            ListAlertView *listAlertView=[[ListAlertView  alloc]initWithArray:_dictOrderInfo[kOrderPropertyDetail]];
            listAlertView.delegate=self;
            listAlertView.alertType = AlertTypeLimit;
            [listAlertView show];
        } else if (errCode.integerValue == ErrorGoodsNotEnough) {    //剩余数量不足
            ListAlertView *listAlertView=[[ListAlertView  alloc]initWithArray:_dictOrderInfo[kOrderPropertyDetail]];
            listAlertView.alertType = AlertTypeNotEnough;
            listAlertView.delegate=self;
            [listAlertView show];
        }
    }
}

-(void)didRetrieveDataFailed:(RetrieveRequest *)request
{
    if (request == _confirmOrderRequest) {
        [MBProgressHUD showHUDAutoDismissWithString:@"生成订单失败" andDim:NO];
    }
}


-(void)didClickButton:(UIView *)listAlertView
{
    
}


@end
