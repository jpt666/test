//
//  MineInfoViewController.m
//  CookBook
//
//  Created by zhangxi on 16/4/11.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "MineInfoViewController.h"
#import "NavView.h"
#import "ContentScrollView.h"
#import "UserHeadView.h"
#import "GlobalVar.h"
#import "CookDataManager.h"
#import "UserManager.h"
#import "DraftTableViewCell.h"
#import "MenuEditorViewController.h"
#import "RetrieveCookDataRequest.h"
#import "CookBookReformer.h"
#import "CookProductReformer.h"
#import "CookBookPropertyKeys.h"
#import "CookProductPropertyKeys.h"
#import <MJRefresh.h>
#import "MineMenuTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "DetailContentViewController.h"
#import "NavView.h"
#import "UserManager.h"
#import "SettingViewController.h"
#import "UserManager.h"
#import "LoginViewController.h"
#import <WXApi.h>
#import "MyCollectionViewCell.h"
#import "CollectionReuseableView.h"
#import "MyOrderViewController.h"
#import "MyGroupBuyViewController.h"
#import "ShopAddressViewController.h"
#import "MyCollectionViewController.h"
#import "DraftsViewController.h"
#import "MyDishMenuViewController.h"
#import "ApplySuccViewController.h"
#import "MBProgressHUD+Helper.h"
#import "GroupsPropertyKeys.h"

@interface MineInfoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,RetrieveRequestDelegate>

@end

static NSString *cellIdentifier = @"MyCollectionViewCell";


