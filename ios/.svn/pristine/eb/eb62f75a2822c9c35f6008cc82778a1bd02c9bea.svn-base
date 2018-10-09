//
//  PreviewCollectionViewCell.m
//  HuaBao
//
//  Created by 你好 on 16/4/12.
//  Copyright © 2016年 xyxNav. All rights reserved.
//

#import "PreviewCollectionViewCell.h"
#import <ImageIO/ImageIO.h>
#import "UIImage+fixOrientation.h"
@implementation PreviewCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

-(void)configCellWithImage:(UIImage *)image;
{
    [self.scrollView setZoomScale:1.0f];
    self.imageView.image =image;
    [self _resizeSubviews];
}

- (void)configUI {
    
    self.backgroundColor = self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.bouncesZoom = YES;
    self.scrollView.maximumZoomScale = 3.0f;
    self.scrollView.minimumZoomScale = 1.0f;
    self.scrollView.multipleTouchEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.scrollView.delaysContentTouches = NO;
    self.scrollView.canCancelContentTouches = YES;
    self.scrollView.alwaysBounceVertical = NO;
    [self.contentView addSubview:self.scrollView];
    
    
    self.containerView = [[UIView alloc] initWithFrame:self.bounds];
    self.containerView.clipsToBounds = YES;
    
    [self.scrollView addSubview:self.containerView];
    
    
    self.imageView= [[UIImageView alloc] initWithFrame:self.bounds];
    self.imageView.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.500];
    self.imageView.clipsToBounds = YES;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.containerView addSubview:self.imageView];

    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_handleSingleTap)];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_handleDoubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    
    [singleTap requireGestureRecognizerToFail:doubleTap];
    [self.contentView addGestureRecognizer:singleTap];
    [self.contentView addGestureRecognizer:doubleTap];
    
}


- (void)_handleSingleTap {

    if (_delegate && [_delegate respondsToSelector:@selector(singleTap)])
    {
        [_delegate singleTap];
    }
}

- (void)_handleDoubleTap:(UITapGestureRecognizer *)doubleTap {
    if (self.scrollView.zoomScale > 1.0f) {
        [self.scrollView setZoomScale:1.0 animated:YES];
    }else {
        CGPoint touchPoint = [doubleTap locationInView:self.imageView];
        CGFloat newZoomScale = self.scrollView.maximumZoomScale;
        CGFloat xsize = self.frame.size.width / newZoomScale;
        CGFloat ysize = self.frame.size.height / newZoomScale;
        [self.scrollView zoomToRect:CGRectMake(touchPoint.x - xsize/2, touchPoint.y - ysize/2, xsize, ysize) animated:YES];
    }
}


- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.containerView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGFloat offsetX = (scrollView.frame.size.width > scrollView.contentSize.width) ? (scrollView.frame.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.frame.size.height > scrollView.contentSize.height) ? (scrollView.frame.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    self.containerView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX, scrollView.contentSize.height * 0.5 + offsetY);
}

- (void)_resizeSubviews {
    self.containerView.frame = self.bounds;
    UIImage *image = self.imageView.image;
    if (!image) {
        return;
    }
    CGFloat screenScale = [UIScreen mainScreen].scale;
    CGFloat widthPercent = (image.size.width / screenScale) / self.frame.size.width;
    CGFloat heightPercent = (image.size.height / screenScale) / self.frame.size.height;
    if (widthPercent <= 1.0f && heightPercent <= 1.0f) {
        self.containerView.bounds = CGRectMake(0, 0, image.size.width/screenScale, image.size.height/screenScale);
        self.containerView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    } else if (widthPercent > 1.0f && heightPercent < 1.0f) {
        self.containerView.frame = CGRectMake(0, 0, self.frame.size.width, heightPercent * self.frame.size.width);
    }else if (widthPercent <= 1.0f && heightPercent > 1.0f) {
        self.containerView.frame = CGRectMake(0, 0, self.frame.size.height * widthPercent ,self.frame.size.height);
    }else {
        if (widthPercent > heightPercent) {
            self.containerView.frame = CGRectMake(0, 0, self.frame.size.width, heightPercent * self.frame.size.width);
        }else {
            self.containerView.frame = CGRectMake(0, 0, self.frame.size.height * widthPercent ,self.frame.size.height);
        }
    }
    
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    [self.scrollView scrollRectToVisible:self.bounds animated:NO];
    self.scrollView.alwaysBounceVertical = self.containerView.frame.size.height <= self.frame.size.height ? NO : YES;
    self.imageView.frame = self.containerView.bounds;
    
}
@end
