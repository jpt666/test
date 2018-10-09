//
//  DetailContentViewController.m
//  CookBook
//
//  Created by 你好 on 16/4/20.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "DetailContentViewController.h"
#import "AFHttpTool.h"
#import "NavView.h"
#import "JSONKit.h"
#import "CustomImageView.h"
#import "CustomTextView.h"
#import "CustomLineView.h"
#import "CustomSingleLineView.h"
#import "DetailTabelViewCell.h"
#import "CookBookPropertyKeys.h"
#import <UIImageView+WebCache.h>
#import "CookProductPropertykeys.h"
#import "BottomShowView.h"
#import "BottomTextView.h"
#import "CustomImageTitleView.h"
#import "UserManager.h"
#import "LoginViewController.h"
#import "CommentTableCell.h"
#import "EditLineView.h"
#import "MWPhotoBrowser.h"
#import "MoreContentView.h"
#import "UserManager.h"
#import "MBProgressHUD+Helper.h"
#import "CookBookProxy.h"
#import "CookProductProxy.h"
#import "MenuEditorViewController.h"
#import "NSMutableDictionary+CookBook.h"
#import "RetrieveCookDataRequest.h"
#import "CookBookReformer.h"
#import "CookProductReformer.h"
#import <WXApi.h>

@interface DetailContentViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,MWPhotoBrowserDelegate,MoreContentViewDelegate,UIActionSheetDelegate,RetrieveRequestDelegate>

@property (nonatomic,strong)NSMutableArray *photos;

@end

