//
//  AddressTableViewCell.m
//  CookBook
//
//  Created by 你好 on 16/6/7.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "AddressTableViewCell.h"
#import "GroupsPropertyKeys.h"
@implementation AddressTableViewCell

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
    UIImage *headImage=[UIImage imageNamed:@"normal_round_icon"];
    
    self.headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10,(50-headImage.size.height)/2, headImage.size.width, headImage.size.height)];
    self.headImageView.image=headImage;
    [self.contentView addSubview:self.headImageView];
    
    UIImage *locationImage=[UIImage imageNamed:@"location_icon_dark"];
    self.locationImageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.headImageView.frame.origin.x+self.headImageView.frame.size.width+10, 5+(20-locationImage.size.height)/2, locationImage.size.width, locationImage.size.height)];
    self.locationImageView.image=locationImage;
    [self.contentView addSubview:self.locationImageView];
    
    self.addressLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.locationImageView.frame.origin.x+self.locationImageView.frame.size.width+5, 5, ScreenWidth-self.locationImageView.frame.origin.x-self.locationImageView.frame.size.width-5, 20)];
    self.addressLabel.font=[UIFont systemFontOfSize:14];
    self.addressLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.8];
    [self.contentView addSubview:self.addressLabel];
    
    UIImage *timeImage=[UIImage imageNamed:@"time_icon_dark"];
    self.timeImageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.locationImageView.frame.origin.x, 25+(20-timeImage.size.height)/2, timeImage.size.width, timeImage.size.height)];
    self.timeImageView.image=timeImage;
    [self.contentView addSubview:self.timeImageView];
    
    self.timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.addressLabel.frame.origin.x, 25, 120, 20)];
    self.timeLabel.font=[UIFont systemFontOfSize:14];
    self.timeLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.5];
    [self.contentView addSubview:self.timeLabel];

    UIImage *phoneImage=[UIImage imageNamed:@"phone_icon_dark"];
    self.phoneImageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.timeLabel.frame.origin.x+self.timeLabel.frame.size.width, self.timeImageView.frame.origin.y, phoneImage.size.width, phoneImage.size.height)];
    self.phoneImageView.image=phoneImage;
    [self.contentView addSubview:self.phoneImageView];
    
    self.phoneLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.phoneImageView.frame.origin.x+self.phoneImageView.frame.size.width, self.timeLabel.frame.origin.y, ScreenWidth-self.phoneImageView.frame.origin.x-self.phoneImageView.frame.size.width-10, 20)];
    self.phoneLabel.font=[UIFont systemFontOfSize:14];
    self.phoneLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.5];
    [self.contentView addSubview:self.phoneLabel];
    
    self.lineView=[[UIView alloc]initWithFrame:CGRectMake(10, 52.5, ScreenWidth-20, 0.5)];
    self.lineView.backgroundColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.3];
    [self.contentView addSubview:self.lineView];
    
}


-(void)configData:(NSDictionary *)dict
{
    NSDateFormatter *dateFormate=[[NSDateFormatter alloc]init];
    [dateFormate setDateFormat:@"hh:mm"];
    
    if ([[dict objectForKey:@"isSelected"]boolValue])
    {
        self.headImageView.image=[UIImage imageNamed:@"selected_green_icon"];
    }
    else
    {
        self.headImageView.image=[UIImage imageNamed:@"normal_round_icon"];
    }
    
//    NSString *startTime=[NSString stringWithFormat:@"%@",[dateFormate stringFromDate:[NSDate dateWithTimeIntervalSince1970:[dict[kDispatcherPropertyOpenTime] doubleValue]/1000/1000]]];
//    NSString *endTime=[NSString stringWithFormat:@"%@",[dateFormate stringFromDate:[NSDate dateWithTimeIntervalSince1970:[dict[kDispatcherPropertyCloseTime] doubleValue]/1000/1000]]];
    
    if ([dict[kDispatcherPropertyIsCustom] boolValue]) {
        self.timeLabel.text = @"已团主通知为准";
    } else {
        NSString *startTime=[NSString stringWithFormat:@"%@:00",dict[kDispatcherPropertyOpenTime]];
        NSString *endTime = [NSString stringWithFormat:@"%@:00",dict[kDispatcherPropertyCloseTime]];
        self.timeLabel.text=[NSString stringWithFormat:@"%@-%@",startTime,endTime];
    }
    
    self.addressLabel.text=dict[kDispatcherPropertyAddress];
    self.phoneLabel.text=dict[kDispatcherPropertyMobile];
    
}


@end
