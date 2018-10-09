//
//  MyDishMenuViewController.m
//  CookBook
//
//  Created by 你好 on 16/6/12.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "MyDishMenuViewController.h"
#import "NavView.h"
#import "MyCollectionCell.h"
#import "RetrieveCookDataRequest.h"
#import "CookBookReformer.h"
#import "CookProductReformer.h"
#import "MJRefresh.h"
#import "CookBookPropertyKeys.h"
#import "CookProductPropertyKeys.h"
#import "GlobalVar.h"
#import "UserManager.h"
#import "DetailContentViewController.h"
#import "MBProgressHUD+Helper.h"

@interface MyDishMenuViewController()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,RetrieveRequestDelegate>


@end

static NSString *cellIdentifier = @"MyCollectionCell";


@implementation MyDishMenuViewController
{
    NavView *_navView;
    UIButton *_leftButton;
    UIButton *_rightButton;
    UIView *_bottomLineView;
    UIScrollView *_scrollView;
    UICollectionView *_productCollectionView;
    UICollectionView *_cookBookCollectionView;
    
    NSMutableArray *_arrCookBook;
    NSMutableArray *_arrCookProduct;
    
    RetrieveCookDataRequest * _bookRefreshRequest;
    RetrieveCookDataRequest * _productRefreshRequest;
    
    RetrieveCookDataRequest * _bookLoadMoreRequest;
    RetrieveCookDataRequest * _productLoadMoreRequest;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.rdv_tabBarController setTabBarHidden:YES animated:NO];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    _navView=[[NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navView.centerLabel.text=@"我的菜报";
    [_navView.leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_navView.leftButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navView];
    
    _leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _leftButton.frame=CGRectMake(0, 64, (ScreenWidth-4)/2, 50);
    [_leftButton setTitle:@"作 品" forState:UIControlStateNormal];
    [_leftButton setTitleColor:[UIColor colorWithHexString:@"#4e4e4e"] forState:UIControlStateNormal];
    [_leftButton setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [_leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_leftButton];
    
    _rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _rightButton.frame=CGRectMake(ScreenWidth/2+2, 64, (ScreenWidth-4)/2, 50);
    [_rightButton setTitle:@"菜 谱" forState:UIControlStateNormal];
    [_rightButton setTitleColor:[UIColor colorWithHexString:@"#4e4e4e"] forState:UIControlStateNormal];
    [_rightButton setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [_rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_rightButton];
    
    _bottomLineView=[[UIView alloc]initWithFrame:CGRectMake(0, 112, (ScreenWidth-4)/2, 2)];
    _bottomLineView.backgroundColor=[UIColor orangeColor];
    [self.view addSubview:_bottomLineView];
    
    _leftButton.selected=YES;
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 114, ScreenWidth, ScreenHeight-64-50)];
    _scrollView.showsVerticalScrollIndicator=NO;
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width*2 ,_scrollView.bounds.size.height-50);
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    UICollectionViewFlowLayout *flowLayoutProduct=[[UICollectionViewFlowLayout alloc]init];
    _productCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,_scrollView.bounds.size.height) collectionViewLayout:flowLayoutProduct];
    _productCollectionView.dataSource=self;
    _productCollectionView.delegate=self;
    _productCollectionView.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    _productCollectionView.alwaysBounceVertical=YES;
    [_productCollectionView registerClass:[MyCollectionCell class] forCellWithReuseIdentifier:cellIdentifier];
    [_scrollView addSubview:_productCollectionView];
    
    UICollectionViewFlowLayout *flowLayoutBook=[[UICollectionViewFlowLayout alloc]init];
    _cookBookCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth,_scrollView.bounds.size.height) collectionViewLayout:flowLayoutBook];
    _cookBookCollectionView.dataSource=self;
    _cookBookCollectionView.delegate=self;
    _cookBookCollectionView.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    _cookBookCollectionView.alwaysBounceVertical=YES;
    [_cookBookCollectionView registerClass:[MyCollectionCell class] forCellWithReuseIdentifier:cellIdentifier];
    [_scrollView addSubview:_cookBookCollectionView];
    
    
    MJRefreshNormalHeader *productHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshProductData];
    }];