@implementation DetailContentViewController
{
    NavView *_navView;
    UITableView *_tableView;
    UIView *_headView;
    UIView *_footView;
    UIView *_bottomView;
    UIView *_frontView;
    UIActivityIndicatorView *_activityView;
    BottomShowView *_bottomShowView;
    BottomTextView *_bottomTextView;
    UIButton *_backButton;
    UIView *_shareView;
    UITableView *_commentTableView;
    CustomImageView *_titleImageView;
    CGRect _titleImageViewFrame;
    
    RetrieveCookDataRequest * _relatedBookRequest;
    RetrieveCookDataRequest * _relatedProductRequest;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor=[UIColor whiteColor];
    [self.rdv_tabBarController setTabBarHidden:YES animated:NO];
    
    self.photos =[[NSMutableArray alloc]initWithCapacity:0];
    
    _titleImageView=[[CustomImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 260)];
    _titleImageView.textField.font=[UIFont systemFontOfSize:24];
    _titleImageView.contentMode = UIViewContentModeScaleAspectFill;
    _titleImageView.clipsToBounds = YES;
    _titleImageView.textField.enabled=NO;
    _titleImageViewFrame = _titleImageView.frame;
    
    _headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 330)];
    _headView.backgroundColor=RGBACOLOR(241, 241, 241, 0.05);
    [_headView addSubview:_titleImageView];
    
    UIImageView *userImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 280, 40, 40)];
    userImageView.layer.cornerRadius=20;
    userImageView.clipsToBounds=YES;
    userImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_headView addSubview:userImageView];
    
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(70, 280, ScreenWidth-70, 20)];
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.font=[UIFont systemFontOfSize:14];
    titleLabel.textColor=[UIColor colorWithHexString:@"#343434"];
    [_headView addSubview:titleLabel];
    
    UILabel *descLabel=[[UILabel alloc]initWithFrame:CGRectMake(70, 300, ScreenWidth-70, 20)];
    descLabel.backgroundColor=[UIColor clearColor];
    descLabel.font=[UIFont systemFontOfSize:14];
    descLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.8];
    [_headView addSubview:descLabel];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    
    [_titleImageView.viewBtn setTitle:@"0" forState:UIControlStateNormal];
    [_titleImageView.favorBtn setTitle:@"0" forState:UIControlStateNormal];
    
    if (self.cookType==CookBookType)
    {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:3];//调整行间距
        paragraphStyle.paragraphSpacing=3;

        [_titleImageView.viewBtn setImage:[UIImage imageNamed:@"view_icon"] forState:UIControlStateNormal];
        [_titleImageView.favorBtn setImage:[UIImage imageNamed:@"zan_icon"] forState:UIControlStateNormal];
        
        NSMutableString *tipString=[NSMutableString string];
        for (NSString *str in self.dict[kBookPropertyTips])
        {
            [tipString appendString:str];
            if ([self.dict[kBookPropertyTips]  indexOfObject:str]!=[self.dict[kBookPropertyTips] count]-1)
            {
                [tipString appendString:@"\n"];
            }
        }
        
        _footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, [self heightForLabelText:tipString]+50)];
        _footView.backgroundColor=[UIColor whiteColor];
        
        NSString *urlString=self.dict[kBookPropertyFrontCoverUrl];
        _titleImageView.textField.text = self.dict[kBookPropertyDishName];
        [_titleImageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:PLACE_HOLDER_COOK_IMAGE]];
        NSString *urlStr=self.dict[kBookPropertyCookerIconUrl];
        [userImageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"default_icon"]];
        titleLabel.text=self.dict[kBookPropertyCookerNickName];
        
        descLabel.text=[self dateString:[self.dict[kBookPropertyCreateTime] longLongValue]/1000];
        
        if([self.dict[kBookPropertyDescription] length]>0)
        {
            NSMutableAttributedString *cookDescStr = [[NSMutableAttributedString alloc] initWithString:self.dict[kBookPropertyDescription]];
            [cookDescStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.dict[kBookPropertyDescription] length])];
            
            CustomSingleLineView *customTextView=[[CustomSingleLineView alloc]initWithFrame:CGRectMake(0, 340, ScreenWidth, [self heightForLabelText:self.dict[kBookPropertyDescription]])];
            customTextView.titleLabel.font=[UIFont systemFontOfSize:16];
            customTextView.titleLabel.lineBreakMode=NSLineBreakByWordWrapping;
            customTextView.titleLabel.numberOfLines=0;
            customTextView.lineView.hidden=YES;
            customTextView.titleLabel.attributedText=cookDescStr;
            [_headView addSubview:customTextView];
        }

        
        if ([self.dict[kBookPropertyFoodMaterials] count]>0)
        {
            CustomImageTitleView *singleLineView=[[CustomImageTitleView alloc]init];
            UIView *materView=[[UIView alloc]init];
            if([self.dict[kBookPropertyDescription] length]>0)
            {
                singleLineView.frame=CGRectMake(0, 340+[self heightForLabelText:self.dict[kBookPropertyDescription]], ScreenWidth, 50);
                materView.frame=CGRectMake(0, 390+[self heightForLabelText:self.dict[kBookPropertyDescription]], ScreenWidth, 40*[self.dict[kBookPropertyFoodMaterials] count]+65);
                _headView.frame=CGRectMake(0, 0, ScreenWidth, 390+[self heightForLabelText:self.dict[kBookPropertyDescription]]+materView.frame.size.height);
            }
            else
            {
                singleLineView.frame=CGRectMake(0, 340, ScreenWidth, 50);
                materView.frame=CGRectMake(0, 390, ScreenWidth, 40*[self.dict[kBookPropertyFoodMaterials] count]+65);
                _headView.frame=CGRectMake(0, 0, ScreenWidth, 390+materView.frame.size.height);
            }
            
            UIImage *materImage=[UIImage imageNamed:@"materials_icon"];
            singleLineView.backgroundColor=[UIColor whiteColor];
            singleLineView.titleLabel.text=@"用料";
            singleLineView.headImageView.frame=CGRectMake(10, (50-materImage.size.height)/2-4, materImage.size.width, materImage.size.height);
            singleLineView.headImageView.image=materImage;
            singleLineView.titleLabel.font=[UIFont systemFontOfSize:18];
            singleLineView.lineView.frame=CGRectMake(10, singleLineView.frame.size.height-2, ScreenWidth-20, 0.5);
            [_headView addSubview:singleLineView];
            
            for (int i=0; i<[self.dict[kBookPropertyFoodMaterials] count]; i++)
            {
                NSDictionary *d=[self.dict[kBookPropertyFoodMaterials] objectAtIndex:i];
                EditLineView *lineView=[[EditLineView alloc]initWithFrame:CGRectMake(0, i*40, ScreenWidth, 40)];
                lineView.leftLabel.text=d[kBookFoodPropertyFoodName];
                lineView.rightLabel.text=d[kBookFoodPropertyQuantity];
                [materView addSubview:lineView];
            }
            
            UIImage *headImage=[UIImage imageNamed:@"practice_icon"];
            UIImageView *headImageView =[[UIImageView alloc]initWithFrame:CGRectMake(10, materView.frame.size.height-50+(50-headImage.size.height)/2, headImage.size.width, headImage.size.height)];
            headImageView.image=headImage;
            [materView addSubview:headImageView];
            
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(15+headImageView.bounds.size.width, materView.frame.size.height-50, ScreenWidth-20-headImageView.bounds.size.width, 50)];
            label.text=@"做法";
            label.font=[UIFont systemFontOfSize:18];
            label.textColor=[UIColor colorWithHexString:@"#343434"];
            label.backgroundColor=[UIColor clearColor];
            [materView addSubview:label];
            
            [_headView addSubview:materView];
        }
        else
        {
            UIView *materView=[[UIView alloc]init];
            if([self.dict[kBookPropertyDescription] length]>0)
            {
                materView.frame=CGRectMake(0, 340+[self heightForLabelText:self.dict[kBookPropertyDescription]], ScreenWidth, 65);
                _headView.frame=CGRectMake(0, 0, ScreenWidth, 340+[self heightForLabelText:self.dict[kBookPropertyDescription]]+materView.frame.size.height);
            }
            else
            {
                materView.frame=CGRectMake(0, 340, ScreenWidth, 65);
                _headView.frame=CGRectMake(0, 0, ScreenWidth, 340+materView.frame.size.height);
            }
            
            UIImage *headImage=[UIImage imageNamed:@"practice_icon"];
            UIImageView *headImageView =[[UIImageView alloc]initWithFrame:CGRectMake(10, (50-headImage.size.height)/2, headImage.size.width, headImage.size.height)];
            headImageView.image=headImage;
            [materView addSubview:headImageView];
            
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(15+headImageView.bounds.size.width, 0, ScreenWidth-20-headImageView.bounds.size.width, 50)];
            label.text=@"做法";
            label.font=[UIFont systemFontOfSize:18];
            label.textColor=[UIColor colorWithHexString:@"#343434"];
            label.backgroundColor=[UIColor clearColor];
            [materView addSubview:label];
            
            [_headView addSubview:materView];
        }
        
        UIImage *tipImage=[UIImage imageNamed:@"tips_icon"];
        CustomImageTitleView *tipsView=[[CustomImageTitleView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
        tipsView.backgroundColor=[UIColor whiteColor];
        tipsView.headImageView.frame=CGRectMake(10, (50-tipImage.size.height)/2-2, tipImage.size.width, tipImage.size.height);
        tipsView.headImageView.image=tipImage;
        tipsView.titleLabel.text=@"小贴士";
        tipsView.lineView.hidden=YES;
        tipsView.titleLabel.font=[UIFont systemFontOfSize:18];
        [_footView addSubview:tipsView];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:tipString];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, tipString.length)];
        
        CustomSingleLineView *tipsTextView=[[CustomSingleLineView alloc]initWithFrame:CGRectMake(0, 50, ScreenWidth, [self heightForLabelText:tipString])];
        tipsTextView.titleLabel.font=[UIFont systemFontOfSize:16];
        tipsTextView.titleLabel.lineBreakMode=NSLineBreakByWordWrapping;
        tipsTextView.titleLabel.numberOfLines=0;
        tipsTextView.titleLabel.attributedText=attributedString;
        tipsTextView.lineView.hidden=YES;
        [_footView addSubview:tipsTextView];
        
        _tableView.tableFooterView=_footView;
        
        UITapGestureRecognizer *commentTapGesture =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(commentTapGesture:)];
        commentTapGesture.numberOfTapsRequired=1;
        commentTapGesture.numberOfTouchesRequired=1;
        
        UITapGestureRecognizer *uploadTapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(uploadTapGesture:)];
        uploadTapGesture.numberOfTouchesRequired=1;
        uploadTapGesture.numberOfTapsRequired=1;

