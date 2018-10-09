//
//  DictButton.h
//  CookBook
//
//  Created by 你好 on 16/5/18.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CookBaseProxy.h"

@interface DictButton : UIButton

@property (nonatomic,retain)UILabel *descLabel;
@property (nonatomic,strong)NSDictionary *dict;
@property CookType type;

-(instancetype)initWithFrame:(CGRect)frame;

@end
