//
//  EditPickUpAddressViewController.m
//  CookBook
//
//  Created by 你好 on 16/8/11.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "EditPickUpAddressViewController.h"
#import "NavView.h"
#import "MCAlertview.h"
#import "EditAddressTableCell.h"
#import "MBProgressHUD+Helper.h"
#import "UserManager.h"
#import "GroupsPropertyKeys.h"
#import "MBProgressHUD+Helper.h"
#import "RetrieveRequest.h"
#import "GlobalVar.h"

@interface EditPickUpAddressViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,MCALertviewDelegate,RetrieveRequestDelegate>

@end

@implementation EditPickUpAddressViewController
{
    NavView *_navView;
    UITableView *_tableView;
    NSMutableDictionary * _dictCopy;
    
    RetrieveRequest * _deleteRequest;
    RetrieveRequest * _editRequest;
    RetrieveRequest * _createRequest;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    
    _navView=[[NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    [_navView.leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_navView.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_navView.rightButton setTitle:@"完成" forState:UIControlStateNormal];
    [_navView.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_navView.rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navView];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    [self.view addSubview:_tableView];
    
    if (self.addressType==EditAddress)
    {
        _navView.centerLabel.text=@"修改临时自提点";

        CGRect rect=[_tableView rectForSection:0];
        UIButton *delButton=[UIButton buttonWithType:UIButtonTypeCustom];
        delButton.frame=CGRectMake(10, rect.origin.y+rect.size.height+40, ScreenWidth-20, 50);
        delButton.backgroundColor=RGBACOLOR(176, 116, 67, 1);
        [delButton setTitle:@"删除自提点" forState:UIControlStateNormal];
        [delButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [delButton addTarget:self action:@selector(delButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_tableView addSubview:delButton];
        
        _dictCopy = [self.dictOrg mutableCopy];
    } else if (self.addressType == CreateAddress){
        
        _navView.centerLabel.text=@"添加临时自提点";
        
        _dictCopy = [NSMutableDictionary dictionary];
    }
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];

}


-(void)deleteStorageRequest
{
    [MBProgressHUD showLoadingWithDim:YES];
    if (_deleteRequest) {
        [_deleteRequest cancel];
    }
    
    _deleteRequest = [[RetrieveRequest alloc] init];
    _deleteRequest.delegate = self;
    [_deleteRequest deleteRequestWithUrl:_dictCopy[kDispatcherPropertyUrl] andParam:nil];
}

-(void)createStorageRequest
{
    [MBProgressHUD showLoadingWithDim:YES];
    if (_createRequest) {
        [_createRequest cancel];
    }
    
    _createRequest = [[RetrieveRequest alloc] init];
    _createRequest.delegate = self;
    [_createRequest postRequestWithUrl:[GlobalVar shareGlobalVar].storagesUrl andParam:_dictCopy];
}

-(void)editStorageRequest
{
    [MBProgressHUD showLoadingWithDim:YES];
    if (_editRequest) {
        [_editRequest cancel];
    }
    
    _editRequest = [[RetrieveRequest alloc] init];
    _editRequest.delegate = self;
    [_editRequest patchRequestWithUrl:_dictCopy[kDispatcherPropertyUrl] andParam:_dictCopy];
}

-(BOOL)checkValueValid
{
    return YES;
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

#pragma mark - RetrieveRequestDelegate
-(void)didRetrieveDataSuccess:(RetrieveRequest *)request
{
    [MBProgressHUD dismissHUD];
    
    if (request == _deleteRequest) {
        if (self.deleteFinish) {
            self.deleteFinish(_dictCopy);
            self.deleteFinish = nil;
            
        }
    } else if (request == _createRequest) {
        if (self.createFinish) {
            self.createFinish(_dictCopy);
            self.createFinish = nil;
        }
    } else if (request == _editRequest) {
        if (self.editFinish) {
            self.editFinish(_dictCopy);
            self.editFinish = nil;
        }
    }
    
    self.editFinish = nil;
    self.createFinish = nil;
    self.deleteFinish = nil;
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)didRetrieveDataFailed:(RetrieveRequest *)request
{
    [MBProgressHUD showHUDAutoDismissWithError:request.error andDim:NO];
}

#pragma mark - UITextFieldDelegate

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    EditAddressTableCell *cell;
    if (IS_OS_8_OR_LATER)
    {
        cell = (EditAddressTableCell *)textField.superview.superview;
    }
    else
    {
        cell = (EditAddressTableCell *)textField.superview.superview.superview;
    }
    
    NSIndexPath *indexPath=[_tableView indexPathForCell:cell];
    
    if (indexPath.row==0)
    {
        [_dictCopy setObject:textField.text forKey:kDispatcherPropertyAddress];
    }
    else if (indexPath.row==1)
    {
        [_dictCopy setObject:textField.text forKey:kDispatcherPropertyMobile];
    }
}


-(void)textFieldDidChange:(NSNotification *)nsnotification
{
    UITextField *textField=nsnotification.object;
    
    EditAddressTableCell *cell;
    if (IS_OS_8_OR_LATER)
    {
        cell = (EditAddressTableCell *)textField.superview.superview;
    }
    else
    {
        cell = (EditAddressTableCell *)textField.superview.superview.superview;
    }
    
    NSIndexPath *indexPath=[_tableView indexPathForCell:cell];
    
    if (indexPath.row==0)
    {
        [_dictCopy setObject:textField.text forKey:kDispatcherPropertyAddress];
    }
    else if (indexPath.row==1)
    {
        if (textField.text.length>11)
        {
            textField.text=[textField.text substringToIndex:11];
        }
        [_dictCopy setObject:textField.text forKey:kDispatcherPropertyMobile];
    }
}


#pragma mark - UITableViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _tableView)
    {
        CGFloat sectionHeaderHeight = 10;
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0)
        {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        }
        else if (scrollView.contentOffset.y>=sectionHeaderHeight)
        {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cellID";
    EditAddressTableCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil)
    {
        cell=[[EditAddressTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    if (indexPath.row==0)
    {
        cell.titleLabel.text=@"发货地址";
        
        if (self.addressType==EditAddress)
        {
            cell.textField.text=_dictOrg[kDispatcherPropertyAddress];
        }
        else if(self.addressType==CreateAddress)
        {
            cell.textField.text=@"";
        }
        cell.textField.delegate=self;
    }
    else if (indexPath.row==1)
    {
        cell.titleLabel.text=@"联系方式";
        
        if (self.addressType==EditAddress)
        {
            cell.textField.text=_dictOrg[kDispatcherPropertyMobile];
        }
        else if(self.addressType==CreateAddress)
        {
            cell.textField.text=@"";
        }
        cell.textField.delegate=self;
        cell.textField.keyboardType=UIKeyboardTypeNumberPad;
    }
    else if (indexPath.row==2)
    {
        cell.titleLabel.text=@"取货时间";
        
        if (self.addressType==EditAddress)
        {
            cell.textField.text=@"以团主通知为准";
        }
        else if(self.addressType==CreateAddress)
        {
            cell.textField.text=@"以团主通知为准";
        }
        cell.textField.enabled=NO;
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    view.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}


#pragma mark - buttonClick

-(void)delButtonClick:(UIButton *)button
{
    MCAlertview *mcAlertView=[[MCAlertview alloc]initWithMessage:@"确认删除该自提点吗?" CancelButton:@"取消" andCancelBtnBackGround:nil OkButton:@"确定" andOkBtnColor:nil];
    mcAlertView.delegate=self;
    [mcAlertView show];
}

-(void)didClickWith:(UIView *)alertView  buttonAtIndex:(NSUInteger)buttonIndex
{
    if (buttonIndex==2)
    {
        [self deleteStorageRequest];
    }
    else if (buttonIndex==1)
    {
        
    }
}


-(void)leftButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightButtonClick:(UIButton *)button
{
    EditAddressTableCell *addressCell=[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    EditAddressTableCell *phoneCell=[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    if (addressCell.textField.text.length<=0)
    {
        [MBProgressHUD showHUDAutoDismissWithString:@"收货地址不能为空" andDim:NO];
    }
    else if ([self validatePhone:phoneCell.textField.text]==NO)
    {
        [MBProgressHUD showHUDAutoDismissWithString:@"联系方式格式不合法" andDim:NO];
    }
    else
    {
        if ([self checkValueValid]) {
            
            if (self.addressType==EditAddress)
            {
                [self editStorageRequest];
            }
            else if (self.addressType==CreateAddress)
            {
                [self createStorageRequest];
            }
        } else {
            
        }
    }
}


#pragma mark - onEventAction

-(void)onEventAction:(AppEventType)type object:(id)object
{
    [super onEventAction:type object:object];
    
    
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
