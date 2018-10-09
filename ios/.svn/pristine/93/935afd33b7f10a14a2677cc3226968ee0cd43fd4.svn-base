//
//  UIViewController+Helper.m
//  cyxmap
//
//  Created by zouting on 6/26/13.
//  Copyright (c) 2013 Chang Yi Xing. All rights reserved.
//

#import "UIViewController+Helper.h"
#import "MBProgressHUD.h"

@implementation UIViewController (Helper)

// hudParentView finds the best view for MBProgressHUD.
// Generally it is the window at the top of application.
- (UIView *)hudParentView
{
    UIWindow *w = nil;
    NSArray *windows = [[UIApplication sharedApplication] windows];
    
    // If keyboard exists(windows.count>1), we use keyboard window
    if (windows.count>1)
        w = [windows objectAtIndex:1];
    else
        w = [windows objectAtIndex:0];
    
    return w;
}

- (MBProgressHUD *)findHud
{
    UIView *parentView = [self hudParentView];
    for (id v in parentView.subviews) {
        if ([v isKindOfClass:[MBProgressHUD class]])
            return v;
    }
    
    return nil;
}

- (MBProgressHUD *)findOrCreateHud
{
    MBProgressHUD *hud = [self findHud];
    if (hud==nil) {
        UIView *parentView = [self hudParentView];
        hud = [[MBProgressHUD alloc] initWithView:parentView];
        [parentView addSubview:hud];
    }
    
    return hud;
}

- (void)showHUD:(NSString *)text
{
    MBProgressHUD *hud = [self findOrCreateHud];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = text;
    hud.dimBackground = YES;
    
    [hud show:YES];
}

- (void)showHUDAutoDismiss:(NSString *)text
{
    MBProgressHUD *hud = [self findOrCreateHud];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.dimBackground = NO;
    hud.cornerRadius = 20.0;
    
    CGRect frame = hud.frame;
    hud.yOffset = frame.size.height/2-frame.size.height/5;
    
    [hud show:YES];
    [self performSelector:@selector(dismissHUD) withObject:nil afterDelay:2];
}

- (void)showHUDAutoDismiss:(NSString *)text detailedText:(NSString *)detailed
{
    MBProgressHUD *hud = [self findOrCreateHud];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.detailsLabelText = detailed;
    hud.dimBackground = YES;
    
    [hud show:YES];
    [self performSelector:@selector(dismissHUD) withObject:nil afterDelay:2];
    
}


- (void)dismissHUD
{
    MBProgressHUD *hud = [self findHud];

    if (hud) {
        [hud removeFromSuperview];
    }
}

@end
