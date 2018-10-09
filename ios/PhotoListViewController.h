//
//  PhotoListViewController.h
//  CookBook
//
//  Created by 你好 on 16/4/14.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoViewController.h"

@interface PhotoListViewController : UIViewController

@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic)EnterPhotoVCType enterType;
@property (nonatomic)BusinessType businessType;
@property (nonatomic,copy) void (^backValue)(NSDictionary *dict);

@property (nonatomic, strong) NSMutableArray * puzzleImages;
@property (nonatomic, strong) NSMutableArray * tmpPuzzleImages;


@end