//        _bottomShowView=[[BottomShowView alloc]initWithFrame:CGRectMake(0, ScreenHeight-49, ScreenWidth, 49)];
//        _bottomShowView.backgroundColor=[UIColor whiteColor];
//        [_bottomShowView.commentBtn addGestureRecognizer:commentTapGesture];
//        [_bottomShowView.uploadWorkBtn addGestureRecognizer:uploadTapGesture];
//        [_bottomShowView.collectBtn addTarget:self action:@selector(collectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:_bottomShowView];
        
        _relatedBookRequest = [[RetrieveCookDataRequest alloc] initWithRelatedId:self.dict[kBookPropertyServerId] count:3 url:[GlobalVar shareGlobalVar].cookRecipesUrl];
        _relatedBookRequest.delegate = self;
        [_relatedBookRequest request];
//        [[UserManager shareInstance]getMoreCuisine:self.dict[kBookPropertyCookerId] cuiSineId:self.dict[kBookPropertyBookId]];
    }
    else if (self.cookType==CookProductType)
    {
        if([self.dict[kProductPropertyDescription] length]>0)
        {
            NSMutableAttributedString *productDescStr = [[NSMutableAttributedString alloc] initWithString:self.dict[kProductPropertyDescription]];
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle setLineSpacing:3];//调整行间距
            paragraphStyle.paragraphSpacing=3;
            [productDescStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.dict[kProductPropertyDescription] length])];
            
            CustomSingleLineView *customTextView=[[CustomSingleLineView alloc]initWithFrame:CGRectMake(0, 340, ScreenWidth, [self heightForLabelText:self.dict[kProductPropertyDescription]])];
            customTextView.titleLabel.font=[UIFont systemFontOfSize:16];
            customTextView.titleLabel.lineBreakMode=NSLineBreakByWordWrapping;
            customTextView.titleLabel.numberOfLines=0;
            customTextView.lineView.hidden=YES;
            customTextView.titleLabel.layer.borderWidth=0.0f;
            [_headView addSubview:customTextView];
            customTextView.titleLabel.attributedText=productDescStr;
            
            _headView.frame=CGRectMake(0, 0, ScreenWidth, 340+[self heightForLabelText:self.dict[kProductPropertyDescription]]);
        }
        else
        {
            _headView.frame=CGRectMake(0, 0, ScreenWidth, 340);
        }
        
//        _commentTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 60*4+50) style:UITableViewStylePlain];
//        _commentTableView.dataSource=self;
//        _commentTableView.delegate=self;
//        _commentTableView.separatorColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.2];
//        _tableView.tableFooterView=_commentTableView;
        
        
//        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
//        lineView.backgroundColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.8];
        
        
//        UILabel *commentLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
//        commentLabel.backgroundColor=[UIColor whiteColor];
//        commentLabel.text=@"    TA们都评价了";
//        commentLabel.textColor=[UIColor colorWithHexString:@"#343434"];
//        [commentLabel addSubview:lineView];
//        _commentTableView.tableHeaderView=commentLabel;
        
        [_titleImageView.viewBtn setImage:[UIImage imageNamed:@"view_icon"] forState:UIControlStateNormal];
        [_titleImageView.favorBtn setImage:[UIImage imageNamed:@"zan_icon"] forState:UIControlStateNormal];
        
        NSString *urlString=self.dict[kProductPropertyFrontCoverUrl];
        _titleImageView.textField.text = self.dict[kProductPropertyDishName];
        [_titleImageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:PLACE_HOLDER_COOK_IMAGE]];
        NSString *urlStr=self.dict[kProductPropertyCookerIconUrl];
        [userImageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"default_icon"]];
        titleLabel.text=self.dict[kProductPropertyCookerNickName];
        descLabel.text=[self dateString:[self.dict[kProductPropertyCreateTime] longLongValue]/1000];
        
