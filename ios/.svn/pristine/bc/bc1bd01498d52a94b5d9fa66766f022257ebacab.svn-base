//
//  ConfirmOrderTopView.m
//  CookBook
//
//  Created by 你好 on 16/6/6.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "ConfirmOrderTopView.h"

@implementation ConfirmOrderTopView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self configUI];
    }
    return self;
}



-(void)configUI
{
    self.backgroundColor=RGBACOLOR(207, 207, 207, 0.5);
    
    UIImage *editImage=[UIImage imageNamed:@"enter_arrow"];
    
    UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-10)];
    backView.backgroundColor=[UIColor whiteColor];
    [self addSubview:backView];
    
    self.nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 50, 30)];
    self.nameLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e"];
    self.nameLabel.font=[UIFont systemFontOfSize:14];
    self.nameLabel.text=@"收货人:";
    [backView addSubview:self.nameLabel];
    
    self.nameTextField=[[UITextField alloc]initWithFrame:CGRectMake(60, 10, (self.bounds.size.width-20)/2-60, 30)];
    self.nameTextField.autocorrectionType=UITextAutocorrectionTypeNo;
    self.nameTextField.autocapitalizationType=UITextAutocapitalizationTypeNone;
    self.nameTextField.returnKeyType=UIReturnKeyDone;
    self.nameTextField.enabled=NO;
    self.nameTextField.tintColor=[UIColor lightGrayColor];
    self.nameTextField.textColor=[UIColor colorWithHexString:@"#4e4e4e"];
    self.nameTextField.font=[UIFont systemFontOfSize:14];
    [backView addSubview:self.nameTextField];
    
    self.phoneTextField=[[UITextField alloc]initWithFrame:CGRectMake((self.bounds.size.width-20)/2, 10,(self.bounds.size.width-20)/2, 30)];
    self.phoneTextField.autocorrectionType=UITextAutocorrectionTypeNo;
    self.phoneTextField.autocapitalizationType=UITextAutocapitalizationTypeNone;
    self.phoneTextField.returnKeyType=UIReturnKeyDone;
    self.phoneTextField.enabled=NO;
    self.phoneTextField.keyboardType=UIKeyboardTypeNumberPad;
    self.phoneTextField.tintColor=[UIColor lightGrayColor];
    self.phoneTextField.textColor=[UIColor colorWithHexString:@"#4e4e4e"];
    self.phoneTextField.font=[UIFont systemFontOfSize:14];
    [backView addSubview:self.phoneTextField];
    
    self.addressLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, self.nameTextField.frame.origin.y+self.nameTextField.frame.size.height, self.bounds.size.width-60, 40)];
    self.addressLabel.numberOfLines=2;
    self.addressLabel.lineBreakMode=NSLineBreakByTruncatingTail;
    self.addressLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e"];
    self.addressLabel.font=[UIFont systemFontOfSize:14];
    [backView addSubview:self.addressLabel];
//    self.addressLabel.text=@"收货地址:提点自提提点自提提点自提提点自提提点自提提点自提提点自提提点自提提点自提提点自提提点自提提点自提提点自提提点自提提点自提提点自提提点自提提点自提提点自提提点自提";

    self.deliverLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, self.addressLabel.frame.origin.y+self.addressLabel.frame.size.height, self.bounds.size.width-20, 30)];
    self.deliverLabel.text=@"配送方式:自提点自提";
    self.deliverLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.8];
    self.deliverLabel.font=[UIFont systemFontOfSize:14];
    [backView addSubview:self.deliverLabel];
    
    self.editButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.editButton.frame=CGRectMake(self.bounds.size.width-50,(self.bounds.size.height-50)/2, 50, 50);
    [self.editButton setImage:editImage forState:UIControlStateNormal];
    [backView addSubview:self.editButton];
    
    UIImage *bottomImage=[UIImage imageNamed:@"colorful_line"];
    UIImageView *bottomImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-bottomImage.size.height-10, ScreenWidth, bottomImage.size.height)];
    bottomImageView.image=bottomImage;
    [backView addSubview:bottomImageView];
    
}



@end
