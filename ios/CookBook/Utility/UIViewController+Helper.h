//
//  UIViewController+Helper.h
//  cyxmap
//
//  Created by zouting on 6/26/13.
//  Copyright (c) 2013 Chang Yi Xing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface UIViewController (Helper)

- (void)showHUD:(NSString *)text;
- (void)showHUDAutoDismiss:(NSString *)text;
- (void)showHUDAutoDismiss:(NSString *)text detailedText:(NSString *)detailed;
- (void)dismissHUD;

// High level hud method
- (MBProgressHUD *)findOrCreateHud;

@end
