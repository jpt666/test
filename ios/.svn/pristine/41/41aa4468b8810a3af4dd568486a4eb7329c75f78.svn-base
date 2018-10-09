//
//  PreviewCollectionViewCell.h
//  HuaBao
//
//  Created by 你好 on 16/4/12.
//  Copyright © 2016年 xyxNav. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PreViewCollectionCellSingleTapDelegate <NSObject>

-(void)singleTap;

@end



@interface PreviewCollectionViewCell : UICollectionViewCell<UIScrollViewDelegate>


@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIView *containerView;
@property (nonatomic, retain) UIImageView *imageView;

@property (nonatomic,assign) id delegate;

-(void)configCellWithImage:(UIImage *)image;


@end
