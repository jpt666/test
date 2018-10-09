//
//  UserInfo.m
//  CookBook
//
//  Created by zhangxi on 16/4/13.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "UserInfo.h"

static NSString * kPropertyToken = @"token";
static NSString * kPropertyFlag = @"flag";

static NSString * kPropertyMobUser = @"mob_user";
static NSString * kMobMobile = @"mob";
static NSString * kMobWXNickName = @"wx_nickname";
static NSString * kMobWXHeadUrl = @"wx_headimgurl";

static NSString * kPropertyUser = @"user";
static NSString * kUserId = @"id";
static NSString * kUserName = @"name";
static NSString * kUserRecentObtainName = @"recent_obtain_name";
static NSString * kUserRecentObtainMobile = @"recent_obtain_mob";

static NSString * kPropertyResellerApplyState = @"state";

static NSString * kPropertyReseller = @"reseller";
static NSString * kPropertyDispatcher = @"dispatcher";

static NSString * kUserBalance = @"balance";

@implementation UserInfo
{
    NSMutableDictionary * _dictAllInfo;
    
    NSMutableDictionary * _dictUser;
    NSMutableDictionary * _dictMobUser;
    NSMutableDictionary * _dictReseller;
    NSMutableDictionary * _dictDispatcher;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
//        _userId = @"";
//        _nickName = @"";
//        _photoUrl = @"";
//        _photoUrl = [NSString stringWithFormat:@"%@%@",SERVER_IMAGE_ACCESS_URL,[[[NSUserDefaults standardUserDefaults] objectForKey:@"UserInfo"] objectForKey:@"imagemd5"]];
    }
    return self;
}


//@property (nonatomic, strong) NSString * userId;
//@property (nonatomic, strong) NSString * nickName;
//@property (nonatomic, strong) NSString * sessionId;
//@property (nonatomic, strong) NSString * tel;
//@property (nonatomic, strong) NSString * photoUrl;
//@property (nonatomic, strong) NSString * homeTown;
//@property (nonatomic, assign) NSInteger favorNum;
//@property (nonatomic, assign) NSInteger fansNum;
//@property (nonatomic, assign) NSInteger followNum;
//@property (nonatomic, assign) BOOL male;
//@property (nonatomic, assign) long long  registerTime;

//-(id)initWithCoder:(NSCoder *)aDecoder
//{
//    NSLog(@"调用了initWithCoder:方法");
//    //注意：在构造方法中需要先初始化父类的方法
//    if (self=[super init])
//    {
//        self.userId=[aDecoder decodeObjectForKey:@"userId"];
//        self.nickName=[aDecoder decodeObjectForKey:@"nickName"];
//        self.sessionId=[aDecoder decodeObjectForKey:@"sessionId"];
//        self.tel=[aDecoder decodeObjectForKey:@"tel"];
//        self.photoUrl=[aDecoder decodeObjectForKey:@"photoUrl"];
//        self.homeTown=[aDecoder decodeObjectForKey:@"homeTown"];
//        self.favorNum=[aDecoder decodeIntegerForKey:@"favorNum"];
//        self.fansNum=[aDecoder decodeIntegerForKey:@"fansNum"];
//        self.followNum=[aDecoder decodeIntegerForKey:@"followNum"];
//        self.male=[aDecoder decodeBoolForKey:@"male"];
//        self.registerTime=[aDecoder decodeDoubleForKey:@"registerTime"];
//    }
//    return self;
//}
//
//
//
//-(void)encodeWithCoder:(NSCoder *)aCoder
//{
//    NSLog(@"调用了encodeWithCoder:方法");
//    [aCoder encodeObject:self.userId forKey:@"userId"];
//    [aCoder encodeObject:self.nickName forKey:@"nickName"];
//    [aCoder encodeObject:self.sessionId forKey:@"sessionId"];
//    [aCoder encodeObject:self.sessionId forKey:@"tel"];
//    [aCoder encodeObject:self.sessionId forKey:@"photoUrl"];
//    [aCoder encodeObject:self.sessionId forKey:@"homeTown"];
//    [aCoder encodeInteger:self.favorNum forKey:@"favorNum"];
//    [aCoder encodeInteger:self.fansNum forKey:@"fansNum"];
//    [aCoder encodeInteger:self.followNum forKey:@"followNum"];
//    [aCoder encodeBool:self.male forKey:@"male"];
//    [aCoder encodeDouble:self.registerTime forKey:@"registerTime"];
//    
//}
//

-(void)setupUserInfoWithDictionary:(NSMutableDictionary *)dict
{
    _dictAllInfo = dict;
    
    _dictMobUser = dict[kPropertyMobUser];
    _dictUser = dict[kPropertyUser];
    _dictReseller = dict[kPropertyReseller];
    _dictDispatcher = dict[kPropertyDispatcher];
    
    _roleFlag = [dict[kPropertyFlag] integerValue];
    
    _token = _dictAllInfo[kPropertyToken];
    
    _userId = [_dictUser[kUserId] integerValue];
    _nickName = _dictUser[kUserName];
    _mobileNumber = _dictMobUser[kMobMobile];
    
    _resellerId = [_dictReseller[kUserId] integerValue];
    _resellerApplyState = [_dictReseller[kPropertyResellerApplyState] integerValue];
}

- (void)setToken:(NSString *)token
{
    _token = token;
    _dictAllInfo[kPropertyToken] = token;
}

- (void)setUserId:(NSInteger )userId
{
    _userId = userId;
    _dictMobUser[kUserId] = @(userId);
}

- (void)setPhoneNumber:(NSString *)mobileNumber
{
    _mobileNumber = mobileNumber;
    _dictMobUser[kMobMobile] = mobileNumber;
}

- (NSInteger)balanceMoney
{
    return [_dictUser[kUserBalance] integerValue];
}

- (NSInteger)couponNum
{
    return 0;
}

- (NSString *)recentObtainName
{
    return _dictUser[kUserRecentObtainName];
}

- (NSString *)recentObtainMobile
{
    return _dictUser[kUserRecentObtainMobile];
}

- (void)setRecentObtainName:(NSString *)recentObtainName
{
    _dictUser[kUserRecentObtainName] = recentObtainName;
}

- (void)setRecentObtainMobile:(NSString *)recentObtainMobile
{
    _dictUser[kUserRecentObtainMobile] = recentObtainMobile;
}

-(NSString *)getUserPhotoUrl
{
//    return _photoUrl;
//   return [NSString stringWithFormat:@"%@%@",SERVER_IMAGE_ACCESS_URL,_photoUrl];
    return _dictMobUser[kMobWXHeadUrl];
}

-(NSString *)getNickName
{
    return _nickName;
//    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"UserInfo"] objectForKey:@"nickname"];
}

@end
