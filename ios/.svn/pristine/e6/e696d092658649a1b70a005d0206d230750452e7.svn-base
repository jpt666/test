//
//  WCAlertview.m
//  WCAlertView
//
//  Created by huangwenchen on 15/2/17.
//  Copyright (c) 2015年 huangwenchen. All rights reserved.
//

#import "WCAlertview.h"

static const CGFloat alertviewWidth = 270.0;
static const CGFloat titleHeight = 50.0;
static const CGFloat imageviewHeight = 150;
static const CGFloat buttonHeight = 50;
@interface WCAlertview()

@property (strong,nonatomic)UIView * alertview;
@property (strong,nonatomic)UIView * backgroundview;
@property (strong,nonatomic)NSString * title;
@property (strong,nonatomic)NSString * cancelButtonTitle;
@property (strong,nonatomic)NSString * okButtonTitle;
@property (strong,nonatomic)UIImage * image;
@end

@implementation WCAlertview

#pragma mark - Gesture


#pragma mark -  private function
-(UIButton *)createButtonWithFrame:(CGRect)frame Title:(NSString *)title
{
    UIButton * button = [[UIButton alloc] initWithFrame:frame];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor]forState:UIControlStateNormal];
    button.titleLabel.textColor = [UIColor blueColor];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.layer.borderWidth = 0.5;
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [button setShowsTouchWhenHighlighted:YES];
    return button;
}
-(void)clickButton:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(didClickWith:buttonAtIndex:)])
    {
        [self.delegate didClickWith:self buttonAtIndex:button.tag-1];
    }
    [self dismiss];
}
-(void)dismiss{
    [UIView animateWithDuration:0.35 animations:^{
        self.alertview.alpha=0.0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.alertview = nil;
    }];
}
-(void)setUpWith:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)canBtnTitle okButtonTitle:(NSString *)okBtntitle

{
    self.backgroundview = [[UIView alloc] initWithFrame:[[UIApplication sharedApplication] keyWindow].frame];
    self.backgroundview.backgroundColor = [UIColor blackColor];
    self.backgroundview.alpha = 0.4;
    [self addSubview:self.backgroundview];

    UIView * keywindow = [[UIApplication sharedApplication] keyWindow];

    self.alertview = [[UIView alloc] init];
    self.alertview.layer.cornerRadius = 17;
    self.alertview.center=self.backgroundview.center;
    self.alertview.backgroundColor = [UIColor whiteColor];
    self.alertview.clipsToBounds = YES;
    self.alertview.alpha=0.0;
    [self addSubview:self.alertview];
    
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.text = title;
    titleLabel.backgroundColor=RGBACOLOR(176, 116, 67, 1);
    titleLabel.textColor=[UIColor whiteColor];
    [self.alertview addSubview:titleLabel];
    
    CGSize size=CGSizeMake(keywindow.frame.size.width-30, 20000.0f);
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:titleLabel.font, NSFontAttributeName,nil];
    CGSize size1 =[titleLabel.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    titleLabel.frame=CGRectMake(0, 0,  keywindow.frame.size.width-30, size1.height+30);
    titleLabel.textAlignment = NSTextAlignmentCenter;

    UILabel *contentLabel=[[UILabel alloc]init];
    contentLabel.backgroundColor=[UIColor clearColor];
    contentLabel.textColor=[UIColor blackColor];
    contentLabel.text=message;
    [self.alertview addSubview:contentLabel];
    
    NSDictionary * dict= [NSDictionary dictionaryWithObjectsAndKeys:contentLabel.font, NSFontAttributeName,nil];
    CGSize size2 =[contentLabel.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dict context:nil].size;
    contentLabel.frame=CGRectMake(0, titleLabel.frame.origin.y+titleLabel.frame.size.height, keywindow.frame.size.width-30, size2.height+50);
    contentLabel.textAlignment=NSTextAlignmentCenter;

    
    self.alertview.frame=CGRectMake(0, 0, keywindow.frame.size.width-30, contentLabel.frame.origin.y+contentLabel.frame.size.height+50);
    self.alertview.center=self.backgroundview.center;
    
    if (canBtnTitle.length>0)
    {
        UIButton *cancelButton=[self createButtonWithFrame:CGRectMake(0, contentLabel.frame.origin.y+contentLabel.frame.size.height, (keywindow.frame.size.width-30)/2, buttonHeight) Title:canBtnTitle];
        cancelButton.tag=1;
        [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.alertview addSubview:cancelButton];
        
        
        UIButton *okButton=[self createButtonWithFrame:CGRectMake(self.alertview.frame.size.width/2, contentLabel.frame.size.height+contentLabel.frame.origin.y, self.alertview.frame.size.width/2, 50) Title:okBtntitle];
        okButton.tag=2;
        [okButton setTitleColor:RGBACOLOR(73, 142, 46, 0.8) forState:UIControlStateNormal];
        [self.alertview addSubview:okButton];
    }
    else
    {
        UIButton *okButton=[self createButtonWithFrame:CGRectMake(0, contentLabel.frame.size.height+contentLabel.frame.origin.y, self.alertview.frame.size.width, 50) Title:okBtntitle];
        okButton.tag=2;
        [okButton setTitleColor:RGBACOLOR(73, 142, 46, 0.8) forState:UIControlStateNormal];
        [self.alertview addSubview:okButton];
    }
    
}
#pragma mark -  API
- (void)show {
    UIView * keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview:self];
    
    [UIView animateWithDuration:0.35 animations:^{
        self.alertview.alpha=1;
    }];

}

-(instancetype)initWithTitle:(NSString *)title WithMessage:(NSString *)message CancelButton:(NSString *)cancelButtonStr OkButton:(NSString *)okButtonStr
{
    if (self = [super initWithFrame:[[UIApplication sharedApplication] keyWindow].frame]) {
        [self setUpWith:title message:message cancelButtonTitle:cancelButtonStr okButtonTitle:okButtonStr];
    }
    return self;
}
@end
