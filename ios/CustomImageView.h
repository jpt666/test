//
//  CustomImageView.h
//  CookBook
//
//  Created by 你好 on 16/4/15.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomShowView.h"
@interface CustomImageView : UIImageView

@property (nonatomic,retain)UITextField *textField;

@property (nonatomic,retain)UIImageView *leftLineView;
@property (nonatomic,retain)UIImageView *rightLineView;
@property (nonatomic,retain)UIButton *viewBtn;
@property (nonatomic,retain)UIButton *favorBtn;


@end
