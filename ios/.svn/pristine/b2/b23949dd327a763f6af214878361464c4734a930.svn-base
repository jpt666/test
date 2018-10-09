//
//  GroupPurDetailCell.m
//  CookBook
//
//  Created by 你好 on 16/6/3.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "GroupPurDetailCell.h"
#import "UIButton+Animation.h"
#import "GoodsPropertyKeys.h"
#import "ShoppingGoods.h"
#import <UIImageView+WebCache.h>
@implementation GroupPurDetailCell
{
    UIButton * _eventbtn;
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
    
    UIImage *priceBackImage=[UIImage imageNamed:@"price_back_icon"];

    self.backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth/16*9+186+84+priceBackImage.size.height)];
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
//    [self.tagButton setTitle:@"新品" forState:UIControlStateNormal];
    [self.tagButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 5, 0)];
//    [self.tagButton setBackgroundImage:image forState:UIControlStateNormal];
    self.tagButton.titleLabel.font=[UIFont systemFontOfSize:12];
    [self.tagButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.tagButton setAdjustsImageWhenHighlighted:NO];
    [self.backView addSubview:self.tagButton];
    
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10,self.contentImageView.frame.origin.y+self.contentImageView.frame.size.height+10, ScreenWidth-100, 30)];
    self.titleLabel.text=@"智利车厘子";
    self.titleLabel.font=[UIFont systemFontOfSize:17];
    [self.backView addSubview:self.titleLabel];
    
    self.specButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.specButton.frame=CGRectMake(ScreenWidth-70, self.contentImageView.frame.origin.y+self.contentImageView.frame.size.height+13, 60, 20);
    self.specButton.titleLabel.font=[UIFont systemFontOfSize:12];
    self.specButton.backgroundColor=RGBACOLOR(176, 116, 67, 1);
    self.specButton.layer.cornerRadius=3;
    self.specButton.clipsToBounds=YES;
    [self.specButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.backView addSubview:self.specButton];
//    NSString *descStr=[NSString stringWithFormat:@""];
//    
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    [paragraphStyle setLineSpacing:7];//调整行间距
    
//    NSMutableAttributedString *descAttrStr=[[NSMutableAttributedString alloc]initWithString:descStr];
//    [descAttrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSParagraphStyleAttributeName:paragraphStyle} range:NSMakeRange(0, descStr.length)];
    
    self.descLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, self.titleLabel.frame.origin.y+self.titleLabel.frame.size.height+10,ScreenWidth-20, 70)];
    self.descLabel.numberOfLines=3;
    self.descLabel.lineBreakMode=NSLineBreakByWordWrapping;
    self.descLabel.textColor=[UIColor colorWithHexString:@"4e4e4e" alpha:0.8];
    self.descLabel.font=[UIFont systemFontOfSize:14];
//    self.descLabel.attributedText=descAttrStr;
    [self.backView addSubview:self.descLabel];
    
    
    self.limitLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, self.descLabel.frame.origin.y+self.descLabel.frame.size.height+7.5, self.backView.bounds.size.width-20, 30)];
    self.limitLabel.font=[UIFont systemFontOfSize:14];
    self.limitLabel.textColor=RGBACOLOR(73, 142, 46, 0.8);
    self.limitLabel.textAlignment=NSTextAlignmentRight;