//        _bottomTextView=[[BottomTextView  alloc]initWithFrame:CGRectMake(0, ScreenHeight-49, ScreenWidth, 49)];
//        _bottomTextView.backgroundColor=RGBACOLOR(237, 237, 237, 0.8);
//        _bottomTextView.textFiled.delegate=self;
//        [_bottomTextView.publishBtn addTarget:self action:@selector(publishBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:_bottomTextView];
        
        _relatedProductRequest = [[RetrieveCookDataRequest alloc] initWithRelatedId:self.dict[kProductPropertyServerId] count:3 url:[GlobalVar shareGlobalVar].cookDishsUrl];
        _relatedProductRequest.delegate = self;
        [_relatedProductRequest request];
//        [[UserManager shareInstance]getMoreProduct:self.dict[kProductPropertyCookerId] productId:self.dict[kProductPropertyProductId]];
    }
    
    _tableView.tableHeaderView=_headView;
    
    _navView=[[NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    [_navView.leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    _navView.rightButton.frame=CGRectMake(ScreenWidth-50, 20, 50, 44);
    _navView.leftButton.frame=CGRectMake(-5, 20, 50, 44);
    _navView.backgroundColor=[UIColor colorWithWhite:1 alpha:0.0f];
    _navView.lineView.hidden=YES;
    [_navView.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    if ([WXApi isWXAppInstalled])
//    {
        [_navView.rightButton setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
        [_navView.rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    }

    if (self.cookType==CookBookType)
    {
        if ([self.dict[kBookPropertyCookerId] integerValue] == [UserManager shareInstance].curUser.userId)
        {
            UIButton *rightEditBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            rightEditBtn.frame=CGRectMake(ScreenWidth-90, 20, 50, 44);
            [rightEditBtn setImage:[UIImage imageNamed:@"edit_icon"] forState:UIControlStateNormal];
            [rightEditBtn addTarget:self action:@selector(rightEditBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_navView addSubview:rightEditBtn];
            _navView.centerLabel.frame=CGRectMake(90, 20, ScreenWidth-180, 44);
        }
    }
    else if (self.cookType==CookProductType)
    {
        if ([self.dict[kProductPropertyCookerId] integerValue] == [UserManager shareInstance].curUser.userId)
        {
            UIButton *rightEditBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            rightEditBtn.frame=CGRectMake(ScreenWidth-90, 20, 50, 44);
            [rightEditBtn setImage:[UIImage imageNamed:@"edit_icon"] forState:UIControlStateNormal];
            [rightEditBtn addTarget:self action:@selector(rightEditBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_navView addSubview:rightEditBtn];
            _navView.centerLabel.frame=CGRectMake(90, 20, ScreenWidth-180, 44);
        }
    }

    [self.view addSubview:_navView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleDefault;
}

-(void)rightEditBtnClick:(UIButton *)button
{
    UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"编辑" otherButtonTitles:@"删除",nil];
    actionSheet.destructiveButtonIndex=1;
    [actionSheet showInView:self.view];
}


-(void)rightButtonClick:(UIButton *)button
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
    [UIView animateWithDuration:0.25 animations:^{
        _shareView.frame=CGRectMake(0, ScreenHeight-150, ScreenWidth, 150);
    }];
}

-(void)shareToWeiXin:(UIButton *)button
{
    WXMediaMessage *message = [WXMediaMessage message];
    NSString *urlString=nil;
    if (self.cookType==CookBookType)
    {
        if ([self.dict[kBookPropertyDescription] length]>0)
        {
            message.title=[NSString stringWithFormat:@"%@的美食《%@》",self.dict[kBookPropertyCookerNickName],self.dict[kBookPropertyDishName]];
        }
        else
        {
            message.title=[NSString stringWithFormat:@"%@的美食",self.dict[kBookPropertyCookerNickName]];
        }
        
        if ([self.dict[kBookPropertyDescription] length]>0)
        {
            message.description=self.dict[kBookPropertyDescription];
        }
        else
        {
            message.description=[NSString stringWithFormat:@"《%@》",self.dict[kBookPropertyDishName]];
        }
        urlString=self.dict[kBookPropertyCardUrl];
    }
    else if (self.cookType==CookProductType)
    {
        if ([self.dict[kProductPropertyDescription] length]>0)
        {
            message.title=[NSString stringWithFormat:@"%@的美食《%@》",self.dict[kProductPropertyCookerNickName],self.dict[kProductPropertyDishName]];
        }
        else
        {
            message.title=[NSString stringWithFormat:@"%@的美食",self.dict[kProductPropertyCookerNickName]];
        }
        
        if ([self.dict[kProductPropertyDescription] length]>0)
        {
            message.description=self.dict[kProductPropertyDescription];
        }
        else
        {
            message.description=[NSString stringWithFormat:@"《%@》",self.dict[kProductPropertyDishName]];
        }
        urlString=self.dict[kProductPropertyCardUrl];
    }
    
    CGFloat width = 100.0f;
    CGFloat height = _titleImageView.image.size.height * width/ _titleImageView.image.size.width;
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [_titleImageView.image drawInRect:CGRectMake(0, 0, width, height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [message setThumbImage:scaledImage];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl=urlString;
    message.mediaObject=ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;
    NSLog(@"%d",[WXApi sendReq:req]);
    [WXApi sendReq:req];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self backButtonClick:nil];
    });

}

-(void)shareToTimeline:(UIButton *)button
{
    WXMediaMessage *message = [WXMediaMessage message];
    NSString *urlString=nil;
    if (self.cookType==CookBookType)
    {
        if ([self.dict[kBookPropertyDescription] length]>0)
        {
            message.title=[NSString stringWithFormat:@"%@的美食《%@》",self.dict[kBookPropertyCookerNickName],self.dict[kBookPropertyDishName]];
        }
        else
        {
            message.title=[NSString stringWithFormat:@"%@的美食",self.dict[kBookPropertyCookerNickName]];
        }
        
        if ([self.dict[kBookPropertyDescription] length]>0)
        {
            message.description=self.dict[kBookPropertyDescription];
        }
        else
        {
            message.description=[NSString stringWithFormat:@"《%@》",self.dict[kBookPropertyDishName]];
        }
        urlString=self.dict[kBookPropertyCardUrl];
    }
    else if (self.cookType==CookProductType)
    {
        if ([self.dict[kProductPropertyDescription] length]>0)
        {
            message.title=[NSString stringWithFormat:@"%@的美食《%@》",self.dict[kProductPropertyCookerNickName],self.dict[kProductPropertyDishName]];
        }
        else
        {
            message.title=[NSString stringWithFormat:@"%@的美食",self.dict[kProductPropertyCookerNickName]];
        }
        
        if ([self.dict[kProductPropertyDescription] length]>0)
        {
            message.description=self.dict[kProductPropertyDescription];
        }
        else
        {
            message.description=[NSString stringWithFormat:@"《%@》",self.dict[kProductPropertyDishName]];
        }
        urlString=self.dict[kProductPropertyCardUrl];
    }
    
    CGFloat width = 100.0f;
    CGFloat height = _titleImageView.image.size.height * width/ _titleImageView.image.size.width;
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [_titleImageView.image drawInRect:CGRectMake(0, 0, width, height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [message setThumbImage:scaledImage];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl=urlString;
    message.mediaObject=ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    NSLog(@"%d",[WXApi sendReq:req]);
    [WXApi sendReq:req];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self backButtonClick:nil];
    });
}


-(void)backButtonClick:(UIButton *)button
{
    [UIView animateWithDuration:0.25 animations:^{
        _shareView.frame=CGRectMake(0, ScreenHeight, ScreenWidth, 150);
    } completion:^(BOOL finished) {
        [_backButton removeFromSuperview];
        _backButton=nil;
    }];
}


-(void)publishBtnClick:(UIButton *)button
{
    
}

-(void)commentTapGesture:(UITapGestureRecognizer *)tapGesture
{
    
}

-(void)uploadTapGesture:(UITapGestureRecognizer *)tapGesture
{
//    CATransition* transition = [CATransition animation];
//    transition.type = kCATransitionPush;//可更改为其他方式
//    transition.subtype = kCATransitionFromTop;//可更改为其他方式
//    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
//    
//    if ([UserManager shareInstance].bIsLogin)
//    {
//        PhotoViewController *photoVC=[[PhotoViewController alloc]init];
//        photoVC.enterType=FirstEnterPhotoVC;
//        photoVC.businessType=UploadMenuBusiness;
//        [self.navigationController pushViewController:photoVC animated:NO];
//    }
//    else
//    {
//        LoginViewController *loginVC=[[LoginViewController alloc]init];
//        [self.navigationController pushViewController:loginVC animated:NO];
//    }
}

-(void)collectBtnClick:(UIButton *)button
{
   
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView==_tableView)
    {
        CGFloat yOffset  = scrollView.contentOffset.y;
        CGFloat xOffset = yOffset*_titleImageView.bounds.size.width/_titleImageView.bounds.size.height;
        if (yOffset>135)
        {
//            _navView.backgroundColor=RGBACOLOR(176, 116, 67, 1);
            _navView.backgroundColor=[UIColor whiteColor];
            _navView.lineView.hidden=NO;
            if (self.cookType==CookProductType)
            {
                _navView.centerLabel.text=self.dict[kProductPropertyDishName];
            }
            else
            {
                _navView.centerLabel.text=self.dict[kBookPropertyDishName];
            }
            _titleImageView.frame = _titleImageViewFrame;
        }
        else if (yOffset<=0)
        {
//            _navView.backgroundColor=RGBACOLOR(176, 116, 67, 0);
            _navView.backgroundColor=[UIColor colorWithWhite:1 alpha:0.0f];
            _navView.lineView.hidden=YES;
            _navView.centerLabel.text=@"";
            
            _titleImageView.frame = CGRectMake(_titleImageViewFrame.origin.x+xOffset/2, _titleImageViewFrame.origin.y+yOffset, _titleImageViewFrame.size.width-xOffset, _titleImageViewFrame.size.height-yOffset);
        }
        else
        {
//            _navView.backgroundColor=RGBACOLOR(73, 142, 46, yOffset/115);
            _navView.backgroundColor=[UIColor colorWithWhite:1 alpha:yOffset/115];
            _navView.lineView.hidden=YES;
            _navView.centerLabel.text=@"";
            
            _titleImageView.frame = _titleImageViewFrame;
        }
    }
}




-(NSString *)dateString:(NSTimeInterval)timeInterVal
{
    NSDate *currentDate = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];
    NSInteger curYear = [components year];
    
    NSDate *editDate = [NSDate dateWithTimeIntervalSince1970:timeInterVal/1000];
    components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:editDate];
    NSInteger editYear = [components year];
    
    NSDateFormatter *dateFormate=[[NSDateFormatter alloc]init];
    if (curYear!=editYear)
    {
        [dateFormate setDateFormat:@"yyyy年MM月dd日 hh:mm"];
        return [dateFormate stringFromDate:editDate];
    }
    else
    {
        [dateFormate setDateFormat:@"MM月dd日 hh:mm"];
        return [dateFormate stringFromDate:editDate];
    }
}

