//
//  UIViewController+Helper.m
//  cyxmap
//
//  Created by zouting on 6/26/13.
//  Copyright (c) 2013 Chang Yi Xing. All rights reserved.
//

#import "MBProgressHUD+Helper.h"
#import "MBProgressHUD.h"
#import "UIImage+GIF.h"
#import "GlobalVar.h"
#import "CookBookError.h"

@implementation MBProgressHUD (Helper)

// hudParentView finds the best view for MBProgressHUD.
// Generally it is the window at the top of application.

//+ (MBProgressHUD *)shareView
//{
//    static MBProgressHUD * hud;
//    if (!hud) {
//        hud = [[MBProgressHUD alloc] init];
//    }
//    return hud;
//}

+ (UIView *)hudParentView
{
    UIWindow *w = nil;
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows) {
        BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
        BOOL windowIsVisible = !window.hidden && window.alpha > 0;
        BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
        
        if(windowOnMainScreen && windowIsVisible && windowLevelNormal) {
            w = window;
            break;
        }
    }
    
//    UIWindow *w = nil;
//    NSArray *windows = [[UIApplication sharedApplication] windows];
//    
//    // If keyboard exists(windows.count>1), we use keyboard window
//    if (windows.count>1)
//        w = [windows objectAtIndex:1];
//    else
//        w = [windows objectAtIndex:0];
    
    return w;
}

+ (MBProgressHUD *)findHud
{
    UIView *parentView = [self hudParentView];
    for (id v in parentView.subviews) {
        if ([v isKindOfClass:[MBProgressHUD class]])
            return v;
    }
    
    return nil;
}

+ (MBProgressHUD *)findOrCreateHud
{
    MBProgressHUD *hud = [self findHud];
    if (hud==nil) {
        UIView *parentView = [self hudParentView];
        hud = [[MBProgressHUD alloc] initWithView:parentView];
//        hud = [MBProgressHUD shareView];
        [parentView addSubview:hud];
    }
    
    return hud;
}

+ (void)showLoadingWithDim:(BOOL)dimBackground
{
    MBProgressHUD *hud = [self findOrCreateHud];
    hud.mode = MBProgressHUDModeCustomView;
    hud.color = [UIColor clearColor];
    hud.labelText = nil;
    hud.dimBackground = dimBackground;
    hud.userInteractionEnabled = dimBackground;
    UIImage  *image=[UIImage sd_animatedGIFNamed:@"hudloading"];
    hud.yOffset = 0;
    int fator = 2;
    if ([UIScreen mainScreen].scale > 2) {
        fator = 1;
    }
    UIImageView  *gifview=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,image.size.width/fator, image.size.height/fator)];
    gifview.image = image;
    hud.customView = gifview;
    
    [hud show:YES];
}

+ (void)showHUD:(NSString *)text
{
    MBProgressHUD *hud = [self findOrCreateHud];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = text;
    hud.dimBackground = YES;
    
    [hud show:YES];
}

+ (void)showHUDAutoDismissWithString:(NSString *)text andDim:(BOOL)dimBackground
{
    MBProgressHUD *hud = [self findOrCreateHud];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = nil;
    hud.detailsLabelText = text;
    hud.detailsLabelFont = [UIFont systemFontOfSize:15];
    hud.color = [UIColor darkGrayColor];
    hud.margin = 12;
    hud.dimBackground = dimBackground;
    hud.userInteractionEnabled = dimBackground;
    hud.cornerRadius = 8.0;
    
    CGRect frame = hud.frame;
    
    if ([GlobalVar shareGlobalVar].bKeyboardIsShow) {
        hud.yOffset = 0;
    } else {
        hud.yOffset = frame.size.height/2-frame.size.height/5;
    }
    
    [hud show:YES];
    
    [self cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(dismissHUD) withObject:nil afterDelay:2.5];
}

+ (void)showHUDAutoDismiss:(NSString *)text detailedText:(NSString *)detailed
{
    MBProgressHUD *hud = [self findOrCreateHud];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.detailsLabelText = detailed;
    hud.dimBackground = YES;
    
    [hud show:YES];
    [self performSelector:@selector(dismissHUD) withObject:nil afterDelay:2];
    
}

+ (void)showHUDAutoDismissWithError:(NSError *)error andDim:(BOOL)dimBackground
{
    NSInteger errCode = [error.userInfo[kAFNetWorkStatusCodeKey] integerValue];
    NSString *text = [CookBookError descriptionForIntCode:errCode];
    
    if (!text.length) {
        text = error.userInfo[NSLocalizedDescriptionKey];
    }
    if (!text.length) {
        text = [NSString stringWithFormat:@"未知错误:%ld,%ld", error.code,errCode];
    }

    [self showHUDAutoDismissWithString:text andDim:dimBackground];
}


+ (void)dismissHUD
{
    MBProgressHUD *hud = [self findHud];

    if (hud) {
        [hud removeFromSuperview];
    }
}

@end
