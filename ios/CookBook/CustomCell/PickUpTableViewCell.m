//
//  PickUpTableViewCell.m
//  CookBook
//
//  Created by 你好 on 16/8/11.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "PickUpTableViewCell.h"
#import "GroupsPropertyKeys.h"

@implementation PickUpTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

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
    self.typeLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20)];
//    self.typeLabel.text=@"[ 固定自提点 ]";
//    self.typeLabel.textColor=[UIColor orangeColor];
    self.typeLabel.font=[UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.typeLabel];
    
    UIImage *locationImage=[UIImage imageNamed:@"location_icon_dark"];
    self.locationImageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.typeLabel.frame.origin.x , self.typeLabel.frame.origin.y+self.typeLabel.frame.size.height+(20-locationImage.size.height)/2+5, locationImage.size.width, locationImage.size.height)];
    self.locationImageView.image=locationImage;
    [self.contentView addSubview:self.locationImageView];
    
    self.addressLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.locationImageView.frame.origin.x+self.locationImageView.frame.size.width+5, self.typeLabel.frame.origin.y+self.typeLabel.frame.size.height+5, ScreenWidth-self.locationImageView.frame.origin.x-self.locationImageView.frame.size.width-5, 20)];
    self.addressLabel.font=[UIFont systemFontOfSize:14];
    self.addressLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.8];
    self.addressLabel.text=@"海淀区上地7街1号汇众大厦2号楼";
    [self.contentView addSubview:self.addressLabel];
    
    UIImage *timeImage=[UIImage imageNamed:@"time_icon_dark"];
    self.timeImageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.locationImageView.frame.origin.x, self.addressLabel.frame.origin.y+self.addressLabel.frame.size.height+(20-timeImage.size.height)/2+5, timeImage.size.width, timeImage.size.height)];
    self.timeImageView.image=timeImage;
    [self.contentView addSubview:self.timeImageView];
    
    self.timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.addressLabel.frame.origin.x, self.addressLabel.frame.origin.y+self.addressLabel.frame.size.height+5, 120, 20)];
    self.timeLabel.font=[UIFont systemFontOfSize:14];
    self.timeLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.5];
    self.timeLabel.text=@"09:00-17:00";
    [self.contentView addSubview:self.timeLabel];
    
    UIImage *phoneImage=[UIImage imageNamed:@"phone_icon_dark"];
    self.phoneImageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.timeLabel.frame.origin.x+self.timeLabel.frame.size.width, self.timeImageView.frame.origin.y, phoneImage.size.width, phoneImage.size.height)];
    self.phoneImageView.image=phoneImage;
    [self.contentView addSubview:self.phoneImageView];
    
    self.phoneLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.phoneImageView.frame.origin.x+self.phoneImageView.frame.size.width, self.timeLabel.frame.origin.y, ScreenWidth-self.phoneImageView.frame.origin.x-self.phoneImageView.frame.size.width-10, 20)];
    self.phoneLabel.font=[UIFont systemFontOfSize:14];
    self.phoneLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.5];
    self.phoneLabel.text=@"13845698524";
    [self.contentView addSubview:self.phoneLabel];
    
    self.lineView=[[UIView alloc]initWithFrame:CGRectMake(10, 90, ScreenWidth-20, 0.5)];
    self.lineView.backgroundColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.3];
    [self.contentView addSubview:self.lineView];

}

-(void)configData:(NSDictionary *)dict
{
    
    self.addressLabel.text=dict[kDispatcherPropertyAddress];
    self.phoneLabel.text=dict[kDispatcherPropertyMobile];
    
    if (dict[kDispatcherPropertyIsCustom] &&
        [dict[kDispatcherPropertyIsCustom] boolValue]) {
        self.timeLabel.text = @"以团主通知为准";
        
        self.typeLabel.text=@"[ 临时自提点 ]";
        self.typeLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.8];
        
    } else {
        
        NSString *timeStr=[NSString stringWithFormat:@"%@:00-%@:00",dict[kDispatcherPropertyOpenTime],dict[kDispatcherPropertyCloseTime]];
        self.timeLabel.text=timeStr;
        self.typeLabel.text=@"[ 固定自提点 ]";
        self.typeLabel.textColor=RGBACOLOR(176, 116, 67, 1);
    }
}

@end
