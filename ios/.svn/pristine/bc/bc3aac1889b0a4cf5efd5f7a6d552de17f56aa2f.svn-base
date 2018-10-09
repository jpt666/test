//
//  CustomTextField.m
//  CookBook
//
//  Created by zhangxi on 16/5/12.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "UICustomTextField.h"

@implementation UICustomTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.origin.x+10, bounds.origin.y+5.5, 20, 20);
}

-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.origin.x+33, bounds.origin.y, bounds.size.width-66, bounds.size.height);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    if (self.text.length) {
        return CGRectMake(bounds.origin.x+10, bounds.origin.y, bounds.size.width-20, bounds.size.height);
    } else {
        return CGRectMake(bounds.origin.x+32, bounds.origin.y, bounds.size.width-64, bounds.size.height);
    }
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.origin.x+35, bounds.origin.y, bounds.size.width-70, bounds.size.height);
}

@end
