//
//  ImageManager.h
//  CookBook
//
//  Created by 你好 on 16/4/19.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageManager : NSObject


+ (ImageManager*)shareInstance;

@property (nonatomic,strong) NSMutableArray *selectImageArray;

@property (nonatomic,strong) NSMutableArray *puzzleImageArray;


@end
