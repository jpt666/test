//
//  EditAddressTableCell.m
//  CookBook
//
//  Created by 你好 on 16/6/12.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "EditAddressTableCell.h"

@implementation EditAddressTableCell

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
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10,0, 80, 50)];
    self.titleLabel.font=[UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.titleLabel];
    
    self.textField=[[UITextField alloc]initWithFrame:CGRectMake(90, 0, ScreenWidth-100,50)];
    self.textField.autocorrectionType=UITextAutocorrectionTypeNo;
    self.textField.autocapitalizationType=UITextAutocapitalizationTypeNone;
    self.textField.textColor=[UIColor colorWithHexString:@"#4e4e4e"];
    self.textField.placeholder=@"请输入";
    self.textField.font=[UIFont systemFontOfSize:16];
    self.textField.tintColor=[UIColor lightGrayColor];
    [self.contentView addSubview:self.textField];
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(10, 49.5, ScreenWidth-20, 0.5)];
    lineView.backgroundColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.3];
    [self.contentView addSubview:lineView];
}


@end
