//
//  DraftsViewController.m
//  CookBook
//
//  Created by 你好 on 16/6/12.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "DraftsViewController.h"
#import "NavView.h"
#import "DraftTableViewCell.h"
#import "CookDataManager.h"
#import "CookBaseProxy.h"
#import "MenuEditorViewController.h"
#import "MBProgressHUD+Helper.h"
//#import <SVProgressHUD.h>

@interface DraftsViewController()<UITableViewDelegate,UITableViewDataSource,CookDataManagerDelegate>

@end

@implementation DraftsViewController
{
    NavView *_navView;
    UITableView *_tableView;
    NSArray * _arrCookDraft;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.rdv_tabBarController setTabBarHidden:YES animated:NO];

    self.view.backgroundColor=[UIColor whiteColor];
    
    _navView=[[NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navView.centerLabel.text=@"草稿箱";
    [_navView.leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_navView.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navView];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.backgroundColor = RGBACOLOR(230, 230, 230, 1);
    _tableView.delegate=self;
    _tableView.rowHeight=120;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView=[UIView new];
    [self.view addSubview:_tableView];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [CookDataManager shareInstance].delegate=self;
    [self refeshDraftData];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}


-(void)leftButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)refeshDraftData
{
    _arrCookDraft = [[[CookDataManager shareInstance] retrieveCookDataDrafts] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        CookBaseProxy *b1 = obj1;
        CookBaseProxy *b2 = obj2;
        if ([b1 editTime] == [b2 editTime]) {
            return NSOrderedSame;
        } else if ([b1 editTime] > [b2 editTime]) {
            return NSOrderedAscending;
        } else {
            return NSOrderedDescending;
        }
        
    }];
    [_tableView reloadData];
}



#pragma mark CookDataManagerDelegate

-(void)didLocalCookDataChanged:(CookDataManager *)cookDataMng
{
    [self refeshDraftData];
}

-(void)didCookDataUploadProgressChanged:(CookBaseProxy *)cookBaseProxy
{
    NSInteger index = [_arrCookDraft indexOfObject:cookBaseProxy];
    
    DraftTableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    if (cell) {
        [cell setUploadProgress:cookBaseProxy.uploadingProgress];
    }
    
    //    [_draftTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}



#pragma mark - UITableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"DraftTableViewCell";
    DraftTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil)
    {
        cell=[[DraftTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID andRowHeight:_tableView.rowHeight];
    }
    [cell setupWithCookData:[_arrCookDraft objectAtIndex:indexPath.row]];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
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


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CookBaseProxy * cbProxy = [_arrCookDraft objectAtIndex:indexPath.row];
    if (cbProxy.cookDataStatus == CookDataStatusUploading) {
//        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
//        [SVProgressHUD setMinimumDismissTimeInterval:1.5f];
//        [SVProgressHUD showInfoWithStatus:@"数据正在上传中！"];
        [MBProgressHUD showHUDAutoDismissWithString:@"数据正在上传中！" andDim:NO];
    } else {
        MenuEditorViewController *menuVc = [[MenuEditorViewController alloc] init];
        menuVc.cookProxy = cbProxy;
        menuVc.bFromDraft = YES;
        [self.navigationController pushViewController:menuVc animated:YES];
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrCookDraft.count;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
