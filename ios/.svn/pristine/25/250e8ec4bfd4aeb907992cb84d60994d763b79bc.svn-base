//
//  GroupPurchaseViewController.m
//  CookBook
//
//  Created by zhangxi on 16/4/11.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "GroupPurchaseViewController.h"
#import "CookBookProxy.h"
#import "CookProductProxy.h"
#import "CookDataManager.h"
#import "NavView.h"
#import "UICustomTextField.h"
#import "GroupPurchaseTableCell.h"
#import "GroupPurDetailViewController.h"
#import "RetrieveBulkDataRequest.h"
#import "GlobalVar.h"
#import "GroupsPropertyKeys.h"
#import "MJRefresh.h"
#import "GroupsInfoReformer.h"
#import "MBProgressHUD+Helper.h"
#import "IQkeyboardManager.h"


@interface GroupPurchaseViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,RetrieveRequestDelegate>

@end

@implementation GroupPurchaseViewController
{
    NavView *_navView;
    UIButton *_cancelSearchBtn;
    UICustomTextField *_searchTextField;
    UIImageView *_searchBackEditView;
    UITableView *_tableView;
    
    NSMutableArray * _arrBulks;
    
    RetrieveBulkDataRequest * _bulkRefreshRequest;
    RetrieveBulkDataRequest * _bulkLoadMoreRequest;
    
    UITableView * _searchRetTable;
    NSMutableArray * _arrSearchRet;
    RetrieveBulkDataRequest * _searchRequest;
    UIView * _searchLabelView;
    
    UITableView *_searchHintTable;
    NSMutableArray * _arrHintText;
}


-(instancetype)init
{
    self = [super init];
    if (self) {
        self.vcType = GroupPurchaseVcMain;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
    self.view.backgroundColor =RGBACOLOR(230, 230, 230, 1);
    
    _navView=[[NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navView.leftButton.hidden=YES;
    _navView.rightButton.hidden=YES;
    _navView.centerLabel.hidden=YES;
    [self.view addSubview:_navView];
    
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
    
    UIImage *searchImage=[UIImage imageNamed:@"search"];
    UIImageView *searchImageView=[[UIImageView alloc]initWithFrame:CGRectMake(5, (35-searchImage.size.height)/2, searchImage.size.width, searchImage.size.height)];
    searchImageView.image=searchImage;
    
    [[UITextField appearance] setTintColor:[UIColor whiteColor]];
    
    _searchTextField=[[UICustomTextField alloc]initWithFrame:CGRectMake(16, 22.5, ScreenWidth-32, 32.5)];
    _searchTextField.backgroundColor=[UIColor clearColor];
    _searchTextField.autocapitalizationType=UITextAutocapitalizationTypeNone;
    _searchTextField.autocorrectionType=UITextAutocorrectionTypeNo;
    _searchTextField.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@" 搜索团主、商品" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    _searchTextField.font=[UIFont systemFontOfSize:16];
    _searchTextField.textColor=[UIColor whiteColor];
    _searchTextField.delegate=self;
    _searchTextField.returnKeyType=UIReturnKeySearch;
    _searchTextField.leftView = searchImageView;
    _searchTextField.leftViewMode = UITextFieldViewModeUnlessEditing;
    [_navView addSubview:_searchTextField];
    

    [self setupBulkTableView];
    [self setupSearchTableView];
    
    if (self.vcType == GroupPurchaseVcMain) {
        [self setupSearchHintTableViewWithFrame:_searchRetTable.frame];
    }
    
    if (self.vcType == GroupPurchaseVcSearch) {
        [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
        
//        [_searchTextField becomeFirstResponder];
        _searchTextField.text = self.searchKey;
        
        [self willBeginSearch];
        [self startSearch];
    }
}


- (void)caneclSearch:(UIButton *)btn
{
//    [UIView animateWithDuration:0.1 animations:^{
//        _searchBackImageView.alpha = MIN((1-_contentTableView.contentOffset.y/(_contentTableView.tableHeaderView.bounds.size.height-FLOAT_SECTION_HEIGHT))*0.7,0.7);
//        
//        _searchBackEditView.alpha =MIN((_contentTableView.contentOffset.y/(_contentTableView.tableHeaderView.bounds.size.height-FLOAT_SECTION_HEIGHT))*0.7,0.7);
//    }];
    
    if (self.vcType == GroupPurchaseVcMain) {
        [_searchTextField resignFirstResponder];
        _searchTextField.text = nil;
        
        _searchHintTable.hidden = YES;
        _searchRetTable.hidden = YES;
        
        [self clearLastSearch];
        
        [self resizeSearchBar];
    } else if (self.vcType == GroupPurchaseVcSearch) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.vcType == GroupPurchaseVcMain) {
        [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
        
        if (!_arrBulks.count) {
            [_tableView.mj_header beginRefreshing];
        } else {
            //        [self refreshBulkData];
        }
        
    }
}

- (void)applicationDidBecomeActive:(NSNotification *)notify
{
    if (!_arrBulks.count) {
        [_tableView.mj_header beginRefreshing];
    } else {
//        [self refreshBulkData];
    }
}

- (void)setupBulkTableView
{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-49) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.contentInset=UIEdgeInsetsMake(0, 0, -MJRefreshFooterHeight, 0);
    _tableView.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    [self.view addSubview:_tableView];
    
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshBulkData];
    }];
    [header setTitle:@"正在获取数据中..." forState:MJRefreshStateRefreshing];
    _tableView.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            if (!_arrBulks.count) {
                [footer endRefreshing];
                return;
            }
        footer.mj_h = MJRefreshFooterHeight;
        [self loadMoreBulkData];

    }];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    footer.refreshingTitleHidden=YES;
    footer.automaticallyHidden=YES;
    _tableView.mj_footer = footer;
}


