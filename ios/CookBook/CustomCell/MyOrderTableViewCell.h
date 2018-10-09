//
//  MyOrderTableViewCell.h
//  CookBook
//
//  Created by 你好 on 16/6/12.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyOrderView.h"

@protocol MyOrderTableViewCellDelegate <NSObject>

-(void)payButtonClicked:(NSDictionary *)dictOrder;
-(void)cancelButtonClicked:(NSDictionary *)dictOrder;
-(void)confirmButtonClicked:(NSDictionary *)dictOrder;
-(void)checkTransportBtnClicked:(NSDictionary *)dictOrder;
-(void)deleteBtnClicked:(NSDictionary *)dictOrder;
-(void)ETABtnClicked:(NSDictionary *)dictOrder;

@end

@interface MyOrderTableViewCell : UITableViewCell

@property (nonatomic,retain)UIImageView *headImageView;
@property (nonatomic,retain)UILabel *userLabel;
@property (nonatomic,retain)UILabel *orderTimeLabel;
@property (nonatomic,retain)UILabel *orderStatusLabel;
@property (nonatomic,retain)UILabel *totalPriceLabel;
@property (nonatomic,retain)UIButton *cancelButton;
@property (nonatomic,retain)UIButton *payButton;
@property (nonatomic,retain)UIButton *cofirmButton;
@property (nonatomic,retain)UIButton *checkTransportBtn;
@property (nonatomic,retain)UIButton *deleteButton;
@property (nonatomic,retain)UIButton *ETAButton;
@property (nonatomic,retain)MyOrderView *myOrderView;
@property (nonatomic,retain)UIView *lineView;
@property (nonatomic,weak) NSDictionary * dictOrder;
@property (nonatomic,weak) id<MyOrderTableViewCellDelegate> delegate;


-(void)configData:(NSDictionary *)dict;

@end
