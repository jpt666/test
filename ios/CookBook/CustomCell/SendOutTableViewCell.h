//
//  SendOutTableViewCell.h
//  CookBook
//
//  Created by 你好 on 16/9/6.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendOutTableViewCell : UITableViewCell

@property (nonatomic,retain)UILabel *nameLabel;
@property (nonatomic,retain)UILabel *phoneLabel;
@property (nonatomic,retain)UILabel *addressLabel;
@property (nonatomic,retain)UIImageView *headImageView;
@property (nonatomic,retain)UIButton *bottomButton;
@property (nonatomic,retain)UIView *lineView;

-(void)configData:(NSDictionary *)dict;

-(void)setChecked:(BOOL)bChecked;

@end
