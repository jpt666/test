//
//  CookLocalPhoto.h
//  CookBook
//
//  Created by zhangxi on 16/4/13.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CookPhoto : NSObject

@property (nonatomic, strong) NSString * story;
@property (nonatomic, strong) NSString * imageMd5;
@property (nonatomic, strong) NSString * serverUrl;
//@property (nonatomic, assign) double TextHeight;
//@property (nonatomic, strong) UIImage * image;

- (UIImage *)getImageWithCookDataId:(NSString *)cookDataId;

-(void)setCookPhoto:(UIImage *)image;

@end
