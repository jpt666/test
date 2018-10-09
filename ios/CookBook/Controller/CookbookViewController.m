//
//  CookbookViewController.m
//  CookBook
//
//  Created by zhangxi on 16/4/11.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "CookbookViewController.h"
#import "ShowCookingSkillView.h"
#import "MainPageTableCell.h"
#import "MenuEditorViewController.h"
#import "PhotoViewController.h"
#import "DetailContentViewController.h"
#import "UserManager.h"
#import "LoginViewController.h"
#import <UIImageView+WebCache.h>
#import "JSONKit.h"
#import "RetrieveRequest.h"
#import "RetrieveCookDataRequest.h"
#import "MJRefresh.h"
#import "GlobalVar.h"
#import "ContentScrollView.h"
#import "CookBookPropertyKeys.h"
#import "CookProductPropertyKeys.h"
#import "CookBookReformer.h"
#import "CookProductReformer.h"
#import "CookRecipeIndexReformer.h"
#import "TopScrollView.h"
#import "IQKeyboardManager.h"
#import "UICustomTextField.h"
#import "WebViewController.h"
#import "MBProgressHUD+Helper.h"
#define FLOAT_SECTION_HEIGHT 64

@interface CookbookViewController ()<ShowCookingSkillViewDelegate,ShowCookingSkillViewDataSource,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UITextFieldDelegate, RetrieveRequestDelegate,ContentScrollViewDataSource,ContentScrollViewDelegate,TopScrollViewDelegate>
{

}

@end

@implementation CookbookViewController
{

    UITableView *_contentTableView;
    UITableView *_bookTableView;
    UITableView *_productTableView;
    
    
    ContentScrollView * _searchRetContentView;
    UITableView *_bookRetTable;
    UITableView *_productRetTable;
    UITableView *_searchHintTable;
    
    NSMutableArray * _arrHintText;
    
//    UITableView *_shadowBookTableView;
//    UITableView *_shadowProductTableView;
    
    __weak UITableView *_curSelectedTableView;
    
    __weak UITableView *_curRetTableView;
    
    ContentScrollView * _contentScrollView;
    BOOL _bContentTopped;
//    ContentScrollView * _contentShadowView;
    TopScrollView *_topScrollView;
    
    UIView *_navView;
    UIView *_navBackView;
    UIImageView *_searchBackEditView;
    UIImageView *_searchBackImageView;
    UICustomTextField *_searchTextField;
    UIButton * _cancelSearchBtn;

    NSMutableArray *_arrCookBook;
    NSMutableArray *_arrCookProduct;
    ShowCookingSkillView * _cookingView;
    UIView *  _maskView;
    int index;
    
    RetrieveCookDataRequest * _bookRefreshRequest;
    RetrieveCookDataRequest * _productRefreshRequest;
    
    RetrieveCookDataRequest * _bookLoadMoreRequest;
    RetrieveCookDataRequest * _productLoadMoreRequest;
    
    
    NSMutableArray * _arrBookSearch;
    NSMutableArray * _arrProductSearch;
    
    RetrieveCookDataRequest * _bookSearchRequest;
    RetrieveCookDataRequest * _productSearchRequest;
    
    RetrieveRequest * _recipeIndexRequest;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    if ([[UIDevice currentDevice] systemVersion].floatValue>=7.0) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.view.backgroundColor = RGBACOLOR(230, 230, 230, 1);
    [self.navigationController setNavigationBarHidden:YES];
    
    UIView * shadowView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    shadowView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:shadowView];

    _arrCookBook=[[NSMutableArray alloc]initWithCapacity:0];
    
    _navView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navView.backgroundColor=[UIColor clearColor];
    _navBackView = [[UIView alloc] initWithFrame:_navView.bounds];
    _navBackView.hidden = YES;
    [_navView addSubview:_navBackView];
    
    _cancelSearchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelSearchBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelSearchBtn addTarget:self action:@selector(caneclSearch:) forControlEvents:UIControlEventTouchUpInside];
    _cancelSearchBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    _cancelSearchBtn.backgroundColor = [UIColor clearColor];
    [_cancelSearchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _cancelSearchBtn.hidden = YES;
    _cancelSearchBtn.frame = CGRectMake(ScreenWidth-60, 20, 60, 35);
    [_navView addSubview:_cancelSearchBtn];
    
    UIImage *editSeartchImage=[UIImage imageNamed:@"search_background_begin"];
    _searchBackEditView =[[UIImageView alloc]initWithFrame:CGRectMake(10, 22.5, ScreenWidth-20, editSeartchImage.size.height)];
        _searchBackEditView.image = [editSeartchImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 30) resizingMode:UIImageResizingModeStretch];
    _searchBackEditView.alpha = 0.7;
    [_navView addSubview:_searchBackEditView];
    
    _searchBackImageView =[[UIImageView alloc]initWithFrame:CGRectMake(10, 22.5, ScreenWidth-20, editSeartchImage.size.height)];
    _searchBackImageView.image=[UIImage imageNamed:@"search_back_image"];
    _searchBackImageView.alpha = 0.7;
    [_navView addSubview:_searchBackImageView];
    
    UIImage *searchImage=[UIImage imageNamed:@"search"];
    UIImageView *searchImageView=[[UIImageView alloc]initWithFrame:CGRectMake(5, (35-searchImage.size.height)/2, searchImage.size.width, searchImage.size.height)];
    searchImageView.image=searchImage;
    
    [[UITextField appearance] setTintColor:[UIColor whiteColor]];
    
    _searchTextField=[[UICustomTextField alloc]initWithFrame:CGRectMake(16, 22.5, ScreenWidth-32, 32.5)];
    _searchTextField.backgroundColor=[UIColor clearColor];
    _searchTextField.autocapitalizationType=UITextAutocapitalizationTypeNone;
    _searchTextField.autocorrectionType=UITextAutocorrectionTypeNo;
    _searchTextField.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@" 搜索菜谱、美食" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    _searchTextField.font=[UIFont systemFontOfSize:16];
    _searchTextField.textColor=[UIColor whiteColor];
    _searchTextField.delegate=self;
    _searchTextField.returnKeyType=UIReturnKeySearch;
    _searchTextField.leftView = searchImageView;
    _searchTextField.leftViewMode = UITextFieldViewModeUnlessEditing;
    
    [_navView addSubview:_searchTextField];

    [self setupContentTableViewWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-49)];
    
    [self setupShowCookingView];
    
    [self setupSearchRetContentViewWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64-49)];
    
    [self setupSearchHintTableViewWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64-49)];
    
    [self.view addSubview:_navView];
    
    [self refreshRecipeIndex];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(searchTextDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshBookData) name:NOTIFY_REFRESH_COOK_CUISINE object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshProductData) name:NOTIFY_REFRESH_COOK_PRODUCT object:nil];
    
}

