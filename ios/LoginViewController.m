//
//  LoginViewController.m
//  Gopeer
//
//  Created by 你好 on 15/10/26.
//  Copyright © 2015年 xyxNav. All rights reserved.
//

#import "LoginViewController.h"
#import "NavView.h"
#import <AFNetworking.h>
#import "UserManager.h"
#import "PwdTableViewCell.h"
#import "WXApiRequestHandler.h"
#import "BindMobViewController.h"
#import "WXApiManager.h"
#import "MBProgressHUD+Helper.h"
#import "GreedTimer.h"
#define WXAUTH_ERR_OK  0
#define WXAUTH_ERR_AUTH_DENIED  -4
#define WXAUTH_ERR_USER_CANCEL  -2

@interface LoginViewController ()<UITextFieldDelegate, WXApiManagerDelegate>

@end

@implementation LoginViewController
{
    NavView *_navView;
    UIButton *_loginBtn;
    UITextField *_phoneTextField;
    UITextField *_verificateTextFiled;
    UIView *_phoneBackView;
    UIView *_verCodeView;
    
    UIButton * _getCodeBtn;
    
//    dispatch_source_t _timer;
    GRTimer * _timer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    [self.navigationController setNavigationBarHidden:YES];
    
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    
    _navView=[[NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    [_navView.leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_navView.leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_navView.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _navView.centerLabel.text=@"登录";
    _navView.rightButton.titleLabel.font=[UIFont systemFontOfSize:16];
    [self.view addSubview:_navView];
    
    _phoneBackView=[[UIView alloc]initWithFrame:CGRectMake(0, 74, ScreenWidth, 50.5)];
    _phoneBackView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_phoneBackView];
    
    _verCodeView=[[UIView alloc]initWithFrame:CGRectMake(0, _phoneBackView.frame.origin.y+_phoneBackView.frame.size.height, ScreenWidth, 50.5)];
    _verCodeView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_verCodeView];
    
    UILabel *phoneLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, 50)];
    phoneLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e"];
    phoneLabel.text=@"手机号";
    phoneLabel.font=[UIFont systemFontOfSize:16];
    [_phoneBackView addSubview:phoneLabel];
    
    _phoneTextField=[[UITextField alloc]initWithFrame:CGRectMake(phoneLabel.frame.origin.x+phoneLabel.frame.size.width, 0, ScreenWidth-180, 50)];
    _phoneTextField.autocorrectionType=UITextAutocorrectionTypeNo;
    _phoneTextField.autocapitalizationType=UITextAutocapitalizationTypeNone;
    _phoneTextField.keyboardType=UIKeyboardTypeNumberPad;
    _phoneTextField.placeholder=@"请输入手机号";
    _phoneTextField.tintColor=[UIColor lightGrayColor];
    [_phoneBackView addSubview:_phoneTextField];
    
    _getCodeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _getCodeBtn.frame=CGRectMake(ScreenWidth-95, 12 , 85, 26);
    _getCodeBtn.layer.cornerRadius=5;
    _getCodeBtn.backgroundColor=RGBACOLOR(176, 116, 67, 1);
    [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _getCodeBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [_getCodeBtn addTarget:self action:@selector(getCodeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_phoneBackView addSubview:_getCodeBtn];
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(10, _phoneBackView.frame.origin.y+_phoneBackView.frame.size.height, ScreenWidth-20, 0.5)];
    lineView.backgroundColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.3];
    [self.view addSubview:lineView];
    
    UILabel *verificateLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, 50)];
    verificateLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e"];
    verificateLabel.text=@"验证码";
    verificateLabel.font=[UIFont systemFontOfSize:16];
    [_verCodeView addSubview:verificateLabel];
    
    _verificateTextFiled=[[UITextField alloc]initWithFrame:CGRectMake(verificateLabel.frame.origin.x+verificateLabel.frame.size.width, verificateLabel.frame.origin.y, ScreenWidth-100, 50)];
    _verificateTextFiled.clearButtonMode=UITextFieldViewModeWhileEditing;
    _verificateTextFiled.autocorrectionType=UITextAutocorrectionTypeNo;
    _verificateTextFiled.autocapitalizationType=UITextAutocapitalizationTypeNone;
    _verificateTextFiled.placeholder=@"请输入验证码";
    _verificateTextFiled.keyboardType=UIKeyboardTypeNumberPad;
    _verificateTextFiled.tintColor=[UIColor lightGrayColor];
    [_verCodeView addSubview:_verificateTextFiled];
    
    _loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _loginBtn.frame=CGRectMake(10, _verCodeView.frame.origin.y+_verCodeView.frame.size.height+60, ScreenWidth-20, 50);
    _loginBtn.enabled=NO;
    _loginBtn.backgroundColor=[UIColor lightGrayColor];
    [_loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    
    UIImage *lineLeftImage=[UIImage imageNamed:@"moreline_left"];
    UIImage *lineRightImage=[UIImage imageNamed:@"moreline_right"];
    UIImage *weixinLoginImage=[UIImage imageNamed:@"weixinLogin_icon"];

    if ([WXApi isWXAppInstalled])
    {
        UILabel *bottomLabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-40, ScreenHeight-weixinLoginImage.size.height-60,80,30)];
        bottomLabel.text=@"快捷登录";
        bottomLabel.textAlignment=NSTextAlignmentCenter;
        [self.view addSubview:bottomLabel];
        
        UIImageView *leftImageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, bottomLabel.frame.origin.y+(30-lineLeftImage.size.height)/2, ScreenWidth/2-55, lineLeftImage.size.height)];
        leftImageView.image=lineLeftImage;
        [self.view addSubview:leftImageView];
        
        UIImageView *rightImageView=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2+40, bottomLabel.frame.origin.y+(30-lineRightImage.size.height)/2, ScreenWidth/2-55, lineRightImage.size.height)];
        rightImageView.image=lineRightImage;
        [self.view addSubview:rightImageView];
        
        UIButton *weixinLoginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        weixinLoginBtn.frame=CGRectMake((ScreenWidth-weixinLoginImage.size.width)/2, bottomLabel.frame.origin.y+bottomLabel.frame.size.height+10, weixinLoginImage.size.width, weixinLoginImage.size.height);
        [weixinLoginBtn setImage:weixinLoginImage forState:UIControlStateNormal];
        [weixinLoginBtn addTarget:self action:@selector(weixinLoginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:weixinLoginBtn];
    }
    
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    tapGesture.numberOfTapsRequired=1;
    tapGesture.numberOfTouchesRequired=1;
    [self.view addGestureRecognizer:tapGesture];
}


