//
//  EditPickUpAddressViewController.h
//  CookBook
//
//  Created by 你好 on 16/8/11.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResponderViewController.h"
typedef enum _AddressType{
    EditAddress,
    CreateAddress
}AddressType;



@interface EditPickUpAddressViewController :ResponderViewController

@property (nonatomic,assign)AddressType addressType;
@property (nonatomic,strong)NSDictionary *dictOrg;

@property (nonatomic,strong)void(^editFinish)(NSDictionary *dict);
@property (nonatomic,strong)void(^createFinish)(NSDictionary *dict);
@property (nonatomic,strong)void(^deleteFinish)(NSDictionary *dict);

@end
