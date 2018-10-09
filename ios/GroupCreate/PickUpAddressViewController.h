//
//  PickUpAddressViewController.h
//  CookBook
//
//  Created by 你好 on 16/8/11.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickUpAddressViewController : UIViewController

@property (nonatomic, strong) NSMutableArray * selectedAddr;
@property (nonatomic, strong) void(^selectComplete)(NSMutableArray *selected);

@end
