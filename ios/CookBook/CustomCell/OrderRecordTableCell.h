//
//  OrderRecordTableCell.h
//  CookBook
//
//  Created by 你好 on 16/6/7.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderRecordTableCell : UITableViewCell

@property (nonatomic,retain)UIImageView *headImageView;
@property (nonatomic,retain)UILabel *unitLabel;
@property (nonatomic,retain)UILabel *userLabel;
@property (nonatomic,retain)UILabel *dateLabel;

-(void)configData:(NSDictionary *)dict;

@end
