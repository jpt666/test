//
//  PhotoViewController.h
//  CookBook
//
//  Created by 你好 on 16/4/14.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum _EnterPhotoVCType{
    FirstEnterPhotoVC,
    SubsequentEnterPhotoVC,
    SubseReplacePhotoVC,
    SubseReplaceFromPersonVC,
    SubsequentEnterPuzzleVC
}EnterPhotoVCType;

typedef enum _BusinessType{
    ShowFoodBusiness,
    UploadMenuBusiness
}BusinessType;


@interface PhotoViewController : UIViewController


@property (nonatomic)EnterPhotoVCType enterType;
@property (nonatomic)BusinessType businessType;
@property (nonatomic,copy) void (^backValue)(NSMutableArray *array);
@property (nonatomic,copy) void (^backImageValue)(UIImage *image);

@property (nonatomic,strong) NSMutableArray * puzzleImages;

@end
