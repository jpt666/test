//
//  GroupPurTopView.h
//  CookBook
//
//  Created by 你好 on 16/6/3.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupPurTopView : UIView

@property (nonatomic,retain)UIImageView *userImageView;
@property (nonatomic,retain)UILabel *userTitleLabel;
@property (nonatomic,retain)UILabel *addressLabel;
@property (nonatomic,retain)UILabel *groupNumLabel;
@property (nonatomic,retain)UIButton *ETAButton;
@property (nonatomic,retain)UIImageView *groupNumImageView;


-(void)configData:(NSDictionary *)dict;

@end
