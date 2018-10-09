//
//  AboutUsViewController.m
//  CookBook
//
//  Created by 你好 on 16/6/15.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "AboutUsViewController.h"
#import "NavView.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController
{
    NavView *_navView;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES];
    
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    
    _navView=[[NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    [_navView.leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_navView.leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_navView.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _navView.centerLabel.text=@"关于我们";
    _navView.rightButton.titleLabel.font=[UIFont systemFontOfSize:16];
    [self.view addSubview:_navView];
    
    UIImage *image=[UIImage imageNamed:@"about_us_icon"];
    UIImageView *contentImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenWidth*image.size.height/image.size.width)];
    contentImageView.image=image;
    [self.view addSubview:contentImageView];
    
    UILabel *versionLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, ScreenHeight-100, ScreenWidth, 40)];
    versionLabel.text=[NSString stringWithFormat:@"版本  V%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    versionLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:versionLabel];
    
    UILabel *companyLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, ScreenHeight-30, ScreenWidth, 20)];
    companyLabel.font=[UIFont systemFontOfSize:12];
    companyLabel.textAlignment=NSTextAlignmentCenter;
    companyLabel.text=@"北京星图通科技有限公司";
    [self.view addSubview:companyLabel];
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