-(void)tapGestureForLabel:(UITapGestureRecognizer *)tapGesture
{
//    PwdTableViewCell *cell1=[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
//    RetrievePwdViewController *retrievePwdVC=[[RetrievePwdViewController alloc]init];
//    if (cell1.textField.text.length>0)
//    {
//        retrievePwdVC.tel=cell1.textField.text;
//    }
//    [self.navigationController pushViewController:retrievePwdVC animated:YES];
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

-(void)startTime
{
    _timer = [[GRTimer alloc] init];
    _timer.timeInBackground = YES;
    _timer.start = 0;
    _timer.interval = 1;
    _timer.repeats = YES;
    
    __weak __typeof(GRTimer *)weakTimer = _timer;
    __weak __typeof(self) wSelf = self;
    _timer.action = ^{
        [wSelf timerChanged:weakTimer];
    };
    
    [[GRTimerManager sharedInstance] addAndRunTimer:_timer];
}

-(void)timerChanged:(GRTimer *)timer
{
    int timeOut = 60;
    if (timeOut > timer.duration) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:1];
            [_getCodeBtn setTitle:[NSString stringWithFormat:@"%.2ds后重试", timeOut-(int)timer.duration] forState:UIControlStateNormal];
            [UIView commitAnimations];
            _getCodeBtn.enabled = NO;
        });

    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            _getCodeBtn.enabled = YES;
            
            [[GRTimerManager sharedInstance] stopTimerWithKey:timer.key];
        });
    }
}

//-(void)startTime2{
//    __block int timeout=60; //倒计时时间
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
//    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
//    dispatch_source_set_event_handler(_timer, ^{
//        if(timeout<=0){ //倒计时结束
//            dispatch_source_cancel(_timer);
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//                _getCodeBtn.enabled = YES;
//            });
//        }else{
//            int seconds = timeout % 61;
//            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [UIView beginAnimations:nil context:nil];
//                [UIView setAnimationDuration:1];
//                [_getCodeBtn setTitle:[NSString stringWithFormat:@"%@s后重试",strTime] forState:UIControlStateNormal];
//                [UIView commitAnimations];
//                _getCodeBtn.enabled = NO;
//            });
//            timeout--;
//        }
//    });
//    dispatch_resume(_timer);
//}


-(void)getCodeBtnClick:(UIButton *)button
{
    if (![self validatePhone:_phoneTextField.text]) {
        [MBProgressHUD showHUDAutoDismissWithString:@"手机号格式不合法" andDim:NO];
        return;
    }

    [MBProgressHUD showLoadingWithDim:YES];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",[GlobalVar shareGlobalVar].smsCodeUrl, _phoneTextField.text];
    [AFHttpTool requestWithMethod:RequestMethodTypeGet url:urlStr params:nil success:^(id response) {
        
        [self startTime];
        [MBProgressHUD showHUDAutoDismissWithString:@"验证码已发送" andDim:NO];
        
    } failure:^(NSError *err) {
        [MBProgressHUD showHUDAutoDismissWithString:@"获取验证码失败，请稍后再试！" andDim:NO];
    }];
}

