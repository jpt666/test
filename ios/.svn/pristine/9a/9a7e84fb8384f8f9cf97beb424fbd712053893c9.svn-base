//
//  HotSellGoodsCell.m
//  CookBook
//
//  Created by 你好 on 16/6/20.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "HotSellGoodsCell.h"
#import <UIImageView+WebCache.h>
#import "GoodsPropertyKeys.h"

@implementation HotSellGoodsCell

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

    UIImage *priceBackImage=[UIImage imageNamed:@"price_back_icon"];
    
    self.backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth/16*9+165+priceBackImage.size.height)];
    self.backView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:self.backView];
    
    self.contentImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth/16*9)];
    self.contentImageView.image=[UIImage imageNamed:PLACE_HOLDER_COOK_IMAGE];
    self.contentImageView.contentMode=UIViewContentModeScaleAspectFill;
    self.contentImageView.clipsToBounds=YES;
    [self.backView addSubview:self.contentImageView];
    
    UIImage *image=[UIImage imageNamed:@"subTitle_hotSell"];
    self.tagButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.tagButton.frame=CGRectMake(19, 0, image.size.width, image.size.height);
    [self.tagButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 5, 0)];
    self.tagButton.titleLabel.font=[UIFont systemFontOfSize:12];
    [self.tagButton setAdjustsImageWhenHighlighted:NO];
    [self.tagButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.backView addSubview:self.tagButton];
    
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10,self.contentImageView.frame.origin.y+self.contentImageView.frame.size.height+10, ScreenWidth-80, 30)];
    self.titleLabel.text=@"智利车厘子";
    self.titleLabel.font=[UIFont systemFontOfSize:17];
    [self.backView addSubview:self.titleLabel];
    
    self.specLabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-70, self.titleLabel.frame.origin.y+5, 60, 20)];
    self.specLabel.backgroundColor=RGBACOLOR(176, 116, 67, 1);
    self.specLabel.textColor=[UIColor whiteColor];
    self.specLabel.font=[UIFont systemFontOfSize:12];
    self.specLabel.layer.cornerRadius=3;
    self.specLabel.textAlignment=NSTextAlignmentCenter;
    self.specLabel.text=@"6盒/箱";
    self.specLabel.clipsToBounds=YES;
    [self.backView addSubview:self.specLabel];
    
    NSString *descStr=[NSString stringWithFormat:@"智利车厘子智利车厘子智利车厘子智利车厘子智利车厘子"];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:7];//调整行间距
    
    NSMutableAttributedString *descAttrStr=[[NSMutableAttributedString alloc]initWithString:descStr];
    [descAttrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSParagraphStyleAttributeName:paragraphStyle} range:NSMakeRange(0, descStr.length)];
    
    self.descLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, self.titleLabel.frame.origin.y+self.titleLabel.frame.size.height+10,ScreenWidth-20, 70)];
    self.descLabel.numberOfLines=3;
    self.descLabel.lineBreakMode=NSLineBreakByTruncatingTail;
    self.descLabel.textColor=[UIColor colorWithHexString:@"4e4e4e" alpha:0.8];
    self.descLabel.font=[UIFont systemFontOfSize:14];
    self.descLabel.attributedText=descAttrStr;
    [self.backView addSubview:self.descLabel];
    
    NSString *priceStr=[NSString stringWithFormat:@"¥155.0"];
    NSMutableAttributedString *priceAttrStr=[[NSMutableAttributedString alloc]initWithString:priceStr];
    [priceAttrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(0, 1)];
    [priceAttrStr addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(1, priceStr.length-1)];
    [priceAttrStr addAttributes:@{NSKernAttributeName:@(2.0f)} range:NSMakeRange(1, 1)];
    
    self.priceButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.priceButton.frame=CGRectMake(0, self.descLabel.frame.origin.y+self.descLabel.frame.size.height+15, priceBackImage.size.width, priceBackImage.size.height);
    [self.priceButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    [self.priceButton setBackgroundImage:priceBackImage forState:UIControlStateNormal];
    [self.priceButton setAttributedTitle:priceAttrStr forState:UIControlStateNormal];
    [self.priceButton setAdjustsImageWhenHighlighted:NO];
    [self.backView addSubview:self.priceButton];
    
    self.costPriceLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.priceButton.frame.size.width-5,self.priceButton.frame.origin.y+15,60,30)];
    self.costPriceLabel.textAlignment=NSTextAlignmentCenter;
    [self.backView addSubview:self.costPriceLabel];
    
    self.groupNumLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.priceButton.frame.size.width+self.costPriceLabel.frame.size.width-5, self.priceButton.frame.origin.y+15, ScreenWidth-self.costPriceLabel.frame.size.width-self.priceButton.frame.size.width-10, 30)];
    self.groupNumLabel.textColor=RGBACOLOR(176, 116, 67, 1);
    self.groupNumLabel.font=[UIFont systemFontOfSize:14];
    self.groupNumLabel.textAlignment=NSTextAlignmentRight;
    [self.backView addSubview:self.groupNumLabel];
}


+(double)heightForText:(NSString *)str
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:7];//调整行间距
    
    CGRect rect= [str boundingRectWithSize:CGSizeMake(ScreenWidth-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSParagraphStyleAttributeName:paragraphStyle} context:nil];
    
    double height=rect.size.height;
    if (height < 25) {
        height -= 7;
    }
    
    if (height>65)
    {
        height=65;
    }
    return height;
}