- (void)clearLastSearch
{
    if(_bookSearchRequest) {
        [_bookSearchRequest cancel];
        _bookSearchRequest = nil;
    }
    
    if(_productSearchRequest) {
        [_productSearchRequest cancel];
        _productSearchRequest = nil;
    }
    
    [_arrBookSearch removeAllObjects];
    [_arrProductSearch removeAllObjects];
    
    [_productRetTable reloadData];
    [_bookRetTable reloadData];
}

- (void)caneclSearch:(UIButton *)btn
{
    [_searchTextField resignFirstResponder];
    _searchTextField.text = nil;
    _searchHintTable.hidden = YES;
    _searchRetContentView.hidden = YES;
    _navView.backgroundColor=[UIColor clearColor];

    [UIView animateWithDuration:0.1 animations:^{
        _searchBackImageView.alpha = MIN((1-_contentTableView.contentOffset.y/(_contentTableView.tableHeaderView.bounds.size.height-FLOAT_SECTION_HEIGHT))*0.7,0.7);
        
        _searchBackEditView.alpha =MIN((_contentTableView.contentOffset.y/(_contentTableView.tableHeaderView.bounds.size.height-FLOAT_SECTION_HEIGHT))*0.7,0.7);
    }];
    
    [self clearLastSearch];
    
    if (_bContentTopped) {
        _navBackView.hidden = NO;
    } else {
        _navBackView.hidden = YES;
    }
    
    [self resizeSearchBar];
}

