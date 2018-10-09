//
//  AddressTableViewCell.h
//  CookBook
//
//  Created by 你好 on 16/6/7.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressTableViewCell : UITableViewCell

@property (nonatomic,retain)UIImageView *headImageView;
@property (nonatomic,retain)UIImageView *locationImageView;
@property (nonatomic,retain)UIImageView *timeImageView;
@property (nonatomic,retain)UIImageView *phoneImageView;
@property (nonatomic,retain)UILabel *addressLabel;
@property (nonatomic,retain)UILabel *timeLabel;
@property (nonatomic,retain)UILabel *phoneLabel;
@property (nonatomic,retain)UIView *lineView;


-(void)configData:(NSDictionary *)dict;

@end
