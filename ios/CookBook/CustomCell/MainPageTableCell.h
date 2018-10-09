//
//  MainPageTableCell.h
//  CookBook
//
//  Created by 你好 on 16/4/13.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CookBaseProxy.h"

@interface MainPageTableCell : UITableViewCell

@property (nonatomic,retain)UIImageView *backImageView;
@property (nonatomic,retain)UILabel *titleLabel;
@property (nonatomic,retain)UILabel *detailLabel;
@property (nonatomic,retain)UIImageView *userIconImageView;
@property (nonatomic,retain)UILabel *userLabel;


- (void)setupWithCookData:(NSMutableDictionary*)dict andType:(CookType)cookType;

@end
