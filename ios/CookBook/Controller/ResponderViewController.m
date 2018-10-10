//
//  ResponderViewController.m
//  CookBook
//
//  Created by zhangxi on 16/5/10.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "ResponderViewController.h"
#import "LoginViewController.h"
#import "BindMobViewController.h"
#import "UserManager.h"
#import "MBProgressHUD+Helper.h"

@interface ResponderViewController ()

@end

@implementation ResponderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[GlobalVar shareGlobalVar] setResponderViewController:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[GlobalVar shareGlobalVar] setResponderViewController:self];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[GlobalVar shareGlobalVar] setResponderViewController:nil];
    
    [MBProgressHUD dismissHUD];
    [super viewWillDisappear:animated];
}

- (void)pushLoginViewController:(UIViewController *)vc animated:(BOOL)animate
{
    NSMutableArray *arrVC = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    
    UIViewController *commonVc = [arrVC lastObject];
    if ([commonVc isKindOfClass:[BindMobViewController class]]) {
        [arrVC replaceObjectAtIndex:arrVC.count-1 withObject:vc];
        [self.navigationController setViewControllers:arrVC animated:animate];
    } else {
        [self.navigationController pushViewController:vc animated:animate];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)applicationDidBecomeActive:(NSNotification *)notify
{
    
}

- (void)onEventAction:(AppEventType)type object:(id)object
{
    switch (type) {
        case UI_EVENT_USER_AUTH_FAILED:
        {
            if ([UserManager shareInstance].bIsLogin) {
                [[UserManager shareInstance] logOutWithClearToken:YES];
            }
            
            if (![[self.navigationController.viewControllers lastObject] isKindOfClass:[LoginViewController class]]) {
                LoginViewController *loginVc = [[LoginViewController alloc] init];
                [self pushLoginViewController:loginVc animated:YES];
            }

//            LoginViewController *loginVc = nil;
//            for (UIViewController *vc in self.navigationController.viewControllers) {
//                if ([vc isKindOfClass:[LoginViewController class]]) {
//                    loginVc = (LoginViewController *)vc;
//                    break;
//                }
//            }
//            if (loginVc) {
//                [self.navigationController popToViewController:loginVc animated:YES];
//            } else {
//                LoginViewController *loginVc = [[LoginViewController alloc] init];
//                [self.navigationController pushViewController:loginVc animated:YES];
//            }
        }
            break;
            
        default:
            break;
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    
    
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
