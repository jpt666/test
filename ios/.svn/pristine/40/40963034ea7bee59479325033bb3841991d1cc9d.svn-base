//
//  MyGroupBuyViewController.m
//  CookBook
//
//  Created by 你好 on 16/6/12.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "MyGroupBuyViewController.h"
#import "NavView.h"
#import "UserManager.h"
#import "GroupBuyTableViewCell.h"
#import "RetrieveBulkDataRequest.h"
#import "GroupsPropertyKeys.h"
#import "GroupsInfoReformer.h"
#import "MJRefresh.h"
#import "GoodsListViewController.h"
#import "CreateGroupVC1.h"
#import "GroupPurDetailViewController.h"
#import "MBProgressHUD+Helper.h"
#import "MCAlertView.h"
#import "AgreementViewController.h"
typedef NS_ENUM(NSInteger, BulkCreateStatus){
    BulkPublishManual = 0,
    BulkCommitOrder = 1,
    BulkOver = -1
};

@interface MyGroupBuyViewController()<UITableViewDelegate,UITableViewDataSource,RetrieveRequestDelegate,GroupBuyTableViewCellDelegate,MCALertviewDelegate>

@end

@implementation MyGroupBuyViewController
{
    NavView *_navView;
    UIImageView *_headImageView;
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    RetrieveBulkDataRequest *_bulkRefreshRequest;
    RetrieveBulkDataRequest *_bulkLoadMoreRequest;
    
    RetrieveBulkDataRequest *_deleteBulkRequest;
    RetrieveBulkDataRequest *_commitOrderRequest;
    RetrieveBulkDataRequest *_terminateBulkRequest;
    
    UIView * _hintLabelView;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    _dataArray=[[NSMutableArray alloc]initWithCapacity:0];
    [self.rdv_tabBarController setTabBarHidden:YES animated:NO];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _navView=[[NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navView.centerLabel.text=@"我的团";
    [_navView.leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_navView.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navView];
    
    if ([UserManager shareInstance].curUser.resellerId &&
        [UserManager shareInstance].curUser.resellerApplyState == StateApprove)
    {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView=[UIView new];
        _tableView.backgroundColor=RGBACOLOR(230, 230, 230, 1);
        _tableView.contentInset=UIEdgeInsetsMake(0, 0, -MJRefreshFooterHeight, 0);
        [self.view addSubview:_tableView];
    
        MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self refreshBulkData];
        }];
        [header setTitle:@"正在获取数据中..." forState:MJRefreshStateRefreshing];
        _tableView.mj_header = header;
        
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            if (!_dataArray.count) {
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
        
        
        _hintLabelView = [[UIView alloc] initWithFrame:CGRectMake(10, 120, _tableView.bounds.size.width-20, 80)];
        [_tableView addSubview:_hintLabelView];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _hintLabelView.bounds.size.width, _hintLabelView.bounds.size.height/2)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"还没有团购活动呢，快创建一个吧！";
        [_hintLabelView addSubview:label];
        
        _hintLabelView.hidden = YES;
        
        
        UIImage *image=[UIImage imageNamed:@"add"];
        UIButton *createButton=[UIButton buttonWithType:UIButtonTypeCustom];
        createButton.frame = CGRectMake(ScreenWidth-image.size.width-20, ScreenHeight-image.size.height-30, image.size.width, image.size.height);
        [createButton setBackgroundImage:image forState:UIControlStateNormal];
        createButton.adjustsImageWhenHighlighted=NO;
        [createButton addTarget:self action:@selector(createButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:createButton];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshBulkData) name:REFRESH_MY_GROUPBUY object:nil];
        
    }
    else
    {
//        UIImage *image=[UIImage imageNamed:@"toBe_grouper"];
//        _headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 154, ScreenWidth, ScreenWidth*image.size.height/image.size.width)];
//        _headImageView.image=image;
//        [self.view addSubview:_headImageView];
        _navView.rightButton.frame=CGRectMake(ScreenWidth-60, 20, 50, 44);
        [_navView.rightButton setImage:[UIImage imageNamed:@"applyForGrouper"] forState:UIControlStateNormal];
        [_navView.rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];

        UILabel *centerLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
        centerLabel.textAlignment=NSTextAlignmentCenter;
        centerLabel.userInteractionEnabled=YES;
        [self.view addSubview:centerLabel];
        
        NSString *string=[NSString stringWithFormat:@"申请成为团主,自己开团"];
        NSMutableAttributedString *attrStr=[[NSMutableAttributedString alloc]initWithString:string];
        [attrStr addAttributes:@{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle],NSForegroundColorAttributeName:[UIColor blueColor],NSStrokeColorAttributeName:[UIColor blueColor],NSFontAttributeName:[UIFont systemFontOfSize:22]} range:NSMakeRange(0, string.length)];
        centerLabel.attributedText=attrStr;
        
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rightButtonClick:)];
        tapGesture.numberOfTapsRequired=1;
        tapGesture.numberOfTouchesRequired=1;
        [centerLabel addGestureRecognizer:tapGesture];
    }

    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([UserManager shareInstance].curUser.resellerId)
    {
        if (!_dataArray.count) {
            [_tableView.mj_header beginRefreshing];
        }
    }
}