//    self.limitLabel.text=@"每个ID限购5份";
    [self.backView addSubview:self.limitLabel];
    

    NSString *priceStr=[NSString stringWithFormat:@"¥ 155.00"];
    NSRange range=[priceStr rangeOfString:@"."];
    NSMutableAttributedString *priceAttrStr=[[NSMutableAttributedString alloc]initWithString:priceStr];
    [priceAttrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(0, 1)];
    [priceAttrStr addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(1, priceStr.length-4)];
    [priceAttrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(range.location, 3)];
    
    self.priceButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.priceButton.frame=CGRectMake(0, self.limitLabel.frame.origin.y+self.limitLabel.frame.size.height+7.5, priceBackImage.size.width,priceBackImage.size.height);
    [self.priceButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [self.priceButton setBackgroundImage:priceBackImage forState:UIControlStateNormal];
    self.priceButton.layer.cornerRadius=10;
    [self.priceButton setAdjustsImageWhenHighlighted:NO];
    [self.priceButton setAttributedTitle:priceAttrStr forState:UIControlStateNormal];
    [self.backView addSubview:self.priceButton];
    
    self.topLineView=[[UIView alloc]initWithFrame:CGRectMake(10, self.priceButton.frame.origin.y+self.priceButton.frame.size.height+15, ScreenWidth-20, 0.5)];
    self.topLineView.backgroundColor=[UIColor colorWithHexString:@"4e4e4e" alpha:0.3];
    [self.backView addSubview:self.topLineView];
    
    self.userListView=[[UserListView alloc]initWithFrame:CGRectMake(10, self.topLineView.frame.origin.y+self.topLineView.frame.size.height+5, ScreenWidth-20, 50)];
    [self.backView addSubview:self.userListView];
    
    self.bottomLineView=[[UIView alloc]initWithFrame:CGRectMake(10, self.userListView.frame.origin.y+self.userListView.frame.size.height+5, ScreenWidth-20, 0.7)];
    self.bottomLineView.backgroundColor=[UIColor colorWithHexString:@"4e4e4e" alpha:0.3];
    [self.backView addSubview:self.bottomLineView];
    
    UIImage *addImage=[UIImage imageNamed:@"add_icon"];
    UIImage *reduceImage=[UIImage imageNamed:@"reduce_icon"];
    
    NSString *costPriceStr=@"89.00";
    NSMutableAttributedString *costAttrStr=[[NSMutableAttributedString alloc]initWithString:costPriceStr];
    [costAttrStr addAttributes:@{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle],NSForegroundColorAttributeName:[UIColor lightGrayColor],NSStrokeColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:14]} range:NSMakeRange(0,costPriceStr.length)];
    
    self.costPriceLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.priceButton.frame.size.width+10,self.priceButton.frame.origin.y, ScreenWidth-self.priceButton.frame.size.width-10-addImage.size.width*2-40, self.priceButton.frame.size.height/2)];
    self.costPriceLabel.backgroundColor=[UIColor clearColor];
    self.costPriceLabel.attributedText=costAttrStr;
    [self.backView addSubview:self.costPriceLabel];
    
    self.remainLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.costPriceLabel.frame.origin.x, self.costPriceLabel.frame.origin.y+self.costPriceLabel.frame.size.height, self.costPriceLabel.frame.size.width, self.costPriceLabel.frame.size.height)];
    self.remainLabel.backgroundColor=[UIColor clearColor];
    self.remainLabel.font=[UIFont systemFontOfSize:14];
//    self.remainLabel.text=@"剩余20份";
    [self.backView addSubview:self.remainLabel];
    
    _eventbtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth-addImage.size.width*2-40-10, self.addButton.frame.origin.y-10, addImage.size.width*2+30+20, addImage.size.height+20)];
    _eventbtn.backgroundColor = [UIColor clearColor];
    _eventbtn.userInteractionEnabled = YES;
    [self.backView addSubview:_eventbtn];
    
    self.addButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.addButton.frame=CGRectMake(ScreenWidth-addImage.size.width-10, self.limitLabel.frame.origin.y+self.limitLabel.frame.size.height+(self.priceButton.bounds.size.height-addImage.size.height)/2+7.5, addImage.size.width, addImage.size.height);
    [self.addButton setImage:addImage forState:UIControlStateNormal];
    [self.addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.addButton];
    
    self.reduceButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.reduceButton.frame=CGRectMake(ScreenWidth-addImage.size.width*2-40, self.addButton.frame.origin.y, reduceImage.size.width, reduceImage.size.height);
    [self.reduceButton setImage:reduceImage forState:UIControlStateNormal];
    [self.reduceButton addTarget:self action:@selector(reduceButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.reduceButton.alpha = 0.0;
    [self.backView addSubview:self.reduceButton];
    
    self.numLabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-40-addImage.size.width, self.addButton.frame.origin.y, 30, addImage.size.height)];
    self.numLabel.text=@"0";
    self.numLabel.textAlignment=NSTextAlignmentCenter;
    self.numLabel.font=[UIFont systemFontOfSize:14];
    self.numLabel.alpha = 0.0;
    [self.backView addSubview:self.numLabel];
}


