//
//  BindMobViewController.m
//  CookBook
//
//  Created by 你好 on 16/6/15.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "BindMobViewController.h"
#import "NavView.h"
#import "UserManager.h"
//#import "MBLoadingView.h"
//#import "SVProgressHUD.h"
#import "MBProgressHUD+Helper.h"
#import "GreedTimer.h"

@interface BindMobViewController()<UITextFieldDelegate>

@end


@implementation BindMobViewController
{
    NavView *_navView;
    UIButton *_loginBtn;
    UITextField *_phoneTextField;
    UITextField *_verificateTextFiled;
    UIView *_phoneBackView;
    UIView *_verCodeView;
    
    UIButton *_getCodeBtn;
    
//    dispatch_source_t _timer;
    GRTimer * _timer;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    [self.navigationController setNavigationBarHidden:YES];
    
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    
    _navView=[[NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    [_navView.leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_navView.leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_navView.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _navView.leftButton.hidden = YES;
    _navView.centerLabel.text=@"绑定手机";
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
    [_loginBtn setTitle:@"确 定" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];

    
//    UILabel *phoneLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 64, 80, 50)];
//    phoneLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e"];
//    phoneLabel.text=@"绑定手机";
//    phoneLabel.font=[UIFont systemFontOfSize:16];
//    [self.view addSubview:phoneLabel];
//    
//    _phoneTextField=[[UITextField alloc]initWithFrame:CGRectMake(phoneLabel.frame.origin.x+phoneLabel.frame.size.width, 64, ScreenWidth-180, 50)];
//    _phoneTextField.autocorrectionType=UITextAutocorrectionTypeNo;
//    _phoneTextField.autocapitalizationType=UITextAutocapitalizationTypeNone;
//    _phoneTextField.keyboardType=UIKeyboardTypeNumberPad;
//    _phoneTextField.placeholder=@"请输入手机号";
//    _phoneTextField.tintColor=[UIColor lightGrayColor];
//    [self.view addSubview:_phoneTextField];
//    
//    _getCodeBtn =[UIButton buttonWithType:UIButtonTypeCustom];
//    _getCodeBtn.frame=CGRectMake(ScreenWidth-95, 76, 80, 26);
//    _getCodeBtn.layer.cornerRadius=5;
//    _getCodeBtn.backgroundColor=[UIColor orangeColor];
//    [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//    [_getCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    _getCodeBtn.titleLabel.font=[UIFont systemFontOfSize:14];
//    [_getCodeBtn addTarget:self action:@selector(getCodeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_getCodeBtn];
//    
//    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(10, 114, ScreenWidth-20, 0.5)];
//    lineView.backgroundColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.3];
//    [self.view addSubview:lineView];
//    
//    UILabel *verificateLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 115, 80, 50)];
//    verificateLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e"];
//    verificateLabel.text=@"验证码";
//    verificateLabel.font=[UIFont systemFontOfSize:16];
//    [self.view addSubview:verificateLabel];
//    
//    _verificateTextFiled=[[UITextField alloc]initWithFrame:CGRectMake(verificateLabel.frame.origin.x+verificateLabel.frame.size.width, verificateLabel.frame.origin.y, ScreenWidth-100, 50)];
//    _verificateTextFiled.clearButtonMode=UITextFieldViewModeWhileEditing;
//    _verificateTextFiled.autocorrectionType=UITextAutocorrectionTypeNo;
//    _verificateTextFiled.autocapitalizationType=UITextAutocapitalizationTypeNone;
//    _verificateTextFiled.placeholder=@"请输入验证码";
//    _verificateTextFiled.tintColor=[UIColor lightGrayColor];
//    [self.view addSubview:_verificateTextFiled];
//    
//    UIView *lineView1=[[UIView alloc]initWithFrame:CGRectMake(10, _verificateTextFiled.frame.origin.y+_verificateTextFiled.frame.size.height, ScreenWidth-20, 0.5)];
//    lineView1.backgroundColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.3];
//    [self.view addSubview:lineView1];
//    
//    _loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    _loginBtn.frame=CGRectMake(10, lineView1.frame.origin.y+lineView1.frame.size.height+60, ScreenWidth-20, 50);
//    _loginBtn.enabled=NO;
//    _loginBtn.backgroundColor=[UIColor lightGrayColor];
//    [_loginBtn setTitle:@"确 定" forState:UIControlStateNormal];
//    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [_loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_loginBtn];

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



-(void)textFieldDidChange:(NSNotification *)nsnotification
{
    if (_phoneTextField.text.length > 11)
    {
        _phoneTextField.text = [_phoneTextField.text substringToIndex:11];
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


-(void)leftButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
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


//-(void)startTime{
//    __block int timeout=60; //倒计时时间
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
//    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
//    dispatch_source_set_event_handler(_timer, ^{
//        if(timeout<=0){ //倒计时结束
//            dispatch_source_cancel(_timer);
//            _timer = nil;
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
        //        [SVProgressHUD setMinimumDismissTimeInterval:1.0f];
        //        [SVProgressHUD showInfoWithStatus:@"请输入有效的手机号"];
        [MBProgressHUD showHUDAutoDismissWithString:@"手机号格式不合法" andDim:NO];
        
        return;
    }
    
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
//    [SVProgressHUD show];
    [MBProgressHUD showLoadingWithDim:YES];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",[GlobalVar shareGlobalVar].smsCodeUrl, _phoneTextField.text];
    [AFHttpTool requestWithMethod:RequestMethodTypeGet url:urlStr params:nil success:^(id response) {
        
        [self startTime];
        
        //        [SVProgressHUD setMinimumDismissTimeInterval:1.0f];
        //        [SVProgressHUD showInfoWithStatus:@"验证码已发送"];
        [MBProgressHUD showHUDAutoDismissWithString:@"验证码已发送" andDim:NO];
    } failure:^(NSError *err) {
        //        [SVProgressHUD setMinimumDismissTimeInterval:1.0f];
        //        [SVProgressHUD showErrorWithStatus:@"获取验证码失败，请稍后再试！"];
        //
        [MBProgressHUD showHUDAutoDismissWithString:@"获取验证码失败，请稍后再试！" andDim:NO];
    }];
}

-(void)loginBtnClick:(UIButton *)button
{
//    [MBLoadingView showLoadingViewWithDimBackground:YES];
    [MBProgressHUD showLoadingWithDim:YES];
    [[UserManager shareInstance]bindMob:_phoneTextField.text andCode:_verificateTextFiled.text];

}

-(void)onEventAction:(AppEventType)type object:(id)object
{    
    switch (type) {
//        case UI_EVENT_USER_BIND_MOB_SUCC:
//        {
//            [MBProgressHUD dismissHUD];
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//            break;
//        case UI_EVENT_USER_BIND_MOB_FAILED:
//        {
//            [MBProgressHUD dismissHUD];
//            
//            NSError *error = (NSError *)object;
//            NSInteger statusCode = [error.userInfo[kAFNetWorkStatusCodeKey] integerValue];
//            if (statusCode != USER_TOKEN_EXPIRED &&
//                statusCode != USER_REQUIR_AUTH &&
//                statusCode != USER_TOKEN_AUTH_FAILED){
//                
//                [MBProgressHUD showHUDAutoDismissWithString:@"绑定手机失败" andDim:NO];
//            }
//        }
//            break;
        case UI_EVENT_USER_LOGIN_SUCC:
        {
            [MBProgressHUD dismissHUD];
            [self.navigationController popViewControllerAnimated:YES];
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

                [MBProgressHUD showHUDAutoDismissWithString:@"绑定手机失败" andDim:NO];
            }
        }
            break;
        default:
            dispatch_async(dispatch_get_main_queue(), ^{
                [super onEventAction:type object:object];
            });
            
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

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
