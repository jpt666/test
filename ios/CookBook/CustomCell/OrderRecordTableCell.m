//
//  OrderRecordTableCell.m
//  CookBook
//
//  Created by 你好 on 16/6/7.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "OrderRecordTableCell.h"
#import "ParticipantPropertyKeys.h"
#import "GroupsPropertyKeys.h"
#import <UIImageView+WebCache.h>

@implementation OrderRecordTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self configUI];
    }
    return self;
}

-(void)configUI
{
    self.headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 40, 40)];
    self.headImageView.layer.cornerRadius=20;
    self.headImageView.clipsToBounds=YES;
    [self.contentView addSubview:self.headImageView];
    
    self.userLabel=[[UILabel alloc]initWithFrame:CGRectMake(60, 15, ScreenWidth-170, 20)];
    self.userLabel.font=[UIFont systemFontOfSize:14];
    self.userLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e"];
    [self.contentView addSubview:self.userLabel];
    
    self.unitLabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-100, 0, 80, 70)];
    self.unitLabel.font=[UIFont systemFontOfSize:14];
    self.unitLabel.textAlignment=NSTextAlignmentRight;
    self.unitLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e"];
    [self.contentView addSubview:self.unitLabel];
    
    self.dateLabel=[[UILabel alloc]initWithFrame:CGRectMake(60, 35, ScreenWidth-170,20)];
    self.dateLabel.font=[UIFont systemFontOfSize:12];
    self.dateLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.5];
    [self.contentView addSubview:self.dateLabel];
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(10, 69.5, ScreenWidth-20, 0.5)];
    lineView.backgroundColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.3];
    [self.contentView addSubview:lineView];
}

-(void)configData:(NSDictionary *)dict
{
    NSDateFormatter *dateFormate=[[NSDateFormatter alloc]init];
    [dateFormate setDateFormat:@"MM-dd hh:mm"];
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:dict[kDispatcherPropertyWXHeadUrl]] placeholderImage:[UIImage imageNamed:@"default_icon"]];
//    self.unitLabel.text=[NSString stringWithFormat:@"%@%@",dict[kParticipantPropertyQuantity],dict[kParticipantPropertySpec]];
    self.userLabel.text=dict[kParticipantPropertyName];
    self.unitLabel.text=[NSString stringWithFormat:@"%@", dict[kParticipantPropertyQuantity]];
    self.dateLabel.text=[dateFormate stringFromDate:[NSDate dateWithTimeIntervalSince1970:[dict[kParticipantPropertyCreateTime] doubleValue]/1000/1000]];
}


@end
