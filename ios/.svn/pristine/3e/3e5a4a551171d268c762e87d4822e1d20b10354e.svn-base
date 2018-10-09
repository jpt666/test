//
//  MixAddressViewController.m
//  CookBook
//
//  Created by 你好 on 16/9/6.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "MixAddressViewController.h"
#import "NavView.h"
#import "PickUpAddressView.h"
#import "CommentPointView.h"
#import "CommentPointTableCell.h"
#import "SendOutTableViewCell.h"
#import "UpdateCommentPointViewController.h"
#import "UserManager.h"
#import "EditShopAddressViewController.h"
#import "MBProgressHUD+Helper.h"
#import "UnEditTextView.h"
@interface MixAddressViewController ()<PickUpAddressViewDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>

@end

@implementation MixAddressViewController
{
    NavView *_navView;
    PickUpAddressView *_pickUpAddressView;
    UIScrollView *_contetnScrollView;
    UITableView *_commentTableView;
    UITableView *_sendOutTableView;
    UIButton *_bottomButton;
    CommentPointView *_commentPointView;
//    NSMutableArray *_commentPointArray;
    NSMutableArray *_shopAddressArray;
    UILabel *_alertLabel;
    
    NSString * _selectedName;
    NSString * _selectedMobile;
    
    NSDictionary * _selectedPickUp;
    NSDictionary * _selectedSendOut;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    _commentPointArray=[[NSMutableArray alloc]initWithCapacity:0];
//    _shopAddressArray=[[NSMutableArray alloc]initWithCapacity:0];
    
    
    _navView=[[NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navView.centerLabel.text=@"选择地址";
    [_navView.rightButton setTitle:@"完成" forState:UIControlStateNormal];
    [_navView.rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_navView.leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_navView.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navView];
    
    _pickUpAddressView=[[PickUpAddressView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, 50)];
    _pickUpAddressView.layer.borderWidth=0.5;
    _pickUpAddressView.delegate=self;
    _pickUpAddressView.layer.borderColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.3].CGColor;
    _pickUpAddressView.leftButton.selected=YES;
    [_pickUpAddressView configViewForOrder:self.dict];
    [self.view addSubview:_pickUpAddressView];
    
    _contetnScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 114, ScreenWidth, ScreenHeight-114)];
    _contetnScrollView.showsHorizontalScrollIndicator=NO;
    _contetnScrollView.showsVerticalScrollIndicator=NO;
    _contetnScrollView.bounces=NO;
    _contetnScrollView.pagingEnabled=YES;
    _contetnScrollView.delegate=self;
    _contetnScrollView.contentSize=CGSizeMake(_contetnScrollView.bounds.size.width*2, _contetnScrollView.bounds.size.height);
    [self.view addSubview:_contetnScrollView];
    
    
    _selectedName = [UserManager shareInstance].curUser.recentObtainName;
    _selectedMobile = [UserManager shareInstance].curUser.recentObtainMobile;
    
    _commentPointView=[[CommentPointView alloc]initWithFrame:CGRectMake(0, 0, _contetnScrollView.bounds.size.width, 50)];
    _commentPointView.backgroundColor=RGBACOLOR(255, 255, 194, 1);
    _commentPointView.consigneeLabel.text=_selectedName;
    _commentPointView.phoneLabel.text= _selectedMobile;
    _commentPointView.layer.borderWidth=0.5;
    _commentPointView.layer.borderColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.3].CGColor;
    [_contetnScrollView addSubview:_commentPointView];
    
    _commentTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 50, _contetnScrollView.bounds.size.width,_contetnScrollView.bounds.size.height-50) style:UITableViewStylePlain];
    _commentTableView.dataSource=self;
    _commentTableView.delegate=self;
    _commentTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _commentTableView.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    [_contetnScrollView addSubview:_commentTableView];
    
    _alertLabel=[[UILabel alloc]initWithFrame:CGRectMake(_contetnScrollView.bounds.size.width, 0, _contetnScrollView.bounds.size.width, _contetnScrollView.bounds.size.height-49)];
    _alertLabel.text=@"还没有收货地址,赶快添加一个吧";
    _alertLabel.textAlignment=NSTextAlignmentCenter;
    _alertLabel.hidden=YES;
    [_contetnScrollView addSubview:_alertLabel];
    
    _sendOutTableView=[[UITableView alloc]initWithFrame:CGRectMake(_contetnScrollView.bounds.size.width, 0, _contetnScrollView.bounds.size.width, _contetnScrollView.bounds.size.height-49) style:UITableViewStylePlain];
    _sendOutTableView.dataSource=self;
    _sendOutTableView.delegate=self;
    _sendOutTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _sendOutTableView.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    [_contetnScrollView addSubview:_sendOutTableView];
    
    _bottomButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _bottomButton.frame=CGRectMake(_contetnScrollView.bounds.size.width, _contetnScrollView.bounds.size.height-49, _contetnScrollView.bounds.size.width, 49);
    _bottomButton.backgroundColor=RGBACOLOR(176, 116, 67, 1);
    [_bottomButton setTitle:@"添加新地址" forState:UIControlStateNormal];
    [_bottomButton addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_contetnScrollView addSubview:_bottomButton];
    
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    tapGesture.numberOfTapsRequired=1;
    tapGesture.numberOfTouchesRequired=1;
    [_commentPointView addGestureRecognizer:tapGesture];
    
    if ([self.dict[kGroupsPropertyRecieveMode] integerValue]==ReceiveModePickUp)
    {
        [_contetnScrollView scrollRectToVisible:CGRectMake(0, 0, _contetnScrollView.bounds.size.width, _contetnScrollView.bounds.size.height) animated:NO];
        _contetnScrollView.scrollEnabled=NO;
    }
    else if ([self.dict[kGroupsPropertyRecieveMode] integerValue]==ReceiveModeDeliver)
    { 
        [_contetnScrollView scrollRectToVisible:CGRectMake(_contetnScrollView.bounds.size.width, 0,_contetnScrollView.bounds.size.width, _contetnScrollView.bounds.size.height) animated:NO];
        _contetnScrollView.scrollEnabled=NO;
        [[UserManager shareInstance]getShopAddress];
    }
    else if ([self.dict[kGroupsPropertyRecieveMode] integerValue]==ReceiveModePickUpAndDeliver)
    {
        _contetnScrollView.scrollEnabled=YES;
        [[UserManager shareInstance]getShopAddress];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_shopAddressArray.count>0)
    {
        [_contetnScrollView bringSubviewToFront:_sendOutTableView];
    }
    else
    {
        [_contetnScrollView bringSubviewToFront:_alertLabel];
    }
    [_sendOutTableView reloadData];
}