- (void)resizeSearchBar
{
    if ([_searchTextField isFirstResponder])
    {
        _cancelSearchBtn.hidden = NO;
        [UIView animateWithDuration:0.1 animations:^{
            _searchTextField.frame = CGRectMake(16, 22.5, ScreenWidth-32-55, 32.5);
        }];

        [UIView animateWithDuration:0.1 animations:^{
            _searchBackImageView.frame = CGRectMake(_searchBackImageView.frame.origin.x, _searchBackImageView.frame.origin.y, ScreenWidth-20-55, _searchBackImageView.frame.size.height);
            _searchBackEditView.frame = CGRectMake(_searchBackEditView.frame.origin.x, _searchBackEditView.frame.origin.y, ScreenWidth-20-55, _searchBackEditView.frame.size.height);
        }];
    }
    else
    {
        _cancelSearchBtn.hidden = YES;
        [UIView animateWithDuration:0.1 animations:^{
            _searchTextField.frame = CGRectMake(16, 22.5, ScreenWidth-32, 32.5);
        }];

        [UIView animateWithDuration:0.1 animations:^{
            _searchBackImageView.frame = CGRectMake(_searchBackImageView.frame.origin.x, _searchBackImageView.frame.origin.y, ScreenWidth-20, _searchBackImageView.frame.size.height);
            _searchBackEditView.frame = CGRectMake(_searchBackEditView.frame.origin.x, _searchBackEditView.frame.origin.y, ScreenWidth-20, _searchBackEditView.frame.size.height);
        }];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [_cookingView folderView];
    
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleDefault;
    [_cookingView showView];
}

- (void)applicationDidBecomeActive:(NSNotification *)notify
{
//    [self refreshRecipeIndex];
//    [self refreshBookData];
//    [self refreshProductData];
}

-(void)refreshRecipeIndex
{
    if (_recipeIndexRequest) {
        [_recipeIndexRequest cancel];
    }
    _recipeIndexRequest = [[RetrieveRequest alloc] init];
    _recipeIndexRequest.delegate = self;
    [_recipeIndexRequest getRequestWithUrl:[GlobalVar shareGlobalVar].recipeIndexUrl andParam:nil];
    
}

-(void)refreshBookData
{
    if (_bookRefreshRequest) {
        [_bookRefreshRequest cancel];
    }
    _bookRefreshRequest = [[RetrieveCookDataRequest alloc] initWithCookerId:0 offset:0 count:10 url:[GlobalVar shareGlobalVar].cookRecipesUrl];
    _bookRefreshRequest.delegate = self;
    [_bookRefreshRequest request];
}

-(void)refreshProductData
{
    if (_productRefreshRequest) {
        [_productRefreshRequest cancel];
    }
    _productRefreshRequest = [[RetrieveCookDataRequest alloc] initWithCookerId:0 offset:0 count:10 url:[GlobalVar shareGlobalVar].cookDishsUrl];
    _productRefreshRequest.delegate = self;
    [_productRefreshRequest request];
}

-(void)loadMoreBookData
{
    if (_bookLoadMoreRequest) {
        [_bookLoadMoreRequest cancel];
    }
    _bookLoadMoreRequest = [[RetrieveCookDataRequest alloc] initWithCookerId:0 limitTime:[[[_arrCookBook lastObject] objectForKey:kBookPropertyCreateTime] longLongValue] count:10 url:[GlobalVar shareGlobalVar].cookRecipesUrl];
    _bookLoadMoreRequest.delegate = self;
    [_bookLoadMoreRequest request];
}

-(void)loadMoreProductData
{
    if (_productLoadMoreRequest) {
        [_productLoadMoreRequest cancel];
    }
    _productLoadMoreRequest = [[RetrieveCookDataRequest alloc] initWithCookerId:0 limitTime:[[[_arrCookProduct lastObject] objectForKey:kProductPropertyCreateTime] longLongValue] count:10 url:[GlobalVar shareGlobalVar].cookDishsUrl];
    _productLoadMoreRequest.delegate = self;
    [_productLoadMoreRequest request];
}

- (BOOL)searchCookDataWithRefresh:(BOOL)bRefresh
{
    if (_searchTextField.text.length) {
        if (_curRetTableView == _bookRetTable) {
            [self searchBookWithRefresh:bRefresh];
        } else if (_curRetTableView == _productRetTable) {
            [self searchProductWithRefresh:bRefresh];
        }
        
        return YES;
    }
    
    return NO;
}

- (void)searchBookWithRefresh:(BOOL)bRefresh
{
    if (bRefresh) {
//        [_arrBookSearch removeAllObjects];
//        [_bookRetTable reloadData];
    }
    
    if (_bookSearchRequest) {
        [_bookSearchRequest cancel];
    }
    
    long long limitTime = 0;
    if (_arrBookSearch.count && !bRefresh) {
        limitTime =[[[_arrBookSearch lastObject] objectForKey:kBookPropertyCreateTime] longLongValue];
    }
    
    _bookSearchRequest = [[RetrieveCookDataRequest alloc] initWithKeyword:_searchTextField.text count:10 limitTime:limitTime url:[GlobalVar shareGlobalVar].cookRecipesUrl];
    _bookSearchRequest.delegate = self;
    [_bookSearchRequest request];
}

- (void)searchProductWithRefresh:(BOOL)bRefresh
{
    if (bRefresh) {
        
    }
    
    if (_productSearchRequest) {
        [_productSearchRequest cancel];
    }
    long long limitTime = 0;
    if (_arrProductSearch.count && !bRefresh) {
        limitTime =[[[_arrProductSearch lastObject] objectForKey:kProductPropertyCreateTime] longLongValue];
    }
    
    _productSearchRequest = [[RetrieveCookDataRequest alloc] initWithKeyword:_searchTextField.text count:10 limitTime:limitTime url:[GlobalVar shareGlobalVar].cookDishsUrl];
    _productSearchRequest.delegate = self;
    [_productSearchRequest request];
}



#pragma mark - UITableViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _contentTableView) {
        
        if (_contentTableView.contentOffset.y >= _contentTableView.tableHeaderView.bounds.size.height-FLOAT_SECTION_HEIGHT) {
            CGRect f= _contentScrollView.frame;
            f.origin = CGPointMake(0, _contentTableView.contentOffset.y+FLOAT_SECTION_HEIGHT);
            _contentScrollView.frame = f;
            
            _curSelectedTableView.contentOffset = CGPointMake(_contentTableView.contentOffset.x, _contentTableView.contentOffset.y-(_contentTableView.tableHeaderView.bounds.size.height-FLOAT_SECTION_HEIGHT));
            
  
            _navBackView.hidden = NO;
  
            _bContentTopped = YES;
        } else {
            _contentScrollView.frame = CGRectMake(0, _contentTableView.tableHeaderView.bounds.size.height, _contentScrollView.bounds.size.width, _contentScrollView.bounds.size.height);
            _bookTableView.contentOffset = CGPointMake(_contentTableView.contentOffset.x, 0);
            _productTableView.contentOffset = _bookTableView.contentOffset;
            
            _navBackView.hidden = _searchHintTable.hidden;
            _bContentTopped = NO;
        }
        
        [_topScrollView setAppearanceViewAlpha:1-_contentTableView.contentOffset.y/(_contentTableView.tableHeaderView.bounds.size.height-FLOAT_SECTION_HEIGHT)];
        

            _searchBackImageView.alpha = MIN((1-_contentTableView.contentOffset.y/(_contentTableView.tableHeaderView.bounds.size.height-FLOAT_SECTION_HEIGHT))*0.7,0.7);
        
            _searchBackEditView.alpha =MIN((_contentTableView.contentOffset.y/(_contentTableView.tableHeaderView.bounds.size.height-FLOAT_SECTION_HEIGHT))*0.7,0.7);
        
    
        if (_contentTableView.contentOffset.y == 0) {
            [_cookingView showView];
        } else {
            [_cookingView hideView];
        }
        
        [_contentScrollView setTitleAlpha:MIN(_contentTableView.contentOffset.y/(_contentTableView.tableHeaderView.bounds.size.height-FLOAT_SECTION_HEIGHT)*0.35, 0.35)];

    } else {
        
    }
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView == _contentTableView) {
        if (!decelerate) {
            [_cookingView showView];
        }
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _contentTableView) {
        [_cookingView showView];
    }
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if (scrollView == _contentTableView) {
        [_cookingView showView];
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _bookTableView)
    {
        static NSString *cellID=@"cookBookCellID";
        MainPageTableCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil)
        {
            cell=[[MainPageTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        
        NSMutableDictionary *dict=[_arrCookBook objectAtIndex:indexPath.row];
        [cell setupWithCookData:dict andType:CookBookType];

        return cell;
    }
    else if(tableView == _productTableView)
    {
        static NSString *cellID=@"productCellID";
        MainPageTableCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil)
        {
            cell=[[MainPageTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }

        NSMutableDictionary *dict=[_arrCookProduct objectAtIndex:indexPath.row];
        [cell setupWithCookData:dict andType:CookProductType];

        return cell;
    }
    else if (tableView == _contentTableView)
    {
        static NSString *cellID=@"CommonCellID";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }else if (tableView == _bookRetTable)
    {
        static NSString *cellID=@"cookBookCellID";
        MainPageTableCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil)
        {
            cell=[[MainPageTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        
        NSMutableDictionary *dict=[_arrBookSearch objectAtIndex:indexPath.row];
        [cell setupWithCookData:dict andType:CookBookType];
        
        return cell;
    }
    else if(tableView == _productRetTable)
    {
        static NSString *cellID=@"productCellID";
        MainPageTableCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil)
        {
            cell=[[MainPageTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        
        NSMutableDictionary *dict=[_arrProductSearch objectAtIndex:indexPath.row];
        [cell setupWithCookData:dict andType:CookProductType];
        
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (tableView==_contentTableView)
//    {
//        return 44;
//    }
//    else
    {
        return  ScreenWidth/16*9+82.5;
    }
    
    return 0;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _bookTableView ||
        (tableView == _contentTableView &&
         _curSelectedTableView == _bookTableView)) {
        return _arrCookBook.count;
    } else if (tableView == _productTableView ||
               (tableView == _contentTableView &&
                _curSelectedTableView == _productTableView)) {
        return _arrCookProduct.count;
    } else if (tableView == _bookRetTable) {
        return _arrBookSearch.count;
    } else if (tableView == _productRetTable) {
        return _arrProductSearch.count;
    }
    return 0;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _bookTableView) {
        NSDictionary *dict=[_arrCookBook objectAtIndex:indexPath.row];
        DetailContentViewController *detailContentVC=[[DetailContentViewController alloc]init];
        detailContentVC.dict=dict;
        detailContentVC.cookType=CookBookType;
        [self.navigationController pushViewController:detailContentVC animated:YES];
    } else if (tableView==_productTableView) {
        NSDictionary *dict=[_arrCookProduct objectAtIndex:indexPath.row];
        DetailContentViewController *detailContentVC=[[DetailContentViewController alloc]init];
        detailContentVC.dict=dict;
        detailContentVC.cookType=CookProductType;
        [self.navigationController pushViewController:detailContentVC animated:YES];
    } else if (tableView == _bookRetTable) {
        NSDictionary *dict=[_arrBookSearch objectAtIndex:indexPath.row];
        DetailContentViewController *detailContentVC=[[DetailContentViewController alloc]init];
        detailContentVC.dict=dict;
        detailContentVC.cookType=CookBookType;
        [self.navigationController pushViewController:detailContentVC animated:YES];
    } else if (tableView==_productRetTable) {
        NSDictionary *dict=[_arrProductSearch objectAtIndex:indexPath.row];
        DetailContentViewController *detailContentVC=[[DetailContentViewController alloc]init];
        detailContentVC.dict=dict;
        detailContentVC.cookType=CookProductType;
        [self.navigationController pushViewController:detailContentVC animated:YES];
    } else if (tableView == _searchHintTable) {
        _searchTextField.text = [_arrHintText objectAtIndex:indexPath.row];
        if (_searchTextField.text.length) {
            _searchHintTable.hidden = YES;
            [_curRetTableView.mj_header beginRefreshing];
            [self searchCookDataWithRefresh:YES];
        }
    }
}



#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField == _searchTextField) {
        
        if (_searchTextField.text.length) {
            _searchHintTable.hidden = YES;
            
            [self clearLastSearch];
            if ([_curRetTableView.mj_header isRefreshing]) {
                [_curRetTableView.mj_header endRefreshing];
            }
            [_curRetTableView.mj_header beginRefreshing];
            return YES;
        } else {
            return NO;
        }
    }
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _searchTextField) {
        return YES;
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _searchTextField) {
        
        [self resizeSearchBar];
        _navView.backgroundColor=[UIColor whiteColor];
        _searchHintTable.hidden = NO;
        [self.view bringSubviewToFront:_searchHintTable];
        _searchRetContentView.hidden = NO;
        _navBackView.hidden = NO;
        
        [UIView animateWithDuration:0.1 animations:^{
            _searchBackImageView.alpha = 0;
            _searchBackEditView.alpha = 0.7;
        }];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _searchTextField)
    {
        
    }
}

-(void)searchTextDidChange:(NSNotification *)nsnotification
{
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupSearchHintTableViewWithFrame:(CGRect)rect
{
    if (_searchHintTable) {
        return;
    }
    
    _searchHintTable = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    _searchHintTable.backgroundColor = RGBACOLOR(230, 230, 230, 1);
    _searchHintTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _searchHintTable.delegate = self;
    _searchHintTable.dataSource = self;
    _searchHintTable.tableFooterView=[UIView new];
    
    _searchHintTable.hidden = YES;
    
    [self.view addSubview:_searchHintTable];
}

- (void)setupSearchRetContentViewWithFrame:(CGRect)rect
{
    if (_searchRetContentView) {
        return;
    }
    _searchRetContentView = [[ContentScrollView alloc] initWithFrame:rect];
    _searchRetContentView.hidden = YES;
    
    _searchRetContentView.delegate = self;
    _searchRetContentView.dataSource = self;
    
    [_searchRetContentView setTitleAlpha:0.35];

    [self.view addSubview:_searchRetContentView];
}

- (void)setupContentTableViewWithFrame:(CGRect)rect
{
    
    [self initTopScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, (ScreenWidth/320)*220)];
    [self initContentScrollViewWithFrame:CGRectMake(0, (ScreenWidth/320)*220, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    _contentTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    _contentTableView.backgroundColor = [UIColor clearColor];
    _contentTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _contentTableView.tableHeaderView = _topScrollView;
    _contentTableView.contentInset=UIEdgeInsetsMake(0, 0, -MJRefreshFooterHeight, 0);
    
    UIView *placeHoleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _contentTableView.bounds.size.width, 35)];
    placeHoleView.backgroundColor = [UIColor clearColor];
    _contentTableView.tableFooterView = placeHoleView;
    
    [_contentTableView addSubview:_contentScrollView];
    
    
    _contentTableView.delegate = self;
    _contentTableView.dataSource = self;
    
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshContentCookData];
        if (!_topScrollView.imageArray.count) {
            [self refreshRecipeIndex];
        }
    }];
    
    [header setTitle:@"正在获取数据中..." forState:MJRefreshStateRefreshing];
    
    _contentTableView.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (_curSelectedTableView == _bookTableView) {
            
            if (!_arrCookBook.count) {

                [_contentTableView.mj_footer endRefreshing];
                return;
            }
            [self loadMoreBookData];
            
        } else if (_curSelectedTableView == _productTableView) {
            
            if (!_arrCookProduct.count) {
                [_contentTableView.mj_footer endRefreshing];
                return;
            }
            [self loadMoreProductData];
        }
    }];
    
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    footer.refreshingTitleHidden=YES;
    footer.automaticallyHidden=YES;
    _contentTableView.mj_footer = footer;
    
    [self.view addSubview:_contentTableView];
}


