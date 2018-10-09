//
//  CustomImageView.m
//  CookBook
//
//  Created by 你好 on 16/4/15.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "CustomImageView.h"
#import "GPUImage.h"

@implementation CustomImageView
{
    GPUImageView * _backGPUImageView;
    GPUImageiOSBlurFilter *_blurFilter;
    
    CGRect _textFieldFrame;
    CGRect _favBtnFrame;
    CGRect _viewBtnFrame;
    CGRect _rightLineFrame;
    CGRect _leftLineFrame;
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
    _backGPUImageView = [[GPUImageView alloc] initWithFrame:self.bounds];
    _backGPUImageView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill;
    [self addSubview:_backGPUImageView];
    
    _blurFilter = [[GPUImageiOSBlurFilter alloc] init];
    _blurFilter.blurRadiusInPixels = 0.6f;
    _blurFilter.rangeReductionFactor=0.4f;

    
    self.textField=[[UITextField alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, 40)];
    self.textField.textAlignment=NSTextAlignmentCenter;
    self.textField.center=self.center;
    self.textField.tintColor=[UIColor whiteColor];
    self.textField.textColor=[UIColor whiteColor];
    self.textField.autocapitalizationType=UITextAutocapitalizationTypeNone;
    self.textField.autocorrectionType=UITextAutocorrectionTypeNo;
    [self addSubview:self.textField];
    _textFieldFrame = self.textField.frame;
    
    self.viewBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.viewBtn.frame=CGRectMake(ScreenWidth/2-40, self.bounds.size.height-40, 40, 40);
    [self.viewBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.viewBtn.imageEdgeInsets=UIEdgeInsetsMake(5, 0, 5, 5);
    self.viewBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [self addSubview:self.viewBtn];
    _viewBtnFrame = self.viewBtn.frame;
    
    self.favorBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.favorBtn.frame=CGRectMake(ScreenWidth/2, self.bounds.size.height-40, 40, 40);
    [self.favorBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.favorBtn.imageEdgeInsets=UIEdgeInsetsMake(5, 0, 5, 5);
    self.favorBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [self addSubview:self.favorBtn];
    _favBtnFrame = self.favorBtn.frame;
    
    self.leftLineView=[[UIImageView alloc]initWithFrame:CGRectMake(15, self.bounds.size.height-20, ScreenWidth/2-60, 1)];
    self.leftLineView.image=[UIImage imageNamed:@"line_left_icon"];
    [self addSubview:self.leftLineView];
    _leftLineFrame = self.leftLineView.frame;
    
    self.rightLineView=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2+40, self.bounds.size.height-20, ScreenWidth/2-65, 1)];
    self.rightLineView.image=[UIImage imageNamed:@"line_right_icon"];
    [self addSubview:self.rightLineView];
    _rightLineFrame = self.rightLineView.frame;
    
    self.clipsToBounds = NO;
}

-(void)setImage:(UIImage *)image
{
    if (image) {
        GPUImagePicture *picture = [[GPUImagePicture alloc] initWithImage:image];
        if (_blurFilter) {
            [_blurFilter removeAllTargets];
        }
        [picture addTarget:_blurFilter];
        [_blurFilter addTarget:_backGPUImageView];
        [picture processImageWithCompletionHandler:^{
//            dispatch_async(dispatch_get_main_queue(), ^{
//                super.image = [UIImage imageWithCGImage:[_blurFilter newCGImageFromCurrentlyProcessedOutput]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                super.image = image;
                [_blurFilter removeAllTargets];
            });
//            });

        }];
    }
}


-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _backGPUImageView.frame = self.bounds;
    
    self.textField.frame = CGRectOffset(_textFieldFrame, -frame.origin.x, -frame.origin.y/2);
    
    self.favorBtn.frame = CGRectOffset(_favBtnFrame, -frame.origin.x, -frame.origin.y);
    
    self.viewBtn.frame = CGRectOffset(_viewBtnFrame, -frame.origin.x, -frame.origin.y);
    
    self.leftLineView.frame = CGRectOffset(_leftLineFrame, -frame.origin.x, -frame.origin.y);
    
    self.rightLineView.frame = CGRectOffset(_rightLineFrame, -frame.origin.x, -frame.origin.y);
    
}

@end
