//
//  GroupPurchaseTableCell.m
//  CookBook
//
//  Created by 你好 on 16/6/2.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "GroupPurchaseTableCell.h"
#import "GroupsPropertyKeys.h"
#import "GroupsInfoReformer.h"
#import <UIButton+WebCache.h>

@implementation GroupPurchaseTableCell
{
    UIView * _coverView;
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
    self.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    self.contentView.clipsToBounds = YES;
    
    UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth/16*9+127+28)];
    backView.backgroundColor=[UIColor whiteColor];
    backView.userInteractionEnabled=YES;
    [self.contentView addSubview:backView];

    self.contentImageView=[[GradientImageView alloc]initWithFrame:CGRectMake(0, 0, backView.bounds.size.width,  ScreenWidth/16*9)];
    
//    UIImage * statusImage = [UIImage imageNamed:@"gpFinish"];
//    self.statusImageView = [[UIImageView alloc] initWithImage:statusImage];
//    self.statusImageView.frame = CGRectMake(self.contentImageView.bounds.size.width-statusImage.size.width-10, 0, statusImage.size.width, statusImage.size.height);
//    [self.contentImageView addSubview:self.statusImageView];
    [backView addSubview:self.contentImageView];
    
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.contentImageView.frame.origin.x, self.contentImageView.frame.origin.y+self.contentImageView.frame.size.height/2-25, self.contentImageView.frame.size.width, 20)];
    self.titleLabel.font=[UIFont systemFontOfSize:16];
    self.titleLabel.textColor=[UIColor whiteColor];
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
    [backView addSubview:self.titleLabel];
    
    self.lineView=[[UIView alloc]initWithFrame:CGRectZero];
    self.lineView.backgroundColor=[UIColor whiteColor];
    [backView addSubview:self.lineView];
    
    self.subTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.contentImageView.frame.origin.x, self.contentImageView.frame.origin.y+self.contentImageView.frame.size.height/2+5, self.contentImageView.frame.size.width, 20)];
    self.subTitleLabel.textColor=[UIColor whiteColor];
    self.subTitleLabel.textAlignment=NSTextAlignmentCenter;
    self.subTitleLabel.font=[UIFont boldSystemFontOfSize:20];
    self.subTitleLabel.shadowColor=RGBACOLOR(1, 1, 1, 0.5);
    self.subTitleLabel.shadowOffset= CGSizeMake(0, -1.0);
    [backView addSubview:self.subTitleLabel];
    
    
