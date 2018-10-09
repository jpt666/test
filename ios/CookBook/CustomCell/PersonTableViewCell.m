//
//  PersonTableViewCell.m
//  CookBook
//
//  Created by 你好 on 16/5/3.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "PersonTableViewCell.h"

@implementation PersonTableViewCell

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
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 60, 50)];
    self.titleLabel.backgroundColor=[UIColor clearColor];
    [self.contentView addSubview:self.titleLabel];
    
    
    self.textField=[[UITextField alloc]initWithFrame:CGRectMake(90, 0, ScreenWidth-90, 50)];
    self.textField.backgroundColor=[UIColor clearColor];
    self.textField.autocorrectionType=UITextAutocorrectionTypeNo;
    self.textField.autocapitalizationType=UITextAutocapitalizationTypeNone;
    self.textField.tintColor=[UIColor lightGrayColor];
    [self.contentView addSubview:self.textField];
}


@end