-(void)tapGesture:(UITapGestureRecognizer *)getsure
{
    [self.photos removeAllObjects];
    
    if (self.cookType==CookBookType)
    {
        for (NSDictionary *dict in self.dict[kBookPropertyCookSteps])
        {
            NSString *url=dict[kPhotoPropertyPhotoUrl];
            MWPhoto *photo=[MWPhoto photoWithURL:[NSURL URLWithString:url]];
            photo.caption=dict[kPhotoPropertyDescription];
            [self.photos addObject:photo];
        }
    }
    else
    {
        for (NSDictionary *dict in self.dict[kProductPropertyPhotos])
        {
            NSString *url=dict[kPhotoPropertyPhotoUrl];
            MWPhoto *photo=[MWPhoto photoWithURL:[NSURL URLWithString:url]];
            photo.caption=dict[kPhotoPropertyDescription];
            [self.photos addObject:photo];
        }
    }
    
    
    BOOL displayActionButton = YES;
    BOOL displaySelectionButtons = NO;
    BOOL displayNavArrows = NO;
    BOOL enableGrid = NO;
    BOOL startOnGrid = NO;
    BOOL autoPlayOnAppear = NO;
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = displayActionButton;
    browser.displayNavArrows = displayNavArrows;
    browser.displaySelectionButtons = displaySelectionButtons;
    browser.alwaysShowControls = displaySelectionButtons;
    browser.zoomPhotosToFill = NO;
    browser.enableGrid = enableGrid;
    browser.startOnGrid = startOnGrid;
    browser.enableSwipeToDismiss = NO;
    browser.autoPlayOnAppear = autoPlayOnAppear;
    [browser setCurrentPhotoIndex:getsure.view.tag];
    [self.navigationController pushViewController:browser animated:YES];

}

