//
//  MyCollectionViewController.m
//  CookBook
//
//  Created by 你好 on 16/6/12.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "NavView.h"
#import "MyCollectionCell.h"
@interface MyCollectionViewController()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

//static NSString *cellIdentifier = @"MyCollectionCell";

@implementation MyCollectionViewController
{
    NavView *_navView;
    UIImageView *_headImageView;
//    UICollectionView *_collectionView;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.rdv_tabBarController setTabBarHidden:YES animated:NO];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    _navView=[[NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navView.centerLabel.text=@"我的收藏";
    [_navView.leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_navView.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navView];

    
    UIImage *image=[UIImage imageNamed:@"myCollection"];
    _headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 154, ScreenWidth, ScreenWidth*image.size.height/image.size.width)];
    _headImageView.image=image;
    [self.view addSubview:_headImageView];
    
//    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
//    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth,ScreenHeight-64) collectionViewLayout:flowLayout];
//    _collectionView.dataSource=self;
//    _collectionView.delegate=self;
//    _collectionView.backgroundColor=[UIColor clearColor];
//    self.automaticallyAdjustsScrollViewInsets=NO;
//    _collectionView.alwaysBounceVertical=YES;
//    [_collectionView registerClass:[MyCollectionCell class] forCellWithReuseIdentifier:cellIdentifier];
//    
//    [self.view addSubview:_collectionView];
}


-(void)leftButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

//#pragma mark - UICollectionViewDelegate
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    MyCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
//    return cell;
//}
//
//
////定义展示的UICollectionViewCell的个数
//-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    
//    return 10;
//}
//
////定义展示的Section的个数
//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//    return 1;
//}
//
////定义每个UICollectionView 的大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake((ScreenWidth-4)/2,(ScreenWidth-4)/2*1.45);
//}
//
//
////定义每个UICollectionView 的 margin
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsZero;
//}
//
//
//-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 2;
//}
//
//-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 4;
//}
//
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}


-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