-(void)bottomButtonClick:(UIButton *)button
{
    EditShopAddressViewController *editShopAddressVC=[[EditShopAddressViewController alloc]init];
    editShopAddressVC.addressType=CreateAddress;
    editShopAddressVC.createFinish = ^(){
        [[UserManager shareInstance] getShopAddress];
    };
    [self.navigationController pushViewController:editShopAddressVC animated:YES];
}

-(void)tapGesture:(UITapGestureRecognizer *)tapGesture
{
    UpdateCommentPointViewController *updateComPointVC=[[UpdateCommentPointViewController alloc]init];
    updateComPointVC.name = _commentPointView.consigneeLabel.text;
    updateComPointVC.mobile = _commentPointView.phoneLabel.text;
    updateComPointVC.saveEdit = ^(NSString *name, NSString * mobile) {
        _selectedName = name;
        _selectedMobile = mobile;
        _commentPointView.consigneeLabel.text = _selectedName;
        _commentPointView.phoneLabel.text = _selectedMobile;
    };
    
    [self.navigationController pushViewController:updateComPointVC animated:YES];
}

-(void)editButtonClick:(UIButton *)button
{
    NSMutableDictionary *dict=[_shopAddressArray objectAtIndex:button.tag-1];
    EditShopAddressViewController *editShopAddressVC=[[EditShopAddressViewController alloc]init];
    editShopAddressVC.addressType=EditAddress;
    editShopAddressVC.dict=[dict mutableCopy];
    editShopAddressVC.editFinish = ^(NSMutableDictionary * dict) {
        for (NSMutableDictionary *d in _shopAddressArray) {
            if ([d[@"id"] integerValue] == [dict[@"id"] integerValue]) {
                [_shopAddressArray replaceObjectAtIndex:[_shopAddressArray indexOfObject:d] withObject:dict];
                break;
            }
        }
        if ([dict[@"id"] integerValue] == [_selectedSendOut[@"id"] integerValue]) {
            _selectedSendOut = dict;
        }
        
        [_sendOutTableView reloadData];
    };
    editShopAddressVC.deleteFinish = ^(NSMutableDictionary *dict) {
        
        for (NSMutableDictionary *d in _shopAddressArray) {
            if ([d[@"id"] integerValue] == [dict[@"id"] integerValue]) {
                [_shopAddressArray removeObject:d];
                break;
            }
        }
        if ([dict[@"id"] integerValue] == [_selectedSendOut[@"id"] integerValue]) {
            _selectedSendOut = nil;
        }
        
        if (_shopAddressArray.count>0)
        {
            _alertLabel.hidden=YES;
            [_contetnScrollView bringSubviewToFront:_sendOutTableView];
        }
        else
        {
            _alertLabel.hidden=NO;
            [_contetnScrollView bringSubviewToFront:_alertLabel];
        }
        
        [_sendOutTableView reloadData];
    };
    [self.navigationController pushViewController:editShopAddressVC animated:YES];
}

