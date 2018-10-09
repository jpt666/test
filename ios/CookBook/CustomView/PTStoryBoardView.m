//
//  PTStoryBoardView.m
//  PinTuDemo
//
//  Created by zhangxi on 16/5/18.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "PTStoryBoardView.h"

@implementation PTStoryBoardView
{
    UIButton *_selectedBtn;
}


- (id)initWithFrame:(CGRect)frame imagesCount:(NSInteger)imagesCount
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imagesCount = imagesCount;
        [self initView];
    }
    return self;
}

- (void)initView
{
    _storyboardView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 49)];
    _storyboardView.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.5];
    [self addSubview:_storyboardView];
    
    
    NSArray *templateArray = nil;
    
    switch (self.imagesCount) {
        case 2:
            templateArray = [NSArray arrayWithObjects:@"template_2_1",
                             @"template_2_2",
                             @"template_2_3",
                             @"template_2_4",
                             @"template_2_5",
                             @"template_2_6",nil];
            break;
        case 3:
            templateArray = [NSArray arrayWithObjects:@"template_3_1",
                             @"template_3_2",
                             @"template_3_3",
                             @"template_3_4",
                             @"template_3_5",
                             @"template_3_6",nil];
            break;
        case 4:
            templateArray = [NSArray arrayWithObjects:@"template_4_1",
                             @"template_4_2",
                             @"template_4_3",
                             @"template_4_4",
                             @"template_4_5",
                             @"template_4_6",nil];
            break;
        case 5:
            templateArray = [NSArray arrayWithObjects:@"template_5_1",
                             @"template_5_2",
                             @"template_5_3",
                             @"template_5_4",
                             @"template_5_5",
                             @"template_5_6",nil];
            break;
        case 6:
            templateArray = [NSArray arrayWithObjects:@"template_6_1",
                             @"template_6_2",
                             @"template_6_3",
                             @"template_6_4",
                             @"template_6_5",
                             @"template_6_6",nil];
            break;
        default:
            break;
    }
    
    CGFloat width =63;
    
    for (int i = 0; i < [templateArray count]; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i*width+(width-37)/2.0f, 2, 37, 45)];
        [button setImage:[UIImage imageNamed:[templateArray objectAtIndex:i]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"template_border"] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[UIImage imageNamed:@"template_border"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(storyboardSelected:) forControlEvents:UIControlEventTouchUpInside];
        [button setTag:i+1];
        [_storyboardView addSubview:button];
        if (i==0) {
            [button setSelected:YES];
            _selectedBtn = button;
        }
        button  = nil;
    }
    [_storyboardView setContentSize:CGSizeMake([templateArray count]*width, _storyboardView.bounds.size.height)];
}

- (void)storyboardSelected:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (button == _selectedBtn) {
        return;
    }
    self.storyboardIndex = button.tag;
    [_selectedBtn setSelected:NO];
    _selectedBtn = button;
    [_selectedBtn setSelected:YES];
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedStoryboardIndex:forImagesCount:)]) {
        [_delegate didSelectedStoryboardIndex:self.storyboardIndex forImagesCount:self.imagesCount];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
