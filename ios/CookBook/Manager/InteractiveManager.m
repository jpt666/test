//
//  IneractiveManager.m
//  CookBook
//
//  Created by zhangxi on 16/4/21.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "InteractiveManager.h"
#import "SFHFKeychainUtils.h"
#import "NSData+md5.h"
#import <UIImageView+WebCache.h>
#import "JSONKit.h"
@implementation InteractiveManager

+(InteractiveManager *)shareInstance
{
    static InteractiveManager * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class]alloc] init];
    });
    return instance;
}

- (void)initDelegate
{
    _userActionDelegate = [UserManager shareInstance];
}

- (UserInfo *)convertUserInfoFromDict:(NSDictionary *)dict
{
    UserInfo *userInfo=[[UserInfo alloc]init];

    return userInfo;
}


- (void)loginWithUserId:(NSString *)userId andPassword:(NSString *)password
{
    NSDictionary *dict=@{@"userid":userId,@"password":password};
    [AFHttpTool requestWithMethod:RequestMethodTypePost url:SERVER_LOGIN_USER params:dict success:^(id response) {
        if ([[response objectForKey:@"code"] integerValue]==0)
        {
            NSDictionary *dict=[response objectForKey:@"result"];
            
            UserInfo * userInfo = [self convertUserInfoFromDict:dict];
            if (_userActionDelegate && [_userActionDelegate respondsToSelector:@selector(didUserLoginSuccess:andPassword:)]) {
                [_userActionDelegate didUserLoginSuccess:userInfo andPassword:password];
            }
        }
        else
        {
            NSError *err = [NSError errorWithDomain:SERVER_HOST code:[[response objectForKey:@"code"] integerValue] userInfo:[NSDictionary dictionaryWithObject:[response objectForKey:@"message"] forKey:NSLocalizedDescriptionKey]];
            
            if (_userActionDelegate && [_userActionDelegate respondsToSelector:@selector(didUserLoginFailed:error:)]) {
                [_userActionDelegate didUserLoginFailed:userId error:err];
            }

        }
    }failure:^(NSError *err) {
         if (_userActionDelegate && [_userActionDelegate respondsToSelector:@selector(didUserLoginFailed:error:)]) {
             [_userActionDelegate didUserLoginFailed:userId error:err];
         }
     }];
}

- (void)registerWithInfo:(NSDictionary *)dictInfo withPassword:(NSString *)password
{
    [AFHttpTool requestWithMethod:RequestMethodTypePost url:SERVER_REGISTER_USER params:dictInfo success:^(id response) {
        if ([[response objectForKey:@"code"] integerValue]==0)
        {
            NSDictionary *dict=[response objectForKey:@"result"];
            
            UserInfo * userInfo = [self convertUserInfoFromDict:dict];
            
            if (_userActionDelegate && [_userActionDelegate respondsToSelector:@selector(didUserRegistSuccess:andPassword:)]) {
                [_userActionDelegate didUserRegistSuccess:userInfo andPassword:password];
            }
        }
        else
        {
            NSError *err = [NSError errorWithDomain:SERVER_HOST code:[[response objectForKey:@"code"] integerValue] userInfo:[NSDictionary dictionaryWithObject:[response objectForKey:@"message"] forKey:NSLocalizedDescriptionKey]];
            
            if (_userActionDelegate && [_userActionDelegate respondsToSelector:@selector(didUserRegistFailedWithError:)]) {
                [_userActionDelegate didUserRegistFailedWithError:err];
            }
        }
    } failure:^(NSError *err) {
        if (_userActionDelegate && [_userActionDelegate respondsToSelector:@selector(didUserRegistFailedWithError:)]) {
            [_userActionDelegate didUserRegistFailedWithError:err];
        }
    }];
}