#pragma mark - UIActionSheetDelegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%ld",buttonIndex);
    if(buttonIndex==0)
    {
        MenuEditorViewController *menuEditVc = [[MenuEditorViewController alloc] init];
        menuEditVc.bAgainEdit = YES;
        
        if (self.cookType==CookBookType)
        {
            NSMutableDictionary * dictBookInfo = [_dict mutableCopyForBook];
            CookBookProxy *cb = [[CookBookProxy alloc] initWithDictionary:dictBookInfo];
            
            menuEditVc.businessType = UploadMenuBusiness;
            menuEditVc.cookProxy = cb;
        }
        else if (self.cookType==CookProductType)
        {
            NSMutableDictionary * dictProductInfo = [_dict mutableCopyForProduct];
            CookProductProxy *cb = [[CookProductProxy alloc] initWithDictionary:dictProductInfo];
            menuEditVc.businessType = ShowFoodBusiness;
            menuEditVc.cookProxy = cb;
        }
        
        [self.navigationController pushViewController:menuEditVc animated:NO];
        
    }
    else if (buttonIndex==1)
    {
        [MBProgressHUD showLoadingWithDim:YES];
        
        if (self.cookType==CookBookType)
        {
            [[UserManager shareInstance]deleteCuisineById:self.dict[kBookPropertyUrl]];
        }
        else if (self.cookType==CookProductType)
        {
            [[UserManager shareInstance]deleteProductById:self.dict[kProductPropertyUrl]];
        }

    }
}





#pragma mark - MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
{
    return _photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    if (index < self.photos.count)
    {
        return [self.photos objectAtIndex:index];
    }
    return nil;
}



