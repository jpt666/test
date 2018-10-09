//
//  AgreementViewController.m
//  CookBook
//
//  Created by 你好 on 16/9/7.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "AgreementViewController.h"
#import "NavView.h"
#import <WebKit/WebKit.h>
#import "GlobalVar.h"
#import "RetrieveRequest.h"
#import "MBProgressHUD+Helper.h"
#import "ApplySuccViewController.h"
#import "UserManager.h"
#import "GroupsPropertyKeys.h"

@interface AgreementViewController ()<WKNavigationDelegate, RetrieveRequestDelegate>

@end

@implementation AgreementViewController
{
    WKWebView *_webView;
    NavView *_navView;
    UIProgressView *_progressView;
    UIButton *_bottomButton;
    
    RetrieveRequest * _applyRequest;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES];
    
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    
    _navView=[[NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    [_navView.leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_navView.leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_navView.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _navView.centerLabel.text=@"团主协议";
    _navView.rightButton.titleLabel.font=[UIFont systemFontOfSize:16];
    [self.view addSubview:_navView];
    
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:[GlobalVar shareGlobalVar].applyProtocolUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15.0f];
    
    _webView=[[WKWebView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-49)];
    [_webView loadRequest:request];
    _webView.navigationDelegate=self;
    [self.view addSubview:_webView];
    
    _progressView=[[UIProgressView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, 4)];
    _progressView.trackTintColor=[UIColor clearColor];
    [self.view addSubview:_progressView];
    
    _bottomButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _bottomButton.frame=CGRectMake(0, ScreenHeight-49, ScreenWidth, 49);
    _bottomButton.backgroundColor=[UIColor lightGrayColor];
    [_bottomButton setTitle:@"同 意" forState:UIControlStateNormal];
    [_bottomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _bottomButton.enabled=NO;
    [_bottomButton addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_bottomButton];
    
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (_webView.estimatedProgress==1)
    {
        _progressView.hidden=YES;
    }
    else
    {
        _progressView.hidden=NO;
        _progressView.progress=_webView.estimatedProgress;
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

-(void)bottomButtonClick:(UIButton *)button
{
    if (!_applyRequest) {
        [MBProgressHUD showLoadingWithDim:YES];
        
        _applyRequest = [[RetrieveRequest alloc] init];
        _applyRequest.delegate = self;
        [_applyRequest postRequestWithUrl:[GlobalVar shareGlobalVar].applyResellerUrl andParam:nil];
    }
}

#pragma mark - RetrieveRequestDelegate
-(void)didRetrieveDataSuccess:(RetrieveRequest *)request
{
    if (request == _applyRequest) {
        [MBProgressHUD dismissHUD];
        
        [UserManager shareInstance].curUser.resellerId = [_applyRequest.rawData[kResellerPropertyId] integerValue];
        [UserManager shareInstance].curUser.resellerApplyState = [_applyRequest.rawData[kResellerPropertyApplyState] integerValue];
        
        [[UserManager shareInstance] refreshToken:YES];
        
        ApplySuccViewController *applySuccVC=[[ApplySuccViewController alloc]init];
        [self.navigationController pushViewController:applySuccVC animated:YES];

    }
}

-(void)didRetrieveDataFailed:(RetrieveRequest *)request
{
    if (request == _applyRequest) {
        [MBProgressHUD showHUDAutoDismissWithError:request.error andDim:NO];
        _applyRequest = nil;
    }
}

#pragma mark - WkWebViewDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    _bottomButton.enabled=YES;
    _bottomButton.backgroundColor=RGBACOLOR(176, 116, 67, 1);
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    
}


-(void)leftButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
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
