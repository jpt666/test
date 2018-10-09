//
//  CreateGroupVC2.m
//  CookBook
//
//  Created by 你好 on 16/8/11.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "CreateGroupVC2.h"
#import "NavView.h"
#import "DetailGoodsTableCell.h"
#import "RetrieveRequest.h"
#import "GlobalVar.h"
#import "GoodsCategoryPropertyKeys.h"
#import "MBProgressHUD+Helper.h"
#import "GCSortGoodsViewController.h"

@interface CreateGroupVC2 ()<UITableViewDelegate,UITableViewDataSource,RetrieveRequestDelegate>

@end

@implementation CreateGroupVC2
{
    NavView *_navView;
    UITableView *_tableView;
    UIView *_bottomView;
    NSMutableArray *_dataArray;
    
    RetrieveRequest * _goodsListRequest;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dataArray=[[NSMutableArray alloc]initWithCapacity:0];
    
    _navView=[[NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navView.centerLabel.text=@"选择团购商品";
    [_navView.leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_navView.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_navView.rightButton setTitle:@"下一步" forState:UIControlStateNormal];
    _navView.rightButton.frame=CGRectMake(ScreenWidth-70, 20, 60, 44);
    [_navView.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_navView.rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navView];

    _bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-49, ScreenWidth, 49)];
    _bottomView.backgroundColor=[UIColor whiteColor];
    _bottomView.layer.borderWidth=0.5;
    _bottomView.layer.borderColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.3].CGColor;
    [self.view addSubview:_bottomView];
    
    UIButton *selectAllBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    selectAllBtn.frame=CGRectMake(0, 0, _bottomView.bounds.size.width/2-0.25, _bottomView.bounds.size.height);
    [selectAllBtn setTitle:@"全选" forState:UIControlStateNormal];
    [selectAllBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [selectAllBtn addTarget:self action:@selector(selectAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:selectAllBtn];
    
    UIButton *disSelectAllBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    disSelectAllBtn.frame=CGRectMake(_bottomView.bounds.size.width/2+0.25, 0, _bottomView.bounds.size.width/2-0.25, _bottomView.bounds.size.height);
    [disSelectAllBtn setTitle:@"全不选" forState:UIControlStateNormal];
    [disSelectAllBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [disSelectAllBtn addTarget:self action:@selector(disSelectAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:disSelectAllBtn];
    
    UIView *centerLineView=[[UIView alloc]initWithFrame:CGRectMake(_bottomView.bounds.size.width/2-0.25, 0, 0.5, _bottomView.bounds.size.height)];
    centerLineView.backgroundColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.3];
    [_bottomView addSubview:centerLineView];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-49) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if (!_dataArray.count) {
        [self refreshGoodsList];
    }
}

-(void)selectAllBtnClick:(UIButton *)button
{
    for (NSMutableDictionary *dict in _dataArray)
    {
        if ([[dict objectForKey:@"isSelected"] boolValue]==NO)
        {
            [dict setObject:[NSNumber numberWithInt:YES] forKey:@"isSelected"];
        }
    }
    [_tableView reloadData];
}

-(void)disSelectAllBtnClick:(UIButton *)button
{
    for (NSMutableDictionary *dict in _dataArray)
    {
        if ([[dict objectForKey:@"isSelected"] boolValue]==YES)
        {
            [dict setObject:[NSNumber numberWithInt:NO] forKey:@"isSelected"];
        }
    }
    [_tableView reloadData];
}

-(void)refreshGoodsList
{
    [MBProgressHUD showLoadingWithDim:NO];
    if (_goodsListRequest) {
        [_goodsListRequest cancel];
    }
    _goodsListRequest = [[RetrieveRequest alloc] init];
    _goodsListRequest.delegate = self;
    [_goodsListRequest getRequestWithUrl:[GlobalVar shareGlobalVar].listInCategoryUrl andParam:[NSDictionary dictionaryWithObject:self.selectedCategory[kGoodsCategoryPropertyId] forKey:@"category"]];
}


-(void)leftButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightButtonClick:(UIButton *)button
{
    NSArray * arr = [_dataArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"%K=%@",@"isSelected",[NSNumber numberWithBool:YES]]];
    if (arr.count <= 0) {
        [MBProgressHUD showHUDAutoDismissWithString:@"未选择商品" andDim:NO];
        return;
    }
    
    GCSortGoodsViewController * sortVc = [[GCSortGoodsViewController alloc] init];
    sortVc.bulkTitle = self.bulkTitle;
    sortVc.selectedCategory = self.selectedCategory;
    sortVc.selectedGoods = [NSMutableArray arrayWithArray:arr];
    
    [self.navigationController pushViewController:sortVc animated:YES];
}


#pragma mark - UITableViewDelgate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cellID";
    DetailGoodsTableCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil)
    {
        cell=[[DetailGoodsTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID isEditable:NO];
    }
    
    NSDictionary *dict=[_dataArray objectAtIndex:indexPath.row];
    [cell configData:dict];
    if ([[dict objectForKey:@"isSelected"] boolValue])
    {
        cell.bottomImageView.image=[UIImage imageNamed:@"selected_green_icon"];
    }
    else
    {
        cell.bottomImageView.image=[UIImage imageNamed:@"normal_round_icon"];
    }
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
    return 80.5;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *dictory=[_dataArray objectAtIndex:indexPath.row];
    if ([[dictory objectForKey:@"isSelected"] boolValue])
    {
        [dictory setObject:[NSNumber numberWithBool:NO] forKey:@"isSelected"];
    }
    else
    {
        [dictory setObject:[NSNumber numberWithBool:YES] forKey:@"isSelected"];
    }
    [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}


#pragma mark - RetrieveRequestDelegate
-(void)didRetrieveDataSuccess:(RetrieveRequest *)request
{
    if (request == _goodsListRequest) {
        _dataArray = [NSMutableArray arrayWithArray:(NSArray *)_goodsListRequest.rawData];
        for (NSMutableDictionary *dict in _dataArray) {
            [dict setObject:[NSNumber numberWithBool:NO] forKey:@"isSelected"];
        }
        [_tableView reloadData];
        
        [MBProgressHUD dismissHUD];
    }
}

-(void)didRetrieveDataFailed:(RetrieveRequest *)request
{
    if (request == _goodsListRequest) {
        [MBProgressHUD showHUDAutoDismissWithError:request.error andDim:NO];
    }
}



#pragma mark - onEventAction

-(void)onEventAction:(AppEventType)type object:(id)object
{
    [super onEventAction:type object:object];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
