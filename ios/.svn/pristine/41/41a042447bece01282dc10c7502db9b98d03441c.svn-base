//
//  GroupPurTopView.m
//  CookBook
//
//  Created by 你好 on 16/6/3.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "GroupPurTopView.h"
#import "GroupsPropertyKeys.h"
#import "GroupsInfoReformer.h"
#import <UIImageView+WebCache.h>
#import "NSDate+ZXAdd.h"

@implementation GroupPurTopView


-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        [self configUI];
    }
    return self;
}



-(void)configUI
{
    self.hidden=YES;
    
    self.userImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 50, 50)];
    self.userImageView.contentMode=UIViewContentModeScaleAspectFill;
    self.userImageView.image=[UIImage imageNamed:@"default_icon"];
    self.userImageView.layer.cornerRadius=25;
    self.userImageView.clipsToBounds=YES;
    self.userImageView.layer.borderColor=[UIColor whiteColor].CGColor;
    self.userImageView.layer.borderWidth=1.0f;
    [self addSubview:self.userImageView];
    
    self.userTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(70, 15, ScreenWidth/2-70, 30)];
    self.userTitleLabel.backgroundColor=[UIColor clearColor];
    self.userTitleLabel.textColor=[UIColor colorWithHexString:@"343434"];
    [self addSubview:self.userTitleLabel];
    
    UIImage *addressImage=[UIImage imageNamed:@"location_icon"];
    UIImageView *addressImageView=[[UIImageView alloc]initWithFrame:CGRectMake(70, 45+(20-addressImage.size.height)/2, addressImage.size.width, addressImage.size.height)];
    addressImageView.image=addressImage;
    [self addSubview:addressImageView];
    
    self.addressLabel=[[UILabel alloc]initWithFrame:CGRectMake(addressImageView.frame.origin.x+addressImageView.frame.size.width+5, 45, ScreenWidth/2-addressImageView.frame.origin.x-addressImageView.frame.size.width-5, 20)];
    self.addressLabel.font=[UIFont systemFontOfSize:12];
    self.addressLabel.textColor=[UIColor colorWithHexString:@"4e4e4e"];
    [self addSubview:self.addressLabel];
    
//    NSString *numString=[NSString stringWithFormat:@"已有23人参团"];
//    NSString *durationString=[NSString stringWithFormat:@"剩2天"];
//    NSString *titleString=[NSString stringWithFormat:@"%@   %@",numString,durationString];
//
//    NSRange range=[titleString rangeOfString:durationString];
//    
//    NSMutableAttributedString *attrString=[[NSMutableAttributedString alloc]initWithString:titleString];
//    [attrString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor orangeColor]} range:NSMakeRange(2, numString.length-4)];
//    [attrString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor orangeColor]} range:NSMakeRange(range.location+1, durationString.length-2)];
//    [attrString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} range:NSMakeRange(0, 2)];
//    [attrString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} range:NSMakeRange(numString.length-2, 2)];
//    [attrString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} range:NSMakeRange(range.location, 1)];
//    [attrString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} range:NSMakeRange(titleString.length-1, 1)];
    
//    [attrString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor blackColor],NSKernAttributeName:@(1.5f)} range:NSMakeRange(0, 2)];
//    [attrString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor blackColor],NSKernAttributeName:@(1.5f)} range:NSMakeRange(numString.length-2, 2)];
    
    self.groupNumLabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2, 15, ScreenWidth/2-10, 20)];
    self.groupNumLabel.backgroundColor=[UIColor clearColor];
    self.groupNumLabel.textAlignment=NSTextAlignmentRight;
