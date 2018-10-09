//
//  GradientImageView.h
//  CookBook
//
//  Created by 你好 on 16/6/2.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GradientImageView : UIImageView

@property (nonatomic,retain)UIView  *backView;
@property (nonatomic,strong)NSMutableArray *imageArray;
@property (nonatomic,strong)NSDictionary *dict;

-(void)configData;

@end
