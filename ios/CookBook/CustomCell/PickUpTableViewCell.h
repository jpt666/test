//
//  PickUpTableViewCell.h
//  CookBook
//
//  Created by 你好 on 16/8/11.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickUpTableViewCell : UITableViewCell

@property (nonatomic,retain)UILabel *typeLabel;
@property (nonatomic,retain)UIImageView *locationImageView;
@property (nonatomic,retain)UIImageView *timeImageView;
@property (nonatomic,retain)UIImageView *phoneImageView;
@property (nonatomic,retain)UILabel *addressLabel;
@property (nonatomic,retain)UILabel *timeLabel;
@property (nonatomic,retain)UILabel *phoneLabel;
@property (nonatomic,retain)UIView *lineView;

@property (nonatomic,retain)UIButton *editButton;

-(void)configData:(NSDictionary *)dict;

@end
