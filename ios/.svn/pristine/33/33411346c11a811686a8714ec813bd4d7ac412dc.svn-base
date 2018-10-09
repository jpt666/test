//
//  UnEditTextView.m
//  CookBook
//
//  Created by 你好 on 16/9/8.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "UnEditTextView.h"

@implementation UnEditTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if ([UIMenuController sharedMenuController]) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}

@end
