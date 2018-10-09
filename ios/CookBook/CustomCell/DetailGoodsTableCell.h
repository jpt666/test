//
//  DetailGoodsTableCell.h
//  CookBook
//
//  Created by 你好 on 16/8/11.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailGoodsTableCell : UITableViewCell

@property (nonatomic,strong)UILabel *labelSeq;
@property (nonatomic,retain)UIImageView *headImageView;
@property (nonatomic,retain)UILabel *typeLabel;
@property (nonatomic,retain)UILabel *titleLabel;
@property (nonatomic,retain)UILabel *specLabel;
@property (nonatomic,retain)UILabel *limitLabel;
@property (nonatomic,retain)UILabel *priceLabel;
@property (nonatomic,retain)UIImageView *bottomImageView;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier isEditable:(BOOL)isEditable;

-(void)configData:(NSDictionary *)dict;

-(void)setSequenceNum:(NSInteger)num;

@end
