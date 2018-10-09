//
//  UserManager.m
//  CookBook
//
//  Created by zhangxi on 16/4/18.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "UserManager.h"
#import "SFHFKeychainUtils.h"
#import "InteractiveManager.h"
#import "CookDataManager.h"
#import "WXApiRequestHandler.h"


@implementation UserManager

+ (UserManager*)shareInstance
{
    static UserManager* instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[[self class] alloc] init];
    });
    
    return instance;
}

- (void)weixinLoginInViewController:(UIViewController *)viewController
{
    [WXApiRequestHandler sendAuthRequestScope:kAuthScope State:kAuthState OpenID:nil InViewController:viewController];
}

- (void)loginWithMobile:(NSString *)phoneNumber andCode:(NSString *)code
{
    [[InteractiveManager shareInstance] loginWithMobile:phoneNumber andCode:code];
}

- (void)loginWithWeiXinCode:(NSString *)code
{
    [[InteractiveManager shareInstance] loginWithWeiXinCode:code];
}

- (void)refreshToken:(BOOL)bForce
{
    if (!bForce && _bIsLogin) {
        return;
    }
    
    NSString * token = _curUser.token;
    if (!token) {
        NSDictionary * dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserInfo"];
        if (dict) {
            token = [dict objectForKey:@"token"];
        }
    }
    
    if (token) {
        [[InteractiveManager shareInstance] refreshToken:token];
    }
}

- (void)saveCurUserInfo
{
    if (_bIsLogin) {
        [self saveUserInfo:_curUser withPassword:nil];
    }
}