#pragma mark - UITableViewDelegate

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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_commentTableView)
    {
        static NSString *cellIDE=@"cellIDE";
        CommentTableCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIDE];
        if (cell==nil)
        {
            cell=[[CommentTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIDE];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (tableView==_tableView)
    {
        static NSString *cellID=@"cellID";
        DetailTabelViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil)
        {
            cell=[[DetailTabelViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        
        [cell setupWithCookData:self.dict CookType:self.cookType IndexPath:indexPath];
        cell.contentImageView.userInteractionEnabled=YES;
        cell.contentImageView.tag=indexPath.row;
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
        tapGesture.numberOfTapsRequired=1;
        tapGesture.numberOfTouchesRequired=1;
        [cell.contentImageView addGestureRecognizer:tapGesture];
        cell.backgroundColor=RGBACOLOR(241, 241, 241, 0.05);
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_commentTableView)
    {
        return 4;
    }
    else if (tableView==_tableView)
    {
        if (self.cookType==CookBookType)
        {
            return [self.dict[kBookPropertyCookSteps] count];
        }
        else if (self.cookType==CookProductType)
        {
            return [self.dict[kProductPropertyPhotos] count];
        }
        return 0;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==_tableView)
    {
        return 1;
    }
    else if(tableView==_commentTableView)
    {
        return 1;
    }
    return 0;
}

//-(void)configCell:(DetailTabelViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
//{
//    // 正常的设置文字和其他内容
//    NSString *url=nil;
//    NSString *descStr=nil;
//    if (self.cookType==CookBookType)
//    {
//        NSDictionary *dictory=[self.dict[kBookPropertyCookSteps] objectAtIndex:indexPath.row];
//        url=[NSString stringWithFormat:@"%@%@",SERVER_IMAGE_ACCESS_URL,dictory[kPhotoPropertyPhotoUrl]];
//        if ([dictory[kPhotoPropertyDescription] length]>0)
//        {
//            descStr=[NSString stringWithFormat:@"%ld.%@",(long)indexPath.row+1,dictory[kPhotoPropertyDescription]];
//        }
//        else
//        {
//            descStr=dictory[kPhotoPropertyDescription];
//        }
//    }
//    else
//    {
//        NSDictionary *dictory=[self.dict[kProductPropertyPhotos] objectAtIndex:indexPath.row];
//        url=[NSString stringWithFormat:@"%@%@",SERVER_IMAGE_ACCESS_URL,dictory[kPhotoPropertyPhotoUrl]];
//        if ([dictory[kPhotoPropertyDescription] length]>0)
//        {
//            descStr=[NSString stringWithFormat:@"%ld.%@",(long)indexPath.row+1,dictory[kPhotoPropertyDescription]];
//        }
//        else
//        {
//            descStr=dictory[kPhotoPropertyDescription];
//        }
//    }
//
//    // 开始加载图片
//    UIImage *cachedImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:url];
//    
//    // 没有已经下载好的图片
//    if ( !cachedImage ) {
//        // 要是当前 table view 没有在被拖动或者自由滑行
//        if ( !_tableView.dragging && !_tableView.decelerating ) {
//            // 下载当前 cell 中的图片
//            [self downloadImage:url forIndexPath:indexPath];
//        }
//        // cell 中图片先用缓存的占位图代替
//        [cell setSpitslotImage:[UIImage imageNamed:PLACE_HOLDER_COOK_IMAGE]];
//    } else {
//        // 找到了缓存的图片，直接插缓存的图片
//        [cell setSpitslotImage:cachedImage string:descStr];
//    }
//}
//
//- (void)downloadImage:(NSString *)imageURL forIndexPath:(NSIndexPath *)indexPath
//{
//    __weak typeof(self) target = self;
//    [[SDWebImageDownloader sharedDownloader]downloadImageWithURL:[NSURL URLWithString:imageURL] options:SDWebImageDownloaderUseNSURLCache progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
//        [[SDImageCache sharedImageCache]storeImage:image forKey:imageURL toDisk:YES];
//        [target performSelectorOnMainThread:@selector(reloadCellAtIndexPath:) withObject:indexPath waitUntilDone:NO];
//    }];
//}
//
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    // table view 停止滚动了
//    if (scrollView==_tableView)
//    {
//        [self loadImageForOnScreenRows];
//    }
//}
//
//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    if (scrollView==_tableView)
//    {
//        if (!decelerate)
//        {
//            [self loadImageForOnScreenRows];
//        }
//    }
//}
//
//- (void)loadImageForOnScreenRows
//{
//    NSArray *visiableIndexPathes = [_tableView indexPathsForVisibleRows];
//    
//    for(NSInteger i = 0; i < [visiableIndexPathes count]; i++)
//    {
//        NSDictionary *dictory=[self.dict[kBookPropertyCookSteps] objectAtIndex:i];
//        NSString *urlStr=[NSString stringWithFormat:@"%@%@",SERVER_IMAGE_ACCESS_URL,dictory[kPhotoPropertyPhotoUrl]];
//        [self downloadImage:urlStr forIndexPath:visiableIndexPathes[i]];
//    }
//}
//
//- (void)reloadCellAtIndexPath:(NSIndexPath *)indexPath
//{
//    [_tableView reloadData];
//}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==_tableView)
    {
        NSDictionary *dictory;
        if (self.cookType==CookBookType)
        {
            dictory=[self.dict[kBookPropertyCookSteps] objectAtIndex:indexPath.row];
        }
        else
        {
            dictory=[self.dict[kProductPropertyPhotos] objectAtIndex:indexPath.row];
        }
        double imageWidth=[dictory[kPhotoPropertyWidth] doubleValue];
        double imageHeight=[dictory[kPhotoPropertyHeight] doubleValue];
        
        double height = imageHeight;
        if (imageWidth) {
            height=(ScreenWidth*imageHeight)/imageWidth;
        }
        double textHeight;
        if ([dictory[kPhotoPropertyDescription] length]>0)
        {
           textHeight=[self heightForCellLabelText:dictory[kPhotoPropertyDescription]]+50;
        }
        else
        {
            textHeight=20;
        }
        NSLog(@"index:%ld,height:%f",(long)indexPath.row,height+textHeight);
        return height+textHeight;
    }
    else if (tableView==_commentTableView)
    {
        return 60;
    }
    
    return 0;
}


-(double)heightForCellLabelText:(NSString *)str
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];//调整行间距
    
    CGRect rect= [str boundingRectWithSize:CGSizeMake(ScreenWidth-40, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSParagraphStyleAttributeName:paragraphStyle} context:nil];
    return rect.size.height;
}
-(double)heightForLabelText:(NSString *)str
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];//调整行间距
    paragraphStyle.paragraphSpacing=3;
    
    CGRect rect= [str boundingRectWithSize:CGSizeMake(ScreenWidth-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSParagraphStyleAttributeName:paragraphStyle} context:nil];
    if (rect.size.height<=50)
    {
        return 50;
    }
    else
    {
        return rect.size.height+15;
    }
}