-(void)configData:(NSDictionary *)dict andIndexpath:(NSIndexPath *)indexPath
{
    NSDictionary *productDict=dict[@"product"];
    UIImage *priceBackImage=[UIImage imageNamed:@"price_back_icon"];

    if ([productDict[@"tag_color"] isEqualToString:@"red"])
    {
        self.tagButton.hidden=NO;
        [self.tagButton setTitle:productDict[kGoodsPropertyTag] forState:UIControlStateNormal];
        [self.tagButton setBackgroundImage:[UIImage imageNamed:@"subTitle_hotSell"] forState:UIControlStateNormal];
    }
    else if ([productDict[@"tag_color"] isEqualToString:@"green"])
    {
        self.tagButton.hidden=NO;
        [self.tagButton setTitle:productDict[kGoodsPropertyTag] forState:UIControlStateNormal];
        [self.tagButton setBackgroundImage:[UIImage imageNamed:@"subTitle_newGoods"] forState:UIControlStateNormal];
    }
    else if([productDict[@"tag_color"] isEqualToString:@"yellow"])
    {
        self.tagButton.hidden=NO;
        [self.tagButton setTitle:productDict[kGoodsPropertyTag] forState:UIControlStateNormal];
        [self.tagButton setBackgroundImage:[UIImage imageNamed:@"subTitle_sprice"] forState:UIControlStateNormal];
    }
    else if([productDict[@"tag_color"] isEqualToString:@"orange"])
    {
        self.tagButton.hidden=NO;
        [self.tagButton setTitle:productDict[kGoodsPropertyTag] forState:UIControlStateNormal];
        [self.tagButton setBackgroundImage:[UIImage imageNamed:@"subTitle_recommend"] forState:UIControlStateNormal];
    }
    else if([productDict[@"tag_color"] length]<=0)
    {
        self.tagButton.hidden=YES;
    }
    
    [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:productDict[kGoodsPropertyCover]] placeholderImage:[UIImage imageNamed:PLACE_HOLDER_COOK_IMAGE]];
    self.titleLabel.text=productDict[kGoodsPropertyTitle];
    
    NSString *descStr=productDict[kGoodsPropertyDesc];
    self.backView.frame=CGRectMake(0, 0, ScreenWidth, ScreenWidth/16*9+90+priceBackImage.size.height+[HotSellGoodsCell heightForText:descStr]);
    self.contentImageView.frame=CGRectMake(0, 0, ScreenWidth, ScreenWidth/16*9);
    self.titleLabel.frame=CGRectMake(10,self.contentImageView.frame.origin.y+self.contentImageView.frame.size.height+10, ScreenWidth-80, 30);
    self.specLabel.frame=CGRectMake(ScreenWidth-70, self.titleLabel.frame.origin.y+5, 60, 20);
    self.specLabel.text=productDict[kGoodsPropertySpecDesc];
    self.descLabel.frame=CGRectMake(10, self.titleLabel.frame.origin.y+self.titleLabel.frame.size.height+10,ScreenWidth-20, [HotSellGoodsCell heightForText:descStr]);
    self.priceButton.frame=CGRectMake(0, self.descLabel.frame.origin.y+self.descLabel.frame.size.height+15, priceBackImage.size.width, priceBackImage.size.height);
    self.costPriceLabel.frame=CGRectMake(self.priceButton.frame.size.width-5,self.priceButton.frame.origin.y+15,60,30);
    self.groupNumLabel.frame=CGRectMake(self.priceButton.frame.size.width+self.costPriceLabel.frame.size.width-5, self.priceButton.frame.origin.y+15, ScreenWidth-self.costPriceLabel.frame.size.width-self.priceButton.frame.size.width-10, 30);
    
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:7];//调整行间距
    
    NSMutableAttributedString *descAttrStr=[[NSMutableAttributedString alloc]initWithString:descStr];
    [descAttrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSParagraphStyleAttributeName:paragraphStyle} range:NSMakeRange(0, descStr.length)];
    self.descLabel.attributedText=descAttrStr;
    
    NSString *priceStr=[NSString stringWithFormat:@"¥ %.2f",[productDict[kGoodsPropertyUnitPrice] doubleValue]/100];

    NSRange range=[priceStr rangeOfString:@"."];
    NSMutableAttributedString *priceAttrStr=[[NSMutableAttributedString alloc]initWithString:priceStr];
    [priceAttrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(0, 1)];
    [priceAttrStr addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:22],NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(1, priceStr.length-4)];
    [priceAttrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(range.location, 3)];
    
    [self.priceButton setAttributedTitle:priceAttrStr forState:UIControlStateNormal];
    
    NSString *costPriceStr=[NSString stringWithFormat:@"%.2f",[productDict[kGoodsPropertyMarketPrice] doubleValue]/100];
    NSMutableAttributedString *costAttrStr=[[NSMutableAttributedString alloc]initWithString:costPriceStr];
    [costAttrStr addAttributes:@{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle],NSForegroundColorAttributeName:[UIColor lightGrayColor],NSStrokeColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:16]} range:NSMakeRange(0,costPriceStr.length)];
    self.costPriceLabel.attributedText=costAttrStr;
    
    self.groupNumLabel.text=[NSString stringWithFormat:@"已有%@人参团",productDict[kGoodsPropertyParticipantCount]];
}



@end
