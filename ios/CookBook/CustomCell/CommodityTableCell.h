//
//  CommodityTableCell.h
//  CookBook
//
//  Created by 你好 on 16/6/3.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommodityTableCell : UITableViewCell

@property (nonatomic,retain)UIImageView *contentImageView;

-(void)configData:(NSDictionary *)dict;

@end
