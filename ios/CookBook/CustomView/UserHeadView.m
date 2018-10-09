//
//  UserHeadView.m
//  CookBook
//
//  Created by zhangxi on 16/4/18.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "UserHeadView.h"
#import "GPUImage.h"
#import <UIImageView+WebCache.h>
#import "GlobalVar.h"

@implementation UserHeadView
{
    GPUImageView * _backGPUImageView;
    UIImageView * _backgroundView;
    GPUImageiOSBlurFilter *_blurFilter;
    UILabel * _cookerName;
    UILabel *_leftBalanceLabel;
    UILabel *_rightCouponsLabel;
    UIView  *_lineView;
    
//    UILabel * _favorNum;
//    UILabel * _fansNum;
//    UILabel * _followNum;
    
//    UILabel * _favorText;
//    UILabel * _fansText;
//    UILabel * _followText;

    NSMutableArray * _arrStaticView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}


- (void)configUI
{
//    self.backgroundColor = [UIColor greenColor];
    _arrStaticView = [NSMutableArray array];
    
    _backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
    _backgroundView.image = [UIImage imageNamed:@""];
    [self addSubview:_backgroundView];
    
    _backGPUImageView = [[GPUImageView alloc] initWithFrame:self.bounds];
    _backGPUImageView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill;
    [self addSubview:_backGPUImageView];
    
    _blurFilter = [[GPUImageiOSBlurFilter alloc] init];
    _blurFilter.blurRadiusInPixels = 10.0f;
    
    UIImage *image=[UIImage imageNamed:@"my_unLogin_back_icon"];
    GPUImagePicture *picture = [[GPUImagePicture alloc] initWithImage:image];
    if (_blurFilter) {
        [_blurFilter removeAllTargets];
    }
    [picture addTarget:_blurFilter];
    [_blurFilter addTarget:_backGPUImageView];
    [picture processImageWithCompletionHandler:^{
        [_blurFilter removeAllTargets];
    }];
    
    _headView = [[UIImageView alloc] initWithFrame:CGRectMake((self.bounds.size.width-70)/2, (self.bounds.size.height-70)/2-20, 70, 70)];
    _headView.contentMode = UIViewContentModeScaleAspectFill;
    _headView.layer.cornerRadius=35;
    _headView.clipsToBounds=YES;
    _headView.layer.borderWidth=1.0f;
    _headView.layer.borderColor=[UIColor whiteColor].CGColor;
    _headView.userInteractionEnabled=YES;
    [self addSubview:_headView];
    
    _cookerName = [[UILabel alloc] initWithFrame:CGRectMake((self.bounds.size.width-200)/2,_headView.frame.origin.y+_headView.frame.size.height+10, 200, 30)];
    _cookerName.textAlignment = NSTextAlignmentCenter;
    _cookerName.textColor = [UIColor whiteColor];
    _cookerName.font = [UIFont boldSystemFontOfSize:18];
    [self addSubview:_cookerName];
    
    _leftBalanceLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-35, ScreenWidth/2, 35)];
    _leftBalanceLabel.backgroundColor=RGBACOLOR(1, 1, 1, 0.5);
    _leftBalanceLabel.text=@"余额     0.00";
    _leftBalanceLabel.textColor=[UIColor whiteColor];
    _leftBalanceLabel.textAlignment=NSTextAlignmentCenter;
    _leftBalanceLabel.font=[UIFont systemFontOfSize:13];
    [self addSubview:_leftBalanceLabel];
    
    _rightCouponsLabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2, self.bounds.size.height-35, ScreenWidth/2, 35)];
    _rightCouponsLabel.backgroundColor=RGBACOLOR(1, 1, 1, 0.5);
    _rightCouponsLabel.text=@"优惠券   0";
    _rightCouponsLabel.textColor=[UIColor whiteColor];
    _rightCouponsLabel.textAlignment=NSTextAlignmentCenter;
    _rightCouponsLabel.font=[UIFont systemFontOfSize:13];
    [self addSubview:_rightCouponsLabel];
    
    _lineView=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/2-0.25, _leftBalanceLabel.frame.origin.y+5, 0.5, _leftBalanceLabel.bounds.size.height-10)];
    _lineView.backgroundColor=[UIColor whiteColor];
    [self addSubview:_lineView];
    
    