//    [productHeader setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
//    [productHeader setTitle:@"释放开始刷新" forState:MJRefreshStatePulling];
//    [productHeader setTitle:@"正在刷新 ..." forState:MJRefreshStateRefreshing];
    [productHeader setTitle:@"正在获取数据中..." forState:MJRefreshStateRefreshing];
    _productCollectionView.mj_header = productHeader;

    MJRefreshNormalHeader *cookBookHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshBookData];
    }];
//    [cookBookHeader setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
//    [cookBookHeader setTitle:@"释放开始刷新" forState:MJRefreshStatePulling];
//    [cookBookHeader setTitle:@"正在刷新 ..." forState:MJRefreshStateRefreshing];
    [cookBookHeader setTitle:@"正在获取数据中..." forState:MJRefreshStateRefreshing];    _cookBookCollectionView.mj_header = cookBookHeader;
    
    MJRefreshAutoNormalFooter *productFooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            if (!_arrCookProduct.count)
            {
                [_productCollectionView.mj_footer endRefreshing];
                return;
            }
            [self loadMoreProductData];
    }];
    
    [productFooter setTitle:@"" forState:MJRefreshStateIdle];
    productFooter.refreshingTitleHidden=YES;
    productFooter.automaticallyHidden=YES;
    _productCollectionView.mj_footer = productFooter;
    
    
    MJRefreshAutoNormalFooter *cookBookFooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            if (!_arrCookBook.count)
            {
                [_cookBookCollectionView.mj_footer endRefreshing];
                return;
            }
            [self loadMoreBookData];
    }];
    
    [cookBookFooter setTitle:@"" forState:MJRefreshStateIdle];
    cookBookFooter.refreshingTitleHidden=YES;
    cookBookFooter.automaticallyHidden=YES;
    _cookBookCollectionView.mj_footer = cookBookFooter;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshBookData) name:NOTIFY_REFRESH_COOK_CUISINE object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshProductData) name:NOTIFY_REFRESH_COOK_PRODUCT object:nil];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self refreshData];
}

-(void)backButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)shareButtonClick:(UIButton *)button
{
    
}

-(void)leftButtonClick:(UIButton *)button
{
    _leftButton.selected=YES;
    _rightButton.selected=NO;
    [self.view bringSubviewToFront:_bottomLineView];
    [UIView animateWithDuration:0.25 animations:^{
        _bottomLineView.frame=CGRectMake(0, 112, (ScreenWidth-4)/2, 2);
        [_scrollView setContentOffset:CGPointMake(0, 0)];
    } completion:^(BOOL finished) {
//        if (!_arrCookProduct.count) {
//            if  ([_productCollectionView.mj_header isRefreshing]) {
//                [_productCollectionView.mj_header endRefreshing];
//            }
//            [_productCollectionView.mj_header beginRefreshing];
//        }
        [self refreshData];
    }];
//    [_scrollView scrollRectToVisible:CGRectMake(0, _scrollView.bounds.origin.y, _scrollView.bounds.size.width, _scrollView.bounds.size.height) animated:YES];

}

-(void)rightButtonClick:(UIButton *)button
{
    _leftButton.selected=NO;
    _rightButton.selected=YES;
    [self.view bringSubviewToFront:_bottomLineView];
    [UIView animateWithDuration:0.25 animations:^{
        [_scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width, 0)];
        _bottomLineView.frame=CGRectMake(ScreenWidth/2+2, 112, (ScreenWidth-4)/2, 2);
    } completion:^(BOOL finished) {
//        if (!_arrCookBook.count) {
//            if  ([_cookBookCollectionView.mj_header isRefreshing]) {
//                [_cookBookCollectionView.mj_header endRefreshing];
//            }
//            [_cookBookCollectionView.mj_header beginRefreshing];
//        }
        [self refreshData];
    }];
    ;
//    [_scrollView scrollRectToVisible:CGRectMake(_scrollView.bounds.size.width, _scrollView.bounds.origin.y, _scrollView.bounds.size.width, _scrollView.bounds.size.height) animated:YES];
}