-(double)heightForText:(NSString *)str
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



- (void)setupWithDictGoods:(NSDictionary *)dictGoods withNum:(NSUInteger)num
{
    self.dictGoods = dictGoods;
    
    UIImage *priceBackImage=[UIImage imageNamed:@"price_back_icon"];
    UIImage *addImage=[UIImage imageNamed:@"add_icon"];
    UIImage *reduceImage=[UIImage imageNamed:@"reduce_icon"];
    
    if ([dictGoods[@"tag_color"]length]>0)
    {
        self.tagButton.hidden=NO;
        if ([dictGoods[@"tag_color"] isEqualToString:@"red"])
        {
            [self.tagButton setTitle:dictGoods[kGoodsPropertyTag] forState:UIControlStateNormal];
            [self.tagButton setBackgroundImage:[UIImage imageNamed:@"subTitle_hotSell"] forState:UIControlStateNormal];
        }
        else if ([dictGoods[@"tag_color"] isEqualToString:@"green"])
        {
            [self.tagButton setTitle:dictGoods[kGoodsPropertyTag] forState:UIControlStateNormal];
            self.tagButton.hidden=NO;
            [self.tagButton setBackgroundImage:[UIImage imageNamed:@"subTitle_newGoods"] forState:UIControlStateNormal];
        }
        else if([dictGoods[@"tag_color"] isEqualToString:@"yellow"])
        {
            [self.tagButton setTitle:dictGoods[kGoodsPropertyTag] forState:UIControlStateNormal];
            self.tagButton.hidden=NO;
            [self.tagButton setBackgroundImage:[UIImage imageNamed:@"subTitle_sprice"] forState:UIControlStateNormal];
        }
        else if([dictGoods[@"tag_color"] isEqualToString:@"orange"])
        {
            [self.tagButton setTitle:dictGoods[kGoodsPropertyTag] forState:UIControlStateNormal];
            self.tagButton.hidden=NO;
            [self.tagButton setBackgroundImage:[UIImage imageNamed:@"subTitle_recommend"] forState:UIControlStateNormal];
        }
    }
    else
    {
        self.tagButton.hidden=YES;
    }
    
    [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:dictGoods[kGoodsPropertyCover]] placeholderImage:[UIImage imageNamed:PLACE_HOLDER_COOK_IMAGE]];
    self.titleLabel.text=dictGoods[kGoodsPropertyTitle];
    
    [self.specButton setTitle:dictGoods[kGoodsPropertySpecDesc] forState:UIControlStateNormal];
    
    NSString *descStr=dictGoods[kGoodsPropertyDesc];
    
    self.backView.frame=CGRectMake(0, 0, ScreenWidth, ScreenWidth/16*9+191+priceBackImage.size.height+[self heightForText:descStr]);
    self.descLabel.frame=CGRectMake(10, self.titleLabel.frame.origin.y+self.titleLabel.frame.size.height+10,ScreenWidth-20, [self heightForText:descStr]);
    self.limitLabel.frame=CGRectMake(10, self.descLabel.frame.origin.y+self.descLabel.frame.size.height+7.5, self.backView.bounds.size.width-20, 30);
    self.priceButton.frame=CGRectMake(0, self.limitLabel.frame.origin.y+self.limitLabel.frame.size.height+7.5, priceBackImage.size.width,priceBackImage.size.height);
    self.costPriceLabel.frame=CGRectMake(self.priceButton.frame.size.width+10, self.priceButton.frame.origin.y, ScreenWidth-self.priceButton.frame.size.width-10-addImage.size.width*2-40, self.priceButton.frame.size.height/2);
    self.remainLabel.frame=CGRectMake(self.costPriceLabel.frame.origin.x, self.costPriceLabel.frame.origin.y+self.costPriceLabel.frame.size.height, self.costPriceLabel.frame.size.width, self.costPriceLabel.frame.size.height);
    self.addButton.frame=CGRectMake(ScreenWidth-addImage.size.width-10, self.limitLabel.frame.origin.y+self.limitLabel.frame.size.height+(self.priceButton.frame.size.height-addImage.size.height)/2+7.5, addImage.size.width, addImage.size.height);
    self.reduceButton.frame=CGRectMake(ScreenWidth-addImage.size.width*2-40, self.addButton.frame.origin.y, reduceImage.size.width, reduceImage.size.height);
    self.numLabel.frame=CGRectMake(ScreenWidth-40-addImage.size.width, self.addButton.frame.origin.y, 30, addImage.size.height);
    
    _eventbtn.frame = CGRectMake(ScreenWidth-addImage.size.width*2-40-10, self.addButton.frame.origin.y-10, addImage.size.width*2+30+20, addImage.size.height+20);
    
    self.topLineView.frame=CGRectMake(10, self.priceButton.frame.origin.y+self.priceButton.frame.size.height+15, ScreenWidth-20, 0.5);
    self.userListView.frame=CGRectMake(10, self.topLineView.frame.origin.y+self.topLineView.frame.size.height+5, ScreenWidth-20, 50);
    self.bottomLineView.frame=CGRectMake(10, self.userListView.frame.origin.y+self.userListView.frame.size.height+5, ScreenWidth-20, 0.7);

    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:7];//调整行间距
    
    NSMutableAttributedString *descAttrStr=[[NSMutableAttributedString alloc]initWithString:descStr];
    [descAttrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSParagraphStyleAttributeName:paragraphStyle} range:NSMakeRange(0, descStr.length)];
    self.descLabel.attributedText=descAttrStr;
    [self.userListView configData:dictGoods[kGoodsPropertyParticipantAvatars] andAllCount:[dictGoods[kGoodsPropertyParticipantCount] integerValue]];
    
    NSString *priceStr=[NSString stringWithFormat:@"¥ %.2f",[dictGoods[kGoodsPropertyUnitPrice] doubleValue]/100];
    NSRange range=[priceStr rangeOfString:@"."];
    NSMutableAttributedString *priceAttrStr=[[NSMutableAttributedString alloc]initWithString:priceStr];
    [priceAttrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(0, 1)];
    [priceAttrStr addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:22],NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(1, priceStr.length-4)];
    [priceAttrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(range.location, 3)];
    
    [self.priceButton setAttributedTitle:priceAttrStr forState:UIControlStateNormal];

    
    NSString *costPriceStr=[NSString stringWithFormat:@"%.2f",[dictGoods[kGoodsPropertyMarketPrice] doubleValue]/100];
    NSMutableAttributedString *costAttrStr=[[NSMutableAttributedString alloc]initWithString:costPriceStr];
    [costAttrStr addAttributes:@{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle],NSForegroundColorAttributeName:[UIColor lightGrayColor],NSStrokeColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:16]} range:NSMakeRange(0,costPriceStr.length)];
    self.costPriceLabel.attributedText=costAttrStr;
    
    self.purchaseNum = num;
    self.numLabel.text=[NSString stringWithFormat:@"%ld",num];
    
    if (dictGoods[kGoodsPropertyPurchaseLimit] &&
        [dictGoods[kGoodsPropertyPurchaseLimit] integerValue] > 0) {
        self.limitLabel.hidden = NO;
        self.limitLabel.text = [NSString stringWithFormat:@"每个ID限购%@份", dictGoods[kGoodsPropertyPurchaseLimit]];
    } else {
        self.limitLabel.hidden = YES;
    }
    
    if (dictGoods[kGoodsPropertyStock]) {
//        self.remainLabel.hidden = NO;
        self.remainLabel.hidden = self.limitLabel.hidden;
        NSInteger remainCount = [dictGoods[kGoodsPropertyStock] integerValue]-[dictGoods[kGoodsPropertyPurchasedCount] integerValue];
        if (remainCount < 0) {
            remainCount = 0;
        }
        self.remainLabel.text = [NSString stringWithFormat:@"剩余%ld份", remainCount];
    } else {
        self.remainLabel.hidden = YES;
    }
    
    if (self.remainLabel.isHidden) {
        CGRect frame = self.costPriceLabel.frame;
        frame.origin.y += 9;
        self.costPriceLabel.frame = frame;
//        self.costPriceLabel.backgroundColor = [UIColor redColor];
    }
    
    if (num > 0) {
        self.numLabel.alpha = 1.0;
        self.reduceButton.alpha = 1.0;
    } else {
        self.numLabel.alpha = 0.0;
        self.reduceButton.alpha = 0.0;
    }
}



