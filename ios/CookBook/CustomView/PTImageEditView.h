//
//  PTImageEditView.h
//  PinTuDemo
//
//  Created by zhangxi on 16/5/18.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTImageEditView;

@protocol PTImageEditViewDelegate <NSObject>

- (void)tapInsideWithEditView:(PTImageEditView *)imageEditView;

- (void)zoomingImageEditView:(BOOL)bZooming;

//-(void)view:(PTImageEditView*)view touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;
//-(void)view:(PTImageEditView*)view touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;
//-(void)view:(PTImageEditView*)view touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;
@end

@interface PTImageEditView : UIView<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView * contentView;
@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UIBezierPath * scopePath;
@property (nonatomic, strong) UIBezierPath * pathInSuper;
@property (nonatomic, assign) CGRect fixedFrame;
@property (nonatomic, assign) CGFloat currentScale;
@property (nonatomic, weak) id<PTImageEditViewDelegate> delegate;


- (void)setImageData:(UIImage *)image andFrame:(CGRect)rect;

- (void)layoutImageData;

- (void)recoverImageZoomScale;

@end
