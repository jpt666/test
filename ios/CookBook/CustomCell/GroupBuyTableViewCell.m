//
//  GroupBuyTableViewCell.m
//  CookBook
//
//  Created by 你好 on 16/8/10.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "GroupBuyTableViewCell.h"
#import "GroupsPropertyKeys.h"
#import "GroupsInfoReformer.h"
#import <UIButton+WebCache.h>
@implementation GroupBuyTableViewCell
{
    UIView * _coverView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
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
    
    UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth/16*9+127+28+40)];
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
    
    
    UIView *topLineView=[[UIView alloc]initWithFrame:CGRectMake(9, self.userButton.frame.origin.y+self.userButton.frame.size.height+15, ScreenWidth-18, 1)];
    topLineView.backgroundColor=[UIColor lightGrayColor];
    topLineView.alpha=0.5;
    [backView addSubview:topLineView];
    
    
    self.tapView=[[GroupTapView alloc]initWithFrame:CGRectMake(9, topLineView.frame.origin.y+topLineView.frame.size.height, ScreenWidth-18, 60)];
    self.tapView.rightLabel.text=@"商品总计 > ";
    [backView addSubview:self.tapView];
    

    UIView *bottomLineView=[[UIView alloc]initWithFrame:CGRectMake(9, topLineView.frame.origin.y+60 , backView.bounds.size.width-18, 1)];
    bottomLineView.backgroundColor=[UIColor lightGrayColor];
    bottomLineView.alpha=0.5;
    [backView addSubview:bottomLineView];
    
//    self.alertLabel=[[UILabel alloc]initWithFrame:CGRectMake(9, bottomLineView.frame.origin.y+bottomLineView.frame.size.height, ScreenWidth-9-210, 54)];
    self.alertLabel=[[UILabel alloc]initWithFrame:CGRectMake(9+80, bottomLineView.frame.origin.y+bottomLineView.frame.size.height, ScreenWidth-9-210, 54)];
    self.alertLabel.text=@"未开始";
    self.alertLabel.font=[UIFont systemFontOfSize:14];
    self.alertLabel.textAlignment=NSTextAlignmentRight;
    [backView addSubview:self.alertLabel];
    
    self.delButton=[UIButton buttonWithType:UIButtonTypeCustom];
//    self.delButton.frame=CGRectMake(ScreenWidth-9-180, self.alertLabel.frame.origin.y+12, 80, 30);
    self.delButton.frame=CGRectMake(ScreenWidth-9-90, self.alertLabel.frame.origin.y+12, 80, 30);
    self.delButton.layer.cornerRadius=6;
    self.delButton.clipsToBounds=YES;
    self.delButton.titleLabel.font=[UIFont systemFontOfSize:14];
    self.delButton.backgroundColor=RGBACOLOR(176, 116, 67, 1);
    [self.delButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.delButton setTitle:@"删除团购" forState:UIControlStateNormal];
    [backView addSubview:self.delButton];
    
//    self.editButton=[UIButton buttonWithType:UIButtonTypeCustom];
//    self.editButton.frame=CGRectMake(ScreenWidth-9-90, self.delButton.frame.origin.y, 80, 30);
//    self.editButton.layer.cornerRadius=6;
//    self.editButton.clipsToBounds=YES;
//    self.editButton.titleLabel.font=[UIFont systemFontOfSize:14];
//    self.editButton.backgroundColor=[UIColor orangeColor];
//    [self.editButton setTitle:@"编辑团购" forState:UIControlStateNormal];
//    [self.editButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [backView addSubview:self.editButton];
    
    self.terminateButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.terminateButton.frame=CGRectMake(ScreenWidth-9-90, self.delButton.frame.origin.y, 80, 30);
    self.terminateButton.layer.cornerRadius=8;
    self.terminateButton.clipsToBounds=YES;
    self.terminateButton.titleLabel.font=[UIFont systemFontOfSize:14];
    self.terminateButton.backgroundColor=RGBACOLOR(176, 116, 67, 1);
    [self.terminateButton setTitle:@"终止团购" forState:UIControlStateNormal];
    [self.terminateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backView addSubview:self.terminateButton];
    
    self.submitButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.submitButton.frame=CGRectMake(ScreenWidth-9-90, self.delButton.frame.origin.y, 80, 30);
    self.submitButton.layer.cornerRadius=8;
    self.submitButton.clipsToBounds=YES;
    self.submitButton.titleLabel.font=[UIFont systemFontOfSize:14];
    self.submitButton.backgroundColor=RGBACOLOR(176, 116, 67, 1);
    [self.submitButton setTitle:@"提交订单" forState:UIControlStateNormal];
    [self.submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backView addSubview:self.submitButton];
