//
//  UIHookApplication.m
//  CookBook
//
//  Created by zhangxi on 16/5/23.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "UIHookApplication.h"


@implementation UIHookApplication

-(void)sendEvent:(UIEvent *)event
{
    if (event.type == UIEventTypeTouches) {
        UITouchPhase touchPhase = [event.allTouches anyObject].phase;
        
        if (touchPhase == UITouchPhaseBegan) {
            [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:NotifyScreenTouchBegin object:[event.allTouches anyObject] userInfo:nil]];
        } else if (touchPhase == UITouchPhaseMoved) {
            [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:NotifyScreenTouchMoved object:[event.allTouches anyObject] userInfo:nil]];
        } else if (touchPhase == UITouchPhaseEnded ||
                   touchPhase == UITouchPhaseCancelled) {
            [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:NotifyScreenTouchEnded object:[event.allTouches anyObject] userInfo:nil]];
        }
    }
    
    [super sendEvent:event];
}

@end