@implementation MineInfoViewController
{
    ContentScrollView * _contentScrollView;
    UserHeadView * _userHeadView;
    UITableView * _productTableView;
    UITableView * _cookBookTableView;
    UITableView * _draftTableView;
    UIScrollView *_scrollView;
    NavView *_navView;
    RetrieveRequest * _userInfoRequest;
    
    UICollectionView *_collectionView;
    NSMutableArray * _arrCookBook;
    NSMutableArray * _arrCookProduct;

    NSArray * _arrCookDraft;
    UIButton *_backButton;
    UIView *_shareView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-49)];
    _scrollView.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    [self.view addSubview:_scrollView];
    
    _userHeadView = [[UserHeadView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 260)];
    [_userHeadView setupWithUserInfo:[UserManager shareInstance].curUser];
    [_scrollView addSubview:_userHeadView];
    
    _navView=[[NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navView.backgroundColor=[UIColor clearColor];
    _navView.rightButton.frame=CGRectMake(ScreenWidth-45, 20, 50, 44);
    _navView.lineView.hidden=YES;
    [_navView.rightButton setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
    [_navView.rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navView];
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 260, ScreenWidth,(ScreenWidth/3+40)*2) collectionViewLayout:flowLayout];
    _collectionView.dataSource=self;
    _collectionView.delegate=self;
    _collectionView.backgroundColor=[UIColor clearColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    _collectionView.alwaysBounceVertical=YES;
    _collectionView.scrollEnabled=NO;
    [_collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    [_scrollView addSubview:_collectionView];
    
    _scrollView.contentSize=CGSizeMake(ScreenWidth, _collectionView.frame.size.height+_userHeadView.frame.size.height);
    
    UITapGestureRecognizer *tapGesuter=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    tapGesuter.numberOfTapsRequired=1;
    tapGesuter.numberOfTouchesRequired=1;
    [_userHeadView.headView addGestureRecognizer:tapGesuter];
}

-(void)tapGesture:(UITapGestureRecognizer *)tapGesture
{
    if (![UserManager shareInstance].bIsLogin)
    {
        CATransition* transition = [CATransition animation];
        transition.type = kCATransitionPush;//可更改为其他方式
        transition.subtype = kCATransitionFromTop;//可更改为其他方式
        LoginViewController *loginVC=[[LoginViewController alloc]init];
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        [self.navigationController pushViewController:loginVC animated:NO];
    }
}


-(void)rightButtonClick:(UIButton *)button
{
    SettingViewController *settingVC=[[SettingViewController alloc]init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.rdv_tabBarController setTabBarHidden:NO animated:NO];
    
    
    if ([UserManager shareInstance].bIsLogin)
    {
        _navView.leftButton.hidden=NO;
        _navView.centerLabel.hidden=NO;
        [_userHeadView hideUserInfo:NO];
        [_userHeadView setupWithUserInfo:[UserManager shareInstance].curUser];

    }
    else
    {
        _navView.leftButton.hidden=YES;
        _navView.centerLabel.hidden=YES;
        [_userHeadView hideUserInfo:YES];
    }

}


#pragma mark - UICollectionViewDelegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if (indexPath.section==0)
    {
        if (indexPath.row==0)
        {
            cell.titleLabel.text=@"我的订单";
            UIImage *image=[UIImage imageNamed:@"my_order_icon"];
            cell.contentImageView.image=image;
            cell.contentImageView.frame=CGRectMake(((ScreenWidth-4)/3-image.size.width)/2, ((ScreenWidth-4)/3-image.size.height)/2-15, image.size.width , image.size.height);
            cell.titleLabel.frame=CGRectMake(0, cell.contentImageView.frame.origin.y+cell.contentImageView.frame.size.height+10, ScreenWidth/3, 30);
        }
        else if (indexPath.row==1)
        {
            cell.titleLabel.text=@"我的团";
            UIImage *image=[UIImage imageNamed:@"my_groupBuy_icon"];
            cell.contentImageView.image=image;
            cell.contentImageView.frame=CGRectMake(((ScreenWidth-4)/3-image.size.width)/2, ((ScreenWidth-4)/3-image.size.height)/2-15, image.size.width , image.size.height);
            cell.titleLabel.frame=CGRectMake(0, cell.contentImageView.frame.origin.y+cell.contentImageView.frame.size.height+10, ScreenWidth/3, 30);
        }
        else if (indexPath.row==2)
        {
            cell.titleLabel.text=@"收货地址";
            UIImage *image=[UIImage imageNamed:@"my_address_icon"];
            cell.contentImageView.image=image;
            cell.contentImageView.frame=CGRectMake(((ScreenWidth-4)/3-image.size.width)/2, ((ScreenWidth-4)/3-image.size.height)/2-15, image.size.width , image.size.height);
            cell.titleLabel.frame=CGRectMake(0, cell.contentImageView.frame.origin.y+cell.contentImageView.frame.size.height+10, ScreenWidth/3, 30);
        }
        else if (indexPath.row==3)
        {
            cell.titleLabel.text=@"我的菜报";
            UIImage *image=[UIImage imageNamed:@"my_dishMenu_icon"];
            cell.contentImageView.image=image;
            cell.contentImageView.frame=CGRectMake(((ScreenWidth-4)/3-image.size.width)/2, ((ScreenWidth-4)/3-image.size.height)/2-15, image.size.width , image.size.height);
            cell.titleLabel.frame=CGRectMake(0, cell.contentImageView.frame.origin.y+cell.contentImageView.frame.size.height+10, ScreenWidth/3, 30);
        }
        else if(indexPath.row==4)
        {
            cell.titleLabel.text=@"我的收藏";
            UIImage *image=[UIImage imageNamed:@"my_collection_icon"];
            cell.contentImageView.image=image;
            cell.contentImageView.frame=CGRectMake(((ScreenWidth-4)/3-image.size.width)/2, ((ScreenWidth-4)/3-image.size.height)/2-15, image.size.width , image.size.height);
            cell.titleLabel.frame=CGRectMake(0, cell.contentImageView.frame.origin.y+cell.contentImageView.frame.size.height+10, ScreenWidth/3, 30);
        }
        else if(indexPath.row==5)
        {
            cell.titleLabel.text=@"草稿箱";
            UIImage *image=[UIImage imageNamed:@"my_drafts_icon"];
            cell.contentImageView.image=image;
            cell.contentImageView.frame=CGRectMake(((ScreenWidth-4)/3-image.size.width)/2, ((ScreenWidth-4)/3-image.size.height)/2-15, image.size.width , image.size.height);
            cell.titleLabel.frame=CGRectMake(0, cell.contentImageView.frame.origin.y+cell.contentImageView.frame.size.height+10, ScreenWidth/3, 30);
        }
    }
    return cell;
}


//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==0)
    {
        return 6;
    }

    return 0;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

////定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenWidth-4)/3,(ScreenWidth-4)/3);
}


