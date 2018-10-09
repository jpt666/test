//
//  UserInfo.h
//  CookBook
//
//  Created by zhangxi on 16/4/13.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <Foundation/Foundation.h>

//@interface Reseller : NSObject
//
//@property (nonatomic, strong) NSString * resellerId;
//@property (nonatomic, strong) NSString * name;
//@property (nonatomic, strong) NSString * tail;
//@property (nonatomic, assign) long long createTime;
//
//@end
//
//@interface Dispatcher : NSObject
//
//@property (nonatomic, strong) NSString * dispatcherId;
//@property (nonatomic, strong) NSString * name;
//@property (nonatomic, strong) NSString * tail;
//@property (nonatomic, strong) NSString * address;
//@property (nonatomic, assign) long long createTime;
//@property (nonatomic, assign) long long openingTime;
//@property (nonatomic, assign) long long closingTime;
//
//@end

typedef NS_ENUM(NSInteger, ApplyState) {
    StateUnapply = 0,
    StateReview = 1,
    StateApprove = 2
};


@interface UserInfo : NSObject

@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, strong) NSString * nickName;
@property (nonatomic, strong) NSString * token;
@property (nonatomic, strong) NSString * mobileNumber;
//@property (nonatomic, strong) NSString * tel;
@property (nonatomic, strong) NSString * photoUrl;

@property (nonatomic, assign) NSInteger roleFlag;

@property (nonatomic, assign) NSInteger resellerId;
@property (nonatomic, assign) NSInteger resellerApplyState;

@property (nonatomic, strong) NSString * recentObtainName;
@property (nonatomic, strong) NSString * recentObtainMobile;

@property (nonatomic, assign) NSInteger balanceMoney;//余额
@property (nonatomic, assign) NSInteger couponNum;//优惠券


-(void)setupUserInfoWithDictionary:(NSMutableDictionary *)dict;


-(NSString *)getUserPhotoUrl;

-(NSString *)getNickName;

@end