- (void)updateUser:(NSInteger)userId nickName:(NSString *)nickName
{
    NSDictionary *d=@{@"userid":@(userId),@"nickname":nickName};
    [AFHttpTool requestWithMethod:RequestMethodTypePost url:SERVER_UPDATE_PERSONAL_INFO params:d success:^(id response) {

        if ([[response objectForKey:@"code"]integerValue]==0)
        {
            [[UserManager shareInstance] saveCurUserInfo];
            
            if (_userActionDelegate && [_userActionDelegate respondsToSelector:@selector(didUpdateUserNicknameSuccess)])
            {
                [_userActionDelegate didUpdateUserNicknameSuccess];
            }
        }
        else
        {
            NSError *err = [NSError errorWithDomain:SERVER_HOST code:[[response objectForKey:@"code"] integerValue] userInfo:[NSDictionary dictionaryWithObject:[response objectForKey:@"message"] forKey:NSLocalizedDescriptionKey]];
            
            if ((_userActionDelegate && [_userActionDelegate respondsToSelector:@selector(didUpdateUserNicknameFail:)]))
            {
                [_userActionDelegate didUpdateUserNicknameFail:err];
            }
        }
    } failure:^(NSError *err) {
        if ((_userActionDelegate && [_userActionDelegate respondsToSelector:@selector(didUpdateUserNicknameFail:)]))
        {
            [_userActionDelegate didUpdateUserNicknameFail:err];
        }
    }];
}


- (void)updateUserIcon:(NSInteger)userId image:(UIImage *)image
{
    NSData *imageData=UIImagePNGRepresentation(image);
    
    if (imageData.length > 512*512) {
        imageData = UIImageJPEGRepresentation(image, 512*512/imageData.length);
    }
    NSString * imageMd5Str = [imageData md5];
    NSString * baseStr = [imageData base64EncodedStringWithOptions:0];
    NSDictionary *dict = @{@"imagemd5":imageMd5Str,@"image64":baseStr};
    [AFHttpTool requestWithMethod:RequestMethodTypePost url:SERVER_UPLOAD_IMAGE_URL params:dict success:^(id response) {
        if (([[response objectForKey:@"code"] integerValue]==0)||([[response objectForKey:@"code"] integerValue]==-28))
        {
            NSDictionary *d=@{@"userid":@(userId),@"imagemd5":imageMd5Str};
            [AFHttpTool requestWithMethod:RequestMethodTypePost url:SERVER_UPDATE_PERSONAL_INFO params:d success:^(id response) {

                if ([[response objectForKey:@"code"]integerValue]==0){
                    
                    [[UserManager shareInstance] saveCurUserInfo];
    
                    if (_userActionDelegate && [_userActionDelegate respondsToSelector:@selector(didUpdateUserIconSuccess:)])
                    {
                        [_userActionDelegate didUpdateUserIconSuccess:imageMd5Str];
                    }
                }
                else
                {
                    NSError *err = [NSError errorWithDomain:SERVER_HOST code:[[response objectForKey:@"code"] integerValue] userInfo:[NSDictionary dictionaryWithObject:[response objectForKey:@"message"] forKey:NSLocalizedDescriptionKey]];

                    if ((_userActionDelegate && [_userActionDelegate respondsToSelector:@selector(didUpdateUserIconFail:)]))
                    {
                        [_userActionDelegate didUpdateUserIconFail:err];
                    }
                }
                
            } failure:^(NSError *err) {
                if ((_userActionDelegate && [_userActionDelegate respondsToSelector:@selector(didUpdateUserIconFail:)]))
                {
                    [_userActionDelegate didUpdateUserIconFail:err];
                }
            }];
        }
        else
        {
            NSError *err = [NSError errorWithDomain:SERVER_HOST code:[[response objectForKey:@"code"] integerValue] userInfo:[NSDictionary dictionaryWithObject:[response objectForKey:@"message"] forKey:NSLocalizedDescriptionKey]];
            
            if ((_userActionDelegate && [_userActionDelegate respondsToSelector:@selector(didUpdateUserIconFail:)]))
            {
                [_userActionDelegate didUpdateUserIconFail:err];
            }
        }
    } failure:^(NSError *err) {
        
        if ((_userActionDelegate && [_userActionDelegate respondsToSelector:@selector(didUpdateUserIconFail:)]))
        {
            [_userActionDelegate didUpdateUserIconFail:err];
        }
    }];

}




