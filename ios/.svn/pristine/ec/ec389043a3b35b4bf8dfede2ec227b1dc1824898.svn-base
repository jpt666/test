//
//  GroupTapView.m
//  CookBook
//
//  Created by 你好 on 16/8/10.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "GroupTapView.h"

@implementation GroupTapView

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
        self.leftLabel=[[UILabel alloc]initWithFrame:CGRectMake(3, 0, self.bounds.size.width/3*2, self.bounds.size.height)];
        self.leftLabel.font=[UIFont systemFontOfSize:14];
        self.leftLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.8];
        self.leftLabel.userInteractionEnabled=YES;
        [self addSubview:self.leftLabel];
        
        
        self.rightLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width/3*2+3, 0, self.bounds.size.width/3-10, self.bounds.size.height)];
        self.rightLabel.textAlignment=NSTextAlignmentRight;
        self.rightLabel.font=[UIFont systemFontOfSize:14];
        self.rightLabel.userInteractionEnabled=YES;
        [self addSubview:self.rightLabel];
        
        
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
        tapGesture.numberOfTapsRequired=1;
        tapGesture.numberOfTouchesRequired=1;
        [self addGestureRecognizer:tapGesture];
        
        
    }
    return self;
}


-(void)tapGesture:(UITapGestureRecognizer *)tapGesture
{
    if (_delegate && [_delegate respondsToSelector:@selector(groupTapViewClick:)])
    {
        [_delegate groupTapViewClick:self];
    }
}


@end
