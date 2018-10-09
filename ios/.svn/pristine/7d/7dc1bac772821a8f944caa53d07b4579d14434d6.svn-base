//
//  UIImage+AssetUrl.h
//  CookBook
//
//  Created by zhangxi on 16/4/15.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (AssetUrl)

/**
 *  通过assetUrl获取图片.
 *
 *  @param assetUrl 字符串形式的本地图片的assetUrl路径.
 *  @param success  成功获取到图片后执行的操作.
 *  @param fail     获取图片失败时执行的操作.
 */
+ (void)imageForAssetUrl: (NSString *) assetUrl
                 success: (void(^)(UIImage *)) successBlock
                    fail: (void(^)()) failBlock;

@end