//
    self.deliverButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.deliverButton.frame=CGRectMake(ScreenWidth-9-90, self.delButton.frame.origin.y, 80, 30);
    self.deliverButton.layer.cornerRadius=8;
    self.deliverButton.clipsToBounds=YES;
    self.deliverButton.titleLabel.font=[UIFont systemFontOfSize:14];
    self.deliverButton.backgroundColor=RGBACOLOR(176, 116, 67, 1);
    [self.deliverButton setTitle:@"发货中" forState:UIControlStateNormal];
    [self.deliverButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backView addSubview:self.deliverButton];
    
    [self.delButton addTarget:self action:@selector(delButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.editButton addTarget:self action:@selector(editButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.terminateButton addTarget:self action:@selector(terminateButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.submitButton addTarget:self action:@selector(submitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.deliverButton addTarget:self action:@selector(deliverButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _coverView = [[UIView alloc] initWithFrame:self.contentImageView.frame];
    _coverView.backgroundColor = RGBACOLOR(1, 1, 1, 0.4);
    [backView addSubview:_coverView];
    
    UIImage * statusImage = [UIImage imageNamed:@"gpFinish"];
    self.statusImageView = [[UIImageView alloc] initWithImage:statusImage];
    self.statusImageView.frame = CGRectMake(_coverView.bounds.size.width-statusImage.size.width-10, 0, statusImage.size.width, statusImage.size.height);
    [_coverView addSubview:self.statusImageView];
}



-(void)configData:(NSMutableDictionary *)dict
{
    self.dictData = dict;
    self.tapView.dictBulkData = dict;
    
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
    
    
    NSInteger participant = [dict[kGroupsPropertyParticipant] integerValue];
    
    self.nameLabel.attributedText=userAttrStr;
    self.addressLabel.text=dict[kGroupsPropertyLocation];
    self.tapView.leftLabel.text=[NSString stringWithFormat:@"已成团/已有%ld人参团",(long)participant];
    
//    self.endLabel.hidden=YES;
    self.statusImageView.hidden = YES;
    _coverView.hidden = YES;
//    self.statusImageView.image = nil;
    
    self.lineView.hidden=NO;
    self.titleLabel.hidden=NO;
    self.subTitleLabel.hidden=NO;
    self.contentImageView.backView.backgroundColor=RGBACOLOR(1, 1, 1, 0.3);
    self.alertLabel.hidden = YES;
    
    NSInteger status = [dict[kGroupsPropertyStatus] integerValue];
    if (status==GroupBuyInProgress )
    {
        self.delButton.hidden = YES;
        self.submitButton.hidden = YES;
        self.terminateButton.hidden= NO;
        self.deliverButton.hidden = YES;
        
        if ([dict[kGroupsPropertyIsSoldout] boolValue]) {
            self.statusImageView.hidden = NO;
            _coverView.hidden = NO;
            self.statusImageView.image = [UIImage imageNamed:@"gpSoldout"];
        }
        
    } else if (status == GroupBuyNotStart) {
        
//        self.endLabel.text=@"团购未开始";
//        self.endLabel.hidden = NO;
        self.statusImageView.hidden = NO;
        _coverView.hidden = NO;
        self.statusImageView.image = [UIImage imageNamed:@"gpNotStart"];
        
//        self.lineView.hidden=YES;
//        self.titleLabel.hidden=YES;
//        self.subTitleLabel.hidden=YES;
//        self.contentImageView.backView.backgroundColor=RGBACOLOR(1, 1, 1, 0.5);
        
        self.delButton.hidden = NO;
        self.submitButton.hidden = YES;
        self.terminateButton.hidden= YES;
        self.deliverButton.hidden = YES;
        
    } else if (status == GroupBuyCommitOrder) {

//        self.endLabel.text = @"团购已结束";
//        self.endLabel.hidden=NO;
        
        self.statusImageView.hidden = NO;
        _coverView.hidden = NO;
        self.statusImageView.image = [UIImage imageNamed:@"gpFinish"];
        
//        self.lineView.hidden=YES;
//        self.titleLabel.hidden=YES;
//        self.subTitleLabel.hidden=YES;
//        self.contentImageView.backView.backgroundColor=RGBACOLOR(1, 1, 1, 0.5);
        
        
        self.delButton.hidden = YES;
        self.submitButton.hidden = YES;
        self.terminateButton.hidden= YES;
        self.deliverButton.hidden = NO;
        
    } else if (status == GroupBuyTerminate) {
//        self.endLabel.text = @"团购已结束";
//        self.endLabel.hidden=NO;
        
        self.statusImageView.hidden = NO;
        _coverView.hidden = NO;
        self.statusImageView.image =[UIImage imageNamed:@"gpFinish"];
        
//        self.lineView.hidden=YES;
//        self.titleLabel.hidden=YES;
//        self.subTitleLabel.hidden=YES;
//        self.contentImageView.backView.backgroundColor=RGBACOLOR(1, 1, 1, 0.5);
        
        self.delButton.hidden = YES;
        self.submitButton.hidden = NO;
        self.submitButton.enabled = (participant>0)?YES:NO;
        self.submitButton.backgroundColor = (self.submitButton.isEnabled)?RGBACOLOR(176, 116, 67, 1):[UIColor  lightGrayColor];
        
        self.terminateButton.hidden= YES;
        self.deliverButton.hidden = YES;
    }
}

//发货中
-(void)deliverButtonClick:(UIButton *)button
{
    if (_delegate && [_delegate respondsToSelector:@selector(deliverButtonClick:)]) {
        [_delegate deliverButtonClick:self];
    }
}

//提交订单
-(void)submitButtonClick:(UIButton *)button
{
    if (_delegate && [_delegate respondsToSelector:@selector(submitButtonClick:)]) {
        [_delegate submitButtonClick:self];
    }
}

//终止团购
-(void)terminateButtonClick:(UIButton *)button
{
    if (_delegate && [_delegate respondsToSelector:@selector(terminateButtonClick:)]) {
        [_delegate terminateButtonClick:self];
    }
}

//删除团购
-(void)delButtonClick:(UIButton *)button
{
    if (_delegate && [_delegate respondsToSelector:@selector(delButtonClick:)]) {
        [_delegate delButtonClick:self];
    }
}

//编辑团购
-(void)editButtonClick:(UIButton *)button
{
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