- (void)initContentScrollViewWithFrame:(CGRect)rect
{
    if (_contentScrollView) {
        return;
    }
    _contentScrollView = [[ContentScrollView alloc] initWithFrame:rect];
    _contentScrollView.delegate = self;
    _contentScrollView.dataSource = self;
}

- (void)initTopScrollViewWithFrame:(CGRect)rect
{
    if (_topScrollView) {
        return;
    }
    
    NSMutableArray *imageArray=[[NSMutableArray alloc]init];
//    for (int j=0; j<4; j++)
//    {
//        UIImage *image=[UIImage imageNamed:PLACE_HOLDER_COOK_IMAGE];
//        [imageArray addObject:image];
//    }
    _topScrollView=[[TopScrollView alloc]initWithframe:rect andImages:imageArray];
    _topScrollView.delegate=self;
}


- (void)initCookBookTableView
{
    if (!_bookTableView) {
        
        _bookTableView = [[UITableView alloc] init];
        _bookTableView.delegate = self;
        _bookTableView.backgroundColor=RGBACOLOR(207, 207,207, 0.5);
        _bookTableView.dataSource = self;
        _bookTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _bookTableView.scrollEnabled = NO;
        
        UIView *placeHoleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _bookTableView.bounds.size.width, 220)];
        placeHoleView.backgroundColor = [UIColor clearColor];
        _bookTableView.tableFooterView = placeHoleView;
    }
}