-(void)rightButtonClick:(UIButton *)button
{
    AgreementViewController *agreementVC=[[AgreementViewController alloc]init];
    [self.navigationController pushViewController:agreementVC animated:YES];
}


-(void)refreshBulkData
{
    if (_bulkRefreshRequest) {
        [_bulkRefreshRequest cancel];
    }
    
    _bulkRefreshRequest = [[RetrieveBulkDataRequest alloc] initWithReseller:[UserManager shareInstance].curUser.resellerId limitTime:0 count:10 keyword:nil url:[GlobalVar shareGlobalVar].bulkListUrl];
    _bulkRefreshRequest.delegate = self;
    [_bulkRefreshRequest request];
}



-(void)loadMoreBulkData
{
    if (_bulkLoadMoreRequest) {
        [_bulkLoadMoreRequest cancel];
    }
    _bulkLoadMoreRequest = [[RetrieveBulkDataRequest alloc] initWithReseller:[UserManager shareInstance].curUser.resellerId limitTime:[[[_dataArray lastObject] objectForKey:kGroupsPropertyDeadTime] longLongValue] count:10 keyword:nil url:[GlobalVar shareGlobalVar].bulkListUrl];
    _bulkLoadMoreRequest.delegate = self;
    [_bulkLoadMoreRequest request];
}

-(void)deleteBulkData:(NSDictionary *)dictBulk
{
    [MBProgressHUD showLoadingWithDim:YES];
    
    if (_deleteBulkRequest) {
        [_deleteBulkRequest cancel];
    }
    _deleteBulkRequest = [[RetrieveBulkDataRequest alloc] init];
    _deleteBulkRequest.extraData = dictBulk;
    _deleteBulkRequest.delegate = self;
    [_deleteBulkRequest deleteRequestWithUrl:dictBulk[kGroupsPropertyDetailUrl] andParam:nil];
}

-(void)commitOrderWithBulk:(NSDictionary *)dictBulk
{
    [MBProgressHUD showLoadingWithDim:YES];
    
    if (_commitOrderRequest) {
        [_commitOrderRequest cancel];
    }
    
    NSDictionary *dictparam = [NSDictionary dictionaryWithObject:@(GroupBuyCommitOrder) forKey:kGroupsPropertyStatus];
    
    _commitOrderRequest = [[RetrieveBulkDataRequest alloc] init];
    _commitOrderRequest.extraData = dictBulk;
    _commitOrderRequest.delegate = self;
    [_commitOrderRequest patchRequestWithUrl:dictBulk[kGroupsPropertyDetailUrl] andParam:dictparam];
}

-(void)termianteBulk:(NSDictionary *)dictBulk
{
    [MBProgressHUD showLoadingWithDim:YES];
    
    if (_terminateBulkRequest) {
        [_terminateBulkRequest cancel];
    }
    
    NSDictionary *dictparam = [NSDictionary dictionaryWithObject:@(GroupBuyTerminate) forKey:kGroupsPropertyStatus];
    
    _terminateBulkRequest = [[RetrieveBulkDataRequest alloc] init];
    _terminateBulkRequest.extraData = dictBulk;
    _terminateBulkRequest.delegate = self;
    [_terminateBulkRequest patchRequestWithUrl:dictBulk[kGroupsPropertyDetailUrl] andParam:dictparam];
}


-(void)showHintText:(BOOL)bShow
{
    _hintLabelView.hidden = !bShow;
}