- (void)saveUserInfo:(UserInfo *)userInfo withPassword:(NSString *)password
{
    if (password)
    {
        [SFHFKeychainUtils storeUsername:[NSString stringWithFormat:@"%ld",userInfo.userId] andPassword:password forServiceName:SERVER_HOST updateExisting:YES error:nil];
    }

    NSMutableDictionary *dictory=[NSMutableDictionary dictionary];
    
    if (_curUser.token && _curUser.roleFlag != 0) {
        [dictory setObject:_curUser.token forKey:@"token"];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:dictory forKey:@"UserInfo"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)loginSuccess:(UserInfo *)userInfo withPassword:(NSString *)password
{
    _curUser=userInfo;
    _bIsLogin=YES;
    
    [self saveUserInfo:userInfo withPassword:password];
    
    if (_curUser.roleFlag > 0) {
        [[CookDataManager shareInstance] retrieveCookDataDrafts];
    }
}

- (void)logOutWithClearToken:(BOOL)bClear
{
    _curUser=nil;
    _bIsLogin=NO;
    
    if (bClear) {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"UserInfo"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }

    
    [[CookDataManager shareInstance] clearCookDataDrafts];
    
    [[GlobalVar shareGlobalVar] notifyEvent:UI_EVENT_USER_LOGOUT object:nil];
}

- (void)loginWithUserId:(NSString *)userId andPassword:(NSString *)password
{
    [[InteractiveManager shareInstance] loginWithUserId:userId andPassword:password];
}

- (void)registerWithInfo:(NSDictionary *)dictInfo withPassword:(NSString *)password
{
    [[InteractiveManager shareInstance] registerWithInfo:dictInfo withPassword:password];
}


- (void)updateUserIcon:(NSInteger)userId image:(UIImage *)image
{
    [[InteractiveManager shareInstance]updateUserIcon:userId image:image];
}


- (void)updateUser:(NSInteger)userId nickName:(NSString *)nickName
{
    [[InteractiveManager shareInstance]updateUser:userId nickName:nickName];
}


- (void)deleteCuisineById:(NSString *)cusineUrl
{
    [[InteractiveManager shareInstance]deleteCuisineById:cusineUrl];
}


- (void)deleteProductById:(NSString *)productUrl
{
    [[InteractiveManager shareInstance]deleteProductById:productUrl];
}

- (void)getShopAddress
{
    [[InteractiveManager shareInstance]getShoppingAddress];
}


- (void)createShoppingAddress:(NSString *)mob andName:(NSString *)name  andAddress:(NSString *)address
{
    [[InteractiveManager shareInstance]createShoppingAddress:mob andName:name andAddress:address];
}


- (void)updateShoppingAddress:(NSString *)mob andName:(NSString *)name andAddress:(NSString *)address andAddressId:(NSString *)addressID
{
    [[InteractiveManager shareInstance]updateShoppingAddress:mob andName:name andAddress:address andAddressId:addressID];
}

- (void)deleteShoppingAddressByID:(NSString *)addressID
{
    [[InteractiveManager shareInstance]deleteShoppingAddressByID:addressID];
}


- (void)bindMob:(NSString *)mob  andCode:(NSString *)code
{
    [[InteractiveManager shareInstance]bindMob:mob andCode:code];
}

#pragma mark UserManagerDelegate

-(void)didBindMobSuccess:(NSString *)mob
{
    _curUser.mobileNumber=mob;
    [[GlobalVar shareGlobalVar]notifyEvent:UI_EVENT_USER_BIND_MOB_SUCC object:nil];
}

-(void)didBindMobFail:(NSError *)error
{
    [[GlobalVar shareGlobalVar] notifyEvent:UI_EVENT_USER_BIND_MOB_FAILED object:error];
}

-(void)didDeleteShoppingAddressSuccess
{
    [[GlobalVar shareGlobalVar]notifyEvent:UI_EVENT_USER_DELETE_ADDRESS_SUCC object:nil];
}

-(void)didDeleteShoppingAddressFail:(NSError *)error
{
    [[GlobalVar shareGlobalVar]notifyEvent:UI_EVENT_USER_DELETE_ADDRESS_FAILED object:error];
}

-(void)didUpdateShoppingAddressSuccess
{
    [[GlobalVar shareGlobalVar]notifyEvent:UI_EVENT_USER_UPDATE_ADDRESS_SUCC object:nil];
}

-(void)didUpdateShoppingAddressFail:(NSError *)error
{
    [[GlobalVar shareGlobalVar]notifyEvent:UI_EVENT_USER_UPDATE_ADDRESS_FAILED object:error];
}

-(void)didCreateShoppingAddressSuccess
{
    [[GlobalVar shareGlobalVar]notifyEvent:UI_EVENT_USER_CREATE_ADDRESS_SUCC object:nil];
}

-(void)didCreateShoppingAddressFail:(NSError *)error
{
    [[GlobalVar shareGlobalVar]notifyEvent:UI_EVENT_USER_CREATE_ADDRESS_FAILED object:error];
}

-(void)didGetShoppingAddressSuccess:(NSMutableArray *)array
{
    [[GlobalVar shareGlobalVar]notifyEvent:UI_EVENT_USER_GET_SHOPPINGADRESS_SUCC object:array];
}

-(void)didGetShoppingAddressFail:(NSError *)error
{
    [[GlobalVar shareGlobalVar]notifyEvent:UI_EVENT_USER_GET_SHOPPINGADRESS_FAILED object:error];
}

-(void)didRefreshTokeFailed:(NSString *)userId error:(NSError *)error
{
    [self logOutWithClearToken:NO];
}

-(void)didRefreshTokeSuccess:(UserInfo *)userInfo
{
    [self loginSuccess:userInfo withPassword:nil];
}

-(void)didUserLoginSuccess:(UserInfo *)userInfo andPassword:(NSString *)password
{
    [self loginSuccess:userInfo withPassword:password];
    [[GlobalVar shareGlobalVar] notifyEvent:UI_EVENT_USER_LOGIN_SUCC object:userInfo];
}

-(void)didUserLoginFailed:(NSString *)userId error:(NSError *)error
{
    [self logOutWithClearToken:YES];

    [[GlobalVar shareGlobalVar] notifyEvent:UI_EVENT_USER_LOGIN_FAILED object:error];
}


-(void)didUserRegistSuccess:(UserInfo *)userInfo andPassword:(NSString *)password
{
    _curUser=userInfo;
    _bIsLogin=YES;
    
    [self saveUserInfo:userInfo withPassword:password];
    
    [[CookDataManager shareInstance] retrieveCookDataDrafts];
    
    [[GlobalVar shareGlobalVar] notifyEvent:UI_EVENT_USER_REGIST_SUCC object:nil];
}

-(void)didUserRegistFailedWithError:(NSError *)error
{
    [[GlobalVar shareGlobalVar] notifyEvent:UI_EVENT_USER_REGIST_FAILED object:error];
}


-(void)didUpdateUserIconSuccess:(NSString *)md5
{
    [[GlobalVar shareGlobalVar]notifyEvent:UI_EVENT_USER_UPDATE_ICON_SUCC object:nil];
}


-(void)didUpdateUserIconFail:(NSError *)error
{
    [[GlobalVar shareGlobalVar]notifyEvent:UI_EVENT_USER_UPDATE_ICON_FAILED object:error];
}

-(void)didUpdateUserNicknameSuccess
{
    [[GlobalVar shareGlobalVar]notifyEvent:UI_EVENT_USER_UPDATE_NICKNAME_SUCC object:nil];
}


-(void)didUpdateUserNicknameFail:(NSError *)error
{
    [[GlobalVar shareGlobalVar]notifyEvent:UI_EVENT_USER_UPDATE_NICKNAME_FAILED object:nil];
}

-(void)didGetMoreProductSuccess:(NSMutableArray *)array
{
    [[GlobalVar shareGlobalVar]notifyEvent:UI_EVENT_USER_GET_MORE_PRODUCT_SUCC object:array];
}

-(void)didGetMoreCuisineSuccess:(NSMutableArray *)array
{
    [[GlobalVar shareGlobalVar]notifyEvent:UI_EVENT_USER_GET_MORE_CUISINE_SUCC object:array];
}

-(void)didGetMoreCuisineFail:(NSError *)error
{
    [[GlobalVar shareGlobalVar]notifyEvent:UI_EVENT_USER_GET_MORE_CUISINE_FAILED object:error];
}

-(void)didgetMoreProductFail:(NSError *)error
{
    [[GlobalVar shareGlobalVar]notifyEvent:UI_EVENT_USER_GET_MORE_PRODUCT_FAILED object:error];
}

-(void)didDelProductSuccess
{
    [[GlobalVar shareGlobalVar]notifyEvent:UI_EVENT_USER_DELETE_PRODUCT_SUCC object:nil];
    
    if ([NSThread isMainThread]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_REFRESH_COOK_PRODUCT object:nil];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_REFRESH_COOK_PRODUCT object:nil];
        });
    }
}

-(void)didDelCuisineSuccess
{
    [[GlobalVar shareGlobalVar]notifyEvent:UI_EVENT_USER_DELETE_CUISINE_SUCC object:nil];
    if ([NSThread isMainThread]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_REFRESH_COOK_CUISINE object:nil];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_REFRESH_COOK_CUISINE object:nil];
        });
    }
}

-(void)didDelProductFail:(NSError *)error
{
    [[GlobalVar shareGlobalVar]notifyEvent:UI_EVENT_USER_DELETE_PRODUCT_FAILED object:error];
}

-(void)didDelCuisineFail:(NSError *)error
{
    [[GlobalVar shareGlobalVar]notifyEvent:UI_EVENT_USER_DELETE_CUISINE_FAILED object:error];
}


@end
