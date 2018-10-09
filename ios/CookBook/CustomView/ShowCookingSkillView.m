//
//  ShowCookingSkillView.m
//  CookBook
//
//  Created by zhangxi on 16/4/12.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "ShowCookingSkillView.h"

@implementation ShowCookingSkillView
{
    UIButton *_controlBtn;
    UIButton *_leftBtn;
    UIButton *_rightBtn;
    
    CGRect _folderFrame;
    CGRect _leftBtnBounds;
    CGRect _rightBtnBounds;
    
    CGFloat _sepWidth;
    
    
    BOOL _bIsHiding;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _folderFrame = frame;
        _bExpand = NO;
        _sepWidth = 6;
    }
    return self;
}

- (void)setupGUIWithControlButtonImage:(UIImage *)image forState:(UIControlState)state
{
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = YES;
    
    _controlBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_controlBtn addTarget:self action:@selector(controllButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    _controlBtn.bounds = self.bounds;
    [_controlBtn setImage:image forState:state];
    [self addSubview:_controlBtn];
    
    if (self.dataSource) {
        _leftBtn = [self.dataSource leftButtonForView:self];
        _leftBtnBounds = _leftBtn.bounds;
        [self insertSubview:_leftBtn belowSubview:_controlBtn];
        
        _rightBtn = [self.dataSource rightButtonForView:self];
        _rightBtnBounds = _rightBtn.bounds;
        [self insertSubview:_rightBtn belowSubview:_controlBtn];
    }

    [self layoutGUI];
}


- (void)controllButtonClicked:(UIButton *)btn
{
    _bExpand = !_bExpand;
    [self animateLayoutGUI];
}

- (void)folderView
{
    _bExpand = NO;
    [self animateLayoutGUI];
}

- (void)animateLayoutGUI
{
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutGUI];
    } completion:^(BOOL finished) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(didView:expanded:)]) {
            [self.delegate didView:self expanded:_bExpand];
        }
    }];
}

- (void)layoutGUI
{
    if (_bExpand) {
        
        self.frame = CGRectMake(_folderFrame.origin.x-(_leftBtnBounds.size.width+_rightBtnBounds.size.width+_sepWidth*2), _folderFrame.origin.y, _leftBtnBounds.size.width+_rightBtnBounds.size.width+_sepWidth*2+_controlBtn.bounds.size.width, _folderFrame.size.height);
        
        _leftBtn.frame = CGRectMake(0, (_folderFrame.size.height-_leftBtnBounds.size.height)/2, _leftBtnBounds.size.width, _leftBtnBounds.size.height);
        _leftBtn.alpha = 1;
        
        _rightBtn.frame = CGRectMake(_leftBtnBounds.size.width+_sepWidth, (_folderFrame.size.height-_rightBtnBounds.size.height)/2, _rightBtnBounds.size.width, _rightBtnBounds.size.height);
        _rightBtn.alpha = 1;
        
        _controlBtn.frame = CGRectMake(_leftBtnBounds.size.width+_rightBtnBounds.size.width+_sepWidth*2, (_folderFrame.size.height-_controlBtn.bounds.size.height)/2, _folderFrame.size.width, _folderFrame.size.height);
        
        _controlBtn.transform = CGAffineTransformRotate(_controlBtn.transform,-M_PI*3/4);
    } else  {
        
        self.frame = _folderFrame;
        _controlBtn.transform = CGAffineTransformIdentity;
        
        _leftBtn.frame = CGRectMake(0, (_folderFrame.size.height-_leftBtnBounds.size.height)/2, _folderFrame.size.width, _folderFrame.size.height);
        _leftBtn.alpha = 0;
        
        _rightBtn.frame = CGRectMake(0, (_folderFrame.size.height-_rightBtnBounds.size.height)/2, _folderFrame.size.width, _folderFrame.size.height);
        _rightBtn.alpha = 0;
        
        _controlBtn.frame = CGRectMake(0, (_folderFrame.size.height-_controlBtn.bounds.size.height)/2, _folderFrame.size.width, _folderFrame.size.height);
    }
}

- (void)hideView
{
    if (_bIsHiding) {
        return;
    }
    _bIsHiding = YES;
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
//        _bIsHiding = NO;
    }];
}

- (void)showView
{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
        _bIsHiding = NO;
    }];
}

@end