- (void)deleteCuisineById:(NSString *)cusineUrl
{
    [AFHttpTool requestWithMethod:RequestMethodTypeDelete url:cusineUrl params:nil success:^(id response) {
            if (_userActionDelegate && [_userActionDelegate respondsToSelector:@selector(didDelCuisineSuccess)]) {
                [_userActionDelegate didDelCuisineSuccess];
            }
    } failure:^(NSError *err) {
        if ((_userActionDelegate && [_userActionDelegate respondsToSelector:@selector(didDelCuisineFail:)]))
        {
            [_userActionDelegate didDelCuisineFail:err];
        }
    }];
}


- (void)deleteProductById:(NSString *)productUrl
{
    [AFHttpTool requestWithMethod:RequestMethodTypeDelete url:productUrl params:nil success:^(id response) {
            if (_userActionDelegate && [_userActionDelegate respondsToSelector:@selector(didDelProductSuccess)]) {
                [_userActionDelegate didDelProductSuccess];
            }
    } failure:^(NSError *err) {
        if ((_userActionDelegate && [_userActionDelegate respondsToSelector:@selector(didDelProductFail:)]))
        {
            [_userActionDelegate didDelProductFail:err];
        }
    }];
}

- (void)loginWithWeiXinCode:(NSString *)wxCode
{
    NSDictionary *dict = @{@"code":wxCode};
    
    [AFHttpTool requestWithMethod:RequestMethodTypePost url:[GlobalVar shareGlobalVar].wxLoginUrl params:dict success:^(id response) {
        
        UserInfo * userInfo = [[UserInfo alloc] init];
        [userInfo setupUserInfoWithDictionary:response];
        if (_userActionDelegate && [_userActionDelegate respondsToSelector:@selector(didUserLoginSuccess:andPassword:)]) {
            [_userActionDelegate didUserLoginSuccess:userInfo andPassword:nil];
        }
        
    } failure:^(NSError *err) {
        
        if (_userActionDelegate && [_userActionDelegate respondsToSelector:@selector(didUserLoginFailed:error:)]) {
            [_userActionDelegate didUserLoginFailed:nil error:err];
        }
    }];
}

- (void)loginWithMobile:(NSString *)phoneNumber andCode:(NSString *)code
{
    NSDictionary *dict = @{@"mob":phoneNumber , @"code":code};
    [AFHttpTool requestWithMethod:RequestMethodTypePost url:[GlobalVar shareGlobalVar].mobileLoginUrl params:dict success:^(id response) {
        
        UserInfo * userInfo = [[UserInfo alloc] init];
        [userInfo setupUserInfoWithDictionary:response];
        if (_userActionDelegate && [_userActionDelegate respondsToSelector:@selector(didUserLoginSuccess:andPassword:)]) {
            [_userActionDelegate didUserLoginSuccess:userInfo andPassword:nil];
        }
    } failure:^(NSError *err) {
        if (_userActionDelegate && [_userActionDelegate respondsToSelector:@selector(didUserLoginFailed:error:)]) {
            [_userActionDelegate didUserLoginFailed:phoneNumber error:err];
        }
    }];
}

- (void)bindMob:(NSString *)mob  andCode:(NSString *)code
{
    NSDictionary *dict=@{@"mob":mob,@"code":code};
    [AFHttpTool requestWithMethod:RequestMethodTypePost url:[GlobalVar shareGlobalVar].bindingMobileUrl params:dict success:^(id response) {
        
        UserInfo * userInfo = [[UserInfo alloc] init];
        [userInfo setupUserInfoWithDictionary:response];

        if (_userActionDelegate && [_userActionDelegate respondsToSelector:@selector(didUserLoginSuccess:andPassword:)]) {
            [_userActionDelegate didUserLoginSuccess:userInfo andPassword:nil];
        }
    } failure:^(NSError *err) {
        if (_userActionDelegate && [_userActionDelegate respondsToSelector:@selector(didUserLoginFailed:error:)]) {
            [_userActionDelegate didUserLoginFailed:mob error:err];
        }

    }];
}


