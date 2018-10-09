//
//  PwdTableViewCell.m
//  Gopeer
//
//  Created by 你好 on 15/10/23.
//  Copyright © 2015年 xyxNav. All rights reserved.
//

#import "PwdTableViewCell.h"

@implementation PwdTableViewCell

- (void)awakeFromNib {
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
        self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, 70, 60)];
        self.titleLabel.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:self.titleLabel];
        
        self.textField=[[UITextField alloc]initWithFrame:CGRectMake(10, 0, ScreenWidth-20, 60)];
        self.textField.autocapitalizationType=UITextAutocapitalizationTypeNone;
        self.textField.autocorrectionType=UITextAutocorrectionTypeNo;
        self.textField.clearButtonMode=UITextFieldViewModeAlways;
        self.textField.tintColor=[UIColor lightGrayColor];
        [self.contentView addSubview:self.textField];
    }
    
    return self;
}

@end
