//
//  EditShopAddressViewController.m
//  CookBook
//
//  Created by 你好 on 16/6/12.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "EditShopAddressViewController.h"
#import "NavView.h"
#import "EditAddressTableCell.h"
#import "EditAddressTextViewCell.h"
#import "UserManager.h"
#import "MBProgressHUD+Helper.h"
#import "MCAlertview.h"
@interface EditShopAddressViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate,MCALertviewDelegate,UITextViewDelegate>

@end

@implementation EditShopAddressViewController
{
    NavView *_navView;
    UITableView *_tableView;
    NSString *_createString;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.rdv_tabBarController setTabBarHidden:YES animated:NO];
    
    self.view.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    
    _navView=[[NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navView.centerLabel.text=@"修改地址";
    [_navView.leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_navView.rightButton setTitle:@"保存" forState:UIControlStateNormal];
    [_navView.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
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
        _navView.centerLabel.text=@"修改地址";
        
        UIView *footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 169)];
        footView.backgroundColor=[UIColor clearColor];
        
        UIButton *deleteBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        deleteBtn.frame=CGRectMake(10, 60 , ScreenWidth-20, 49);
        deleteBtn.backgroundColor=RGBACOLOR(176, 116, 67, 1);
        [deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [deleteBtn setTitle:@"删除地址" forState:UIControlStateNormal];
        [deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [footView addSubview:deleteBtn];
        _tableView.tableFooterView=footView;
    }
    else if(self.addressType==CreateAddress)
    {
        _navView.centerLabel.text=@"添加新地址";
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

-(void)deleteBtnClick:(UIButton *)button
{
    MCAlertview *mcAlertView=[[MCAlertview alloc]initWithMessage:@"确认删除该地址吗?" CancelButton:@"取消" andCancelBtnBackGround:nil OkButton:@"确定" andOkBtnColor:nil];
    mcAlertView.delegate=self;
    [mcAlertView show];

}

-(void)didClickWith:(UIView *)alertView  buttonAtIndex:(NSUInteger)buttonIndex
{
    if (buttonIndex==2)
    {
        [MBProgressHUD showLoadingWithDim:YES];
        [[UserManager shareInstance]deleteShoppingAddressByID:self.dict[@"id"]];
    }
    else if (buttonIndex==1)
    {
        
    }
}

-(void)rightButtonClick:(UIButton *)button
{
    EditAddressTableCell *nameCell=[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    EditAddressTableCell *phoneCell=[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    EditAddressTextViewCell *textCell=[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    
    [nameCell.textField resignFirstResponder];
    [phoneCell.textField resignFirstResponder];
    [textCell.textView resignFirstResponder];
    
    if (nameCell.textField.text.length<=0)
    {
        [MBProgressHUD showHUDAutoDismissWithString:@"收货人不能为空" andDim:NO];
    }
    else if ([self validatePhone:phoneCell.textField.text]==NO)
    {
        [MBProgressHUD showHUDAutoDismissWithString:@"手机号码格式不合法" andDim:NO];
    }
    else if (textCell.textView.text.length<=0)
    {
        [MBProgressHUD showHUDAutoDismissWithString:@"收货地址不能为空" andDim:NO];
    }
    else
    {
        [MBProgressHUD showLoadingWithDim:YES];
        if (self.addressType==EditAddress)
        {
            self.dict[@"mob"] = phoneCell.textField.text;
            self.dict[@"name"] = nameCell.textField.text;
            self.dict[@"address"] = textCell.textView.text;
            
            [[UserManager shareInstance]updateShoppingAddress:phoneCell.textField.text andName:nameCell.textField.text andAddress:textCell.textView.text andAddressId:self.dict[@"id"]];
        }
        else if (self.addressType==CreateAddress)
        {
            [[UserManager shareInstance]createShoppingAddress:phoneCell.textField.text andName:nameCell.textField.text andAddress:textCell.textView.text];
        }
    }
}

-(void)leftButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
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
        [self.dict setObject:textField.text forKey:@"name"];
    }
    else if (indexPath.row==1)
    {
        [self.dict setObject:textField.text forKey:@"mob"];
    }
}


//-(void)didEndEditTextView:(UITextView *)textView
//{
//    if (self.addressType==EditAddress)
//    {
//        [self.dict setObject:textView.text forKey:@"address"];
//    }
//    else if (self.addressType==CreateAddress)
//    {
//        _createString=textView.text;
//    }
//}

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

    if (indexPath.row==1)
    {
        if (textField.text.length>11)
        {
            textField.text=[textField.text substringToIndex:11];
        }
    }
}

//#pragma mark - EditAddressTextViewCellDelegate
//
//-(void)didChangeTextViewSize:(CGRect)frame andDiff:(CGFloat)diff andTextView:(UITextView *)textView
//{
//    if (self.addressType==EditAddress)
//    {
//        [self.dict setObject:textView.text forKey:@"address"];
//    }
//    else if (self.addressType==CreateAddress)
//    {
//        _createString=textView.text;
//    }
//    
//    NSLog(@"%f",diff);
//    
//    if (diff > 0.01 || diff < -0.01)
//    {
//        [_tableView beginUpdates];
//        [_tableView endUpdates];
//        
////        if (_tableView.contentOffset.y+diff>=0 &&
////            _tableView.contentOffset.y+diff<=_tableView.contentSize.height) {
//            [_tableView setContentSize:CGSizeMake(_tableView.contentSize.width, _tableView.contentSize.height+diff)];
//            [_tableView setContentOffset:CGPointMake(_tableView.contentOffset.x, _tableView.contentOffset.y+diff) animated:YES];
////        }
//    }
//}


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
    if (indexPath.section==0)
    {
        static NSString *cellID=@"cellID";
        EditAddressTableCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil)
        {
            cell=[[EditAddressTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        
        if (indexPath.row==0)
        {
            cell.titleLabel.text=@"收货人";
            if (self.addressType==EditAddress)
            {
                cell.textField.text=self.dict[@"name"];
            }
            else
            {
                cell.textField.text=@"";
            }
        }
        else if (indexPath.row==1)
        {
            cell.titleLabel.text=@"联系电话";
            if (self.addressType==EditAddress)
            {
                cell.textField.text=self.dict[@"mob"];
            }
            else
            {
                cell.textField.text=@"";
            }
            cell.textField.keyboardType=UIKeyboardTypeNumberPad;
        }
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.section==1)
    {
        static NSString *cellID=@"cellIDE";
        EditAddressTextViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil)
        {
            cell=[[EditAddressTextViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.titleLabel.text=@"收货地址";
//        [cell configData:self.dict andType:self.addressType];
//        cell.delegate=self;
  
        if (self.addressType==EditAddress)
        {
            cell.textView.text=self.dict[@"address"];
        }
        else
        {
            cell.textView.text=@"";
        }
        cell.textView.delegate=self;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
        view.backgroundColor=RGBACOLOR(230, 230, 230, 1);
        return view;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        return 10;
    }
    return 0;
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
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1)
    {
//        EditAddressTextViewCell *cell = [[EditAddressTextViewCell alloc]init];
//        CGSize size=CGSizeZero;
//        if (self.addressType==EditAddress)
//        {
//            size = [cell getFitStringTextSize:self.dict[@"address"]];
//        }
//        else if (self.addressType==CreateAddress)
//        {
//            size = [cell getFitStringTextSize:_createString];
//        }
//        return size.height+5;
        return 80;
    }
    else
    {
        return 50;
    }
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


-(void)onEventAction:(AppEventType)type object:(id)object
{
    [super onEventAction:type object:object];

    
    switch (type) {
        case UI_EVENT_USER_CREATE_ADDRESS_FAILED:
        {
            [MBProgressHUD showHUDAutoDismissWithString:@"添加失败" andDim:NO];
        }
            break;
        case UI_EVENT_USER_UPDATE_ADDRESS_FAILED:
        {
            [MBProgressHUD showHUDAutoDismissWithString:@"保存失败" andDim:NO];
        }
            break;
        case UI_EVENT_USER_DELETE_ADDRESS_FAILED:
        {
            [MBProgressHUD showHUDAutoDismissWithString:@"删除失败" andDim:NO];
        }
            break;
        case UI_EVENT_USER_UPDATE_ADDRESS_SUCC:
        {
            [MBProgressHUD dismissHUD];
            
            if (self.editFinish) {
                self.editFinish(self.dict);
                self.editFinish = nil;
            }
            self.deleteFinish = nil;
            
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case UI_EVENT_USER_DELETE_ADDRESS_SUCC:
        {
            [MBProgressHUD dismissHUD];
            
            if (self.deleteFinish) {
                self.deleteFinish(self.dict);
                self.deleteFinish = nil;
            }
            self.editFinish = nil;
            
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case UI_EVENT_USER_CREATE_ADDRESS_SUCC:
        {
            [MBProgressHUD dismissHUD];
            
            if (self.createFinish) {
                self.createFinish();
                self.createFinish = nil;
            }
            
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        default:
            break;
    }
}


-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