- (void)getShoppingAddress
{
    [AFHttpTool requestWithMethod:RequestMethodTypeGet url:[GlobalVar shareGlobalVar].shippingAddrUrl params:nil success:^(id response) {
        if (_userActionDelegate && [_userActionDelegate respondsToSelector:@selector(didGetShoppingAddressSuccess:)]) {
            [_userActionDelegate didGetShoppingAddressSuccess:response];
        }
        
    } failure:^(NSError *err) {
        if (_userActionDelegate && [_userActionDelegate respondsToSelector:@selector(didGetShoppingAddressFail:)]) {
            [_userActionDelegate didGetShoppingAddressFail:err];
        }
    }];
}


-(void)createShoppingAddress:(NSString *)mob andName:(NSString *)name  andAddress:(NSString *)address
{
    NSDictionary *dict=@{@"mob":mob,@"name":name,@"address":address};
    [AFHttpTool requestWithMethod:RequestMethodTypePost url:[GlobalVar shareGlobalVar].shippingAddrUrl params:dict success:^(id response) {
        if (_userActionDelegate && [_userActionDelegate respondsToSelector:@selector(didCreateShoppingAddressSuccess)]) {
            [_userActionDelegate didCreateShoppingAddressSuccess];
        }
    } failure:^(NSError *err) {
        if (_userActionDelegate && [_userActionDelegate respondsToSelector:@selector(didCreateShoppingAddressFail:)]) {
            [_userActionDelegate didCreateShoppingAddressFail:err];
        }
    }];
}


- (void)updateShoppingAddress:(NSString *)mob andName:(NSString *)name andAddress:(NSString *)address andAddressId:(NSString *)addressID
{
    NSDictionary *dict=@{@"mob":mob,@"name":name,@"address":address};
    NSString *url=[NSString stringWithFormat:@"%@%@/",[GlobalVar shareGlobalVar].shippingAddrUrl,addressID];
    [AFHttpTool requestWithMethod:RequestMethodTypePatch url:url params:dict success:^(id response) {
        if(_userActionDelegate  && [_userActionDelegate respondsToSelector:@selector(didUpdateShoppingAddressSuccess)])
        {
            [_userActionDelegate didUpdateShoppingAddressSuccess];
        }
    } failure:^(NSError *err) {
        if (_userActionDelegate && [_userActionDelegate respondsToSelector:@selector(didUpdateShoppingAddressFail:)]) {
            [_userActionDelegate didUpdateShoppingAddressFail:err];
        }
    }];
}


-(void)deleteShoppingAddressByID:(NSString *)addressID
{
    NSString *url=[NSString stringWithFormat:@"%@%@/",[GlobalVar shareGlobalVar].shippingAddrUrl,addressID];
    [AFHttpTool requestWithMethod:RequestMethodTypeDelete url:url params:nil success:^(id response) {
        if (_userActionDelegate && [_userActionDelegate respondsToSelector:@selector(didDeleteShoppingAddressSuccess)]) {
            [_userActionDelegate didDeleteShoppingAddressSuccess];
        }
    } failure:^(NSError *err) {
        if (_userActionDelegate && [_userActionDelegate respondsToSelector:@selector(didDeleteShoppingAddressFail:)]) {
            [_userActionDelegate didUpdateShoppingAddressFail:err];
        }
    }];
}

- (void)refreshToken:(NSString *)token
{
    NSDictionary *dict = @{@"token":token};
    [AFHttpTool requestWithMethod:RequestMethodTypePost url:[GlobalVar shareGlobalVar].refreshTokenUrl params:dict success:^(id response) {
        
        UserInfo * userInfo = [[UserInfo alloc] init];
        [userInfo setupUserInfoWithDictionary:response];
        if (_userActionDelegate && [_userActionDelegate respondsToSelector:@selector(didRefreshTokeSuccess:)]) {
            [_userActionDelegate didRefreshTokeSuccess:userInfo];
        }
        
    } failure:^(NSError *err) {
        
        NSInteger errCode = [err.userInfo[kAFNetWorkStatusCodeKey] integerValue];
        if (errCode > 0) {
            if (_userActionDelegate && [_userActionDelegate respondsToSelector:@selector(didRefreshTokeFailed:error:)]) {
                [_userActionDelegate didRefreshTokeFailed:nil error:err];
            }
        }
    }];
}




@end
