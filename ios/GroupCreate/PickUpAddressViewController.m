//
//  PickUpAddressViewController.m
//  CookBook
//
//  Created by 你好 on 16/8/11.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "PickUpAddressViewController.h"
#import "NavView.h"
#import "PickUpAddressView.h"
#import "PickUpTableViewCell.h"
#import "SelectPickUpTableCell.h"
#import "EditPickUpAddressViewController.h"
#import "RetrieveRequest.h"
#import "GlobalVar.h"
#import "MBProgressHUD+Helper.h"
#import "GroupsPropertyKeys.h"

@interface PickUpAddressViewController ()<PickUpAddressViewDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,RetrieveRequestDelegate,SelectPickUpTableCellDelegate>

@end

@implementation PickUpAddressViewController
{
    NavView *_navView;
    UITableView *_fixedTableView;
    UITableView *_tempTableView;
    UIView *_topView;
    PickUpAddressView *_pickUpAddressView;
    UIScrollView *_contetnScrollView;
    UIButton *_bottomButton;
    
    RetrieveRequest * _storageRequest;
    
    NSMutableArray *_arrFixedAddr;
    NSMutableArray *_arrTempAddr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    
    _navView=[[NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navView.centerLabel.text=@"自提点";
    [_navView.leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_navView.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navView];
    
    _pickUpAddressView=[[PickUpAddressView alloc]initWithFrame:CGRectMake(0, 74, ScreenWidth, 50)];
    _pickUpAddressView.layer.borderWidth=0.5;
    _pickUpAddressView.delegate=self;
    _pickUpAddressView.layer.borderColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.3].CGColor;
    _pickUpAddressView.leftButton.selected=YES;
    [self.view addSubview:_pickUpAddressView];
    
    _contetnScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 124, ScreenWidth, ScreenHeight-124)];
    _contetnScrollView.showsHorizontalScrollIndicator=NO;
    _contetnScrollView.showsVerticalScrollIndicator=NO;
    _contetnScrollView.bounces=NO;
    _contetnScrollView.pagingEnabled=YES;
    _contetnScrollView.delegate=self;
    _contetnScrollView.contentSize=CGSizeMake(_contetnScrollView.bounds.size.width*2, _contetnScrollView.bounds.size.height);
    [self.view addSubview:_contetnScrollView];
    
    _fixedTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, _contetnScrollView.bounds.size.width,_contetnScrollView.bounds.size.height) style:UITableViewStylePlain];
    _fixedTableView.dataSource=self;
    _fixedTableView.delegate=self;
    _fixedTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _fixedTableView.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    [_contetnScrollView addSubview:_fixedTableView];
    
    _tempTableView=[[UITableView alloc]initWithFrame:CGRectMake(_contetnScrollView.bounds.size.width, 0, _contetnScrollView.bounds.size.width,_contetnScrollView.bounds.size.height-50) style:UITableViewStylePlain];
    _tempTableView.dataSource=self;
    _tempTableView.delegate=self;
    _tempTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tempTableView.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    [_contetnScrollView addSubview:_tempTableView];
    
    
    _bottomButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _bottomButton.frame=CGRectMake(_contetnScrollView.bounds.size.width, _contetnScrollView.bounds.size.height-50, ScreenWidth, 50);
    [_bottomButton addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _bottomButton.backgroundColor=RGBACOLOR(176, 116, 67, 1);
    [_bottomButton setTitle:@"创建新的自提点" forState:UIControlStateNormal];
    [_bottomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_contetnScrollView addSubview:_bottomButton];
    
    if (!self.selectedAddr.count) {
        self.selectedAddr = [NSMutableArray array];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!_arrFixedAddr.count && !_arrTempAddr.count) {
        [self retrieveStorages];
    }
}

-(void)removeDictionary:(NSDictionary *)dict FromArray:(NSMutableArray *)array
{
    NSDictionary *refDict = nil;
    for (NSDictionary *d in array) {
        if (d[kDispatcherPropertyId] &&
            dict[kDispatcherPropertyId] && (
            [d[kDispatcherPropertyId] integerValue] ==
            [dict[kDispatcherPropertyId] integerValue])) {
                refDict = d;
                break;
            }
    }
    
    if (refDict) {
        [array removeObject:refDict];
    }
}

-(BOOL)isExistInSelected:(NSDictionary *)dict
{
    for (NSDictionary *d in self.selectedAddr) {
        if (d[kDispatcherPropertyId] &&
            dict[kDispatcherPropertyId] && (
            [d[kDispatcherPropertyId] integerValue] ==
            [dict[kDispatcherPropertyId] integerValue])) {
            return YES;
        }
    }
    return NO;
}

-(void)retrieveStorages
{
    [MBProgressHUD showLoadingWithDim:YES];
    
    if (_storageRequest) {
        [_storageRequest cancel];
    }
    _storageRequest = [[RetrieveRequest alloc] init];
    _storageRequest.delegate = self;
    [_storageRequest getRequestWithUrl:[GlobalVar shareGlobalVar].storagesUrl andParam:nil];
}