//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}


-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([UserManager shareInstance].bIsLogin)
    {
        if (indexPath.row==0)
        {
            MyOrderViewController *myOrderVC=[[MyOrderViewController alloc]init];
            [self.navigationController pushViewController:myOrderVC animated:YES];
        }
        else if (indexPath.row==1)
        {
            if ([UserManager shareInstance].curUser.resellerId &&
                [UserManager shareInstance].curUser.resellerApplyState == StateReview) {
                
                if (!_userInfoRequest) {
                    [MBProgressHUD showLoadingWithDim:NO];
                    
                    _userInfoRequest = [[RetrieveRequest alloc] init];
                    _userInfoRequest.delegate = self;
                    [_userInfoRequest getRequestWithUrl:[GlobalVar shareGlobalVar].userInfoUrl andParam:nil];
                }
            } else {
                MyGroupBuyViewController *myGroupBuyVC=[[MyGroupBuyViewController alloc]init];
                [self.navigationController pushViewController:myGroupBuyVC animated:YES];
            }
        }
        else if (indexPath.row==2)
        {
            ShopAddressViewController *shopAddressVC=[[ShopAddressViewController alloc]init];
            shopAddressVC.enterAddressType=MyShoppingAddress;
            [self.navigationController pushViewController:shopAddressVC animated:YES];
        }
        
        else if (indexPath.row==3)
        {
            MyDishMenuViewController *myDishMenuVC=[[MyDishMenuViewController alloc]init];
            [self.navigationController pushViewController:myDishMenuVC animated:YES];
        }
        else if (indexPath.row==4)
        {
            MyCollectionViewController *myCollectionVC=[[MyCollectionViewController alloc]init];
            [self.navigationController pushViewController:myCollectionVC animated:YES];
        }
        else if (indexPath.row==5)
        {
            DraftsViewController *draftsVC=[[DraftsViewController alloc]init];
            [self.navigationController pushViewController:draftsVC animated:YES];
        }
    }
    else
    {
        CATransition* transition = [CATransition animation];
        transition.type = kCATransitionPush;//可更改为其他方式
        transition.subtype = kCATransitionFromTop;//可更改为其他方式
        LoginViewController *loginVC=[[LoginViewController alloc]init];
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        [self.navigationController pushViewController:loginVC animated:NO];
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

#pragma mark RetrieveCookDataDelegate
-(void)didRetrieveDataSuccess:(RetrieveRequest *)request
{
    if (request == _userInfoRequest) {
        [MBProgressHUD dismissHUD];
        
        NSDictionary * dictReseller = request.rawData[kGroupsPropertyReseller];
        
        [UserManager shareInstance].curUser.resellerId = [dictReseller[kResellerPropertyId] integerValue];
        [UserManager shareInstance].curUser.resellerApplyState = [dictReseller[kResellerPropertyApplyState] integerValue];
        

        _userInfoRequest = nil;
        
        if ([UserManager shareInstance].curUser.resellerId &&
            [UserManager shareInstance].curUser.resellerApplyState == StateReview) {
            
            ApplySuccViewController *applySuccVc = [[ApplySuccViewController alloc] init];
            [self.navigationController pushViewController:applySuccVc animated:YES];
        } else {
            MyGroupBuyViewController *myGroupBuyVC=[[MyGroupBuyViewController alloc]init];
            [self.navigationController pushViewController:myGroupBuyVC animated:YES];
        }

    }
}

-(void)didRetrieveDataFailed:(RetrieveRequest *)request
{
    if  (request == _userInfoRequest) {
        [MBProgressHUD showHUDAutoDismissWithError:request.error andDim:NO];
        _userInfoRequest = nil;
    }
}


-(void)dealloc
{
    
}
@end