-(void)weixinLoginBtnClick:(UIButton *)button
{
    [WXApiManager sharedManager].delegate = self;
    [[UserManager shareInstance] weixinLoginInViewController:self];
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length>0)
    {
        if (textField == _phoneTextField)
        {
            return [self validateNumber:string];
        }
        else if (textField == _verificateTextFiled)
        {
            return [self validatePassword:string];
        }
    }
    else
    {
        return YES;
    }
    return YES;
}


-(BOOL)validatePassword:(NSString *)string
{
    NSString *str=@"^[0-9a-zA-Z]";
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





#pragma mark - UITextFiledDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _phoneTextField)
    {
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    else if(textField == _verificateTextFiled)
    {
        textField.keyboardType = UIKeyboardTypeASCIICapable;
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidChange:(NSNotification *)nsnotification
{
    if (_phoneTextField.text.length > 11)
    {
        _phoneTextField.text = [_phoneTextField.text substringToIndex:11];
    }

    if (_verificateTextFiled.text.length>6)
    {
        _verificateTextFiled.text=[_verificateTextFiled.text substringToIndex:6];
    }
    
    
    if (([self validatePhone:_phoneTextField.text])&&(_verificateTextFiled.text.length>0))
    {
        _loginBtn.enabled=YES;
        _loginBtn.backgroundColor=RGBACOLOR(176, 116, 67, 1);
    }
    else
    {
        _loginBtn.enabled=NO;
        _loginBtn.backgroundColor=[UIColor lightGrayColor];
    }
}



-(void)tapGesture:(UITapGestureRecognizer *)tapGesture
{
    [_phoneTextField resignFirstResponder];
    [_verificateTextFiled resignFirstResponder];
}




-(void)loginBtnClick:(UIButton *)button
{
    [MBProgressHUD showLoadingWithDim:YES];
    [[UserManager shareInstance] loginWithMobile:_phoneTextField.text andCode:_verificateTextFiled.text];
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
    CATransition* transition = [CATransition animation];
    transition.type = kCATransitionPush;//可更改为其他方式
    transition.subtype = kCATransitionFromBottom;//可更改为其他方式
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController popViewControllerAnimated:NO];
}

//-(void)rightButtonClick:(UIButton *)button
//{
    
//    [WXApiRequestHandler jumpToBizPay];
    
//    RegisterViewController *registerVC=[[RegisterViewController alloc]init];
//    [self.navigationController pushViewController:registerVC animated:YES];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushBindMobViewController:(UIViewController *)vc animated:(BOOL)animate
{
    NSMutableArray *arrVC = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [arrVC replaceObjectAtIndex:arrVC.count-1 withObject:vc];
    [self.navigationController setViewControllers:arrVC animated:animate];
}

#pragma mark WXApiManagerDelegate

- (void)managerDidRecvAuthResponse:(SendAuthResp *)response
{
    switch (response.errCode) {
        case WXAUTH_ERR_OK:
            [MBProgressHUD showLoadingWithDim:YES];
            [[UserManager shareInstance] loginWithWeiXinCode:response.code];
            break;
        case WXAUTH_ERR_AUTH_DENIED:
            [[GlobalVar shareGlobalVar] notifyEvent:UI_EVENT_USER_WXAUTH_DENIED object:nil];
            break;
        case WXAUTH_ERR_USER_CANCEL:
            [[GlobalVar shareGlobalVar] notifyEvent:UI_EVENT_USER_WXAUTH_CANCEL object:nil];
            break;
        default:
            break;
    }
}



-(void)dealloc
{
    if (_timer) {
        [[GRTimerManager sharedInstance] stopTimerWithKey:_timer.key];
        _timer = nil;
    }
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
        case UI_EVENT_USER_LOGIN_SUCC:
        {
//            [MBLoadingView hideLoadingView];
            [MBProgressHUD dismissHUD];
            UserInfo * userInfo = (UserInfo *)object;
            if (0 == userInfo.roleFlag) {
                BindMobViewController *bindVc;
//                for (UIViewCont7roller *vc in self.navigationController.viewControllers) {
//                    if ([vc isKindOfClass:[BindMobViewController class]]) {
//                        bindVc = (BindMobViewController *)vc;
//                        break;
//                    }
//                }
//                if (bindVc) {
//                    [self.navigationController popToViewController:bindVc animated:YES];
//                } else {
                    bindVc = [[BindMobViewController alloc] init];
                    [self pushBindMobViewController:bindVc animated:NO];
//                }
            } else {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
            break;
        case UI_EVENT_USER_LOGIN_FAILED:
        {
            [MBProgressHUD dismissHUD];
            
            NSError *error = (NSError *)object;
            NSInteger statusCode = [error.userInfo[kAFNetWorkStatusCodeKey] integerValue];
            if (statusCode != USER_TOKEN_EXPIRED &&
                statusCode != USER_REQUIR_AUTH &&
                statusCode != USER_TOKEN_AUTH_FAILED){
                
                 [MBProgressHUD showHUDAutoDismissWithString:@"登录失败" andDim:NO];
            }
        }
            break;
        default:
            break;
    }
}



@end
