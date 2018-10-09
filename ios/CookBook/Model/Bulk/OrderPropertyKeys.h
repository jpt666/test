//
//  OrderPropertyKeys.h
//  CookBook
//
//  Created by zhangxi on 16/6/15.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#ifndef OrderPropertyKeys_h
#define OrderPropertyKeys_h
typedef enum _OrderStatus{
    OutOfDateOrder=-1,//已过期
    NotPayOrder=0,//未支付
    FinishedPayOrder=1,//已支付
    SendOutOrder=2,//已发货
    WaitForPickUpOrder=3,//待取货
    FinishOrder=4//已完成
}OrderStatus;

typedef enum _OrderErrorCode{
    ErrorGoodsLimit=-1,//已过期
    ErrorGoodsNotEnough =-2,//未支付
}OrderErrorCode;

extern const NSString * const kOrderPropertyId; // id
extern const NSString * const kOrderPropertyStatus;
extern const NSString * const kOrderPropertyTotalFee;

extern const NSString * const kOrderPropertyReseller;   //团主

extern const NSString * const kOrderPropertyCount;    //
extern const NSString * const kOrderPropertyCovers;

extern const NSString * const kOrderPropertyCreateTime;    //创建时间
extern const NSString * const kOrderPropertyDetailUrl;    //详情url

extern const NSString * const kOrderPropertyBulkStatus;


extern const NSString * const kOrderPropertyObtainName;
extern const NSString * const kOrderPropertyObtainMobile;

extern const NSString * const kOrderPropertyRecieveName;
extern const NSString * const kOrderPropertyRecieveMobile;
extern const NSString * const kOrderPropertyRecieveAddress;

extern const NSString * const kOrderPropertyDispatcher;
extern const NSString * const kOrderPropertyFreight;
extern const NSString * const kOrderPropertyGoods;

extern const NSString * const kOrderPropertyWXPayUrl;

extern const NSString * const kOrderPropertyDictionaryPayInfo;
extern const NSString * const kOrderPropertyThirdPartyFee;
extern const NSString * const kOrderPropertyBalanceFee;

extern const NSString * const kOrderPropertyCardTitle;
extern const NSString * const kOrderPropertyCardDesc;
extern const NSString * const kOrderPropertyCardIcon;
extern const NSString * const kOrderPropertyCardUrl;
extern const NSString * const kOrderPropertyRelaySeq;

extern const NSString * const kOrderPropertyErrorCode;
extern const NSString * const kOrderPropertyDetail;

#endif /* OrderPropertyKeys_h */