- (void)initProductTableView
{
    if (!_productTableView) {
        _productTableView = [[UITableView alloc] init];
        _productTableView.delegate = self;
        _productTableView.dataSource = self;
        _productTableView.backgroundColor=RGBACOLOR(207, 207,207,0.5);
        _productTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _productTableView.scrollEnabled = NO;
        
        UIView *placeHoleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _productTableView.bounds.size.width, 220)];
        placeHoleView.backgroundColor = [UIColor clearColor];
        _productTableView.tableFooterView = placeHoleView;
    }
}

- (void)refreshContentCookData
{
    if (_curSelectedTableView == _bookTableView) {
        [self refreshBookData];
    } else if (_curSelectedTableView == _productTableView) {
        [self refreshProductData];
    }
}

- (void)updateTableRefreshFooter
{
    if (_curSelectedTableView == _bookTableView ) {
        _contentTableView.mj_footer.hidden = _arrCookBook.count?NO:YES;
        
    } else if (_curSelectedTableView == _productTableView) {
        _contentTableView.mj_footer.hidden = _arrCookProduct.count?NO:YES;
    }

}

- (void)initBookRetTable
{
    if (!_bookRetTable) {
        
        _bookRetTable = [[UITableView alloc] init];
        _bookRetTable.delegate = self;
        _bookRetTable.backgroundColor=RGBACOLOR(230, 230, 230, 1);
        _bookRetTable.dataSource = self;
        _bookRetTable.separatorStyle=UITableViewCellSeparatorStyleNone;
        _bookRetTable.contentInset = UIEdgeInsetsMake(0, 0, -MJRefreshFooterHeight, 0);
        
        __weak typeof(self) wSelf = self;
        MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            if (![wSelf searchCookDataWithRefresh:YES]) {
                [_bookRetTable.mj_header endRefreshing];
            }
        }];
        
        header.mj_h += 9;
//        header.labelOffsetY = 9;
        [header setTitle:@"正在获取数据中..." forState:MJRefreshStateRefreshing];
        
        _bookRetTable.mj_header = header;
        
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            if (!_arrBookSearch.count) {
                [_bookRetTable.mj_footer endRefreshing];
                return ;
            }
            
            [wSelf searchCookDataWithRefresh:NO];
        }];
        
        [footer setTitle:@"" forState:MJRefreshStateIdle];
        footer.refreshingTitleHidden=YES;
        footer.automaticallyHidden=YES;

        _bookRetTable.mj_footer = footer;
    }
}