-(void)leftButtonClick:(UIButton *)button
{
    if (self.selectComplete) {
        self.selectComplete(_selectedAddr);
        self.selectComplete = nil;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightButtonClick:(UIButton *)button
{
    if (self.selectComplete) {
        self.selectComplete(_selectedAddr);
        self.selectComplete = nil;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)bottomButtonClick:(UIButton *)button
{
    EditPickUpAddressViewController *editPickUpAddressVC=[[EditPickUpAddressViewController alloc]init];
    editPickUpAddressVC.addressType=CreateAddress;
    editPickUpAddressVC.createFinish = ^(NSDictionary *dict){
        [self retrieveStorages];
    };
    [self.navigationController pushViewController:editPickUpAddressVC animated:YES];
}



#pragma mark - UITableViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView==_contetnScrollView)
    {
        int index=scrollView.contentOffset.x/ScreenWidth;
        if (index==0)
        {
            [_pickUpAddressView setLeftButtonSeleted];
        }
        else if (index==1)
        {
            [_pickUpAddressView setRightButtonSeleted];
        }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_fixedTableView)
    {
        static NSString *cellID=@"fixedCellID";
        SelectPickUpTableCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil)
        {
            cell=[[SelectPickUpTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.delegate = self;
        cell.editButton.hidden=YES;
        
        NSDictionary *dict = [_arrFixedAddr objectAtIndex:indexPath.row];
        [cell configData:dict];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        [cell setChecked:[self isExistInSelected:dict]];

        return cell;
    }
    else if (tableView==_tempTableView)
    {
        static NSString *cellID=@"tempCellID";
        SelectPickUpTableCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil)
        {
            cell=[[SelectPickUpTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.delegate = self;
        
        
        NSDictionary * dict = [_arrTempAddr objectAtIndex:indexPath.row];
        [cell configData:dict];
        cell.addressLabel.frame=CGRectMake(cell.locationImageView.frame.origin.x+cell.locationImageView.frame.size.width+5, cell.typeLabel.frame.origin.y+cell.typeLabel.frame.size.height+5, ScreenWidth-cell.locationImageView.frame.origin.x-cell.locationImageView.frame.size.width-15-cell.editButton.frame.size.width, 20);

        [cell setChecked:[self isExistInSelected:dict]];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _fixedTableView) {
        NSDictionary * dict = [_arrFixedAddr objectAtIndex:indexPath.row];
        if ([self isExistInSelected:dict]) {
            [self removeDictionary:dict FromArray:self.selectedAddr];
        } else {
            [self.selectedAddr addObject:dict];
        }
        
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    } else if (tableView == _tempTableView) {
        NSDictionary * dict = [_arrTempAddr objectAtIndex:indexPath.row];
        if ([self isExistInSelected:dict]) {
            [self removeDictionary:dict FromArray:self.selectedAddr];
        } else {
            [self.selectedAddr addObject:dict];
        }
        
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_fixedTableView)
    {
        return _arrFixedAddr.count;
    }
    else if (tableView==_tempTableView)
    {
        return _arrTempAddr.count;
    }
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.5;
}

-(void)editButtonClicked:(SelectPickUpTableCell *)cell
{
    EditPickUpAddressViewController *editPickUpAddressVC=[[EditPickUpAddressViewController alloc]init];
    editPickUpAddressVC.addressType=EditAddress;
    editPickUpAddressVC.editFinish = ^(NSDictionary * dict){
        [self removeDictionary:dict FromArray:_arrTempAddr];
        [_arrTempAddr addObject:dict];
        
        [self removeDictionary:dict FromArray:self.selectedAddr];
        [self.selectedAddr addObject:dict];
        [_tempTableView reloadData];
    };
    
    editPickUpAddressVC.deleteFinish = ^(NSDictionary *dict) {
        [self removeDictionary:dict FromArray:_arrTempAddr];
        [self removeDictionary:dict FromArray:self.selectedAddr];
        [_tempTableView reloadData];
    };
    editPickUpAddressVC.dictOrg = cell.dict;
    [self.navigationController pushViewController:editPickUpAddressVC animated:YES];
}

-(void)fixedButtonClick:(PickUpAddressView *)pickUpView
{
    [_contetnScrollView scrollRectToVisible:CGRectMake(0, 0, _contetnScrollView.bounds.size.width, _contetnScrollView.bounds.size.height) animated:YES];
}

-(void)tempButtonClick:(PickUpAddressView *)pickUpView
{
    [_contetnScrollView scrollRectToVisible:CGRectMake(_contetnScrollView.bounds.size.width, 0,_contetnScrollView.bounds.size.width, _contetnScrollView.bounds.size.height) animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark RetrieveRequestDelegate

-(void)didRetrieveDataSuccess:(RetrieveRequest *)request
{
    if (_storageRequest == request) {
        
        [MBProgressHUD dismissHUD];
        
        NSArray *arr = (NSArray*)request.rawData;
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K=0",kDispatcherPropertyIsCustom];
        _arrFixedAddr = [NSMutableArray arrayWithArray:[arr filteredArrayUsingPredicate:predicate]];
        
        predicate = [NSPredicate predicateWithFormat:@"%K=1",kDispatcherPropertyIsCustom];
        _arrTempAddr = [NSMutableArray arrayWithArray:[arr filteredArrayUsingPredicate:predicate]];
        
        [_fixedTableView reloadData];
        [_tempTableView reloadData];
    }
}

-(void)didRetrieveDataFailed:(RetrieveRequest *)request
{
    if (_storageRequest == request) {
        [MBProgressHUD showHUDAutoDismissWithError:request.error andDim:NO];
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

@end
