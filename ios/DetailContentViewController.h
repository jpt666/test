//
//  DetailContentViewController.h
//  CookBook
//
//  Created by 你好 on 16/4/20.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CookBaseProxy.h"
#import "ResponderViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface DetailContentViewController :ResponderViewController

@property (nonatomic)CookType cookType;
@property(nonatomic,strong)NSDictionary *dict;

@end
