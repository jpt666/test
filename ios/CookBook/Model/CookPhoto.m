//
//  CookLocalPhoto.m
//  CookBook
//
//  Created by zhangxi on 16/4/13.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "CookPhoto.h"
#import "GlobalVar.h"

@implementation CookPhoto
{
    UIImage * _image;
}

- (UIImage *)getImageWithCookDataId:(NSString *)cookDataId
{
    if (!_image) {
        _image = [UIImage imageWithData:[NSData dataWithContentsOfFile:[[[GlobalVar shareGlobalVar].photosDirectory stringByAppendingPathComponent:cookDataId] stringByAppendingPathComponent:_imageMd5]]];
    }
    return _image;
}

-(void)setCookPhoto:(UIImage *)image
{
    _image = image;
}

@end