//    self.endLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.contentImageView.frame.origin.x+self.contentImageView.frame.size.width/2-70, self.contentImageView.frame.origin.y+self.contentImageView.frame.size.height/2-20, 140, 40)];
//    self.endLabel.layer.cornerRadius=15;
//    self.endLabel.clipsToBounds=YES;
//    self.endLabel.textAlignment=NSTextAlignmentCenter;
//    self.endLabel.backgroundColor=RGBACOLOR(1, 1, 1, 0.6);
//    self.endLabel.text=@"团购已结束";
//    self.endLabel.textColor=[UIColor whiteColor];
//    self.endLabel.hidden=YES;
//    [backView addSubview:self.endLabel];
    
    self.userButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.userButton.frame=CGRectMake(10, self.contentImageView.frame.origin.y+self.contentImageView.frame.size.height+15, 50,50);
    [[self.userButton imageView]setContentMode:UIViewContentModeScaleAspectFill];
    self.userButton.layer.cornerRadius=25;
    self.userButton.clipsToBounds=YES;
    [self.userButton setAdjustsImageWhenHighlighted:NO];
    [backView addSubview:self.userButton];
    
    self.nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(70, self.userButton.frame.origin.y, ScreenWidth-140, 30)];
    self.nameLabel.backgroundColor=[UIColor clearColor];
    self.nameLabel.font=[UIFont systemFontOfSize:16];
    self.nameLabel.textColor=[UIColor colorWithHexString:@"#343434"];
    [backView addSubview:self.nameLabel];
    
    self.timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.nameLabel.frame.origin.x, self.nameLabel.frame.origin.y+self.nameLabel.frame.size.height, ScreenWidth-140, 20)];
    self.timeLabel.font=[UIFont systemFontOfSize:12];
    self.timeLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.8];
    [backView addSubview:self.timeLabel];
    
    UIImage *addressImage=[UIImage imageNamed:@"location_icon"];
    self.addressImageView=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-30-addressImage.size.width, self.nameLabel.frame.origin.y, addressImage.size.width, addressImage.size.height)];
    self.addressImageView.image=addressImage;
    [backView addSubview:self.addressImageView];
    
    self.addressLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    self.addressLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e"];
    self.addressLabel.font=[UIFont systemFontOfSize:12];
    [backView addSubview:self.addressLabel];
    
    
    UIView *lineView1=[[UIView alloc]initWithFrame:CGRectMake(9, self.userButton.frame.origin.y+self.userButton.frame.size.height+15, ScreenWidth-18, 1)];
    lineView1.backgroundColor=[UIColor lightGrayColor];
    lineView1.alpha=0.5;
    [backView addSubview:lineView1];
    
    self.groupPurBtn=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-120, backView.bounds.size.height-52, 110, 30)];
    self.groupPurBtn.backgroundColor=RGBACOLOR(177, 116, 67, 1);
    self.groupPurBtn.layer.cornerRadius=8;
    self.groupPurBtn.clipsToBounds=YES;
    self.groupPurBtn.textColor=[UIColor whiteColor];
    self.groupPurBtn.textAlignment=NSTextAlignmentCenter;
    [backView addSubview:self.groupPurBtn];
    
    self.descLabel=[[UILabel alloc]initWithFrame:CGRectMake(15,lineView1.frame.origin.y+17, ScreenWidth-145, 40)];
    self.descLabel.textAlignment=NSTextAlignmentLeft;
    self.descLabel.font=[UIFont systemFontOfSize:12];
    self.descLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.8];
    [backView addSubview:self.descLabel];
    
    _coverView = [[UIView alloc] initWithFrame:self.contentImageView.frame];
    _coverView.backgroundColor = RGBACOLOR(1, 1, 1, 0.4);
    [backView addSubview:_coverView];
    
    UIImage * statusImage = [UIImage imageNamed:@"gpFinish"];
    self.statusImageView = [[UIImageView alloc] initWithImage:statusImage];
    self.statusImageView.frame = CGRectMake(_coverView.bounds.size.width-statusImage.size.width-10, 0, statusImage.size.width, statusImage.size.height);
    [_coverView addSubview:self.statusImageView];
}