#pragma mark - UITableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cellIDE";
    GroupBuyTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil)
    {
        cell=[[GroupBuyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    NSMutableDictionary *dict=[_dataArray objectAtIndex:indexPath.row];
    [cell configData:dict];
    cell.delegate = self;
    cell.tapView.delegate=self;

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScreenWidth/16*9+134.5+28+40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dict = [_dataArray objectAtIndex:indexPath.row];
//    if ([dict[kGroupsPropertyStatus] integerValue]==0)
    {
        GroupPurDetailViewController *groupPurDetailVC=[[GroupPurDetailViewController alloc]init];
        groupPurDetailVC.detailUrl = dict[kGroupsPropertyDetailUrl];
        [self.navigationController pushViewController:groupPurDetailVC animated:YES];
    }
}

-(void)groupTapViewClick:(GroupTapView *)tapView
{
    if ([tapView.dictBulkData[kGroupsPropertyStatus] integerValue] != GroupBuyNotStart) {
        GoodsListViewController *goodsListVC=[[GoodsListViewController alloc]init];
        goodsListVC.bulkId = tapView.dictBulkData[kGroupsPropertyId];
        [self.navigationController pushViewController:goodsListVC animated:YES];
    }
}


#pragma mark RetrieveDataDelegate

-(void)didRetrieveDataSuccess:(RetrieveRequest *)request
{
    if (request == _bulkRefreshRequest) {
        if ([_tableView.mj_header isRefreshing]) {
            [_tableView.mj_header endRefreshing];
        }
        
        NSMutableDictionary * dictResult = [_bulkRefreshRequest fetchDataWithReformer:[[GroupsInfoReformer alloc] init]];
        _dataArray = [NSMutableArray arrayWithArray:dictResult[@"result"]];
        
        [_tableView reloadData];
        
    } else if (request == _bulkLoadMoreRequest) {
        if ([_tableView.mj_footer isRefreshing]) {
            [_tableView.mj_footer endRefreshing];
        }
        
        NSMutableDictionary * dictResult = [_bulkLoadMoreRequest fetchDataWithReformer:[[GroupsInfoReformer alloc] init]];
        NSArray *arrRet = dictResult[@"result"];
        [_dataArray addObjectsFromArray:arrRet];
        
        [_tableView reloadData];
    } else if (request == _deleteBulkRequest) {
        [MBProgressHUD dismissHUD];
        
        [_dataArray removeObject:_deleteBulkRequest.extraData];
        _deleteBulkRequest.extraData = nil;
        _deleteBulkRequest = nil;
        [_tableView reloadData];
    } else if (request == _commitOrderRequest) {
        [MBProgressHUD dismissHUD];
        NSMutableDictionary * dictBulk = _commitOrderRequest.extraData;
        dictBulk[kGroupsPropertyStatus] = @(GroupBuyCommitOrder);
        [_tableView reloadData];
    } else if (request == _terminateBulkRequest) {
        [MBProgressHUD dismissHUD];
        NSMutableDictionary * dictBulk = _terminateBulkRequest.extraData;
        dictBulk[kGroupsPropertyStatus] = @(GroupBuyTerminate);
        [_tableView reloadData];
    }
    
    if (!_dataArray.count) {
        [self showHintText:YES];
    } else {
        [self showHintText:NO];
    }}


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
    } else if (request == _deleteBulkRequest ||
               request == _commitOrderRequest ||
               request == _terminateBulkRequest) {
        [MBProgressHUD showHUDAutoDismissWithError:request.error andDim:NO];
    }
    
    if (!_dataArray.count) {
        [self showHintText:YES];
    } else {
        [self showHintText:NO];
    }
}

#pragma mark - MCAlertViewDelegate
-(void)didClickWith:(MCAlertview *)alertView  buttonAtIndex:(NSUInteger)buttonIndex
{
    if (buttonIndex==2)
    {
        if (alertView.tag==1001)
        {
            [self commitOrderWithBulk:alertView.dict];
        }
        else if (alertView.tag==1002)
        {
            [self termianteBulk:alertView.dict];
        }
        else if (alertView.tag==1003)
        {
            [self deleteBulkData:alertView.dict];
        }
    }
}


#pragma mark - buttonClick
-(void)createButtonClick:(UIButton *)button
{
    CreateGroupVC1 *createGroupVC1=[[CreateGroupVC1 alloc]init];
    [self.navigationController pushViewController:createGroupVC1 animated:YES];
}

//发货中
-(void)deliverButtonClick:(GroupBuyTableViewCell *)cell
{
//#ifdef DEBUG
//    [self deleteBulkData:cell.dictData];
//#endif
}

//提交订单
-(void)submitButtonClick:(GroupBuyTableViewCell *)cell
{
    MCAlertview *mcAlertView=[[MCAlertview alloc]initWithMessage:@"确认提交订单?" CancelButton:@"取消" andCancelBtnBackGround:nil OkButton:@"确定" andOkBtnColor:nil];
    mcAlertView.delegate=self;
    mcAlertView.tag=1001;
    mcAlertView.dict=cell.dictData;
    [mcAlertView show];
//    [self commitOrderWithBulk:cell.dictData];
}

//终止团购
-(void)terminateButtonClick:(GroupBuyTableViewCell *)cell
{
    
    MCAlertview *mcAlertView=[[MCAlertview alloc]initWithMessage:@"确认终止团购?" CancelButton:@"取消" andCancelBtnBackGround:nil OkButton:@"确定" andOkBtnColor:nil];
    mcAlertView.delegate=self;
    mcAlertView.tag=1002;
    mcAlertView.dict=cell.dictData;
    [mcAlertView show];
    
//    [self termianteBulk:cell.dictData];
}

//删除团购
-(void)delButtonClick:(GroupBuyTableViewCell *)cell
{
    MCAlertview *mcAlertView=[[MCAlertview alloc]initWithMessage:@"确认删除团购?" CancelButton:@"取消" andCancelBtnBackGround:nil OkButton:@"确定" andOkBtnColor:nil];
    mcAlertView.delegate=self;
    mcAlertView.tag=1003;
    mcAlertView.dict=cell.dictData;
    [mcAlertView show];
    
//    [self deleteBulkData:cell.dictData];
}

//编辑团购
-(void)editButtonClick:(UIButton *)button
{
    
}


-(void)leftButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:REFRESH_MY_GROUPBUY object:nil];
}

@end
