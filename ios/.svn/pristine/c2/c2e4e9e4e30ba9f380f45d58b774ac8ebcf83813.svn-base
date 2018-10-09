//
//  OrderRecordViewController.m
//  CookBook
//
//  Created by 你好 on 16/6/6.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "OrderRecordViewController.h"
#import "NavView.h"
#import "OrderRecordTableCell.h"
#import "RetrieveBulkDataRequest.h"
#import "ParticipantPropertyKeys.h"
#import "ParticipantReformer.h"
#import "MBProgressHUD+Helper.h"

@interface OrderRecordViewController()<UITableViewDelegate,UITableViewDataSource,RetrieveRequestDelegate>

@end

@implementation OrderRecordViewController
{
    NavView *_navView;
    UITableView *_tableView;
    
    NSMutableArray * _arrParticipants;
    RetrieveBulkDataRequest * _participantRequest;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    _navView=[[NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navView.centerLabel.text=@"成交记录";
    [_navView.leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_navView.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navView];
    
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!_arrParticipants.count) {
        [MBProgressHUD showLoadingWithDim:NO];
    }
    
    [self refreshParticipants];
    
}

-(void)leftButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)refreshParticipants
{
    if (_participantRequest) {
        [_participantRequest cancel];
    }
    _participantRequest = [[RetrieveBulkDataRequest alloc] initWithUrl:self.orderListUrl];
    _participantRequest.delegate = self;
    [_participantRequest request];
}


#pragma mark - UITableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cellID";
    OrderRecordTableCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil)
    {
        cell=[[OrderRecordTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    NSDictionary * dict = [_arrParticipants objectAtIndex:indexPath.row];
    [cell configData:dict];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrParticipants.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)didRetrieveDataSuccess:(RetrieveRequest *)request
{
    if (request == _participantRequest) {
        [MBProgressHUD dismissHUD];
        
        NSDictionary * dict = [_participantRequest fetchDataWithReformer:[[ParticipantReformer alloc] init]];
        _arrParticipants = [NSMutableArray arrayWithArray:dict[@"result"]];
        [_tableView reloadData];
    }
}

-(void)didRetrieveDataFailed:(RetrieveRequest *)request
{
    if (request == _participantRequest) {
        
    }
    [MBProgressHUD showHUDAutoDismissWithError:request.error andDim:NO];
}

@end