-(void)refreshData
{
    if (_scrollView.contentOffset.x/_scrollView.bounds.size.width <= 0) {
        if (!_arrCookProduct.count) {
            if  ([_productCollectionView.mj_header isRefreshing]) {
                [_productCollectionView.mj_header endRefreshing];
            }
            [_productCollectionView.mj_header beginRefreshing];
        }
    } else {
        if (!_arrCookBook.count) {
            if  ([_cookBookCollectionView.mj_header isRefreshing]) {
                [_cookBookCollectionView.mj_header endRefreshing];
            }
            [_cookBookCollectionView.mj_header beginRefreshing];
        }
        
    }
}

-(void)refreshBookData
{
    if (_bookRefreshRequest) {
        [_bookRefreshRequest cancel];
    }
    _bookRefreshRequest = [[RetrieveCookDataRequest alloc] initWithCookerId:[UserManager shareInstance].curUser.userId offset:0 count:10 url:[GlobalVar shareGlobalVar].cookRecipesUrl];
    _bookRefreshRequest.delegate = self;
    [_bookRefreshRequest request];
}

-(void)refreshProductData
{
    if (_productRefreshRequest) {
        [_productRefreshRequest cancel];
    }
    _productRefreshRequest = [[RetrieveCookDataRequest alloc] initWithCookerId:[UserManager shareInstance].curUser.userId offset:0 count:10 url:[GlobalVar shareGlobalVar].cookDishsUrl];
    _productRefreshRequest.delegate = self;
    [_productRefreshRequest request];
}

-(void)loadMoreBookData
{
    if (_bookLoadMoreRequest) {
        [_bookLoadMoreRequest cancel];
    }
    _bookLoadMoreRequest = [[RetrieveCookDataRequest alloc] initWithCookerId:[UserManager shareInstance].curUser.userId limitTime:[[[_arrCookBook lastObject] objectForKey:kBookPropertyCreateTime] longLongValue] count:10 url:[GlobalVar shareGlobalVar].cookRecipesUrl];
    _bookLoadMoreRequest.delegate = self;
    [_bookLoadMoreRequest request];
}

-(void)loadMoreProductData
{
    if (_productLoadMoreRequest) {
        [_productLoadMoreRequest cancel];
    }
    _productLoadMoreRequest = [[RetrieveCookDataRequest alloc] initWithCookerId:[UserManager shareInstance].curUser.userId limitTime:[[[_arrCookProduct lastObject] objectForKey:kProductPropertyCreateTime] longLongValue] count:10 url:[GlobalVar shareGlobalVar].cookDishsUrl];
    _productLoadMoreRequest.delegate = self;
    [_productLoadMoreRequest request];
}


#pragma mark RetrieveCookDataDelegate
-(void)didRetrieveDataSuccess:(RetrieveRequest *)request
{
    if (request == _bookRefreshRequest)
    {
        if ([_cookBookCollectionView.mj_header isRefreshing]) {
            [_cookBookCollectionView.mj_header endRefreshing];
        }
        
        NSMutableDictionary * dictResult = [_bookRefreshRequest fetchDataWithReformer:[[CookBookReformer alloc] init]];
        _arrCookBook = [NSMutableArray arrayWithArray:dictResult[@"cuisinebooks"]];
        
        [_cookBookCollectionView reloadData];
        _cookBookCollectionView.mj_footer.hidden = _arrCookBook.count?NO:YES;
    }
    else if (request == _bookLoadMoreRequest)
    {
        if ([_cookBookCollectionView.mj_footer isRefreshing]) {
            [_cookBookCollectionView.mj_footer endRefreshing];
        }
        
        NSMutableDictionary * dictResult = [_bookLoadMoreRequest fetchDataWithReformer:[[CookBookReformer alloc] init]];
        NSArray *arrRet = dictResult[@"cuisinebooks"];
        [_arrCookBook addObjectsFromArray:arrRet];
        
        [_cookBookCollectionView reloadData];
        _cookBookCollectionView.mj_footer.hidden = arrRet.count?NO:YES;
    }
    else if (request == _productRefreshRequest)
    {
        if ([_productCollectionView.mj_header isRefreshing]) {
            [_productCollectionView.mj_header endRefreshing];
        }
        
        NSMutableDictionary * dictResult = [_productRefreshRequest fetchDataWithReformer:[[CookProductReformer alloc] init]];
        _arrCookProduct = [NSMutableArray arrayWithArray:dictResult[@"products"]];
        
        [_productCollectionView reloadData];
        _productCollectionView.mj_footer.hidden = _arrCookProduct.count?NO:YES;
        
    }
    else if (request == _productLoadMoreRequest)
    {
        if ([_productCollectionView.mj_footer isRefreshing]) {
            [_productCollectionView.mj_footer endRefreshing];
        }
        NSMutableDictionary * dictResult = [_productLoadMoreRequest fetchDataWithReformer:[[CookProductReformer alloc] init]];
        NSArray *arrRet = dictResult[@"products"];
        [_arrCookProduct addObjectsFromArray:arrRet];
        
        [_productCollectionView reloadData];
        _productCollectionView.mj_footer.hidden = arrRet.count?NO:YES;
    }
}