- (void)initProductRetTable
{
    if (!_productRetTable) {
        _productRetTable = [[UITableView alloc] init];
        _productRetTable.delegate = self;
        _productRetTable.dataSource = self;
        _productRetTable.backgroundColor=RGBACOLOR(230, 230, 230, 1);
        _productRetTable.separatorStyle=UITableViewCellSeparatorStyleNone;
        _productRetTable.contentInset = UIEdgeInsetsMake(0, 0, -MJRefreshFooterHeight, 0);
        
        __weak typeof(self) wSelf = self;
        MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            if(![wSelf searchCookDataWithRefresh:YES]) {
                [_productRetTable.mj_header endRefreshing];
            }
        }];
        
        header.mj_h += 9;
//        header.labelOffsetY = 9;

//        header.mj_h += 16;
        
//        [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
//        [header setTitle:@"释放开始刷新" forState:MJRefreshStatePulling];
        [header setTitle:@"正在获取数据中..." forState:MJRefreshStateRefreshing];
        
        _productRetTable.mj_header = header;
        
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            if (!_arrProductSearch.count) {
                [_productRetTable.mj_footer endRefreshing];
                return ;
            }
            
            [wSelf searchCookDataWithRefresh:NO];
        }];
        
        [footer setTitle:@"" forState:MJRefreshStateIdle];
        footer.refreshingTitleHidden=YES;
        footer.automaticallyHidden=YES;
        
        _productRetTable.mj_footer = footer;
    }
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(void)gestureForMaskView:(UIGestureRecognizer *)gesture
{
    if  (_maskView) {
        [_maskView removeFromSuperview];
        _maskView = nil;
    }
    
    [_cookingView folderView];
}


-(void)setupShowCookingView
{
    UIImage *image = [UIImage imageNamed:@"add"];
    _cookingView = [[ShowCookingSkillView alloc] initWithFrame:CGRectMake(ScreenWidth-image.size.width-20, ScreenHeight-49-image.size.height-30, image.size.width, image.size.height)];
    _cookingView.dataSource = self;
    _cookingView.delegate = self;
    [_cookingView setupGUIWithControlButtonImage:image forState:UIControlStateNormal];
    
    [self.view addSubview:_cookingView];
}

-(void)showCookBookButtonClicked:(UIButton *)btn
{
    CATransition* transition = [CATransition animation];
    transition.type = kCATransitionPush;//可更改为其他方式
    transition.subtype = kCATransitionFromTop;//可更改为其他方式
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    
    if ([UserManager shareInstance].bIsLogin)
    {
        PhotoViewController *photoVC=[[PhotoViewController alloc]init];
        photoVC.enterType=FirstEnterPhotoVC;
        photoVC.businessType=ShowFoodBusiness;
        [self.navigationController pushViewController:photoVC animated:NO];
    }
    else
    {
        LoginViewController *loginVC=[[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:NO];
    }
}

-(void)showCookProductButtonClicked:(UIButton *)btn
{
    CATransition* transition = [CATransition animation];
    transition.type = kCATransitionPush;//可更改为其他方式
    transition.subtype = kCATransitionFromTop;//可更改为其他方式
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];

    if ([UserManager shareInstance].bIsLogin)
    {
        PhotoViewController *photoVC=[[PhotoViewController alloc]init];
        photoVC.enterType=FirstEnterPhotoVC;
        photoVC.businessType=UploadMenuBusiness;
        [self.navigationController pushViewController:photoVC animated:NO];
    }
    else
    {
        LoginViewController *loginVC=[[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:NO];
    }
}

#pragma mark - ShowCookingSkillViewDataSource
-(UIButton *)leftButtonForView:(ShowCookingSkillView *)view
{
    UIImage *image = [UIImage imageNamed:@"left_btn_image"];
    UIImage *backImage=[UIImage imageNamed:@"btn_back_image"];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:backImage forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, backImage.size.width, backImage.size.height);
    [btn setImage:image forState:UIControlStateNormal];
    [btn setTitle:@" 秀美食" forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:17];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showCookBookButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

-(UIButton *)rightButtonForView:(ShowCookingSkillView *)view
{
    UIImage *image = [UIImage imageNamed:@"right_btn_image"];
    UIImage *backImage=[UIImage imageNamed:@"btn_back_image"];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, backImage.size.width, backImage.size.height);
    [btn setBackgroundImage:backImage forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setTitle:@" 传菜谱" forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:17];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showCookProductButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

#pragma mark - ShowCookingSkillViewDelegate
- (void)didView:(ShowCookingSkillView *)view expanded:(BOOL)bExpanded
{
    if (bExpanded) {
        _maskView = [[UIView alloc] initWithFrame:self.view.bounds];
        _maskView.backgroundColor = [UIColor clearColor];
        UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gestureForMaskView:)];
        [_maskView addGestureRecognizer:panGes];
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureForMaskView:)];
        [_maskView addGestureRecognizer:tapGes];
        
        [self.view bringSubviewToFront:_cookingView];
        [self.view insertSubview:_maskView belowSubview:_cookingView];
        
    } else {
        if (_maskView) {
            [_maskView removeFromSuperview];
            _maskView = nil;
        }
    }
}

#pragma mark - RetrieveDataRequestDelegate

