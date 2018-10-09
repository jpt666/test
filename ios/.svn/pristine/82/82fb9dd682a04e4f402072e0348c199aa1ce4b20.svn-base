//
//  DraftTableViewCell.h
//  CookBook
//
//  Created by zhangxi on 16/4/19.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSwipeTableCell.h"
#import "CookBaseProxy.h"

@interface DraftTableViewCell : MGSwipeTableCell

//@property (nonatomic, weak) UITableView * parentView;
@property (nonatomic, strong) UIImageView* frontCoverView;
@property (nonatomic, strong) UILabel * cookTypeString;
@property (nonatomic, strong) UILabel * dishName;
@property (nonatomic, strong) UIProgressView * progress;
@property (nonatomic, strong) UILabel * editStatus;
@property (nonatomic, strong) UILabel * editTime;
@property (nonatomic, retain) UIView  * lineView;

-(void)setupWithCookData:(CookBaseProxy *)cookData;

-(void)setUploadProgress:(CGFloat)progress;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andRowHeight:(CGFloat)rowHeight;

@end
