//
//  SetGroupTimeView.h
//  CookBook
//
//  Created by 你好 on 16/8/11.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetGroupTimeView : UIView

@property (nonatomic,retain)UILabel *leftLabel;
@property (nonatomic,retain)UILabel *centerLabel;
@property (nonatomic,retain)UILabel *rightLabel;
@property (nonatomic,strong)NSDate * date;
@property (nonatomic,retain)UIView *bottomLineView;

@end
