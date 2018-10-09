//
//  UserManager.h
//  CookBook
//
//  Created by zhangxi on 16/4/18.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"
#import "GlobalVar.h"
#import "WXApiManager.h"

#define ISUSER(flag) (flag|0x1)
#define ISRESELLER(flag) (flag|0x2)
#define ISDISPATCHER(flag) (flag|0x4)

@protocol UserManagerDelegate <NSObject>

-(void)didGetRecommendSuccess:(NSMutableArray *)array;
-(void)didGetRecommendFail:(NSError *)error;

-(void)didUserLoginSuccess:(UserInfo *)userInfo andPassword:(NSString *)password;
-(void)didUserLoginFailed:(NSString *)userId error:(NSError *)error;
-(void)didRefreshTokeFailed:(NSString *)userId error:(NSError *)error;
-(void)didRefreshTokeSuccess:(UserInfo *)userInfo;

-(void)didUserRegistSuccess:(UserInfo *)userInfo andPassword:(NSString *)password;
-(void)didUserRegistFailedWithError:(NSError *)error;

-(void)didUpdateUserIconSuccess:(NSString *)md5;
-(void)didUpdateUserIconFail:(NSError *)error;

-(void)didUpdateUserNicknameSuccess;
-(void)didUpdateUserNicknameFail:(NSError *)error;

-(void)didGetMoreCuisineSuccess:(NSMutableArray *)array;
-(void)didGetMoreCuisineFail:(NSError *)error;

-(void)didGetMoreProductSuccess:(NSMutableArray *)array;
-(void)didgetMoreProductFail:(NSError *)error;

-(void)didDelProductSuccess;
-(void)didDelProductFail:(NSError *)error;

-(void)didDelCuisineSuccess;
-(void)didDelCuisineFail:(NSError *)error;

-(void)didGetShoppingAddressSuccess:(NSMutableArray *)array;
-(void)didGetShoppingAddressFail:(NSError *)error;

-(void)didCreateShoppingAddressSuccess;
-(void)didCreateShoppingAddressFail:(NSError *)error;

-(void)didUpdateShoppingAddressSuccess;
-(void)didUpdateShoppingAddressFail:(NSError *)error;

-(void)didDeleteShoppingAddressSuccess;
-(void)didDeleteShoppingAddressFail:(NSError *)error;

-(void)didBindMobSuccess:(NSString *)mob;
-(void)didBindMobFail:(NSError *)error;


-(void)didGetHomePageListSucc:(NSDictionary *)dict;
-(void)didGetHomePageListFail:(NSError *)error;

@end

@interface UserManager : NSObject<UserManagerDelegate,WXApiManagerDelegate>

@property (nonatomic, assign) BOOL bIsLogin;
@property (nonatomic, strong) UserInfo * curUser;

+ (UserManager*)shareInstance;

- (void)weixinLoginInViewController:(UIViewController *)viewController;

- (void)loginWithMobile:(NSString *)phoneNumber andCode:(NSString *)code;

- (void)refreshToken:(BOOL)bForce;

- (void)loginWithUserId:(NSString *)userId andPassword:(NSString *)password;

- (void)loginWithWeiXinCode:(NSString *)code;

- (void)registerWithInfo:(NSDictionary *)dictInfo withPassword:(NSString *)password;

- (void)bindMob:(NSString *)mob  andCode:(NSString *)code;

- (void)getShopAddress;

- (void)createShoppingAddress:(NSString *)mob andName:(NSString *)name  andAddress:(NSString *)address;

- (void)updateShoppingAddress:(NSString *)mob andName:(NSString *)name andAddress:(NSString *)address andAddressId:(NSString *)addressID;

- (void)deleteShoppingAddressByID:(NSString *)addressID;

- (void)updateUserIcon:(NSInteger)userId image:(UIImage *)image;

- (void)updateUser:(NSInteger)userId nickName:(NSString *)nickName;

- (void)deleteCuisineById:(NSString *)cusineUrl;

- (void)deleteProductById:(NSString *)productUrl;

- (void)saveCurUserInfo;

- (void)logOutWithClearToken:(BOOL)bClear;

@end
