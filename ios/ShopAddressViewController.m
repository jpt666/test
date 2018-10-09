//
//  ShopAddressViewController.m
//  CookBook
//
//  Created by 你好 on 16/6/7.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "ShopAddressViewController.h"
#import "NavView.h"
#import "EditShopAddressViewController.h"
#import "UserManager.h"
#import "ShopAddressTableCell.h"
#import "MBProgressHUD+Helper.h"
@interface ShopAddressViewController() <UITableViewDelegate,UITableViewDataSource>

@end

@implementation ShopAddressViewController
{
    NavView *_navView;
    UIButton *_bottomButton;
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.rdv_tabBarController setTabBarHidden:YES animated:NO];
    
    self.view.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    
    _dataArray=[[NSMutableArray alloc]initWithCapacity:0];
    
    _navView=[[NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navView.centerLabel.text=@"收货地址";
    [_navView.leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_navView.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navView];
    
    _bottomButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _bottomButton.frame=CGRectMake(0, ScreenHeight-49, ScreenWidth, 49);
    _bottomButton.backgroundColor=RGBACOLOR(176, 116, 67, 1);
    [_bottomButton setTitle:@"添加新地址" forState:UIControlStateNormal];
    [_bottomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_bottomButton addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_bottomButton];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,64, ScreenWidth, ScreenHeight-64-49)];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    

}


-(void)bottomButtonClick:(UIButton *)button
{
    EditShopAddressViewController *editShopAddressVC=[[EditShopAddressViewController alloc]init];
    editShopAddressVC.addressType=CreateAddress;
    [self.navigationController pushViewController:editShopAddressVC animated:YES];
}

-(void)leftButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MBProgressHUD showLoadingWithDim:NO];
    [[UserManager shareInstance]getShopAddress];
}

#pragma mark - UITableViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _tableView)
    {
        CGFloat sectionHeaderHeight = 10;
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0)
        {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        }
        else if (scrollView.contentOffset.y>=sectionHeaderHeight)
        {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cellID";
    ShopAddressTableCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil)
    {
        cell=[[ShopAddressTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    NSDictionary *dict=[_dataArray objectAtIndex:indexPath.row];
    [cell configData:dict];
    cell.bottomButton.tag=indexPath.row+1;
    [cell.bottomButton addTarget:self action:@selector(editAddressBtn:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        return 10;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
        view.backgroundColor=RGBACOLOR(230, 230, 230, 1);
        return view;
    }
    return nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(double)heightForText:(NSString *)str
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];//调整行间距
    
    CGRect rect= [str boundingRectWithSize:CGSizeMake(ScreenWidth-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSParagraphStyleAttributeName:paragraphStyle} context:nil];
    
    double height=rect.size.height;
    if (height>55)
    {
        height=55;
    }
    return height;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *dict=[_dataArray objectAtIndex:indexPath.row];
    if (self.enterAddressType==MyShoppingAddress)
    {
        EditShopAddressViewController *editShopAddressVC=[[EditShopAddressViewController alloc]init];
        editShopAddressVC.addressType=EditAddress;
        editShopAddressVC.dict=dict;
        [self.navigationController pushViewController:editShopAddressVC animated:YES];
    }
    else if (self.enterAddressType==SelectShoppingAddress)
    {
        self.backValue(dict);
        CATransition* transition = [CATransition animation];
        transition.type = kCATransitionPush;//可更改为其他方式
        transition.subtype = kCATransitionFromBottom;//可更改为其他方式
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        [self.navigationController popViewControllerAnimated:NO];
    }
}


-(void)editAddressBtn:(UIButton *)button
{
    NSMutableDictionary *dict=[_dataArray objectAtIndex:button.tag-1];
    EditShopAddressViewController *editShopAddressVC=[[EditShopAddressViewController alloc]init];
    editShopAddressVC.addressType=EditAddress;
    editShopAddressVC.dict=dict;
    [self.navigationController pushViewController:editShopAddressVC animated:YES];
}




#pragma mark - onEventAction
-(void)onEventAction:(AppEventType)type object:(id)object
{
    [super onEventAction:type object:object];

    switch (type)
    {
        case UI_EVENT_USER_GET_SHOPPINGADRESS_SUCC:
        {
            [MBProgressHUD dismissHUD];
            _dataArray=object;
            [_tableView reloadData];
        }
            break;
        case UI_EVENT_USER_GET_SHOPPINGADRESS_FAILED:
        {
            [MBProgressHUD showHUDAutoDismissWithError:object andDim:NO];
        }
            break;
        default:
            break;
    }
}




-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