#pragma mark RetrieveCookDataDelegate
-(void)didRetrieveDataSuccess:(RetrieveRequest *)request
{
    if (request == _bookRefreshRequest) {
        if ([_contentTableView.mj_header isRefreshing]) {
            [_contentTableView.mj_header endRefreshing];
        }
        
        NSMutableDictionary * dictResult = [_bookRefreshRequest fetchDataWithReformer:[[CookBookReformer alloc] init]];
        _arrCookBook = [NSMutableArray arrayWithArray:dictResult[@"cuisinebooks"]];
    
        [_bookTableView reloadData];
        
        [_contentTableView reloadData];
        [self updateTableRefreshFooter];
        
    } else if (request == _bookLoadMoreRequest) {
        if ([_contentTableView.mj_footer isRefreshing]) {
            [_contentTableView.mj_footer endRefreshing];
        }
        
        NSMutableDictionary * dictResult = [_bookLoadMoreRequest fetchDataWithReformer:[[CookBookReformer alloc] init]];
        NSArray *arrRet = dictResult[@"cuisinebooks"];
        [_arrCookBook addObjectsFromArray:arrRet];

        [_bookTableView reloadData];
        
        [_contentTableView reloadData];
        [self updateTableRefreshFooter];
        
    } else if (request == _productRefreshRequest) {
        if ([_contentTableView.mj_header isRefreshing]) {
            [_contentTableView.mj_header endRefreshing];
        }
        
        NSMutableDictionary * dictResult = [_productRefreshRequest fetchDataWithReformer:[[CookProductReformer alloc] init]];
        _arrCookProduct = [NSMutableArray arrayWithArray:dictResult[@"products"]];
        
        [_productTableView reloadData];
        
        [_contentTableView reloadData];
        [self updateTableRefreshFooter];
        
    } else if (request == _productLoadMoreRequest) {
        if ([_contentTableView.mj_footer isRefreshing]) {
            [_contentTableView.mj_footer endRefreshing];
        }
        
        NSMutableDictionary * dictResult = [_productLoadMoreRequest fetchDataWithReformer:[[CookProductReformer alloc] init]];
        NSArray *arrRet = dictResult[@"products"];
        [_arrCookProduct addObjectsFromArray:arrRet];

        [_productTableView reloadData];
        
        [_contentTableView reloadData];
        [self updateTableRefreshFooter];

    } else if (request == _bookSearchRequest) {
        if ([_bookRetTable.mj_header isRefreshing]) {
            [_bookRetTable.mj_header endRefreshing];
            [_arrBookSearch removeAllObjects];
        }
        if ([_bookRetTable.mj_footer isRefreshing]) {
            [_bookRetTable.mj_footer endRefreshing];
        }

        
        NSMutableDictionary * dictResult = [_bookSearchRequest fetchDataWithReformer:[[CookBookReformer alloc] init]];
        if (!_arrBookSearch) {
            _arrBookSearch = [NSMutableArray array];
        }
        [_arrBookSearch addObjectsFromArray:dictResult[@"cuisinebooks"]];
        
        [_bookRetTable reloadData];
        
        [_contentTableView reloadData];
        [self updateTableRefreshFooter];
        
        if (!_arrBookSearch.count) {
            [MBProgressHUD showHUDAutoDismissWithString:@"暂未找到匹配的菜谱" andDim:NO];
        }
        
    } else if (request == _productSearchRequest) {
        if ([_productRetTable.mj_header isRefreshing]) {
            [_productRetTable.mj_header endRefreshing];
            [_arrProductSearch removeAllObjects];
        }
        if ([_productRetTable.mj_footer isRefreshing]) {
            [_productRetTable.mj_footer endRefreshing];
        }
        
        NSMutableDictionary * dictResult = [_productSearchRequest fetchDataWithReformer:[[CookProductReformer alloc] init]];
        if (!_arrProductSearch) {
            _arrProductSearch = [NSMutableArray array];
        }
        [_arrProductSearch addObjectsFromArray:dictResult[@"products"]];

        [_productRetTable reloadData];
        
        [_contentTableView reloadData];
        [self updateTableRefreshFooter];
        
        if (!_arrProductSearch.count) {
            [MBProgressHUD showHUDAutoDismissWithString:@"暂未找到匹配的美食" andDim:NO];
        }
        
    } else if (request == _recipeIndexRequest) {
        
        NSMutableDictionary * dictResult = [_recipeIndexRequest fetchDataWithReformer:[[CookRecipeIndexReformer alloc] init]];
        _topScrollView.imageArray = dictResult[@"slides"];
        [_topScrollView configData];
    }
}

-(void)didRetrieveDataFailed:(RetrieveRequest *)request
{
    if (request == _bookRefreshRequest) {
        if ([_contentTableView.mj_header isRefreshing]) {
            [_contentTableView.mj_header endRefreshing];
        }
    } else if (request == _bookLoadMoreRequest) {
        [_contentTableView.mj_footer endRefreshing];
    } else if (request == _productRefreshRequest) {
        [_contentTableView.mj_header endRefreshing];
    } else if (request == _productLoadMoreRequest) {
        [_contentTableView.mj_footer endRefreshing];
    } else if (request == _bookSearchRequest) {
        if ([_bookRetTable.mj_header isRefreshing]) {
            [_bookRetTable.mj_header endRefreshing];
        }
        if ([_bookRetTable.mj_footer isRefreshing]) {
            [_bookRetTable.mj_footer endRefreshing];
        }
    } else if (request == _productSearchRequest) {
        if ([_productRetTable.mj_header isRefreshing]) {
            [_productRetTable.mj_header endRefreshing];
        }
        if ([_productRetTable.mj_footer isRefreshing]) {
            [_productRetTable.mj_footer endRefreshing];
        }
    } else if (request == _recipeIndexRequest) {
        
    }
    
    [MBProgressHUD showHUDAutoDismissWithError:request.error andDim:NO];
}

#pragma mark ContentViewDelegate