-(void)refreshBulkData
{
    if (_bulkRefreshRequest) {
        [_bulkRefreshRequest cancel];
    }
    _bulkRefreshRequest = [[RetrieveBulkDataRequest alloc] initWithLimitTime:0 count:10 url:[GlobalVar shareGlobalVar].bulkListUrl];
    _bulkRefreshRequest.delegate = self;
    [_bulkRefreshRequest request];
}



-(void)loadMoreBulkData
{
    if (_bulkLoadMoreRequest) {
        [_bulkLoadMoreRequest cancel];
    }
    _bulkLoadMoreRequest = [[RetrieveBulkDataRequest alloc] initWithLimitTime:[[[_arrBulks lastObject] objectForKey:kGroupsPropertyDeadTime] longLongValue] count:10 url:[GlobalVar shareGlobalVar].bulkListUrl];
    _bulkLoadMoreRequest.delegate = self;
    [_bulkLoadMoreRequest request];
}



- (void)setupSearchTableView
{
    CGFloat bottomBarHeight = 49;
    if (self.vcType == GroupPurchaseVcSearch) {
        bottomBarHeight = 0;
    }
    _searchRetTable=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-bottomBarHeight) style:UITableViewStylePlain];
    _searchRetTable.dataSource=self;
    _searchRetTable.delegate=self;
    _searchRetTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    _searchRetTable.contentInset=UIEdgeInsetsMake(0, 0, -MJRefreshFooterHeight, 0);
    _searchRetTable.hidden = YES;
    _searchRetTable.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    [self.view addSubview:_searchRetTable];
    
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self searchDataWithRefresh:YES];
    }];
    [header setTitle:@"正在获取数据中..." forState:MJRefreshStateRefreshing];
    _searchRetTable.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (!_arrSearchRet.count) {
            [footer endRefreshing];
            return;
        }
        [self searchDataWithRefresh:NO];
        
    }];
    
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    footer.refreshingTitleHidden=YES;
    footer.automaticallyHidden=YES;
    _searchRetTable.mj_footer = footer;
    
    
    _searchLabelView = [[UIView alloc] initWithFrame:CGRectMake(10, (_searchRetTable.bounds.size.height-10-80)/2, _searchRetTable.bounds.size.width-20, 80)];
    [_searchRetTable addSubview:_searchLabelView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _searchLabelView.bounds.size.width, _searchLabelView.bounds.size.height/2)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"暂未找到匹配的团购活动";
    [_searchLabelView addSubview:label];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, _searchLabelView.bounds.size.height/2, _searchLabelView.bounds.size.width, _searchLabelView.bounds.size.height/2)];
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:@"申请成为团主功能即将上线，敬请期待！"];
    NSRange contentRange = {0,[content length]};
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    
    label.attributedText = content;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = RGBACOLOR(176, 116, 67, 1);
    
    _searchLabelView.hidden = YES;
    
}

