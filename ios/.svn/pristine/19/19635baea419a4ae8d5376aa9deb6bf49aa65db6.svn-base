//
//  SettingViewController.m
//  CookBook
//
//  Created by 你好 on 16/5/3.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "SettingViewController.h"
#import "NavView.h"
#import "ProfileTableViewCell.h"
#import "PersonalViewController.h"
#import "UserManager.h"
#import <UIImageView+WebCache.h>
#import "SettingTableCell.h"
#import "AboutUsViewController.h"
#import "BindMobViewController.h"
#import "LoginViewController.h"

#define SERVICE_PHONE_NUM @"010-53383271"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SettingViewController
{
    NavView *_navView;
    UIView *_shareView;
    UIButton *_backButton;
    UITableView *_tableView;
    UIButton *_exitButton;
    UIWebView *_callWebview;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    
    _navView=[[NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    [_navView.leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_navView.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _navView.centerLabel.text=@"设置";
    [self.view addSubview:_navView];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth,ScreenHeight-64) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    [self.view addSubview:_tableView];
    
    CGRect rect=[_tableView rectForSection:2];
    _exitButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _exitButton.frame=CGRectMake(10, rect.origin.y+rect.size.height+60, ScreenWidth-20, 40);
    [_exitButton setTitle:@"退出当前账号" forState:UIControlStateNormal];
    _exitButton.backgroundColor=RGBACOLOR(176, 116, 67, 1);
    [_exitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_exitButton addTarget:self action:@selector(logOutButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_tableView addSubview:_exitButton];
    
}


-(void)logOutButtonClick:(UIButton *)button
{
    [[UserManager shareInstance] logOutWithClearToken:YES];
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)leftButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [_tableView reloadData];
    CGRect rect=[_tableView rectForSection:2];
    _exitButton.frame=CGRectMake(10, rect.origin.y+rect.size.height+60, ScreenWidth-20, 40);
    [_tableView layoutIfNeeded];
    [_tableView layoutSubviews];
    
    _exitButton.hidden=![UserManager shareInstance].bIsLogin;
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
    SettingTableCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil)
    {
        cell=[[SettingTableCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    if (indexPath.section==0)
    {
        if (indexPath.row==0)
        {
            cell.headImageView.frame=CGRectMake(10, 15, 40, 40);
            cell.titleLabel.frame=CGRectMake(60, 0, ScreenWidth-130, 70);
            cell.bottomLabel.frame=CGRectMake(ScreenWidth-70, 0, 60, 50);
            if ([UserManager shareInstance].bIsLogin)
            {
                [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:[[UserManager shareInstance].curUser getUserPhotoUrl]] placeholderImage:[UIImage imageNamed:@"default_icon"]];
                cell.titleLabel.text=[UserManager shareInstance].curUser.nickName;
                cell.lineView.hidden=NO;
            }
            else
            {
                cell.headImageView.image=[UIImage imageNamed:@"default_icon"];
                cell.titleLabel.text=@"请点击登录";
                cell.lineView.hidden=YES;
            }
            cell.lineView.frame=CGRectMake(10, 69.5, ScreenWidth-20, 0.5);
            cell.bottomLabel.hidden=YES;
        }
        else if (indexPath.row==1)
        {
            UIImage *image=[UIImage imageNamed:@"setting_tel_icon"];
            cell.headImageView.frame=CGRectMake(15, (50-image.size.height)/2, image.size.width, image.size.height);
            cell.headImageView.image=image;
            cell.titleLabel.frame=CGRectMake(30+image.size.width, 0, ScreenWidth-170-image.size.width, 50);
            cell.titleLabel.text=@"绑定手机";
            cell.bottomLabel.text=[UserManager shareInstance].curUser.mobileNumber;
            cell.lineView.hidden=YES;
            cell.bottomLabel.hidden=NO;
        }
    }
    else if(indexPath.section==1)
    {
        
        if ([WXApi isWXAppInstalled])
        {
            cell.lineView.hidden=NO;
            if (indexPath.row==0)
            {
                UIImage *image=[UIImage imageNamed:@"setting_evaluate_icon"];
                cell.headImageView.frame=CGRectMake(15, (50-image.size.height)/2, image.size.width, image.size.height);
                cell.headImageView.image=image;
                cell.titleLabel.frame=CGRectMake(30+image.size.width, 0, ScreenWidth-170-image.size.width, 50);
                cell.titleLabel.text=@"给个好评吧";
                cell.bottomLabel.hidden=YES;
            }
            else if (indexPath.row==1)
            {
                UIImage *image=[UIImage imageNamed:@"setting_share_icon"];
                cell.headImageView.frame=CGRectMake(15, (50-image.size.height)/2, image.size.width, image.size.height);
                cell.headImageView.image=image;
                cell.titleLabel.frame=CGRectMake(30+image.size.width, 0, ScreenWidth-170-image.size.width, 50);
                
                cell.titleLabel.text=@"分享APP";
                cell.bottomLabel.hidden=YES;
            }
            else if (indexPath.row==2)
            {
                UIImage *image=[UIImage imageNamed:@"setting_about_icon"];
                cell.headImageView.frame=CGRectMake(15, (50-image.size.height)/2, image.size.width, image.size.height);
                cell.headImageView.image=image;
                cell.titleLabel.frame=CGRectMake(30+image.size.width, 0, ScreenWidth-170-image.size.width, 50);
                cell.titleLabel.text=@"关于我们";
                cell.bottomLabel.hidden=YES;
                cell.lineView.hidden=YES;
            }
        }
        else
        {
            cell.lineView.hidden=NO;
            if (indexPath.row==0)
            {
                UIImage *image=[UIImage imageNamed:@"setting_evaluate_icon"];
                cell.headImageView.frame=CGRectMake(15, (50-image.size.height)/2, image.size.width, image.size.height);
                cell.headImageView.image=image;
                cell.titleLabel.frame=CGRectMake(30+image.size.width, 0, ScreenWidth-170-image.size.width, 50);
                cell.titleLabel.text=@"给个好评吧";
                cell.bottomLabel.hidden=YES;
            }
            else if (indexPath.row==1)
            {
                UIImage *image=[UIImage imageNamed:@"setting_about_icon"];
                cell.headImageView.frame=CGRectMake(15, (50-image.size.height)/2, image.size.width, image.size.height);
                cell.headImageView.image=image;
                cell.titleLabel.frame=CGRectMake(30+image.size.width, 0, ScreenWidth-170-image.size.width, 50);
                cell.titleLabel.text=@"关于我们";
                cell.bottomLabel.hidden=YES;
                cell.lineView.hidden=YES;
            }
        }
    }
    else
    {
        UIImage *image;
        if (indexPath.row==0)
        {
            cell.titleLabel.text=@"客服电话";
            cell.bottomLabel.text=SERVICE_PHONE_NUM;
            image =[UIImage imageNamed:@"setting_afterSale_icon"];
        } else if (indexPath.row == 1) {
            cell.titleLabel.text=@"QQ服务群";
            cell.bottomLabel.text=@"493230643";
            image =[UIImage imageNamed:@"qq_group"];
        }
        
        cell.headImageView.frame=CGRectMake(15, (50-image.size.height)/2, image.size.width, image.size.height);
        cell.headImageView.image=image;
        cell.titleLabel.frame=CGRectMake(30+image.size.width, 0, ScreenWidth-170-image.size.width, 50);
        
        cell.bottomLabel.hidden=NO;
    }
    
    if ((indexPath.section==0)&&(indexPath.row==0))
    {
        cell.headImageView.layer.cornerRadius=20;
        cell.headImageView.clipsToBounds=YES;
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        return 10;
    }
    else
    {
        return 10;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    view.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if((indexPath.section==0)&&(indexPath.row==0))
    {
        return 70;
    }
    else
    {
        return 50;
    }
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        if ([UserManager shareInstance].bIsLogin)
        {
            return 2;
        }
        else
        {
            return 1;
        }
    }
    else if (1 == section)
    {
        if ([WXApi isWXAppInstalled])
        {
            return 3;
        }
        else
        {
            return 2;
        }
    }
    else
    {
        return 2;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        if(indexPath.row==0)
        {
            if(![UserManager shareInstance].bIsLogin)
            {
                CATransition* transition = [CATransition animation];
                transition.type = kCATransitionPush;//可更改为其他方式
                transition.subtype = kCATransitionFromTop;//可更改为其他方式
                LoginViewController *loginVC=[[LoginViewController alloc]init];
                [self.navigationController.view.layer addAnimation:transition forKey:nil];
                [self.navigationController pushViewController:loginVC animated:NO];
            }
        }
        else if (indexPath.row==1)
        {

        }
    }
    else if (indexPath.section==1)
    {
        if ([WXApi isWXAppInstalled])
        {
            if(indexPath.row==0)
            {
                NSString *url=[NSString stringWithFormat:@"http://itunes.apple.com/cn/app/id%@",MyAPPID];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
            }
            else if (indexPath.row==1)
            {
                [self createShareView];
            }
            else if (indexPath.row==2)
            {
                AboutUsViewController *aboutUsVC=[[AboutUsViewController alloc]init];
                [self.navigationController pushViewController:aboutUsVC animated:YES];
            }
        }
        else
        {
            if(indexPath.row==0)
            {
                NSString *url=[NSString stringWithFormat:@"http://itunes.apple.com/cn/app/id%@",MyAPPID];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
            }
            else if (indexPath.row==1)
            {
                AboutUsViewController *aboutUsVC=[[AboutUsViewController alloc]init];
                [self.navigationController pushViewController:aboutUsVC animated:YES];
            }
        }
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            if(_callWebview)
            {
                [_callWebview removeFromSuperview];
                _callWebview=nil;
            }
            
            NSString * str=[NSString stringWithFormat:@"tel:%@",SERVICE_PHONE_NUM];
            _callWebview = [[UIWebView alloc] init];
            [_callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
            [self.view addSubview:_callWebview];
        } else if (indexPath.row == 1) {
            
        }
    }
}


- (BOOL)joinGroup:(NSString *)groupUin key:(NSString *)key{
    
    NSString *urlStr = [NSString stringWithFormat:@"mqqapi://card/show_pslcard?src_type=internal&version=1&uin=%@&key=%@&card_type=group&source=external", groupUin,key];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    if([[UIApplication sharedApplication] canOpenURL:url])
    {
        [[UIApplication sharedApplication] openURL:url];
        return YES;
    }

    return NO;
}

-(void)createShareView
{
    _backButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    _backButton.backgroundColor=RGBACOLOR(1, 1, 1, 0.3);
    [_backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backButton];
    
    
    if (!_shareView)
    {
        _shareView=[[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 150)];
        _shareView.backgroundColor=RGBACOLOR(235, 235, 235, 1);
        [self.view addSubview:_shareView];
        
        UIButton *cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame=CGRectMake(0, _shareView.frame.size.height-45, _shareView.frame.size.width, 45);
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        cancelBtn.titleLabel.font=[UIFont systemFontOfSize:16];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cancelBtn.backgroundColor=[UIColor whiteColor];
        [cancelBtn addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_shareView addSubview:cancelBtn];
        
        UIImage *timeLineImage=[UIImage imageNamed:@"timeline_icon"];
        
        double space=(ScreenWidth-timeLineImage.size.width*2)/3;
        
        if ([WXApi isWXAppInstalled])
        {
            for (int i=0; i<2; i++)
            {
                UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
                button.frame=CGRectMake(space*(i+1)+i*timeLineImage.size.width, 15, timeLineImage.size.width, timeLineImage.size.height);
                
                UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(button.frame.origin.x-5, button.frame.origin.y+button.frame.size.height-3, button.frame.size.width+10, 30)];
                label.textAlignment=NSTextAlignmentCenter;
                label.font=[UIFont systemFontOfSize:12];
                label.userInteractionEnabled=YES;
                label.backgroundColor=[UIColor clearColor];
                if (i==0)
                {
                    label.text=@"微信";
                    [button setImage:[UIImage imageNamed:@"weixin_icon"] forState:UIControlStateNormal];
                    [button addTarget:self action:@selector(shareToWeiXin:) forControlEvents:UIControlEventTouchUpInside];
                }
                else if(i==1)
                {
                    label.text=@"朋友圈";
                    [button setImage:[UIImage imageNamed:@"timeline_icon"] forState:UIControlStateNormal];
                    [button addTarget:self action:@selector(shareToTimeline:) forControlEvents:UIControlEventTouchUpInside];
                }
                [_shareView addSubview:label];
                [_shareView addSubview:button];
            }
        }
    }
    
    [self.view bringSubviewToFront:_shareView];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    [UIView animateWithDuration:0.25 animations:^{
        _shareView.frame=CGRectMake(0, ScreenHeight-150, ScreenWidth, 150);
    }];
    
}

-(void)shareToWeiXin:(UIButton *)button
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title=@"一家一农";
    message.description=@"每周团购深海野生海鲜，新鲜水果，种类齐全，品质至上";
    message.thumbData=UIImagePNGRepresentation([UIImage imageNamed:@"thumb_icon"]);
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl=@"http://www.yijiayinong.com/app.html";
    message.mediaObject=ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;
    [WXApi sendReq:req];
    
    [self backButtonClick:nil];
}

-(void)shareToTimeline:(UIButton *)button
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title=@"一家一农";
    message.description=@"每周团购深海野生海鲜，新鲜水果，种类齐全，品质至上";
    message.thumbData=UIImagePNGRepresentation([UIImage imageNamed:@"thumb_icon"]);
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl=@"http://www.yijiayinong.com/app.html";
    message.mediaObject=ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    [WXApi sendReq:req];
    
    [self backButtonClick:nil];
}

-(void)backButtonClick:(UIButton *)button
{
    [UIView animateWithDuration:0.25 animations:^{
        _shareView.frame=CGRectMake(0, ScreenHeight, ScreenWidth, 150);
    } completion:^(BOOL finished) {
        [_backButton removeFromSuperview];
        _backButton=nil;
        [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
    }];
}


-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