-(void)increaseGoodsToNum:(NSUInteger)num
{
    self.purchaseNum = num;
    self.numLabel.text=[NSString stringWithFormat:@"%ld",num];
    if (self.purchaseNum == 1) {
        [self.reduceButton animationDuration:0.3 startFrame:self.addButton.frame destFrame:self.reduceButton.frame startAlpha:0.6 endAlpha:1.0 rotation:M_PI completion:^(BOOL finished) {
            self.numLabel.alpha = 1.0;
        }];
    } else {
        if (num > 0) {
            self.numLabel.alpha = 1.0;
            self.reduceButton.alpha = 1.0;
        } else {
            self.numLabel.alpha = 0.0;
            self.reduceButton.alpha = 0.0;
        }
    }
}

-(void)decreseGoodsToNum:(NSUInteger)num
{
    self.purchaseNum = num;
    self.numLabel.text=[NSString stringWithFormat:@"%ld",num];
    if (self.purchaseNum == 0) {
        self.numLabel.alpha = 0.0;
        CGRect orgRect = self.reduceButton.frame;
        [self.reduceButton animationDuration:0.3 startFrame:self.reduceButton.frame destFrame:self.addButton.frame startAlpha:1.0 endAlpha:0.6 rotation:M_PI completion:^(BOOL finished) {
            self.reduceButton.frame = orgRect;
            self.reduceButton.alpha = 0.0;
        }];
    }
//    } else {
//        if (num > 0) {
//            self.numLabel.alpha = 1.0;
//            self.reduceButton.alpha = 1.0;
//        } else {
//            self.numLabel.alpha = 0.0;
//            self.reduceButton.alpha = 0.0;
//        }
//    }
}


