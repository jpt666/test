//
//  ResponderViewController.h
//  CookBook
//
//  Created by zhangxi on 16/5/10.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalVar.h"

@interface ResponderViewController : UIViewController

- (void)onEventAction:(AppEventType)type object:(id)object;

@property (nonatomic,strong)void(^usePuzzleImage)(UIImage *image);

@end
