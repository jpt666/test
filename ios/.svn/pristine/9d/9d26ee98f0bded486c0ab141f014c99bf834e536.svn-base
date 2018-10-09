//
//  EditShopAddressViewController.h
//  CookBook
//
//  Created by 你好 on 16/6/12.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResponderViewController.h"
typedef enum _AddressType{
    EditAddress,
    CreateAddress
}AddressType;


@interface EditShopAddressViewController : ResponderViewController

@property (nonatomic)AddressType addressType;
@property (nonatomic,strong)NSMutableDictionary *dict;
@property (nonatomic,strong)void (^editFinish)(NSMutableDictionary * dict);
@property (nonatomic,strong)void (^deleteFinish)(NSMutableDictionary * dict);
@property (nonatomic,strong)void (^createFinish)();

@end
