//
//  TopScrollView.h
//  CookBook
//
//  Created by 你好 on 16/4/25.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendImageView.h"

@interface TopScrollView : UIView<UIScrollViewDelegate,RecommendImageViewDelegate>

@property (nonatomic,assign) id delegate;
@property (nonatomic,strong) NSMutableArray *imageArray;
@property (nonatomic,assign) NSInteger currentIndex;//此时幻灯片序号


-(void)setAppearanceViewAlpha:(CGFloat)alpha;
-(instancetype)initWithframe:(CGRect)rect andImages:(NSArray *)images;


-(void)configData;



@end

@protocol TopScrollViewDelegate <NSObject>

-(void)didSelectImageView:(NSDictionary *)dict;

@end
