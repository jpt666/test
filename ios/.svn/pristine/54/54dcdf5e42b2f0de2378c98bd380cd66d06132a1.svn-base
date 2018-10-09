//
//  GlobalVar.h
//  CookBook
//
//  Created by zhangxi on 16/4/11.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    //im group operate
    UI_EVENT_USER_LOGIN_SUCC,
    UI_EVENT_USER_LOGIN_FAILED,
    UI_EVENT_USER_LOGOUT,
    UI_EVENT_USER_REGIST_SUCC,
    UI_EVENT_USER_REGIST_FAILED,
    UI_EVENT_USER_UPDATE_ICON_SUCC,
    UI_EVENT_USER_UPDATE_ICON_FAILED,
    UI_EVENT_USER_UPDATE_NICKNAME_SUCC,
    UI_EVENT_USER_UPDATE_NICKNAME_FAILED,
    UI_EVENT_USER_GET_MORE_CUISINE_SUCC,
    UI_EVENT_USER_GET_MORE_CUISINE_FAILED,
    UI_EVENT_USER_GET_MORE_PRODUCT_SUCC,
    UI_EVENT_USER_GET_MORE_PRODUCT_FAILED,
    UI_EVENT_USER_DELETE_CUISINE_SUCC,
    UI_EVENT_USER_DELETE_CUISINE_FAILED,
    UI_EVENT_USER_DELETE_PRODUCT_SUCC,
    UI_EVENT_USER_DELETE_PRODUCT_FAILED,
//    UI_EVENT_USER_GET_RECOMMEND_SUCC,
//    UI_EVENT_USER_GET_RECOMMEND_FAILED,

    UI_EVENT_USER_WXAUTH_DENIED,
    UI_EVENT_USER_WXAUTH_CANCEL,
    UI_EVENT_USER_GET_SHOPPINGADRESS_SUCC,
    UI_EVENT_USER_GET_SHOPPINGADRESS_FAILED,
    UI_EVENT_USER_CREATE_ADDRESS_SUCC,
    UI_EVENT_USER_CREATE_ADDRESS_FAILED,
    UI_EVENT_USER_UPDATE_ADDRESS_SUCC,
    UI_EVENT_USER_UPDATE_ADDRESS_FAILED,
    UI_EVENT_USER_DELETE_ADDRESS_SUCC,
    UI_EVENT_USER_DELETE_ADDRESS_FAILED,
    UI_EVENT_USER_BIND_MOB_SUCC,
    UI_EVENT_USER_BIND_MOB_FAILED,
//    UI_EVENT_USER_GET_HOMEPAGELIST_SUCC,
//    UI_EVENT_USRE_GET_HOMEPAGELIST_FAILED,
    
    UI_EVENT_USER_AUTH_FAILED
}AppEventType;


#define NOTIFY_REFRESH_COOK_CUISINE @"NOTIFY_REFRESH_COOK_CUISINE"
#define NOTIFY_REFRESH_COOK_PRODUCT @"NOTIFY_REFRESH_COOK_PRODUCT"


@interface GlobalVar : NSObject

@property (nonatomic, strong) NSString * photosDirectory;
@property (nonatomic, strong) dispatch_queue_t uploadImagesQueue;
@property (nonatomic, strong) UIFont * sysSmallFont;
@property (nonatomic, strong) UIFont * sysMediumFont;
@property (nonatomic, strong) UIFont * sysBigFont;
@property (nonatomic, strong) UIFont * sysLargeFont;
@property (nonatomic, strong) UIFont * sysBoldMediumFont;

@property (nonatomic, assign) BOOL bKeyboardIsShow;
@property (nonatomic, assign) BOOL bNetworkInitialed;

@property (nonatomic, strong) NSString * bulkListUrl;
@property (nonatomic, strong) NSString * wxLoginUrl;
@property (nonatomic, strong) NSString * mobileLoginUrl;
@property (nonatomic, strong) NSString * refreshTokenUrl;
@property (nonatomic, strong) NSString * orderUrl;
@property (nonatomic, strong) NSString * shippingAddrUrl;
@property (nonatomic, strong) NSString * bindingMobileUrl;
@property (nonatomic, strong) NSString * imagesUrl;
@property (nonatomic, strong) NSString * cookRecipesUrl;
@property (nonatomic, strong) NSString * cookDishsUrl;
@property (nonatomic, strong) NSString * recipeIndexUrl;
@property (nonatomic, strong) NSString * businessIndexUrl;
@property (nonatomic, strong) NSString * smsCodeUrl;
@property (nonatomic, strong) NSString * apiRootUrl;
@property (nonatomic, strong) NSString * productCategoryUrl;
@property (nonatomic, strong) NSString * listInCategoryUrl;
@property (nonatomic, strong) NSString * bulkSummarysUrl;
@property (nonatomic, strong) NSString * storagesUrl;
@property (nonatomic, strong) NSString * applyResellerUrl;
@property (nonatomic, strong) NSString * applyProtocolUrl;
@property (nonatomic, strong) NSString * userInfoUrl;
//@property (nonatomic, strong) NSString * 

+(GlobalVar *)shareGlobalVar;
+(NSString *)getUUID;

- (void)setResponderViewController:(UIViewController *)vc;

- (void)notifyEvent:(AppEventType)type object:(id)object;

@end