-(void)didContentScrollView:(ContentScrollView *)contentScrollView
              showTableView:(UITableView *)tableView
          indexOfTableviews:(NSInteger)idx
{
    if (contentScrollView == _contentScrollView) {
        _curSelectedTableView = tableView;
        
        if (_contentTableView.contentOffset.y >= _contentTableView.tableHeaderView.bounds.size.height-FLOAT_SECTION_HEIGHT) {
            _contentTableView.contentOffset = CGPointMake(_curSelectedTableView.contentOffset.x, _curSelectedTableView.contentOffset.y+(_contentTableView.tableHeaderView.bounds.size.height-FLOAT_SECTION_HEIGHT));
            
            [_cookingView showView];
//            [_contentTableView setContentOffset:CGPointMake(_curSelectedTableView.contentOffset.x, _curSelectedTableView.contentOffset.y+(_contentTableView.tableHeaderView.bounds.size.height-FLOAT_SECTION_HEIGHT)) animated:NO];
        }
        
        if (tableView == _bookTableView && !_arrCookBook.count) {
            if (_contentTableView.contentOffset.y <= 0) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if ([_contentTableView.mj_header isRefreshing]) {
                        [_contentTableView.mj_header endRefreshing];
                    }
                    [_contentTableView.mj_header beginRefreshing];

                });
            } else {
                [self refreshContentCookData];
            }
            
        } else if (tableView == _productTableView && !_arrCookProduct.count) {
            
            if (_contentTableView.contentOffset.y <= 0) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    if ([_contentTableView.mj_header isRefreshing]) {
                        [_contentTableView.mj_header endRefreshing];
                    }
                    [_contentTableView.mj_header beginRefreshing];

                });
            } else {
                [self refreshContentCookData];
            }
        }
        
        
        if ((_curSelectedTableView == _bookTableView &&
             _arrCookBook.count) ||
            (_curSelectedTableView == _productTableView &&
             _arrCookProduct) ) {
                [_contentTableView reloadData];
            }
        
        [self updateTableRefreshFooter];
    } else if (contentScrollView == _searchRetContentView) {
        
        _curRetTableView = tableView;
        
        if (_searchRetContentView.isHidden) {
            return;
        }
        
        if ((_curRetTableView == _bookRetTable && !_arrBookSearch.count) ||
            (_curRetTableView == _productRetTable && !_arrProductSearch.count)) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if ([_curRetTableView.mj_header isRefreshing]) {
                    [_curRetTableView.mj_header endRefreshing];
                }
                [_curRetTableView.mj_header beginRefreshing];
            });
            
        }
        
    }
}

#pragma mark ContentViewDataSource
- (NSInteger)numberOfPagesInContentScrollView:(ContentScrollView *)contentScrollView
{
    if (contentScrollView == _contentScrollView) {
        return 2;
    } else if (contentScrollView == _searchRetContentView) {
        return 2;
    }
    return 0;
}

- (NSInteger)initialSelectedIndex:(ContentScrollView *)contentScrollView
{
    return 0;
}

- (NSInteger)titleBottomLineInsetX:(ContentScrollView *)contentScrollView
{
    return 0;
}

- (NSInteger)tableViewTopOffset:(ContentScrollView *)contentScrollView
{
    return -9;
}

- (NSMutableArray *)arrayTableViewForContentScrollView:(ContentScrollView *)contentScrollView
{
    NSMutableArray *arr = [NSMutableArray array];
    if (contentScrollView == _contentScrollView) {
        [self initCookBookTableView];
        [self initProductTableView];
        
        [arr addObject:_bookTableView];
        [arr addObject:_productTableView];
    } else if (contentScrollView == _searchRetContentView) {
        
        [self initProductRetTable];
        [self initBookRetTable];
        
        [arr addObject:_productRetTable];
        [arr addObject:_bookRetTable];
    }
   
    return arr;
}

- (NSMutableArray *)arrayButtonForContentScrollView:(ContentScrollView *)contentScrollView
{
    NSMutableArray *arr = [NSMutableArray array];
    if (contentScrollView == _contentScrollView) {
        NSArray *arrTitle = @[@"精 选", @"秀美食"];
        for (int i=0; i<arrTitle.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.backgroundColor = [UIColor clearColor];
            btn.tag = i;
            [btn setTitle:arrTitle[i] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont  systemFontOfSize:18];
            [btn setTitleColor:[UIColor colorWithHexString:@"#343434"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
            [arr addObject:btn];
        }
    } else if (contentScrollView == _searchRetContentView) {
        NSArray *arrTitle = @[@"作 品", @"菜谱"];
        for (int i=0; i<arrTitle.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.backgroundColor = [UIColor clearColor];
            btn.tag = i;
            [btn setTitle:arrTitle[i] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:18];;
            [btn setTitleColor:[UIColor colorWithHexString:@"#343434"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
            [arr addObject:btn];
        }
    }
    return arr;
}

#pragma mark - TopScrollViewDelegate

-(void)didSelectImageView:(NSDictionary *)dict
{
    if ([dict[@"category"] isEqualToString:@"web"])
    {
        WebViewController *webVC=[[WebViewController alloc]init];
        webVC.url=dict[@"source"];
        [self.navigationController pushViewController:webVC animated:YES];
    }
    else if ([dict[@"category"] isEqualToString:@"recipe"])
    {
        DetailContentViewController *detailContentVC=[[DetailContentViewController alloc]init];
        detailContentVC.dict= [CookBookReformer convertLocalBookDataFromNetBook:dict[@"source"]];
        detailContentVC.cookType=CookBookType;
        [self.navigationController pushViewController:detailContentVC animated:YES];
    }
    else if ([dict[@"category"] isEqualToString:@"dish"])
    {
        DetailContentViewController *detailContentVC=[[DetailContentViewController alloc]init];
        detailContentVC.dict= [CookProductReformer convertLocalProductDataFromNetProduct:dict[@"source"]];
        detailContentVC.cookType=CookProductType;
        [self.navigationController pushViewController:detailContentVC animated:YES];
    }
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFY_REFRESH_COOK_CUISINE object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFY_REFRESH_COOK_PRODUCT object:nil];
}


@end