-(void)addButtonClick:(UIButton *)button
{
//    if (self.purchaseNum == 0) {
//        
//        [self.reduceButton animationDuration:0.3 startFrame:self.addButton.frame destFrame:self.reduceButton.frame startAlpha:0.4 endAlpha:1.0 rotation:M_PI completion:^(BOOL finished) {
//            self.numLabel.alpha = 1.0;
//            
//            if (_delegate && [_delegate respondsToSelector:@selector(didNeedIncreaseGoods:)]) {
//                [_delegate didNeedIncreaseGoods:self];
//            }
//            
//        }];
//    } else {
        if (_delegate && [_delegate respondsToSelector:@selector(didNeedIncreaseGoods:)]) {
            [_delegate didNeedIncreaseGoods:self];
        }
//    }
}


-(void)reduceButtonClick:(UIButton *)button
{
//    if (self.purchaseNum>0)
//    { 
//        if (self.purchaseNum == 1) {
//            self.numLabel.alpha = 0.0;
//            CGRect orgRect = self.reduceButton.frame;
//            [self.reduceButton animationDuration:0.3 startFrame:self.reduceButton.frame destFrame:self.addButton.frame startAlpha:1.0 endAlpha:0.4 rotation:M_PI completion:^(BOOL finished) {
//                self.reduceButton.frame = orgRect;
//                self.reduceButton.alpha = 0.0;
//                
//                if (_delegate && [_delegate respondsToSelector:@selector(didNeedDecreaseGoods:)]) {
//                    [_delegate didNeedDecreaseGoods:self];
//                }
//            }];
//        } else {
    
            if (_delegate && [_delegate respondsToSelector:@selector(didNeedDecreaseGoods:)]) {
                [_delegate didNeedDecreaseGoods:self];
            }
//        }
//    }
}






@end
