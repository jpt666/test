//
//  UpdateComPointTableCell.m
//  CookBook
//
//  Created by 你好 on 16/9/6.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "UpdateComPointTableCell.h"

@implementation UpdateComPointTableCell

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
    self.textField=[[UITextField alloc]initWithFrame:CGRectMake(10,0 , ScreenWidth-10, 49.5)];
    self.textField.autocorrectionType=UITextAutocorrectionTypeNo;
    self.textField.autocapitalizationType=UITextAutocapitalizationTypeNone;
    self.textField.clearButtonMode=UITextFieldViewModeUnlessEditing;
    [self.contentView addSubview:self.textField];
    
    self.lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 49.5, ScreenWidth, 0.5)];
    self.lineView.backgroundColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.3];
    [self.contentView addSubview:self.lineView];
}


@end