-(void)configData:(NSDictionary *)dict
{    
    NSURL *userUrl=[NSURL URLWithString: dict[kGroupsPropertyReseller][kDispatcherPropertyWXHeadUrl]];
    NSDateFormatter *dateFormate=[[NSDateFormatter alloc]init];
    [dateFormate setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSTimeInterval timeInterval=[dict[kGroupsPropertyDeadTime] longLongValue]/1000/1000;
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString *deadTime =[dateFormate stringFromDate:date];
    
    
    NSString *str=dict[kGroupsPropertyCategory];
    CGRect rect=[str boundingRectWithSize:CGSizeMake(self.contentImageView.frame.size.width, 20) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    
    NSString *locationStr=dict[kGroupsPropertyLocation];
    
    CGRect locationRect= [locationStr boundingRectWithSize:CGSizeMake(self.contentImageView.frame.size.width/2-20, 30) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    if (locationRect.size.width>self.contentImageView.frame.size.width/2-20)
    {
        locationRect.size.width=self.contentImageView.frame.size.width/2-20;
    }
    
    UIImage *addressImage=[UIImage imageNamed:@"location_icon"];

    self.addressImageView.frame=CGRectMake(ScreenWidth-15-locationRect.size.width-addressImage.size.width,  self.nameLabel.frame.origin.y+(30-addressImage.size.height)/2, addressImage.size.width, addressImage.size.height);
    self.addressLabel.frame=CGRectMake(ScreenWidth-10-locationRect.size.width, self.nameLabel.frame.origin.y, locationRect.size.width, 30);
    self.lineView.frame=CGRectMake(self.contentImageView.frame.origin.x+self.contentImageView.frame.size.width/2-rect.size.width/2, self.contentImageView.frame.origin.y+self.contentImageView.frame.size.height/2-1, rect.size.width, 1);
    
    self.titleLabel.text=str;
    self.subTitleLabel.text=dict[kGroupsPropertyTitle];
    self.contentImageView.imageArray=dict[kGroupsPropertyCovers];
    [self.contentImageView configData];
    [self.userButton sd_setImageWithURL:userUrl forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default_icon"]];
    self.timeLabel.text=[NSString stringWithFormat:@"截团时间:%@",deadTime];

    NSString *userStr=[NSString stringWithFormat:@"%@  团主",dict[kGroupsPropertyReseller][kResellerPropertyName]];
    NSRange nameRange=[userStr rangeOfString:@"团主"];
    NSMutableAttributedString *userAttrStr=[[NSMutableAttributedString alloc]initWithString:userStr];
    [userAttrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} range:NSMakeRange(0, userStr.length-2)];
    [userAttrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} range:NSMakeRange(nameRange.location, nameRange.length)];
    
    self.nameLabel.attributedText=userAttrStr;
    self.addressLabel.text=dict[kGroupsPropertyLocation];
    self.descLabel.text=[NSString stringWithFormat:@"已有%ld人参团",[dict[kGroupsPropertyParticipant] integerValue]];
    
    NSInteger status = [dict[kGroupsPropertyStatus] integerValue];
    if (status==GroupBuyInProgress )
    {
//        self.endLabel.hidden=YES;
        self.statusImageView.hidden = YES;
        _coverView.hidden = YES;
        self.groupPurBtn.text=@"去参团";
        
//        self.lineView.hidden=NO;
//        self.titleLabel.hidden=NO;
//        self.subTitleLabel.hidden=NO;
//        self.contentImageView.backView.backgroundColor=RGBACOLOR(1, 1, 1, 0.3);
//        self.groupPurBtn.backgroundColor=RGBACOLOR(73, 141, 46, 1);
    
        if ([dict[kGroupsPropertyIsSoldout] boolValue]) {
            self.statusImageView.hidden = NO;
            _coverView.hidden = NO;
            self.statusImageView.image = [UIImage imageNamed:@"gpSoldout"];
            self.groupPurBtn.text = @"去围观";
        }
    }
    else
    {
//        self.endLabel.hidden=NO;
        self.statusImageView.hidden = NO;
        _coverView.hidden = NO;

        if (status == GroupBuyNotStart) {
//            self.endLabel.text = @"团购未开始";
            self.statusImageView.image = [UIImage imageNamed:@"gpNotStart"];
            self.groupPurBtn.text=@"去参团";
            
        } else if (status == GroupBuyTerminate ||
                   status == GroupBuyCommitOrder) {
//            self.endLabel.text = @"团购已结束";
            self.statusImageView.image = [UIImage imageNamed:@"gpFinish"];
            self.groupPurBtn.text=@"去围观";
        } 
        
//        self.lineView.hidden=YES;
//        self.titleLabel.hidden=YES;
//        self.subTitleLabel.hidden=YES;
//        self.contentImageView.backView.backgroundColor=RGBACOLOR(1, 1, 1, 0.5);
//        self.groupPurBtn.backgroundColor=[UIColor colorWithHexString:@"#999999"];
        
    }
}


@end