-(double)heightForText:(NSString *)str
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];//调整行间距
    paragraphStyle.paragraphSpacing=3;
    
    CGRect rect= [str boundingRectWithSize:CGSizeMake(ScreenWidth-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSParagraphStyleAttributeName:paragraphStyle} context:nil];
    return rect.size.height;
}

#pragma mark RetrieveCookDataDelegate
-(void)didRetrieveDataSuccess:(RetrieveRequest *)request
{
    if (request == _relatedBookRequest) {
        
        NSMutableDictionary * dictResult = [_relatedBookRequest fetchDataWithReformer:[[CookBookReformer alloc] init]];
        NSMutableArray * arrBook = [NSMutableArray arrayWithArray:dictResult[@"cuisinebooks"]];
        
        [self configCookBookUI:arrBook];
        
    } else if (request == _relatedProductRequest) {
        
        NSMutableDictionary * dictResult = [_relatedProductRequest fetchDataWithReformer:[[CookProductReformer alloc] init]];
        NSMutableArray* arrProduct = [NSMutableArray arrayWithArray:dictResult[@"products"]];
        
        [self configUICookProduct:arrProduct];
    }
}

-(void)didRetrieveDataFailed:(RetrieveRequest *)request
{
    
}


#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)leftButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - MoreContentViewDelegate
-(void)didClickContentView:(NSDictionary *)dict CookType:(CookType)type
{
    DetailContentViewController *detailContentVC=[[DetailContentViewController alloc]init];
    detailContentVC.dict=dict;
    detailContentVC.cookType=type;
    [self.navigationController pushViewController:detailContentVC animated:YES];
}



-(void)configCookBookUI:(NSMutableArray *)array
{
    if (array.count>0)
    {
        NSMutableString *tipString=[NSMutableString string];
        for (NSString *str in self.dict[kBookPropertyTips])
        {
            [tipString appendString:str];
            if ([self.dict[kBookPropertyTips]  indexOfObject:str]!=[self.dict[kBookPropertyTips] count]-1)
            {
                [tipString appendString:@"\n"];
            }
        }
        
        MoreContentView *contentView=[[MoreContentView alloc]initWith:array nickName:self.dict[kBookPropertyCookerNickName] imagemd5:self.dict[kBookPropertyCookerIconUrl] cookType:CookBookType yOffSet:[self heightForLabelText:tipString]+50];
        contentView.delegate=self;
        _footView.frame=CGRectMake(0, 0, ScreenWidth, contentView.frame.origin.y+contentView.frame.size.height+40);
        [_footView addSubview:contentView];
        _tableView.tableFooterView=_footView;
    }
}

-(void)configUICookProduct:(NSMutableArray *)array
{
    if (array.count>0)
    {
        MoreContentView *contentView=[[MoreContentView alloc]initWith:array nickName:self.dict[kProductPropertyCookerNickName] imagemd5:self.dict[kProductPropertyCookerIconUrl] cookType:CookProductType yOffSet:0];
        contentView.delegate=self;
        
        UIView *view=[[UIView alloc]init];
        [view addSubview:contentView];
//        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
//        lineView.backgroundColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.8];
//        
//        UILabel *commentLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, contentView.frame.origin.y+contentView.frame.size.height+20, ScreenWidth, 50)];
//        commentLabel.backgroundColor=[UIColor whiteColor];
//        commentLabel.text=@"    TA们都评价了";
//        commentLabel.textColor=[UIColor colorWithHexString:@"#343434"];
//        [commentLabel addSubview:lineView];
//        [view addSubview:commentLabel];
//        
        view.frame=CGRectMake(0, 0, ScreenWidth, contentView.frame.origin.y+contentView.frame.size.height+30);
//        _commentTableView.frame=CGRectMake(0, 0, ScreenWidth, 60*4+view.bounds.size.height);
//        _commentTableView.scrollEnabled=NO;
//        _commentTableView.tableHeaderView=view;
//        _tableView.tableFooterView=_commentTableView;
        _tableView.tableFooterView=view;
    }
}

#pragma mark - onEventAction

-(void)onEventAction:(AppEventType)type object:(id)object
{
    [super onEventAction:type object:object];
    
    switch (type) {
        case UI_EVENT_USER_DELETE_CUISINE_SUCC:
        case UI_EVENT_USER_DELETE_PRODUCT_SUCC:
        {
//            [SVProgressHUD showSuccessWithStatus:@"删除成功"];
            [MBProgressHUD showHUDAutoDismissWithString:@"删除成功" andDim:NO];
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case UI_EVENT_USER_DELETE_CUISINE_FAILED:
        case UI_EVENT_USER_DELETE_PRODUCT_FAILED:
        {
//            [SVProgressHUD showErrorWithStatus:@"删除失败"];
            [MBProgressHUD showHUDAutoDismissWithString:@"删除失败" andDim:NO];
        }
            break;
//        case UI_EVENT_USER_GET_MORE_CUISINE_SUCC:
//        {
//            [self configCookBookUI:object];
//        }
//            break;
//        case UI_EVENT_USER_GET_MORE_PRODUCT_SUCC:
//        {
//            [self configUICookProduct:object];
//        }
//            break;
//        case UI_EVENT_USER_GET_MORE_CUISINE_FAILED:
//        case UI_EVENT_USER_GET_MORE_PRODUCT_FAILED:
//            break;
        default:
            break;
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