//    NSArray *arrText = @[@"收藏", @"粉丝", @"关注"];
//    for (int i=0; i<3; i++) {
//        
//        UILabel * labelNum = [[UILabel alloc] initWithFrame:CGRectMake((self.bounds.size.width-240)/2+i*80, (self.bounds.size.height-50)/2+75, 80, 20)];
////        labelNum.backgroundColor = [UIColor redColor];
//        labelNum.textAlignment = NSTextAlignmentCenter;
//        labelNum.textColor = [UIColor whiteColor];
//        labelNum.font = [UIFont systemFontOfSize:14];
//        labelNum.text = @"0";
//        
//        UIImageView * imageView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navigationbar_background"]];
//        CGPoint center = labelNum.frame.origin;
//        center.y += labelNum.bounds.size.height;
//        imageView.center = center;
//        
//        if (0 == i) {
//            _favorNum = labelNum;
//        } else if (1 == i) {
//            _fansNum = labelNum;
//            [self addSubview:imageView];
//            [_arrStaticView addObject:imageView];
//        } else if (2 == i) {
//            _followNum = labelNum;
//            [self addSubview:imageView];
//            [_arrStaticView addObject:imageView];
//        }
//        [self addSubview:labelNum];
//        [_arrStaticView addObject:labelNum];
//    
//        
//        UILabel * labelText = [[UILabel alloc] initWithFrame:CGRectMake((self.bounds.size.width-240)/2+i*80, (self.bounds.size.height-50)/2+95, 80, 20)];
//        labelText.textAlignment = NSTextAlignmentCenter;
//        labelText.textColor = [UIColor whiteColor];
//        labelText.font = [UIFont systemFontOfSize:14];;
//        labelText.text = arrText[i];
////        labelText.backgroundColor = [UIColor redColor];
//        [self addSubview:labelText];
//        [_arrStaticView addObject:labelText];
//    }
}

-(void)hideUserInfo:(BOOL)hide
{
    _leftBalanceLabel.hidden=hide;
    _rightCouponsLabel.hidden=hide;
    _lineView.hidden=hide;
    
   
    
    if (hide)
    {
        _headView.image=[UIImage imageNamed:@"my_unLogin_icon"];
        _cookerName.text=@"请点击登录";
        UIImage *image=[UIImage imageNamed:@"my_unLogin_back_icon"];
        
        GPUImagePicture *picture = [[GPUImagePicture alloc] initWithImage:image];
//        if (_blurFilter) {
//            [_blurFilter removeAllTargets];
//        }
        [picture addTarget:_backGPUImageView];
//        [_blurFilter addTarget:_backGPUImageView];
        [picture processImageWithCompletionHandler:^{
//            [_blurFilter removeAllTargets];
        }];
    }

//    _favorNum.hidden = hide;
//    _fansNum.hidden = hide;
//    _followNum.hidden = hide;
//    
//    for (UIView *v in _arrStaticView) {
//        v.hidden = hide;
//    }
}

-(void)setupWithUserInfo:(UserInfo *)userInfo
{
    _cookerName.text = [userInfo getNickName];
    _leftBalanceLabel.text=[NSString stringWithFormat:@"余额     %.2f",userInfo.balanceMoney/100.0f];
    _rightCouponsLabel.text=[NSString stringWithFormat:@"优惠券   %ld",userInfo.couponNum];
    
//    _fansNum.text = [NSString stringWithFormat:@"%ld",(long)userInfo.fansNum];
//    _favorNum.text = [NSString stringWithFormat:@"%ld",(long)userInfo.favorNum];
//    _followNum.text = [NSString stringWithFormat:@"%ld",(long)userInfo.followNum];
    
    [_headView sd_setImageWithURL:[NSURL URLWithString:[userInfo getUserPhotoUrl]] placeholderImage:[UIImage imageNamed:@"default_icon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            GPUImagePicture *picture = [[GPUImagePicture alloc] initWithImage:image];
            if (_blurFilter) {
                [_blurFilter removeAllTargets];
            }
            [picture addTarget:_blurFilter];
            [_blurFilter addTarget:_backGPUImageView];
            [picture processImageWithCompletionHandler:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    _headView.image = image;
                    [_blurFilter removeAllTargets];
                });
            }];
        }
    }];
}

@end
