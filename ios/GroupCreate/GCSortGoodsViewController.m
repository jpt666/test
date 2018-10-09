//
//  GCSortGoodsViewController.m
//  CookBook
//
//  Created by zhangxi on 16/9/21.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "GCSortGoodsViewController.h"
#import "CreateGroupVC3.h"
#import "DetailGoodsTableCell.h"
#import "NavView.h"

@interface GCSortGoodsViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation GCSortGoodsViewController
{
    NavView *_navView;
    UITableView * _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavView];
    [self setupTableView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setupNavView
{
    _navView=[[NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navView.centerLabel.text=@"团购商品排序";
    [_navView.leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_navView.leftButton addTarget:self action:@selector(prevBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_navView.rightButton setTitle:@"下一步" forState:UIControlStateNormal];
    _navView.rightButton.frame=CGRectMake(ScreenWidth-70, 20, 60, 44);
    [_navView.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_navView.rightButton addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navView];
}

- (void)setupTableView
{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.editing = YES;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}


- (void)prevBtnClick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)nextBtnClick:(UIButton *)btn
{
    CreateGroupVC3 *createGroupVC3=[[CreateGroupVC3 alloc]init];
    createGroupVC3.selectedCategory = self.selectedCategory;
    createGroupVC3.bulkTitle = self.bulkTitle;
    createGroupVC3.selectedGoods = self.selectedGoods;
    
    [self.navigationController pushViewController:createGroupVC3 animated:YES];
}


#pragma mark - UITableViewDelgate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cellID";
    DetailGoodsTableCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];

    if (cell==nil)
    {
        cell=[[DetailGoodsTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID isEditable:YES];
    }
    
    NSDictionary *dict=[self.selectedGoods objectAtIndex:indexPath.row];
    [cell configData:dict];
    [cell setSequenceNum:indexPath.row+1];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.selectedGoods.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.5;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    id obj = [self.selectedGoods objectAtIndex:sourceIndexPath.row];
    [self.selectedGoods removeObject:obj];
    [self.selectedGoods insertObject:obj atIndex:destinationIndexPath.row];
    
    [_tableView reloadData];
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
