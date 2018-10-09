
//
//  CommentPointView.m
//  CookBook
//
//  Created by 你好 on 16/9/6.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "CommentPointView.h"
@interface CommentPointView()

@property (nonatomic,retain)UILabel *nameLabel;
@property (nonatomic,retain)UILabel *telLabel;

@end


@implementation CommentPointView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        [self configUI];
        self.userInteractionEnabled=YES;
    }
    return self;
}

-(void)configUI
{
    UIImage *editImage=[UIImage imageNamed:@"enter_arrow"];

    self.nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 50, self.bounds.size.height)];
    self.nameLabel.text=@"收货人:";
    self.nameLabel.font=[UIFont systemFontOfSize:14];
    [self addSubview:self.nameLabel];
    
    self.consigneeLabel=[[UILabel alloc]initWithFrame:CGRectMake(60, 0, self.bounds.size.width/2-80, self.bounds.size.height)];
    self.consigneeLabel.text=@"王涛";
    self.consigneeLabel.font=[UIFont systemFontOfSize:14];
    [self addSubview:self.consigneeLabel];
    
    self.telLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width/2-20, 0, 40, self.bounds.size.height)];
    self.telLabel.text=@"电 话:";
    self.telLabel.font=[UIFont systemFontOfSize:14];
    [self addSubview:self.telLabel];
    
    self.phoneLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width/2+20, 0, self.bounds.size.width/2-editImage.size.width-10-20, self.bounds.size.height)];
    self.phoneLabel.text=@"15684574562";
    self.phoneLabel.font=[UIFont systemFontOfSize:14];
    [self addSubview:self.phoneLabel];
    
    self.bottomImageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width-10-editImage.size.width, (self.bounds.size.height-editImage.size.height)/2, editImage.size.width, editImage.size.height)];
    self.bottomImageView.image=editImage;
    [self addSubview:self.bottomImageView];
    
}


@end