-(void)rightButtonClick:(UIButton *)button
{
    if (self.selecetAddrCompleted) {
        
        ReceiveMode recieveMode = ReceiveModeNone;
        NSDictionary *dictInfo = nil;
        if (_selectedSendOut && _selectedPickUp) {
            recieveMode = ReceiveModeNone;
        } else if (_selectedSendOut) {
            recieveMode = ReceiveModeDeliver;
            dictInfo = _selectedSendOut;
        } else if (_selectedPickUp) {
            recieveMode = ReceiveModePickUp;
            dictInfo = _selectedPickUp;
        }
        self.selecetAddrCompleted(recieveMode, dictInfo, _selectedName, _selectedMobile, _shopAddressArray);
        self.selecetAddrCompleted = nil;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView==_contetnScrollView)
    {
       if ([self.dict[kGroupsPropertyRecieveMode] integerValue]==ReceiveModePickUpAndDeliver)
       {
           int index=scrollView.contentOffset.x/ScreenWidth;
           if (index==0)
           {
               [_pickUpAddressView setLeftButtonSeleted];
           }
           else if (index==1)
           {
               [_pickUpAddressView setRightButtonSeleted];
           }
       }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_commentTableView)
    {
        static NSString *cellID=@"cellID";
        CommentPointTableCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil)
        {
            cell=[[CommentPointTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        NSDictionary *dict=[self.dict[kGroupsPropertyDispatchers] objectAtIndex:indexPath.row];
        [cell configData:dict];
        cell.addressTextView.delegate=self;
        cell.addressTextView.indexPath=indexPath;
        [cell setChecked:(dict==_selectedPickUp)?YES:NO];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (tableView==_sendOutTableView)
    {
        static NSString *cellIDE=@"cellIDE";
        SendOutTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIDE];
        if (cell==nil)
        {
            cell=[[SendOutTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIDE];
            [cell.bottomButton addTarget:self action:@selector(editButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        NSDictionary *dict=[_shopAddressArray objectAtIndex:indexPath.row];
        [cell configData:dict];
        [cell setChecked:(dict==_selectedSendOut)?YES:NO];
        
        cell.bottomButton.tag=indexPath.row+1;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_commentTableView)
    {
        return 90;
    }
    else if (tableView==_sendOutTableView)
    {
        return 100;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_commentTableView)
    {
        return [self.dict[kGroupsPropertyDispatchers] count];
    }
    else if (tableView==_sendOutTableView)
    {
        return _shopAddressArray.count;
    }
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_commentTableView) {
        NSDictionary *dict=[self.dict[kGroupsPropertyDispatchers] objectAtIndex:indexPath.row];
        if (dict == _selectedPickUp) {
            _selectedPickUp = nil;
            [_commentTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        } else {
            _selectedPickUp = dict;
            [_commentTableView reloadData];
//            _selectedSendOut = nil;
//            [_sendOutTableView reloadData];
        }

    } else  if (tableView == _sendOutTableView) {
        
        NSDictionary *dict=[_shopAddressArray objectAtIndex:indexPath.row];
        
        if (dict == _selectedSendOut) {
            _selectedSendOut = nil;
            [_sendOutTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        } else {
            _selectedSendOut = dict;
//            _selectedPickUp = nil;
//            [_commentTableView reloadData];
            [_sendOutTableView reloadData];
        }
    }
}

-(BOOL)textViewShouldBeginEditing:(UnEditTextView *)textView
{
    NSDictionary *dict=[self.dict[kGroupsPropertyDispatchers] objectAtIndex:textView.indexPath.row];
    if (dict == _selectedPickUp) {
        _selectedPickUp = nil;
        [_commentTableView reloadRowsAtIndexPaths:@[textView.indexPath] withRowAnimation:UITableViewRowAnimationNone];
    } else {
        _selectedPickUp = dict;
        [_commentTableView reloadData];
    }
    return NO;
}



-(void)fixedButtonClick:(PickUpAddressView *)pickUpView
{
    _selectedSendOut = nil;
    [_sendOutTableView reloadData];
    [_contetnScrollView scrollRectToVisible:CGRectMake(0, 0, _contetnScrollView.bounds.size.width, _contetnScrollView.bounds.size.height) animated:YES];
}

-(void)tempButtonClick:(PickUpAddressView *)pickUpView
{
    _selectedPickUp = nil;
    [_commentTableView reloadData];
    [_contetnScrollView scrollRectToVisible:CGRectMake(_contetnScrollView.bounds.size.width, 0,_contetnScrollView.bounds.size.width, _contetnScrollView.bounds.size.height) animated:YES];
}

-(void)leftButtonClick:(UIButton *)button
{
    if (self.cancelSelect) {
        self.cancelSelect(_shopAddressArray);
        self.cancelSelect = nil;
    }
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - onEventAction
-(void)onEventAction:(AppEventType)type object:(id)object
{
    [super onEventAction:type object:object];
    
    switch (type)
    {
        case UI_EVENT_USER_GET_SHOPPINGADRESS_SUCC:
        {
            _shopAddressArray=object;
            if (_shopAddressArray.count>0)
            {
                _alertLabel.hidden=YES;
                [_contetnScrollView bringSubviewToFront:_sendOutTableView];
            }
            else
            {
                _alertLabel.hidden=NO;
                [_contetnScrollView bringSubviewToFront:_alertLabel];
            }
            [_sendOutTableView reloadData];
        }
            break;
        case UI_EVENT_USER_GET_SHOPPINGADRESS_FAILED:
        {
            [MBProgressHUD showHUDAutoDismissWithError:object andDim:NO];
        }
            break;
        default:
            break;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
