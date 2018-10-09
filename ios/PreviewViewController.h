//
//  PreviewViewController.h
//  CookBook
//
//  Created by 你好 on 16/4/14.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoViewController.h"
@interface PreviewViewController : UICollectionViewController

@property (nonatomic)EnterPhotoVCType enterType;
@property (nonatomic)BusinessType businessType;

+ (UICollectionViewLayout *)photoPreviewViewLayoutWithSize:(CGSize)size;
@end
