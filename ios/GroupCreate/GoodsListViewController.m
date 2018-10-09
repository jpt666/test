//
//  GoodsListViewController.m
//  CookBook
//
//  Created by 你好 on 16/8/10.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "GoodsListViewController.h"
#import "NavView.h"
#import "GoodsListTableViewCell.h"
#import "GoodListBottomView.h"
#import "MBProgressHUD+Helper.h"
#import "RetrieveRequest.h"
#import "GlobalVar.h"
#import "GoodsPropertyKeys.h"
#import "ParticipantPropertyKeys.h"
@interface GoodsListViewController ()<UITableViewDelegate,UITableViewDataSource,RetrieveRequestDelegate>

@end

@implementation GoodsListViewController
{
    NavView *_navView;
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    GoodListBottomView *_bottomView;
    
    RetrieveRequest * _summaryListRequest;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    _dataArray=[[NSMutableArray alloc]initWithCapacity:0];
    
    _navView=[[NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navView.centerLabel.text=@"商品总计";
    [_navView.leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_navView.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navView];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.tableFooterView=[UIView new];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
        
    _bottomView=[[GoodListBottomView  alloc]initWithFrame:CGRectMake(0, ScreenHeight-49, ScreenWidth, 49)];
    _bottomView.layer.borderColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.2].CGColor;
    _bottomView.layer.borderWidth=0.5f;
    [self.view addSubview:_bottomView];
    
    _bottomView.hidden=YES;
    
    _tableView.contentInset=UIEdgeInsetsMake(0, 0, 49, 0);

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!_dataArray.count) {
        [self refreshSummaryList];
    }
}

- (void)refreshSummaryList
{
    if (_summaryListRequest) {
        [_summaryListRequest cancel];
    }
    _summaryListRequest = [[RetrieveRequest alloc] init];
    _summaryListRequest.delegate = self;
    [_summaryListRequest getRequestWithUrl:[GlobalVar shareGlobalVar].bulkSummarysUrl andParam:[NSDictionary dictionaryWithObject:self.bulkId forKey:@"bulk_id"]];
}

#pragma mark - UITableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cellID";
    GoodsListTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil)
    {
        cell=[[GoodsListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSDictionary *dict=[_dataArray objectAtIndex:indexPath.row];
    [cell configData:dict];
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
    return 60.5;
}

#pragma mark - RetrieveRequestDelegate

-(void)didRetrieveDataSuccess:(RetrieveRequest *)request
{
    if (request == _summaryListRequest) {
        _dataArray = [NSMutableArray arrayWithArray:(NSArray *)request.rawData];
        [_tableView reloadData];
        
        NSInteger count=0;
        double  totalPrice=0;
        for (int i=0; i<_dataArray.count; i++)
        {
            NSDictionary *dict=[_dataArray objectAtIndex:i];
            count=count+[dict[kParticipantPropertyQuantity] integerValue];
            totalPrice=totalPrice+[dict[@"total_price"] doubleValue];
            
            if (i==_dataArray.count-1)
            {
                NSString *priceStr=[NSString stringWithFormat:@"¥ %.2f",totalPrice/100];
                _bottomView.totalLabel.text=[NSString stringWithFormat:@"%ld",count];
                _bottomView.totalPriceLabel.text=priceStr;
                _bottomView.hidden=NO;
            }
        }
    }
}

-(void)didRetrieveDataFailed:(RetrieveRequest *)request
{
    if (request == _summaryListRequest) {
        [MBProgressHUD showHUDAutoDismissWithError:request.error andDim:NO];
    }
}

#pragma mark - onEventAction

-(void)onEventAction:(AppEventType)type object:(id)object
{
    [super onEventAction:type object:object];
    
    
}

-(void)leftButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
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