-(void)searchDataWithRefresh:(BOOL)bRefresh
{
    _searchLabelView.hidden = YES;
    if (_searchRequest) {
        [_searchRequest cancel];
    }
    
    long long limitTime = 0;
    if (_arrSearchRet.count && !bRefresh) {
        limitTime =[[[_arrSearchRet lastObject] objectForKey:kGroupsPropertyCreateTime] longLongValue];
    }
    
    _searchRequest = [[RetrieveBulkDataRequest alloc] initWithLimitTime:limitTime count:10 keyword:_searchTextField.text url:[GlobalVar shareGlobalVar].bulkListUrl];
    _searchRequest.delegate = self;
    [_searchRequest request];
}



- (void)clearLastSearch
{
    if(_searchRequest) {
        [_searchRequest cancel];
        _searchRequest = nil;
    }
    
    [_arrSearchRet removeAllObjects];
    [_searchRetTable reloadData];
}

- (void)setupSearchHintTableViewWithFrame:(CGRect)rect
{
    if (_searchHintTable) {
        return;
    }
    
    _searchHintTable = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    _searchHintTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _searchHintTable.delegate = self;
    _searchHintTable.dataSource = self;
    _searchHintTable.tableFooterView=[UIView new];
    _searchHintTable.hidden = YES;
    [self.view addSubview:_searchHintTable];
}

- (void)willBeginSearch
{
    [self resizeSearchBar];
    
    _searchHintTable.hidden = NO;
    [self.view bringSubviewToFront:_searchHintTable];
    _searchRetTable.hidden = NO;
    
    [UIView animateWithDuration:0.1 animations:^{
        _searchBackEditView.alpha = 0.7;
    }];
}

- (void)startSearch
{
    _searchHintTable.hidden = YES;
    [self clearLastSearch];
    if ([_searchRetTable.mj_header isRefreshing]) {
        [_searchRetTable.mj_header endRefreshing];
    }
    [_searchRetTable.mj_header beginRefreshing];
}

