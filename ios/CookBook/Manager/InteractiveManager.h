//
//  IneractiveManager.h
//  CookBook
//
//  Created by zhangxi on 16/4/21.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserManager.h"


@interface InteractiveManager : NSObject

@property (nonatomic, weak) id<UserManagerDelegate> userActionDelegate;

+(InteractiveManager *)shareInstance;

- (void)initDelegate;

- (void)loginWithUserId:(NSString *)userId andPassword:(NSString *)password;

- (void)bindMob:(NSString *)mob  andCode:(NSString *)code;

- (void)getShoppingAddress;

- (void)createShoppingAddress:(NSString *)mob andName:(NSString *)name  andAddress:(NSString *)address;

- (void)updateShoppingAddress:(NSString *)mob andName:(NSString *)name andAddress:(NSString *)address andAddressId:(NSString *)addressID;

- (void)deleteShoppingAddressByID:(NSString *)addressID;

- (void)registerWithInfo:(NSDictionary *)dictInfo withPassword:(NSString *)password;

- (void)updateUser:(NSInteger)userId nickName:(NSString *)nickName;

- (void)updateUserIcon:(NSInteger)userId image:(UIImage *)image;

- (void)deleteCuisineById:(NSString *)cusineUrl;

- (void)deleteProductById:(NSString *)productUrl;

- (void)loginWithWeiXinCode:(NSString *)wxCode;

- (void)loginWithMobile:(NSString *)phoneNumber andCode:(NSString *)code;

- (void)refreshToken:(NSString *)token;

@end
