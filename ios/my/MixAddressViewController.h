//
//  MixAddressViewController.h
//  CookBook
//
//  Created by 你好 on 16/9/6.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResponderViewController.h"
#import "GroupsPropertyKeys.h"

@interface MixAddressViewController : ResponderViewController

@property (nonatomic,retain)NSDictionary *dict;
//@property (nonatomic,strong)NSMutableArray * arrShipAddress;
//@property (nonatomic,strong)NSNumber * curShipId;

@property (nonatomic,strong) void (^selecetAddrCompleted)(ReceiveMode reciveMode ,NSDictionary *dict, NSString *selectedName, NSString * selectedMob, NSMutableArray * arrShipAddress);

@property (nonatomic,strong) void (^cancelSelect)(NSMutableArray * arrShipAddress);


@end
