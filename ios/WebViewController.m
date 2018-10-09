//
//  WebViewController.m
//  CookBook
//
//  Created by 你好 on 16/5/19.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "WebViewController.h"
#import "NavView.h"
#import <WebKit/WebKit.h>
@interface WebViewController ()<WKNavigationDelegate>

@end

@implementation WebViewController
{
    NavView *_navView;
    WKWebView *_webView;
    UIProgressView *_progressView;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    _navView=[[NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    [_navView.leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_navView.leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_navView.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navView];
        
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:self.url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15.0f];

    _webView=[[WKWebView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
    [_webView loadRequest:request];
    _webView.navigationDelegate=self;
    [self.view addSubview:_webView];
    
    _progressView=[[UIProgressView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, 4)];
    _progressView.trackTintColor=[UIColor clearColor];
    [self.view addSubview:_progressView];
    
    
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

}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{

}


-(void)leftButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
