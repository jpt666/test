//
//  SendOutTableViewCell.m
//  CookBook
//
//  Created by 你好 on 16/9/6.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "SendOutTableViewCell.h"

@implementation SendOutTableViewCell

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
    if(self)
    {
        [self configUI];
    }
    return self;
}

-(void)configUI
{
    UIImage *image=[UIImage imageNamed:@"normal_round_icon"];
    self.headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, (100-image.size.height)/2, image.size.width, image.size.height)];
    self.headImageView.image=image;
    [self.contentView addSubview:self.headImageView];
    
    UIImage *editImage=[UIImage imageNamed:@"edit_icon_dark"];
    self.bottomButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.bottomButton.frame=CGRectMake(ScreenWidth-50, 25, 50, 50);
    [self.bottomButton setImage:editImage forState:UIControlStateNormal];
    [self.contentView addSubview:self.bottomButton];
    
    self.nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(30+image.size.width, 0, (ScreenWidth-90-image.size.width)/2, 50)];
    self.nameLabel.text=@"大神";
    self.nameLabel.font=[UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.nameLabel];
    
    self.phoneLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.nameLabel.frame.origin.x+self.nameLabel.frame.size.width+10, self.nameLabel.frame.origin.y, self.nameLabel.frame.size.width, self.nameLabel.frame.size.height)];
    self.phoneLabel.text=@"1235335332";
    self.phoneLabel.font=[UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.phoneLabel];
    
    self.addressLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.nameLabel.frame.origin.x, 42.5, ScreenWidth-80-editImage.size.width, 55)];
    self.addressLabel.font=[UIFont systemFontOfSize:14];
    self.addressLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.5];
    self.addressLabel.numberOfLines=2;
    self.addressLabel.lineBreakMode=NSLineBreakByTruncatingTail;
    [self.contentView addSubview:self.addressLabel];
    
    NSString *descStr=@"海淀区上地7街1号汇众大厦2号楼海淀区上地7街1号汇众大厦2号楼海淀区上地7街1号汇众大厦2号楼2号楼海淀区上地7街1号汇众大厦2号楼";
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];//调整行间距
    paragraphStyle.lineBreakMode = self.addressLabel.lineBreakMode;
    
    NSMutableAttributedString *descAttrStr=[[NSMutableAttributedString alloc]initWithString:descStr];
    [descAttrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSParagraphStyleAttributeName:paragraphStyle} range:NSMakeRange(0, descStr.length)];
    self.addressLabel.attributedText=descAttrStr;

    self.lineView=[[UIView alloc]initWithFrame:CGRectMake(10, 99.5, ScreenWidth-20, 0.5)];
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
    self.nameLabel.text=dict[@"name"];
    self.phoneLabel.text=dict[@"mob"];
    
    NSString *descStr=dict[@"address"];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];//调整行间距
    paragraphStyle.lineBreakMode = self.addressLabel.lineBreakMode;
    
    NSMutableAttributedString *descAttrStr=[[NSMutableAttributedString alloc]initWithString:descStr];
    [descAttrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSParagraphStyleAttributeName:paragraphStyle} range:NSMakeRange(0, descStr.length)];
    
    self.addressLabel.attributedText=descAttrStr;
}


@end
