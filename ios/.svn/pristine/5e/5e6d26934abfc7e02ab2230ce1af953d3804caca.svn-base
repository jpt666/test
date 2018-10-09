//
//  RegisterViewController.m
//  Gopeer
//
//  Created by 你好 on 15/10/26.
//  Copyright © 2015年 xyxNav. All rights reserved.
//

#import "RegisterViewController.h"
#import "NavView.h"
#import "PwdTableViewCell.h"
#import "UserInfo.h"
#import "UserManager.h"
#import "SFHFKeychainUtils.h"
#import "PhotoViewController.h"
#import "MBProgressHUD+Helper.h"
//#import "MBLoadingView.h"
//#import "GetVerCodeViewController.h"
//#import "JSONKit.h"
//#import "GetVerCodeViewController.h"
//#import "UserManager.h"
//#import "ServerErrorCode.h"
//#import "PrivateViewController.h"
//#import "WCAlertview.h"
@interface RegisterViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

@end

@implementation RegisterViewController
{
    NavView *_navView;
    UITableView *_tableView;
//    UITextField *_phoneNumTextField;
    UIButton *_registerBtn;
    UILabel *_alertLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    
    _navView=[[NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    [_navView.leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _navView.centerLabel.text=@"注册";
    [_navView.leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_navView.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navView];
    
   
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStyleGrouped];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.rowHeight=60;
    [self.view addSubview:_tableView];
    
    
//    _phoneNumTextField=[[UITextField alloc]initWithFrame:CGRectMake(10, 0, ScreenWidth-20, 55)];
//    _phoneNumTextField.autocapitalizationType=UITextAutocapitalizationTypeNone;
//    _phoneNumTextField.autocorrectionType=UITextAutocorrectionTypeNo;
//    _phoneNumTextField.delegate=self;
//    _phoneNumTextField.placeholder=@" 请输入手机号";
//    _phoneNumTextField.keyboardType=UIKeyboardTypeNumberPad;
//    _phoneNumTextField.returnKeyType=UIReturnKeyDone;
//    _phoneNumTextField.clearButtonMode=UITextFieldViewModeAlways;
//    _phoneNumTextField.tintColor=[UIColor lightGrayColor];
//    _phoneNumTextField.backgroundColor=[UIColor whiteColor];
//    [topView addSubview:_phoneNumTextField];

    
    CGRect rect=[_tableView rectForSection:0];

    
    _registerBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _registerBtn.frame=CGRectMake(10, rect.origin.y+rect.size.height, ScreenWidth-20, 50);
    _registerBtn.backgroundColor=[UIColor lightGrayColor];
    _registerBtn.enabled=NO;
    [_registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    _registerBtn.layer.cornerRadius=5;
    [_registerBtn addTarget:self action:@selector(registerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_tableView addSubview:_registerBtn];
    
    
    _alertLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, _registerBtn.frame.size.height+_registerBtn.frame.origin.y+20, ScreenWidth-20, 30)];
    _alertLabel.backgroundColor=[UIColor clearColor];
    _alertLabel.userInteractionEnabled=YES;
    _alertLabel.font=[UIFont systemFontOfSize:12];
    [_tableView addSubview:_alertLabel];
    
    NSString *string=@"注册代表你同意一家一农隐私协议";
    NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:string];
    [str setAttributes:@{NSForegroundColorAttributeName:RGBACOLOR(12, 139, 70, 1),NSUnderlineStyleAttributeName:[NSNumber numberWithInt:NSUnderlineStyleSingle]} range:NSMakeRange(7, string.length-7)];
    _alertLabel.attributedText=str;
    
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    tapGesture.numberOfTapsRequired=1;
    tapGesture.numberOfTouchesRequired=1;
    [self.view addGestureRecognizer:tapGesture];
    
    
    

    

//    UITapGestureRecognizer *tapGestureForLabel=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureForLabel:)];
//    tapGestureForLabel.numberOfTapsRequired=1;
//    tapGestureForLabel.numberOfTouchesRequired=1;
//    [_alertLabel addGestureRecognizer:tapGestureForLabel];
 
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
//    UIView *firstResponder = [keyWindow performSelector:@selector(firstResponder)];
//    [firstResponder resignFirstResponder];
}


#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cellID";
    PwdTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil)
    {
        cell=[[PwdTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.titleLabel.frame=CGRectZero;
    if (indexPath.row==0)
    {
        cell.textField.placeholder=@"手机号";
    }
    else if (indexPath.row==1)
    {
        cell.textField.placeholder=@"密码";
    }
    else if (indexPath.row==2)
    {
        cell.textField.placeholder=@"昵称";
    }
//    else if (indexPath.row==3)
//    {
//        cell.textField.placeholder=@"邮箱地址";
//    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        return 15;
    }
    else
    {
        return CGFLOAT_MIN;
    }
}



#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidChange:(NSNotification *)nsnotification
{
    PwdTableViewCell *cell1=[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    PwdTableViewCell *cell2=[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
//    PwdTableViewCell *cell3=[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
//    PwdTableViewCell *cell4=[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    if (cell1.textField.text.length > 11)
    {
        cell1.textField.text = [cell1.textField.text substringToIndex:11];
    }
    
    
    if (cell2.textField.text.length>15)
    {
        cell2.textField.text=[cell2.textField.text substringToIndex:15];
    }
    
    if (([self validatePhone:cell1.textField.text])&&(cell2.textField.text.length>=6))
    {
        _registerBtn.enabled=YES;
        _registerBtn.backgroundColor=RGBACOLOR(176, 116, 67, 1);
    }
    else
    {
        _registerBtn.enabled=NO;
        _registerBtn.backgroundColor=[UIColor lightGrayColor];
    }
}

-(void)tapGestureForLabel:(UITapGestureRecognizer *)tapGestureForLabel
{
//    PrivateViewController *privateVC=[[PrivateViewController alloc]init];
//    [self.navigationController pushViewController:privateVC animated:YES];
}

-(void)tapGesture:(UITapGestureRecognizer *)tapGesture
{
//    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
//    UIView *firstResponder = [keyWindow performSelector:@selector(firstResponder)];
//    [firstResponder resignFirstResponder];
}


-(void)registerBtnClick:(UIButton *)button
{
    PwdTableViewCell *cell1=[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    PwdTableViewCell *cell2=[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    PwdTableViewCell *cell3=[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
//    PwdTableViewCell *cell4=[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    NSDictionary *dict=@{@"tel":cell1.textField.text,@"password":cell2.textField.text,@"nickname":cell3.textField.text,@"userid":cell1.textField.text};
//    [MBLoadingView showLoadingViewWithDimBackground:YES];
    [MBProgressHUD showLoadingWithDim:YES];
    
    [[UserManager shareInstance] registerWithInfo:dict withPassword:cell2.textField.text];
    
//    [AFHttpTool requestWithMethod:RequestMethodTypePost url:SERVER_REGISTER_USER params:dict success:^(id response) {
//        [MBLoadingView hideLoadingView];
//        if ([[response objectForKey:@"code"] integerValue]==0)
//        {
//            NSDictionary *dict=[response objectForKey:@"result"];
//            UserInfo *userInfo=[[UserInfo alloc]init];
//            userInfo.userId=[dict objectForKey:@"userid"];
//            userInfo.nickName=[dict objectForKey:@"nickname"];
//            userInfo.registerTime=[[dict objectForKey:@"update_at"] longLongValue];
//            userInfo.photoUrl = [dict objectForKey:@"photoUrl"];
//            [UserManager shareInstance].curUser=userInfo;
//            [UserManager shareInstance].curUser.userId=[dict objectForKey:@"userid"];
//            [UserManager shareInstance].bIsLogin=YES;
//            [UserManager shareInstance].curUser.sessionId=dict[@"session_id"];
//            
//            [SFHFKeychainUtils  storeUsername:userInfo.userId andPassword:cell2.textField.text forServiceName:SERVER_HOST updateExisting:YES error:nil];
//            NSMutableDictionary *dictory=[NSMutableDictionary dictionary];
//            [dictory setObject:[dict objectForKey:@"userid"] forKey:@"userid"];
//            [dictory setObject:[dict objectForKey:@"session_id"] forKey:@"session_id"];
//            [[NSUserDefaults standardUserDefaults] setObject:dictory forKey:@"UserInfo"];
//            
//            [self.navigationController popToRootViewControllerAnimated:YES];
//        }
//        else
//        {
//            NSLog(@"%@",[response objectForKey:@"message"]);
//            WCAlertview *alertView=[[WCAlertview alloc]initWithTitle:nil WithMessage:[response objectForKey:@"message"] CancelButton:nil OkButton:@"确定"];
//            [alertView show];
//        }
//    } failure:^(NSError *err) {
//        [MBLoadingView hideLoadingView];
//        WCAlertview *alertView=[[WCAlertview alloc]initWithTitle:nil WithMessage:err.description CancelButton:nil OkButton:@"确定"];
//        [alertView show];
//    }];
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length>0)
    {
        return [self validateNumber:string];
    }
    else
    {
        return YES;
    }
}



-(BOOL)validateNumber:(NSString *)string
{
    NSString *str=@"^[0-9]";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    if ([regextestmobile evaluateWithObject:string])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


-(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
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


-(void)leftButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
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

- (void)onEventAction:(AppEventType)type object:(id)object
{
    [super onEventAction:type object:object];
    
    switch (type) {
        case UI_EVENT_USER_REGIST_SUCC:
//            [MBLoadingView hideLoadingView];
            [MBProgressHUD dismissHUD];
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
        case UI_EVENT_USER_REGIST_FAILED:
        {
//            [MBLoadingView hideLoadingView];
            [MBProgressHUD dismissHUD];
            NSError *err = (NSError *)object;
            WCAlertview *alertView=[[WCAlertview alloc]initWithTitle:nil WithMessage:err.localizedDescription CancelButton:nil OkButton:@"确定"];
            [alertView show];
        }
            break;
        default:
            break;
    }
}

@end
