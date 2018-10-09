//
//  PersonalViewController.m
//  CookBook
//
//  Created by 你好 on 16/5/3.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "PersonalViewController.h"
#import "NavView.h"
#import "ProfileTableViewCell.h"
#import "PersonTableViewCell.h"
#import "UserManager.h"
#import "GlobalVar.h"
//#import "MBLoadingView.h"
#import "MBProgressHUD+Helper.h"
#import "UserInfo.h"
#import <UIImageView+WebCache.h>
#import "UIImage+fixOrientation.h"
@interface PersonalViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation PersonalViewController
{
    UITableView *_tableView;
    NavView *_navView;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    
    _navView=[[NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    [_navView.leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    _navView.centerLabel.text=@"个人资料";
    [_navView.rightButton setTitle:@"保存" forState:UIControlStateNormal];
    [_navView.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_navView.rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_navView.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navView];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStyleGrouped];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.scrollEnabled=NO;
    [self.view addSubview:_tableView];
    
}


-(void)rightButtonClick:(UIButton *)button
{
    [MBProgressHUD showLoadingWithDim:YES];
    
    PersonTableViewCell *cell=(PersonTableViewCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    [[UserManager shareInstance] updateUser:[UserManager shareInstance].curUser.userId nickName:cell.textField.text];
}



-(void)leftButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - UITableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        static NSString *cellID=@"cellID";
        
        ProfileTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil)
        {
            cell=[[ProfileTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:[[UserManager shareInstance].curUser getUserPhotoUrl]] placeholderImage:[UIImage imageNamed:@"default_icon"]];
        cell.titleLabel.text=@"更换头像";
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        static NSString *cellIDE=@"cellIDE";
        
        PersonTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIDE];
        if (cell==nil)
        {
            cell=[[PersonTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIDE];
        }
        if (indexPath.row==0)
        {
            cell.titleLabel.text=@"昵称";
            cell.textField.text=[[UserManager shareInstance].curUser getNickName];
            cell.textField.textColor=[UIColor lightGrayColor];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        return 15;
    }
    else
    {
        return CGFLOAT_MIN;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        return 70;
    }
    else
    {
        return 44;
    }
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return 1;
    }
    else
    {
        return 1;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        CATransition* transition = [CATransition animation];
        transition.type = kCATransitionPush;//可更改为其他方式
        transition.subtype = kCATransitionFromTop;//可更改为其他方式
        transition.removedOnCompletion = YES;
        
        PhotoViewController *photoVC=[[PhotoViewController alloc]init];
        photoVC.enterType=SubseReplaceFromPersonVC;
        photoVC.businessType=UploadMenuBusiness;
        photoVC.backImageValue=^(UIImage *image)
        {
            UIImage *newImage = [image fixOrientation];
            [MBProgressHUD showLoadingWithDim:YES];
            
            [[UserManager shareInstance]updateUserIcon:[UserManager shareInstance].curUser.userId image:newImage];
        };
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        [self.navigationController pushViewController:photoVC animated:NO];
    }
}


- (void)onEventAction:(AppEventType)type object:(id)object
{
    
    [super onEventAction:type object:object];
    
    switch (type)
    {
        case UI_EVENT_USER_UPDATE_NICKNAME_SUCC:
        {
            [MBProgressHUD dismissHUD];
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case UI_EVENT_USER_UPDATE_ICON_SUCC:
        {
            [MBProgressHUD dismissHUD];
            [_tableView reloadData];
        }
            break;
        case UI_EVENT_USER_UPDATE_NICKNAME_FAILED:
        case UI_EVENT_USER_UPDATE_ICON_FAILED:
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
