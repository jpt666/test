//
//  AnimationImageView.m
//  CookBook
//
//  Created by 你好 on 16/4/18.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "AnimationImageView.h"

@implementation AnimationImageView
{
    UIButton *_leftBtn;
    UIButton *_centerBtn;
    UIButton *_rightBtn;
    BOOL isOpen;
}

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
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    tapGesture.numberOfTouchesRequired=1;
    tapGesture.numberOfTapsRequired=1;
    [self addGestureRecognizer:tapGesture];
    
    _leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _centerBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    
    
    UIImage *image=[UIImage imageNamed:@"delete"];
    UIImage *exchangeImage=[UIImage imageNamed:@"exchange"];
    UIImage *centerImage=[UIImage imageNamed:@"puzzle_icon"];

    [_leftBtn setImage:exchangeImage forState:UIControlStateNormal];
    [_rightBtn setImage:image forState:UIControlStateNormal];
    [_centerBtn setImage:centerImage forState:UIControlStateNormal];
    [_leftBtn addTarget:self action:@selector(exChangeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_rightBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_centerBtn addTarget:self action:@selector(puzzleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _leftBtn.backgroundColor=[UIColor clearColor];
    _rightBtn.backgroundColor=[UIColor clearColor];
    _leftBtn.layer.cornerRadius=image.size.width/2;
    _centerBtn.layer.cornerRadius=image.size.width/2;
    _rightBtn.layer.cornerRadius=image.size.width/2;
    

    [self addSubview:_leftBtn];
    [self addSubview:_centerBtn];
    [self addSubview:_rightBtn];
}


-(void)tapGesture:(UITapGestureRecognizer *)tapGesture
{
    isOpen=!isOpen;
    if (isOpen)
    {
        UIImage *image=[UIImage imageNamed:@"delete"];
        CGPoint point=[tapGesture locationInView:tapGesture.view];
        
        CGPoint  p;
        
        if (point.x>self.bounds.size.width-image.size.width*3-30)
        {
            p=CGPointMake(self.bounds.size.width-image.size.width*3-30,point.y);
        }
        else
        {
            p=CGPointMake(point.x, point.y);
        }
        
        if(point.y>self.bounds.size.height-image.size.height-10)
        {
            p=CGPointMake(p.x, self.bounds.size.height-image.size.height-10);
        }
        else
        {
            p=CGPointMake(p.x, point.y);
        }
        
        _leftBtn.frame=CGRectMake(p.x, p.y, image.size.width, image.size.height);
        _centerBtn.frame=_leftBtn.frame;
        _rightBtn.frame=_leftBtn.frame;
        
        _leftBtn.hidden=NO;
        _centerBtn.hidden=NO;
        _rightBtn.hidden=NO;
        
        [UIView animateWithDuration:0.25 animations:^{
            _centerBtn.frame=CGRectMake(_centerBtn.frame.origin.x+image.size.width+10, _centerBtn.frame.origin.y, image.size.width, image.size.height);
            _rightBtn.frame=CGRectMake(_rightBtn.frame.origin.x+image.size.width*2+20, _rightBtn.frame.origin.y, image.size.width, image.size.height);
        }];
    }
    else
    {
        _leftBtn.hidden=YES;
        _centerBtn.hidden=YES;
        _rightBtn.hidden=YES;
        
        [UIView animateWithDuration:0.25 animations:^{
            _rightBtn.frame=_leftBtn.frame;
            _centerBtn.frame=_leftBtn.frame;
        }completion:^(BOOL finished) {
        }];
    }
    
    if (_delegate &&[_delegate respondsToSelector:@selector(animationImageClick:)])
    {
        [_delegate animationImageClick:self];
    }
    
}


-(void)exChangeBtnClick:(UIButton *)button
{
    if (_delegate &&[_delegate respondsToSelector:@selector(exChangeBtnClick:)])
    {
        [_delegate exChangeBtnClick:self];
    }
}

-(void)deleteBtnClick:(UIButton *)button
{
    if (_delegate &&[_delegate respondsToSelector:@selector(deleteBtnClick:)])
    {
        [_delegate deleteBtnClick:self];
    }
}

-(void)puzzleBtnClick:(UIButton *)button
{
    if (_delegate && [_delegate respondsToSelector:@selector(puzzleBtnClick:)])
    {
        [_delegate puzzleBtnClick:self];
    }
}

-(void)hideSubView
{
    _leftBtn.hidden=YES;
    _centerBtn.hidden=YES;
    _rightBtn.hidden=YES;
    isOpen=NO;
}

@end
