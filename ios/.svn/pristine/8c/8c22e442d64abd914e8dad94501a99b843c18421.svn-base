//
//  GlobalVar.m
//  CookBook
//
//  Created by zhangxi on 16/4/11.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "GlobalVar.h"
#import "AFNetworking.h"
#import "CookDataManager.h"
#import "UserManager.h"
#import "ResponderViewController.h"
#import "RetrieveRequest.h"

@interface GlobalVar()<RetrieveRequestDelegate>

@end

@implementation GlobalVar
{
    ResponderViewController *_curVC;
    RetrieveRequest * _apiUrlRequest;
    BOOL _bApiUrlInitialed;
}

+(GlobalVar *)shareGlobalVar
{
    static GlobalVar * instance = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initBusinessUrls];
        
        [self createPhotosDirectory];
        [self createUploadImageQueue];
        
        [self createNetworkMoniter];
        [self createSystemFont];
        
        [self createNotification];
        
//        [[CookDataManager shareInstance] retrieveCookDataDrafts];
    }
    return self;
}



- (void)setResponderViewController:(ResponderViewController *)vc
{
    _curVC = vc;
}

- (void)notifyEvent:(AppEventType)type object:(id)object
{
    if ([NSThread isMainThread]) {
        if (_curVC && [_curVC respondsToSelector:@selector(onEventAction:object:)]) {
            [_curVC onEventAction:type object:object];
        }
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_curVC && [_curVC respondsToSelector:@selector(onEventAction:object:)]) {
                [_curVC onEventAction:type object:object];
            }
        });
    }
}

- (void)initBusinessUrls
{
    self.apiRootUrl = API_ROOT_URL;
    self.bulkListUrl = BULKLIST_URL;
    self.wxLoginUrl = WXLOGIN_URL;
    self.mobileLoginUrl = MOBILELOGIN_URL;
    self.refreshTokenUrl = REFRESHTOKEN_URL;
    self.orderUrl = ORDER_URL;
    self.shippingAddrUrl = SHIPPINGADDR_URL;
    self.bindingMobileUrl = BINDINGMOBILE_URL;
    self.imagesUrl = IMAGES_URL;
    self.cookRecipesUrl = COOKRECIPES_URL;
    self.cookDishsUrl = COOKDISHS_URL;
    self.recipeIndexUrl = RECIPEINDEX_URL;
    self.businessIndexUrl = BUSINESSINDEX_URL;
    self.smsCodeUrl = SMSCODE_URL;
    self.productCategoryUrl = PRODUCTCATEGORY_URL;
    self.listInCategoryUrl = LISTINCATEGORY_URL;
    self.bulkSummarysUrl = BULKSUMMARYS_URL;
    self.storagesUrl = STORAGES_URL;
    self.applyResellerUrl = APPLY_RESELLER_URL;
    self.applyProtocolUrl = APPLY_PROTOCOL_URL;
    self.userInfoUrl = USERINFO_URL;
}

- (void)retrieveBusinessUrls
{
    if (_apiUrlRequest) {
        [_apiUrlRequest cancel];
    }
    _apiUrlRequest = [[RetrieveRequest alloc] init];
    _apiUrlRequest.delegate = self;
    [_apiUrlRequest getRequestWithUrl:self.apiRootUrl andParam:nil];
}

- (void)createPhotosDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    _photosDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"photos"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:_photosDirectory]) {
        
        NSError * err;
        [[NSFileManager defaultManager] createDirectoryAtPath:_photosDirectory withIntermediateDirectories:YES attributes:nil error:&err];
        
        NSLog(@"%@", err);
    }
}

- (void)createUploadImageQueue
{
    _uploadImagesQueue = dispatch_queue_create("UploadImages", DISPATCH_QUEUE_SERIAL);
}

- (void)createNetworkMoniter
{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        self.bNetworkInitialed = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:AFNetworkingReachabilityDidChangeNotification object:@(status)];
        
        if (status == AFNetworkReachabilityStatusReachableViaWiFi) {
//            [[CookDataManager shareInstance] recoverCookUploading];
        }
        
        if (status != AFNetworkReachabilityStatusUnknown &&
            status != AFNetworkReachabilityStatusNotReachable) {
            [[UserManager shareInstance] refreshToken:YES];
            
            if (!_bApiUrlInitialed) {
                [self retrieveBusinessUrls];
            }
        }
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (void)createSystemFont
{
    self.sysSmallFont = [UIFont systemFontOfSize:14];
    self.sysMediumFont = [UIFont systemFontOfSize:16];
    self.sysBigFont = [UIFont systemFontOfSize:20];
    self.sysLargeFont = [UIFont systemFontOfSize:24];
    self.sysBoldMediumFont = [UIFont boldSystemFontOfSize:16];
}

- (void)createNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}

- (void)removeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

+(NSString *)getUUID
{
    CFUUIDRef uuidObj = CFUUIDCreate(nil);
    NSString *uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj);
    return uuidString;
}

-(void)keyboardDidShow:(NSNotification *)notification
{
    self.bKeyboardIsShow = YES;
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    self.bKeyboardIsShow = NO;
}

-(void)dealloc
{
    [self removeNotification];
}


-(void)didRetrieveDataSuccess:(RetrieveRequest *)request
{
    if (request == _apiUrlRequest) {
        _bApiUrlInitialed = YES;
        
        self.bulkListUrl = request.rawData[@"bulks"];
        self.wxLoginUrl = request.rawData[@"weixin"];
        self.mobileLoginUrl = request.rawData[@"login"];
        self.refreshTokenUrl = request.rawData[@"refresh"];
        self.orderUrl = request.rawData[@"orders"];
        self.shippingAddrUrl = request.rawData[@"shippingaddresses"];
        self.bindingMobileUrl = request.rawData[@"bind"];
        self.imagesUrl = request.rawData[@"images"];
        self.cookRecipesUrl = request.rawData[@"recipes"];
        self.cookDishsUrl = request.rawData[@"dishs"];
        self.recipeIndexUrl = request.rawData[@"recipeIndex"];
        self.businessIndexUrl = request.rawData[@"index"];
        self.smsCodeUrl = request.rawData[@"sms"];
    }
}

-(void)didRetrieveDataFailed:(RetrieveRequest *)request
{
    
}

@end