-(void)didRetrieveDataFailed:(RetrieveRequest *)request
{
    if (request == _bookRefreshRequest)
    {
        if ([_cookBookCollectionView.mj_header isRefreshing]) {
            [_cookBookCollectionView.mj_header endRefreshing];
        }
    }
    else if (request == _bookLoadMoreRequest)
    {
        if ([_cookBookCollectionView.mj_footer isRefreshing]) {
            [_cookBookCollectionView.mj_footer endRefreshing];
        }
    }
    else if (request == _productRefreshRequest)
    {
        if ([_productCollectionView.mj_header isRefreshing]) {
            [_productCollectionView.mj_header endRefreshing];
        }
    }
    else if (request == _productLoadMoreRequest)
    {
        if ([_productCollectionView.mj_footer isRefreshing]) {
            [_productCollectionView.mj_footer endRefreshing];
        }
    }
    
    [MBProgressHUD showHUDAutoDismissWithError:request.error andDim:NO];
}



#pragma mark - UICollectionViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView==_scrollView)
    {
        int x=scrollView.contentOffset.x/scrollView.bounds.size.width;
        if (x==0)
        {
            [self leftButtonClick:nil];
        }
        else if(x==1)
        {
            [self rightButtonClick:nil];
        }
    }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView==_productCollectionView)
    {
        MyCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        NSMutableDictionary *dict=[_arrCookProduct objectAtIndex:indexPath.row];
        [cell setupWithCookData:dict andType:CookProductType];
        return cell;
    }
    else if (collectionView == _cookBookCollectionView)
    {
        MyCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        NSMutableDictionary *dict=[_arrCookBook objectAtIndex:indexPath.row];
        [cell setupWithCookData:dict andType:CookBookType];
        return cell;
    }
    
    return nil;
}


//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == _cookBookCollectionView) {
        return _arrCookBook.count;
    } else if (collectionView == _productCollectionView) {
        return _arrCookProduct.count;
    }
    return 0;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenWidth-4)/2,(ScreenWidth-4)/2*1.45);
}


//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}


-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 4;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView==_productCollectionView)
    {
        NSMutableDictionary *dict=[_arrCookProduct objectAtIndex:indexPath.row];
        DetailContentViewController *detailContentVC=[[DetailContentViewController alloc]init];
        detailContentVC.dict=dict;
        detailContentVC.cookType=CookProductType;
        [self.navigationController pushViewController:detailContentVC animated:YES];
    }
    else if (collectionView==_cookBookCollectionView)
    {
        NSMutableDictionary *dict=[_arrCookBook objectAtIndex:indexPath.row];
        DetailContentViewController *detailContentVC=[[DetailContentViewController alloc]init];
        detailContentVC.dict=dict;
        detailContentVC.cookType=CookBookType;
        [self.navigationController pushViewController:detailContentVC animated:YES];
    }
}



-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFY_REFRESH_COOK_CUISINE object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFY_REFRESH_COOK_PRODUCT object:nil];

}

@end
