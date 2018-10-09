//
//  CreateGroupVC1.m
//  CookBook
//
//  Created by 你好 on 16/8/10.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "CreateGroupVC1.h"
#import "NavView.h"
#import "SingleSelectTableCell.h"
#import "CreateGroupVC2.h"
#import "RetrieveRequest.h"
#import "GlobalVar.h"
#import "MBProgressHUD+Helper.h"
#import "GoodsCategoryPropertyKeys.h"
@interface CreateGroupVC1 ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,RetrieveRequestDelegate>

@end

@implementation CreateGroupVC1
{
    NavView *_navView;
    UITableView *_tableView;
    UITextField *_titleTextField;
    RetrieveRequest * _retrieveCategory;
    NSArray * _arrCategory;
    NSDictionary * _selectedCategory;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    
    _navView=[[NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navView.centerLabel.text=@"创建团购";
    [_navView.leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_navView.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_navView.rightButton setTitle:@"下一步" forState:UIControlStateNormal];
    _navView.rightButton.frame=CGRectMake(ScreenWidth-70, 20, 60, 44);
    [_navView.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_navView.rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navView];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    [self.view addSubview:_tableView];
    
    UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 60.5)];

    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    [headView addSubview:topView];
    
    UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, 10 , ScreenWidth, 50.5)];
    bottomView.backgroundColor=[UIColor whiteColor];
    
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, bottomView.bounds.size.width-10, bottomView.bounds.size.height)];
    titleLabel.text=@"团购类别";
    [bottomView addSubview:titleLabel];
    
    UIView *bottomLineView=[[UIView alloc]initWithFrame:CGRectMake(10, bottomView.bounds.size.height-0.5, bottomView.bounds.size.width-20, 0.5)];
    bottomLineView.backgroundColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.3];
    [bottomView addSubview:bottomLineView];
    
    [headView addSubview:bottomView];
    
    UIView *footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 120)];
    
    UIView *topView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    [footView addSubview:topView1];
    
    UIView *bottomView1=[[UIView alloc]initWithFrame:CGRectMake(0, 10 , ScreenWidth, 100.5)];
    bottomView1.backgroundColor=[UIColor whiteColor];
    
    UILabel *titleLabel1=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, bottomView1.bounds.size.width-10, 50)];
    titleLabel1.text=@"团购标题";
    [bottomView1 addSubview:titleLabel1];
    
    UIView *bottomLineView1=[[UIView alloc]initWithFrame:CGRectMake(10, 50, bottomView1.bounds.size.width-20, 0.5)];
    bottomLineView1.backgroundColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.3];
    [bottomView1 addSubview:bottomLineView1];
    
    _titleTextField=[[UITextField alloc]initWithFrame:CGRectMake(10, bottomLineView1.frame.origin.y+bottomLineView1.frame.size.height, ScreenWidth-20, 50)];
    _titleTextField.autocorrectionType=UITextAutocorrectionTypeNo;
    _titleTextField.autocapitalizationType=UITextAutocapitalizationTypeNone;
    _titleTextField.delegate=self;
    _titleTextField.placeholder=@"全网低价，优质高端团购活动";
    [bottomView1 addSubview:_titleTextField];
    
    [bottomView1 bringSubviewToFront:bottomLineView1];
    
    [footView addSubview:bottomView1];

    _tableView.tableHeaderView=headView;

    _tableView.tableFooterView=footView;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!_arrCategory) {
        [self refreshCategory];
    }
}

-(void)refreshCategory
{
    [MBProgressHUD showLoadingWithDim:NO];
    if (_retrieveCategory) {
        [_retrieveCategory cancel];
    }
    
    _retrieveCategory = [[RetrieveRequest alloc] init];
    _retrieveCategory.delegate = self;
    [_retrieveCategory getRequestWithUrl:[GlobalVar shareGlobalVar].productCategoryUrl andParam:nil];
}


#pragma mark - UITableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cellID";
    SingleSelectTableCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil)
    {
        cell=[[SingleSelectTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    NSDictionary *dict = [_arrCategory objectAtIndex:indexPath.row];
    cell.titleLabel.text= dict[kGoodsCategoryPropertyName];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrCategory.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.5;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedCategory = [_arrCategory objectAtIndex:indexPath.row];
}


-(void)rightButtonClick:(UIButton *)button
{
    [_titleTextField resignFirstResponder];
    
    if (!_selectedCategory)
    {
        [MBProgressHUD showHUDAutoDismissWithString:@"未选择类别" andDim:NO];
        return;
    }

    CreateGroupVC2 *createGroupVC2=[[CreateGroupVC2 alloc]init];
    createGroupVC2.selectedCategory = _selectedCategory;
    createGroupVC2.bulkTitle = (_titleTextField.text.length?_titleTextField.text:_titleTextField.placeholder);
    [self.navigationController pushViewController:createGroupVC2 animated:YES];
}


-(void)leftButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)onEventAction:(AppEventType)type object:(id)object
{
    [super onEventAction:type object:object];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark RetrieveRequestDelegate
-(void)didRetrieveDataSuccess:(RetrieveRequest *)request
{
    if (request == _retrieveCategory)
    {
        _arrCategory = [request.rawData copy];
        _selectedCategory = [_arrCategory objectAtIndex:0];
        [_tableView reloadData];
        
        if (_arrCategory.count > 0) {
            [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
        [MBProgressHUD dismissHUD];
    }
}

-(void)didRetrieveDataFailed:(RetrieveRequest *)request
{
    if (request == _retrieveCategory) {
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
