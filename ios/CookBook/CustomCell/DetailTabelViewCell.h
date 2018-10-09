//
//  DetailTabelViewCell.h
//  CookBook
//
//  Created by 你好 on 16/4/22.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimationImageView.h"
#import "CustomSingleLineView.h"
#import "CookBaseProxy.h"
#import "CookProductPropertykeys.h"
#import "CookBookPropertyKeys.h"
#import <UIImageView+WebCache.h>
@interface DetailTabelViewCell : UITableViewCell

@property (nonatomic,retain)AnimationImageView *contentImageView;
@property (nonatomic,retain)UILabel *descLabel;


-(void)setupWithCookData:(NSDictionary *)dict CookType:(CookType)type  IndexPath:(NSIndexPath *)indexPath;

@end
