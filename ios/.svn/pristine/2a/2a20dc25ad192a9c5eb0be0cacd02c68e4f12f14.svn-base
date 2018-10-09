//
//  CommentPointTableCell.m
//  CookBook
//
//  Created by 你好 on 16/9/6.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "CommentPointTableCell.h"
#import "GroupsPropertyKeys.h"
@interface CommentPointTableCell ()<UITextViewDelegate>

@end

@implementation CommentPointTableCell

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
    UIImage *image=[UIImage imageNamed:@"normal_round_icon"];
    self.headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, (90-image.size.height)/2, image.size.width, image.size.height)];
    self.headImageView.image=image;
    [self.contentView addSubview:self.headImageView];
    
    UIImage *locationImage=[UIImage imageNamed:@"location_icon_dark"];
    self.locationImageView=[[UIImageView alloc]initWithFrame:CGRectMake(30+image.size.width,10+(20-locationImage.size.height)/2+5, locationImage.size.width, locationImage.size.height)];
    self.locationImageView.image=locationImage;
    [self.contentView addSubview:self.locationImageView];
    
//    self.addressLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.locationImageView.frame.origin.x+self.locationImageView.frame.size.width+5, 13, ScreenWidth-self.locationImageView.frame.origin.x-self.locationImageView.frame.size.width-5-10, 40)];
//    self.addressLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.8];
//    self.addressLabel.font=[UIFont systemFontOfSize:14];
//    self.addressLabel.numberOfLines=2;
//    self.addressLabel.backgroundColor=[UIColor redColor];
//    self.addressLabel.lineBreakMode=NSLineBreakByTruncatingTail;
//    self.addressLabel.text=@"海淀区上地7街1号汇众大厦2号楼海淀区上地7街1号汇众大厦2号楼海淀区上地7街1号汇众大厦2号楼2号楼海淀区上地7街1号汇众大厦2号楼";
//    [self.contentView addSubview:self.addressLabel];
    
    self.addressTextView=[[UnEditTextView alloc]initWithFrame:CGRectMake(self.locationImageView.frame.origin.x+self.locationImageView.frame.size.width+5, 17, ScreenWidth-self.locationImageView.frame.origin.x-self.locationImageView.frame.size.width-15, 35)];
    self.addressTextView.autocorrectionType=UITextAutocorrectionTypeNo;
    self.addressTextView.autocapitalizationType=UITextAutocapitalizationTypeNone;
    self.addressTextView.font=[UIFont systemFontOfSize:14];
    self.addressTextView.scrollEnabled=NO;
    self.addressTextView.textContainerInset=UIEdgeInsetsMake(0, 0, 0, 0);
    self.addressTextView.textColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.5];
//    self.addressTextView.text=@"海淀区上地7街1号汇众大厦2号楼海淀区上地7街1号汇众大厦2号楼海淀区上地7街1号汇众大厦2号楼2号楼海淀区上地7街1号汇众大厦2号楼";
    [self addSubview:self.addressTextView];
    
    
    UIImage *timeImage=[UIImage imageNamed:@"time_icon_dark"];
    self.timeImageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.locationImageView.frame.origin.x, self.addressTextView.frame.origin.y+self.addressTextView.frame.size.height+(20-timeImage.size.height)/2+5, timeImage.size.width, timeImage.size.height)];
    self.timeImageView.image=timeImage;
    [self.contentView addSubview:self.timeImageView];
    
    self.timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.addressTextView.frame.origin.x+3, self.addressTextView.frame.origin.y+self.addressTextView.frame.size.height+5, 120, 20)];
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
    
    self.lineView=[[UIView alloc]initWithFrame:CGRectMake(10, 89.5, ScreenWidth-20, 0.5)];
    self.lineView.backgroundColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.3];
    [self.contentView addSubview:self.lineView];
    
}

-(void)setChecked:(BOOL)bChecked
{
    UIImage *image;
    if (bChecked) {
        image = [UIImage imageNamed:@"selected_green_icon"];
    } else {
        image = [UIImage imageNamed:@"normal_round_icon"];
    }
    
    self.headImageView.image = image;
}


-(void)configData:(NSDictionary *)dict
{
    self.addressTextView.text=dict[kDispatcherPropertyAddress];
    self.phoneLabel.text=dict[kDispatcherPropertyMobile];
    
    if ([dict[kDispatcherPropertyIsCustom] boolValue])
    {
        self.timeLabel.text = @"以团主通知为准";
    }
    else
    {
        NSString *timeStr=[NSString stringWithFormat:@"%@:00-%@:00",dict[kDispatcherPropertyOpenTime],dict[kDispatcherPropertyCloseTime]];
        self.timeLabel.text=timeStr;
    }
    
}






@end