#pragma mark - UITableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_tableView)
    {
        static NSString *cellID=@"GroupPurchaseTableCell";
        GroupPurchaseTableCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        for (UIView *view in cell.contentView.subviews)
        {
            for (UIView *view1 in view.subviews)
            {
                [view1 removeFromSuperview];
            }
            [view removeFromSuperview];
        }
        cell=nil;
        if (cell==nil)
        {
            cell=[[GroupPurchaseTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        NSDictionary *dict=[_arrBulks objectAtIndex:indexPath.row];
        [cell configData:dict];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        static NSString *cellID=@"GroupPurchaseTableCell";
        GroupPurchaseTableCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        for (UIView *view in cell.contentView.subviews)
        {
            for (UIView *view1 in view.subviews)
            {
                [view1 removeFromSuperview];
            }
            [view removeFromSuperview];
        }
        cell=nil;
        if (cell==nil)
        {
            cell=[[GroupPurchaseTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        NSDictionary *dict=[_arrSearchRet objectAtIndex:indexPath.row];
        [cell configData:dict];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_tableView)
    {
        return ScreenWidth/16*9+134.5+28;
    }
    else if (tableView == _searchRetTable)
    {
        return ScreenWidth/16*9+134.5+28;
    }
    return 0;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==_tableView)
    {
        return 1;
    }
    else if (tableView == _searchRetTable)
    {
        return 1;
    }
    return 0;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_tableView)
    {
        return _arrBulks.count;
    }
    else if (tableView == _searchRetTable)
    {
        return _arrSearchRet.count;
    }
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableView)
    {
        NSDictionary * dict = [_arrBulks objectAtIndex:indexPath.row];
//        if ([dict[kGroupsPropertyStatus] integerValue]==0)
        {
            GroupPurDetailViewController *groupPurDetailVC=[[GroupPurDetailViewController alloc]init];
            groupPurDetailVC.detailUrl = dict[kGroupsPropertyDetailUrl];
            [self.navigationController pushViewController:groupPurDetailVC animated:YES];
        }
    } else if (tableView == _searchRetTable) {
        NSDictionary * dict = [_arrSearchRet objectAtIndex:indexPath.row];
//        if ([dict[kGroupsPropertyStatus] integerValue]==0)
        {
            GroupPurDetailViewController *groupPurDetailVC=[[GroupPurDetailViewController alloc]init];
            groupPurDetailVC.detailUrl = dict[kGroupsPropertyDetailUrl];
            [self.navigationController pushViewController:groupPurDetailVC animated:YES];
        }
    } else if (tableView == _searchHintTable) {
        _searchTextField.text = [_arrHintText objectAtIndex:indexPath.row];
        if (_searchTextField.text.length) {
            _searchHintTable.hidden = YES;
            [_searchRetTable.mj_header beginRefreshing];
        }
    }
}


#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField == _searchTextField) {
        if (_searchTextField.text.length) {
            [self startSearch];
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
        [self willBeginSearch];
    }
}



- (void)resizeSearchBar
{
    if (self.vcType == GroupPurchaseVcSearch) {
        _cancelSearchBtn.hidden = NO;
        _searchTextField.frame = CGRectMake(16, 22.5, ScreenWidth-32-55, 32.5);
        _searchBackEditView.frame = CGRectMake(_searchBackEditView.frame.origin.x, _searchBackEditView.frame.origin.y, ScreenWidth-20-55, _searchBackEditView.frame.size.height);
        
    } else if (self.vcType == GroupPurchaseVcMain) {
        if ([_searchTextField isFirstResponder]) {
            
            _cancelSearchBtn.hidden = NO;
            [UIView animateWithDuration:0.1 animations:^{
                _searchTextField.frame = CGRectMake(16, 22.5, ScreenWidth-32-55, 32.5);
            }];
            
            [UIView animateWithDuration:0.1 animations:^{
                _searchBackEditView.frame = CGRectMake(_searchBackEditView.frame.origin.x, _searchBackEditView.frame.origin.y, ScreenWidth-20-55, _searchBackEditView.frame.size.height);
            }];
        } else {
            _cancelSearchBtn.hidden = YES;
            [UIView animateWithDuration:0.1 animations:^{
                _searchTextField.frame = CGRectMake(16, 22.5, ScreenWidth-32, 32.5);
            }];
            
            [UIView animateWithDuration:0.1 animations:^{
                _searchBackEditView.frame = CGRectMake(_searchBackEditView.frame.origin.x, _searchBackEditView.frame.origin.y, ScreenWidth-20, _searchBackEditView.frame.size.height);
            }];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark RetrieveDataDelegate
-(void)didRetrieveDataSuccess:(RetrieveRequest *)request
{
    if (request == _bulkRefreshRequest) {
        
        if ([_tableView.mj_header isRefreshing]) {
            [_tableView.mj_header endRefreshing];
        }
        
        NSMutableDictionary * dictResult = [_bulkRefreshRequest fetchDataWithReformer:[[GroupsInfoReformer alloc] init]];
        _arrBulks = [NSMutableArray arrayWithArray:dictResult[@"result"]];
        
        [_tableView reloadData];
        
    } else if (request == _bulkLoadMoreRequest) {
        
        if ([_tableView.mj_footer isRefreshing]) {
            [_tableView.mj_footer endRefreshing];
        }
        
        NSMutableDictionary * dictResult = [_bulkLoadMoreRequest fetchDataWithReformer:[[GroupsInfoReformer alloc] init]];
        NSArray *arrRet = dictResult[@"result"];
        [_arrBulks addObjectsFromArray:arrRet];
        
        [_tableView reloadData];
        
    } else if (request == _searchRequest) {
        
        if ([_searchRetTable.mj_header isRefreshing]) {
            [_searchRetTable.mj_header endRefreshing];
            [_arrSearchRet removeAllObjects];
        }
        
        if ([_searchRetTable.mj_footer isRefreshing]) {
            [_searchRetTable.mj_footer endRefreshing];
        }
        
        NSMutableDictionary * dictResult = [_searchRequest fetchDataWithReformer:[[GroupsInfoReformer alloc] init]];
        NSArray *arrRet = dictResult[@"result"];
        
        if (!_arrSearchRet) {
            _arrSearchRet = [NSMutableArray array];
        }
        
        [_arrSearchRet addObjectsFromArray:arrRet];
        
        if (!_arrSearchRet.count) {
            _searchLabelView.hidden = NO;
        }
        [_searchRetTable reloadData];
        
    }
}

-(void)didRetrieveDataFailed:(RetrieveRequest *)request
{
    if (request == _bulkRefreshRequest) {
        if ([_tableView.mj_header isRefreshing]) {
            [_tableView.mj_header endRefreshing];
        }
    } else if (request == _bulkLoadMoreRequest) {
        if ([_tableView.mj_footer isRefreshing]) {
            [_tableView.mj_footer endRefreshing];
        }
    } else if (request == _searchRequest) {
        if ([_searchRetTable.mj_header isRefreshing]) {
            [_searchRetTable.mj_header endRefreshing];
        }
        if ([_searchRetTable.mj_footer isRefreshing]) {
            [_searchRetTable.mj_footer endRefreshing];
        }
    }
    
    [MBProgressHUD showHUDAutoDismissWithError:request.error andDim:NO];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
