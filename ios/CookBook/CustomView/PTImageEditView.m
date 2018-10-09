//
//  PTImageEditView.m
//  PinTuDemo
//
//  Created by zhangxi on 16/5/18.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "PTImageEditView.h"

@implementation PTImageEditView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView
{
    self.backgroundColor = [UIColor grayColor];
    
    _currentScale = 1.0;
    
    _contentView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _contentView.delegate = self;
    _contentView.showsHorizontalScrollIndicator = NO;
    _contentView.showsVerticalScrollIndicator = NO;
    [self addSubview:_contentView];
     
    _imageView = [[UIImageView alloc] initWithFrame:_contentView.bounds];
    _imageView.userInteractionEnabled = YES;
    [_contentView addSubview:_imageView];
}

- (void)layoutImageData
{
    UIImage *imageData = _imageView.image;
    if (!imageData) {
        return;
    }
    
    [self.contentView setZoomScale:1.0];
    CGRect rect  = CGRectZero;
    CGFloat scale = 1.0f;
    CGFloat w = 0.0f;
    CGFloat h = 0.0f;
    
    w = self.contentView.frame.size.width;
    h = w*imageData.size.height/imageData.size.width;
    if(h < self.contentView.frame.size.height){
        h = self.contentView.frame.size.height;
        w = h*imageData.size.width/imageData.size.height;
    }
    
    rect.size = CGSizeMake(w, h);
    
    if (self.contentView.frame.size.width == w) {
        scale = self.contentView.frame.size.width/imageData.size.width;
    } else if (self.contentView.frame.size.height == h) {
        scale = self.contentView.frame.size.height/imageData.size.height;
    }
    CGFloat maxScale = scale<1?3/scale:3;
    
    @synchronized(self){
        _imageView.frame = rect;
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.path = [self.scopePath CGPath];
        maskLayer.fillColor = [[UIColor blackColor] CGColor];
        maskLayer.frame = _imageView.frame;
        self.layer.mask = maskLayer;
        
        [_contentView setContentSize:rect.size];
//        [_contentView setZoomScale:_currentScale];
        [_contentView setMaximumZoomScale:maxScale];
    }
}

- (void)setImageData:(UIImage *)image andFrame:(CGRect)rect
{
    self.frame = rect;
    [self setImageData:image];
}

- (void)recoverImageZoomScale
{
    [_contentView setZoomScale:_currentScale];
}


- (void)setImageData:(UIImage *)imageData
{
    _imageView.image= imageData;
    if (imageData == nil) {
        return;
    }
    
    [self layoutImageData];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    
    BOOL contained=[_scopePath containsPoint:point];
    if(contained) {
        if(_delegate && [_delegate respondsToSelector:@selector(tapInsideWithEditView:)]) {
        [_delegate tapInsideWithEditView:self];
      }
    }
    return contained;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _contentView.frame = self.bounds;
    _imageView.frame = _contentView.bounds;
}

//-(void)view:(UIEventImageView*)view touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    if (_delegate && [_delegate respondsToSelector:@selector(view:touchesBegan:withEvent:)]) {
//        [_delegate view:self touchesBegan:touches withEvent:event];
//    }
//}
//
//-(void)view:(UIEventImageView*)view touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    if (_delegate && [_delegate respondsToSelector:@selector(view:touchesMoved:withEvent:)]) {
//        [_delegate view:self touchesMoved:touches withEvent:event];
//    }
//}
//
//-(void)view:(UIEventImageView*)view touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    if (_delegate && [_delegate respondsToSelector:@selector(view:touchesEnded:withEvent:)]) {
//        [_delegate view:self touchesEnded:touches withEvent:event];
//    }
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    if (_delegate && [_delegate respondsToSelector:@selector(panInsideWithEditView:)]) {
//        [_delegate panInsideWithEditView:self];
//    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view
{
    if (_delegate && [_delegate respondsToSelector:@selector(zoomingImageEditView:)]) {
        [_delegate zoomingImageEditView:YES];
    }
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale
{
    _currentScale = scale;
    
    if (_delegate && [_delegate respondsToSelector:@selector(zoomingImageEditView:)]) {
        [_delegate zoomingImageEditView:NO];
    }
}

@end
