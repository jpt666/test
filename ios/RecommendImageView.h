//
//  RecommendImageView.h
//  CookBook
//
//  Created by 你好 on 16/5/19.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendImageView : UIImageView

@property (nonatomic,strong)NSDictionary *dict;
@property (nonatomic,assign)id delegate;

@end

@protocol RecommendImageViewDelegate <NSObject>

-(void)didClickImageView:(RecommendImageView *)imageView;

@end