//    self.groupNumLabel.attributedText=attrString;
    [self addSubview:self.groupNumLabel];
    
    self.ETAButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.ETAButton.frame=CGRectMake(ScreenWidth-140, 45, 130, 20);
    [self.ETAButton setImage:[UIImage imageNamed:@"transport_icon"] forState:UIControlStateNormal];
    [self.ETAButton setTitleColor:[UIColor colorWithHexString:@"343434"] forState:UIControlStateNormal];
    [self.ETAButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    [self.ETAButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    self.ETAButton.titleLabel.font=[UIFont systemFontOfSize:12];
    self.ETAButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
//    [self.ETAButton setTitle:@"预计3月25日到货" forState:UIControlStateNormal];
    [self addSubview:self.ETAButton];
    
    self.backgroundColor=RGBACOLOR(237, 237, 237, 1);
    
}


-(void)configData:(NSDictionary *)dict
{
//    NSTimeInterval timeInterval=([dict[kGroupsPropertyDeadTime] doubleValue]-[dict[kGroupsPropertyStandardTime] doubleValue])/1000/1000;
    
    NSInteger status = [dict[kGroupsPropertyStatus] integerValue];
    
    long minutesDiff = [NSDate minutesStandForDaysDiff:[dict[kGroupsPropertyStandardTime] longLongValue]/1000/1000 endTime:[dict[kGroupsPropertyDeadTime] longLongValue]/1000/1000];
    
    NSDateFormatter *dateFormate=[[NSDateFormatter alloc]init];
    [dateFormate setDateFormat:@"预计MM月dd日发货"];
    
    NSString *durationString=nil;
    
    if (status != GroupBuyInProgress) {
        durationString = @"剩0天";
    }
    else if (minutesDiff<ONE_HOUR_MINUTE_TIMEINTERVAL)
    {
//        durationString=[NSString stringWithFormat:@"剩%ld分", minutesDiff];
        
        NSInteger hour = minutesDiff?1:0;
        durationString=[NSString stringWithFormat:@"剩%ld时", hour];
    }
    else if (minutesDiff<ONE_HOUR_MINUTE_TIMEINTERVAL*ONE_DAY_HOUR_NUM)
    {
        durationString=[NSString stringWithFormat:@"剩%ld时",(minutesDiff/ONE_HOUR_MINUTE_TIMEINTERVAL)];
    } else {
        durationString=[NSString stringWithFormat:@"剩%ld天",(minutesDiff/(ONE_HOUR_MINUTE_TIMEINTERVAL*ONE_DAY_HOUR_NUM))];
    }
    
    NSString *numString=[NSString stringWithFormat:@"已有%ld人参团",[dict[kGroupsPropertyParticipant]integerValue]];
    NSString *titleString=[NSString stringWithFormat:@"%@  %@",numString,durationString];
    
    NSRange range=[titleString rangeOfString:durationString];
    
    NSMutableAttributedString *attrString=[[NSMutableAttributedString alloc]initWithString:titleString];
    [attrString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:RGBACOLOR(176, 116, 67, 1)} range:NSMakeRange(2, numString.length-4)];
    [attrString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:RGBACOLOR(176, 116, 67, 1)} range:NSMakeRange(range.location+1, durationString.length-2)];
    [attrString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} range:NSMakeRange(0, 2)];
    [attrString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} range:NSMakeRange(numString.length-2, 2)];
    [attrString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} range:NSMakeRange(range.location, 1)];
    [attrString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} range:NSMakeRange(titleString.length-1, 1)];
    
    self.addressLabel.text=dict[kGroupsPropertyLocation];
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:dict[kGroupsPropertyReseller][kResellerPropertyWXHeaderUrl]] placeholderImage:[UIImage imageNamed:@"default_icon"]];
    
    NSString *userStr=[NSString stringWithFormat:@"%@  团主",dict[kGroupsPropertyReseller][kResellerPropertyName]];
    NSRange nameRange=[userStr rangeOfString:@"团主"];
    NSMutableAttributedString *userAttrStr=[[NSMutableAttributedString alloc]initWithString:userStr];
//    [userAttrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} range:NSMakeRange(0, userStr.length-2)];
    [userAttrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} range:NSMakeRange(nameRange.location, nameRange.length)];
    self.userTitleLabel.attributedText=userAttrStr;
//    self.userTitleLabel.text=dict[kGroupsPropertyReseller][kResellerPropertyName];
    self.groupNumLabel.attributedText=attrString;
//    [self.ETAButton setTitle:[dateFormate stringFromDate:[NSDate dateWithTimeIntervalSince1970:[dict[kGroupsPropertyArrivedTime] longLongValue]/1000/1000]] forState:UIControlStateNormal];
    
    [self.ETAButton setTitle:dict[kGroupsPropertyArrivedTime] forState:UIControlStateNormal];
    
}

@end
