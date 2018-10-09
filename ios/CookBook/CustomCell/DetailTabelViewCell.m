//
//  DetailTabelViewCell.m
//  CookBook
//
//  Created by 你好 on 16/4/22.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "DetailTabelViewCell.h"

@implementation DetailTabelViewCell

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
    self.contentImageView=[[AnimationImageView alloc]initWithFrame:CGRectMake(10, 0, ScreenWidth-20, 200)];
    self.contentImageView.userInteractionEnabled=NO;
    self.contentImageView.clipsToBounds=YES;
    self.contentImageView.contentMode=UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.contentImageView];
    
    self.descLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 200, ScreenWidth, 40)];
    self.descLabel.font=[UIFont systemFontOfSize:16];
    self.descLabel.lineBreakMode=NSLineBreakByTruncatingTail;
    self.descLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e"];
    self.descLabel.numberOfLines=0;
//    self.descLabel.backgroundColor=[UIColor greenColor];
    [self.contentView addSubview:self.descLabel];
}


-(void)setupWithCookData:(NSDictionary *)dict CookType:(CookType)type  IndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictory=nil;
    NSString *url=nil;
    NSString *descStr=nil;
    
    if (type==CookBookType)
    {
        dictory=[dict[kBookPropertyCookSteps] objectAtIndex:indexPath.row];
    }
    else if(type==CookProductType)
    {
        dictory=[dict[kProductPropertyPhotos] objectAtIndex:indexPath.row];
    }
    
    url=dictory[kPhotoPropertyPhotoUrl];
    if ([dictory[kPhotoPropertyDescription] length]>0)
    {
        descStr=[NSString stringWithFormat:@"%ld.%@",(long)indexPath.row+1,dictory[kPhotoPropertyDescription]];
    }
    else
    {
        descStr=dictory[kPhotoPropertyDescription];
    }
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:descStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, descStr.length)];
    
    [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:PLACE_HOLDER_COOK_IMAGE]];
    
    double imageWidth=[dictory[kPhotoPropertyWidth] doubleValue];
    double imageHeight=[dictory[kPhotoPropertyHeight] doubleValue];
    
    double height = imageHeight;
    if (imageWidth) {
        height=(ScreenWidth *imageHeight)/imageWidth;
    }
    double textHeight=[self heightForLabelText:descStr];
    self.contentImageView.frame=CGRectMake(0,0, ScreenWidth, height);
    
    if ([dictory[kPhotoPropertyDescription] length]>0)
    {
        self.descLabel.frame=CGRectMake(20, self.contentImageView.frame.origin.y+self.contentImageView.frame.size.height+20, ScreenWidth-40, textHeight);
        self.descLabel.attributedText=attributedString;
    }
    else
    {
        self.descLabel.frame=CGRectZero;
    }
    
}



-(double)heightForLabelText:(NSString *)str
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];//调整行间距

    CGRect rect= [str boundingRectWithSize:CGSizeMake(ScreenWidth-40, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSParagraphStyleAttributeName:paragraphStyle} context:nil];
    return rect.size.height;
}





@end
