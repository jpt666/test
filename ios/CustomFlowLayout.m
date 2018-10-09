//
//  CustomFlowLayout.m
//  CookBook
//
//  Created by 你好 on 16/4/14.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "CustomFlowLayout.h"

@implementation CustomFlowLayout

-(instancetype)init
{
    self=[super init];
    
    if (self)
    {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}



- (CGSize)collectionViewContentSize
{
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
//    return CGSizeMake(ScreenWidth, self.collectionView.contentSize.height+60)
    return CGSizeMake(ScreenWidth, (((ScreenWidth-6)/3+2)*(itemCount/3))+60);
}


@end
