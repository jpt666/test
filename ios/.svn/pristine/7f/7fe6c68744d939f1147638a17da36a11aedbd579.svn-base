//
//  MaterTableViewCell.m
//  CookBook
//
//  Created by 你好 on 16/4/15.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "MaterTableViewCell.h"

@implementation MaterTableViewCell

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
    [[UITextField appearance] setTintColor:[UIColor lightGrayColor]];
    
    self.leftBackView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/2-0.25, 43)];
    self.leftBackView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:self.leftBackView];
    
    UIView *leftLineView=[[UIView alloc]initWithFrame:CGRectMake(0, 43.5, ScreenWidth/2, 0.5)];
    leftLineView.backgroundColor=[UIColor lightGrayColor];
    [self.contentView addSubview:leftLineView];
    
    self.leftTextField=[[UITextField alloc]initWithFrame:CGRectMake(15, 0, ScreenWidth/2-15, 44)];
    self.leftTextField.autocapitalizationType=UITextAutocapitalizationTypeNone;
    self.leftTextField.autocorrectionType=UITextAutocorrectionTypeNo;
    [self.leftBackView addSubview:self.leftTextField];
    
    self.rightBackView=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/2+0.25, 0, ScreenWidth/2-0.25, 43)];
    self.rightBackView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:self.rightBackView];
    
    UIView *rightLineView=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/2, 43.5, ScreenWidth/2, 0.5)];
    rightLineView.backgroundColor=[UIColor lightGrayColor];
    [self.contentView addSubview:rightLineView];
    
    self.rightTextField=[[UITextField alloc]initWithFrame:CGRectMake(15, 0, ScreenWidth/2-15, 44)];
    self.rightTextField.autocorrectionType=UITextAutocorrectionTypeNo;
    self.rightTextField.autocapitalizationType=UITextAutocapitalizationTypeNone;
    [self.rightBackView addSubview:self.rightTextField];
    
    UIView *centerLineView=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/2-0.25, 0, 0.5, 44)];
    centerLineView.backgroundColor=[UIColor lightGrayColor];
    [self.contentView addSubview:centerLineView];
}


@end
