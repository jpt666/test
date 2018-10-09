//
//  BottomView.m
//  CookBook
//
//  Created by 你好 on 16/4/14.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "BottomView.h"

@implementation BottomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    self= [super initWithFrame:frame];
    if (self)
    {
        self.userInteractionEnabled=YES;
        [self configUI];
    }
    return self;
}


-(void)configUI
{
//    self.layer.borderColor=[UIColor lightTextColor].CGColor;
//    self.layer.borderWidth=0.5f;
    
    self.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.7];
    
//    UIBlurEffect * blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
//    UIVisualEffectView * effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
//    effectView.frame = self.bounds;
//    effectView.alpha = 0.5f;
//    [self addSubview:effectView];

    self.leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.leftButton.frame=CGRectMake(10, roundf((self.bounds.size.height-30)/2), 80, 30);
    self.leftButton.backgroundColor=[UIColor clearColor];
    self.leftButton.layer.borderWidth=0.5f;
    self.leftButton.layer.cornerRadius=15;
    self.leftButton.layer.borderColor=[UIColor lightGrayColor].CGColor;
    [self addSubview:self.leftButton];
    
    self.rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.frame=CGRectMake(ScreenWidth-90, roundf((self.bounds.size.height-30)/2), 80, 30);
    self.rightButton.backgroundColor=[UIColor clearColor];
    self.rightButton.layer.cornerRadius=15;
    self.rightButton.layer.borderWidth=0.5f;
    self.rightButton.layer.borderColor=[UIColor lightGrayColor].CGColor;
    [self addSubview:self.rightButton];
}

@end
