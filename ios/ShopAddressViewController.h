//
//  ShopAddressViewController.h
//  CookBook
//
//  Created by 你好 on 16/6/7.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResponderViewController.h"

typedef enum _EnterAddressType{
    MyShoppingAddress,
    SelectShoppingAddress
}EnterAddressType;

@interface ShopAddressViewController : ResponderViewController

@property (nonatomic)EnterAddressType enterAddressType;
@property (nonatomic,copy) void (^backValue)(NSDictionary *dict);

@end
