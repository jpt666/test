//
//  MenuEditorViewController.m
//  CookBook
//
//  Created by 你好 on 16/4/14.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "MenuEditorViewController.h"
#import "NavView.h"
#import "MaterialsViewController.h"
#import "CustomTextView.h"
#import "CustomLineView.h"
#import "MenuEditTableViewCell.h"
#import "CustomImageView.h"
#import "MainPageViewController.h"
#import "ImageManager.h"
#import "CustomSingleLineView.h"
#import "CookBookPropertyKeys.h"
#import "CookProductPropertyKeys.h"
#import "CookDataManager.h"
#import "CookPhoto.h"
#import "UserManager.h"
#import "CookProductProxy.h"
#import "CookBookProxy.h"
#import <UIImageView+WebCache.h>
#import "EditSingleVIew.h"
#import "IQKeyboardManager.h"
#import "UITextView+Placeholder.h"
//#import "SVProgressHUD.h"
#import "MBProgressHUD+Helper.h"
#import "MCAlertview.h"

@interface MenuEditorViewController ()<UITableViewDataSource,UITableViewDelegate,CustomLineViewDelegate,UITextFieldDelegate,AnimationImageViewDelegate,TextViewDidResizeDelegate,CustomTextViewDelegate,MCALertviewDelegate>

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@property (nonatomic, strong) UIView *tempView;
@property (nonatomic, strong) CADisplayLink *edgeScrollTimer;
@property (nonatomic, assign) BOOL canEdgeScroll;
@property (nonatomic, assign) CGFloat edgeScrollRange;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGesture;


@end

@implementation MenuEditorViewController
{
    UITableView *_tableView;
    UIView *_headView;
    CustomImageView *_titleImageView;
    CustomTextView  *_customTextView;
    CustomTextView  *_tipsTextView;
    EditSingleVIew  *_singleLineView;
    UIButton *_saveBtn;
    UIView *_materView;
    NavView *_navView;
    double keyBoardHeight;
    UIView *_footView;
    BOOL _isEditing;
    
    
    UIButton *_rightBtn;
    UIButton *_leftBtn;
    UIView *_curFirstRespond;
    CGRect _titleImageViewFrame;
    
    MCAlertview * _cancelEditAlert;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self.rdv_tabBarController setTabBarHidden:YES animated:NO];
    
    _canEdgeScroll = YES;
    _edgeScrollRange = 150.f;
    
    _titleImageView=[[CustomImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 260)];
    _titleImageView.textField.font=[UIFont systemFontOfSize:22];
    _titleImageView.contentMode = UIViewContentModeScaleAspectFill;
    _titleImageView.clipsToBounds = YES;
    _titleImageView.leftLineView.hidden=YES;
    _titleImageView.rightLineView.hidden=YES;
    _titleImageView.viewBtn.hidden=YES;
    _titleImageView.favorBtn.hidden=YES;
//    _titleImageView.image=self.cookProxy.frontImage;
//    _titleImageView.textField.text = [_cookProxy dishName];
    _titleImageView.textField.delegate=self;
    _titleImageView.textField.tag=100;
    [_titleImageView.textField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    _titleImageViewFrame = _titleImageView.frame;
    
    _headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 390)];
    _headView.backgroundColor=[UIColor whiteColor];
    [_headView addSubview:_titleImageView];
    
    UIImageView *userImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 270, 40, 40)];
    userImageView.layer.cornerRadius=20;
    userImageView.clipsToBounds=YES;
    [userImageView sd_setImageWithURL:[NSURL URLWithString:[[UserManager shareInstance].curUser getUserPhotoUrl]] placeholderImage:[UIImage imageNamed:@"default_icon"]];
    [_headView addSubview:userImageView];
    
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(65, 270, ScreenWidth-70, 20)];
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.text=[[UserManager shareInstance].curUser getNickName];
    titleLabel.font=[UIFont systemFontOfSize:14];
    titleLabel.textColor=[UIColor colorWithHexString:@"#343434"];
    [_headView addSubview:titleLabel];
    
    NSDateFormatter *dateFormate=[[NSDateFormatter alloc]init];
    [dateFormate setDateFormat:@"MM月 dd日 hh:mm"];
    
    UILabel *descLabel=[[UILabel alloc]initWithFrame:CGRectMake(65, 290, ScreenWidth-75, 20)];
    descLabel.backgroundColor=[UIColor clearColor];
    descLabel.text=[dateFormate stringFromDate:[NSDate date]];
    descLabel.font=[UIFont systemFontOfSize:14];
    descLabel.textColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.8];
    [_headView addSubview:descLabel];
    
    _customTextView=[[CustomTextView alloc]initWithFrame:CGRectMake(0, 320, ScreenWidth, 50)];
    _customTextView.textView.text = [_cookProxy cookDescription];
    _customTextView.tag=101;
    _customTextView.delegate=self;
    _customTextView.backgroundColor=[UIColor whiteColor];
    [_customTextView refreshTextViewSize:_customTextView.textView];
    [_headView addSubview:_customTextView];
    
    
    _footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    _footView.backgroundColor=[UIColor whiteColor];
    
    _leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _leftBtn.frame=CGRectMake((ScreenWidth-200)/3, 30, 100, 35);
    [_leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _leftBtn.layer.borderWidth=0.5f;
    _leftBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    _leftBtn.layer.cornerRadius=14;
    _leftBtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
    [_leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_footView addSubview:_leftBtn];
    
    _rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.frame=CGRectMake(ScreenWidth-(ScreenWidth-200)/3-100, 30, 100, 35);
    [_rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _rightBtn.layer.borderWidth=0.5f;
    _rightBtn.layer.cornerRadius=14;
    [_rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    _rightBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    _rightBtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
    [_rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_footView addSubview:_rightBtn];
    
    
    _navView=[[NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navView.lineView.hidden=YES;
    if ([self.cookProxy isKindOfClass:[CookBookProxy class]])
    {
        _titleImageView.textField.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"输入菜谱名称" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:22]}];
        _customTextView.textView.placeholder=@"描述下这篇菜谱要讲什么";
        [_leftBtn setTitle:@"添加步骤" forState:UIControlStateNormal];
        [_rightBtn setTitle:@"调整步骤" forState:UIControlStateNormal];
        _navView.centerLabel.text=@"";
        
        UIImage *lineImage=[UIImage imageNamed:@"dotted_line"];

        UIImage *materImage=[UIImage imageNamed:@"materials_icon"];
        _singleLineView=[[EditSingleVIew alloc]initWithFrame:CGRectMake(0, _customTextView.frame.origin.y+_customTextView.textView.frame.size.height, ScreenWidth, 50)];
        _singleLineView.backgroundColor=[UIColor whiteColor];
        _singleLineView.headImageView.frame=CGRectMake(10, (_singleLineView.bounds.size.height-materImage.size.height)/2-5, materImage.size.width, materImage.size.height);
        _singleLineView.headImageView.image=materImage;
        _singleLineView.titleLabel.text=@"用料";
        _singleLineView.lineImageView.frame=CGRectMake(10, _singleLineView.frame.size.height-lineImage.size.height, ScreenWidth-20, lineImage.size.height);
        _singleLineView.titleLabel.font=[UIFont systemFontOfSize:18];
        [_headView addSubview:_singleLineView];
        
        _materView=[[UIView alloc]initWithFrame:CGRectMake(0, _singleLineView.frame.origin.y+_singleLineView.frame.size.height, ScreenWidth, 100)];
        _materView.backgroundColor=[UIColor whiteColor];
        [_headView addSubview:_materView];
        
        CustomLineView *descLineView=[[CustomLineView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
        descLineView.leftLabel.text=@"添加用料";
        descLineView.delegate=self;
        descLineView.leftLabel.font=[UIFont systemFontOfSize:16];
        descLineView.leftLabel.textColor=[UIColor whiteColor];
        [_materView addSubview:descLineView];
        
        UIImage *headImage=[UIImage imageNamed:@"practice_icon"];
        UIImageView *headImageView =[[UIImageView alloc]initWithFrame:CGRectMake(10, _materView.frame.size.height-50+(50-headImage.size.height)/2, headImage.size.width, headImage.size.height)];
        headImageView.image=headImage;
        [_materView addSubview:headImageView];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(15+headImage.size.width, _materView.frame.size.height-50, ScreenWidth-20-headImage.size.width, 50)];
        label.text=@"做法";
        label.font=[UIFont systemFontOfSize:18];
        label.backgroundColor=[UIColor clearColor];
        label.textColor=[UIColor colorWithHexString:@"#343434"];
        [_materView addSubview:label];
        
        _footView.frame=CGRectMake(0, 0, ScreenWidth, 300);
        
        UIImage *tipImage=[UIImage imageNamed:@"tips_icon"];
        EditSingleVIew *tipsView=[[EditSingleVIew alloc]initWithFrame:CGRectMake(0, 100, ScreenWidth, 50)];
        tipsView.backgroundColor=[UIColor whiteColor];
        tipsView.headImageView.frame=CGRectMake(10, (tipsView.bounds.size.height-tipImage.size.height)/2-5, tipImage.size.width, tipImage.size.height);
        tipsView.headImageView.image=tipImage;
        tipsView.titleLabel.text=@"小贴士";
        tipsView.titleLabel.font=[UIFont systemFontOfSize:18];
        [_footView addSubview:tipsView];
        
        NSMutableString *string=[NSMutableString string];
        for (NSString *str in [self.cookProxy tips])
        {
            [string appendString:str];
            if ([[self.cookProxy tips]  indexOfObject:str]!=[[self.cookProxy tips] count]-1)
            {
                [string appendString:@"\n"];
            }
        }

        _tipsTextView=[[CustomTextView alloc]initWithFrame:CGRectMake(0, 150, ScreenWidth, 50)];
        _tipsTextView.textView.placeholder=@"编辑小贴士";
        _tipsTextView.textView.text = string;
        _tipsTextView.delegate=self;
        _tipsTextView.tag=102;
        [_tipsTextView refreshTextViewSize:_tipsTextView.textView];
        [_footView addSubview:_tipsTextView];
        
        _saveBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _saveBtn.frame=CGRectMake(15, _tipsTextView.frame.origin.y+_tipsTextView.textView.frame.size.height+20, ScreenWidth-30, 40);
        _saveBtn.backgroundColor=RGBACOLOR(176, 116, 67, 1);
        [_saveBtn setTitle:@"保存草稿" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_saveBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_footView addSubview:_saveBtn];
        
        self.materialsArray = [self convertMaterials:[_cookProxy foodMaterials]];
        [self arrangeFoodMaterialsViews:self.materialsArray];
    }
    else if ([self.cookProxy isKindOfClass:[CookProductProxy class]])
    {
        _titleImageView.textField.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"输入美食名称" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:22]}];
        _customTextView.textView.placeholder=@"描述下这篇美食要讲什么";
        [_leftBtn setTitle:@"添加步骤" forState:UIControlStateNormal];
        [_rightBtn setTitle:@"调整步骤" forState:UIControlStateNormal];
        _navView.centerLabel.text=@"";
    }
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    _tableView.tableHeaderView=_headView;
    _tableView.tableFooterView=_footView;
    
    _navView.backgroundColor=[UIColor colorWithWhite:1 alpha:0.0f];
    [_navView.leftButton setTitle:@"取消" forState:UIControlStateNormal];
    [_navView.leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_navView.rightButton setTitle:@"发布" forState:UIControlStateNormal];
    _navView.centerLabel.frame=CGRectMake(55, 20, ScreenWidth-110, 44);
    _navView.leftButton.frame=CGRectMake(5, 20, 50, 44);
    _navView.rightButton.frame=CGRectMake(ScreenWidth-55, 20, 50, 44);
    [_navView.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_navView.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_navView.rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navView];

//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewTouchMoved:) name:NotifyScreenTouchMoved object:nil];
}



#pragma mark - CustomTextViewDelegate

-(void)updateFrame:(CGRect)frame andCustomTextView:(CustomTextView *)view
{
    UIImage *lineImage=[UIImage imageNamed:@"dotted_line"];
    if (view.tag==101)
    {
        if ([self.cookProxy isKindOfClass:[CookBookProxy class]])
        {
            self.cookProxy.dictBaseInfo[kBookPropertyDescription]=view.textView.text.length?view.textView.text:@"";
            _customTextView.frame=CGRectMake(0, 320, ScreenWidth, frame.size.height+lineImage.size.height);
            _customTextView.lineImageView.frame=CGRectMake(10, _customTextView.frame.size.height-lineImage.size.height-1, ScreenWidth-20, lineImage.size.height);
            _singleLineView.frame=CGRectMake(0, _customTextView.frame.origin.y+_customTextView.frame.size.height+lineImage.size.height, ScreenWidth, 50);
            _materView.frame=CGRectMake(0,_customTextView.frame.origin.y+_customTextView.frame.size.height+50+lineImage.size.height, ScreenWidth, _materView.frame.size.height);
            _headView.frame=CGRectMake(0, 0, ScreenWidth, _customTextView.frame.origin.y+_customTextView.frame.size.height+50+_materView.frame.size.height+lineImage.size.height);
            _tableView.tableHeaderView=_headView;
            [_tableView reloadData];
        }
        else if([self.cookProxy isKindOfClass:[CookProductProxy class]])
        {
            self.cookProxy.dictBaseInfo[kProductPropertyDescription]=view.textView.text.length?view.textView.text:@"";
            _customTextView.frame=CGRectMake(0, 320, ScreenWidth, frame.size.height+lineImage.size.height);
            _customTextView.lineImageView.frame=CGRectMake(10, _customTextView.frame.size.height-lineImage.size.height-1, ScreenWidth-20, lineImage.size.height);
            _headView.frame=CGRectMake(0, 0, ScreenWidth, _customTextView.frame.origin.y+_customTextView.frame.size.height+lineImage.size.height);
            NSLog(@"%@",_headView);
            _tableView.tableHeaderView=_headView;
            [_tableView reloadData];
        }
    }
    else if(view.tag==102)
    {
        self.cookProxy.dictBaseInfo[kBookPropertyTips]=@[view.textView.text.length?view.textView.text:@""];
        _tipsTextView.frame=CGRectMake(0, 150, ScreenWidth, frame.size.height+lineImage.size.height);
        _tipsTextView.lineImageView.frame=CGRectMake(10, _tipsTextView.frame.size.height-lineImage.size.height, ScreenWidth-20, lineImage.size.height);
        _footView.frame=CGRectMake(0, 0, ScreenWidth,250+_tipsTextView.frame.size.height+lineImage.size.height);
        _saveBtn.frame=CGRectMake(15, _footView.frame.size.height-80, ScreenWidth-30, 40);
        _tableView.tableFooterView=_footView;
    }
}

- (void)customTextViewDidBeginEditing:(CustomTextView *)textView
{
    _curFirstRespond = textView;
}

- (void)customTextViewDidEndEditing:(CustomTextView *)textView
{
    _curFirstRespond = nil;
}



-(void)saveBtnClick:(UIButton *)btn
{
    [self prepareCookData];
    [self.cookProxy saveCookDataAndUploading:NO];
    
    [self popEditViewControllerAnimated:YES];
}

-(void)leftBtnClick:(UIButton *)btn
{
    CATransition* transition = [CATransition animation];
    transition.type = kCATransitionPush;//可更改为其他方式
    transition.subtype = kCATransitionFromTop;//可更改为其他方式

    PhotoViewController *photoVC=[[PhotoViewController alloc]init];
    photoVC.enterType=SubsequentEnterPhotoVC;
    photoVC.businessType=self.businessType;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:photoVC animated:NO];
}

-(void)rightBtnClick:(UIButton *)btn
{
    
    btn.selected=!btn.selected;
    _isEditing=btn.selected;
    if (btn.selected)
    {
        btn.backgroundColor=RGBACOLOR(251, 135, 40, 1);
        btn.layer.borderWidth=0.0f;
        _leftBtn.hidden=YES;
        [_rightBtn setTitle:@"调整完成" forState:UIControlStateNormal];
    }
    else
    {
        btn.backgroundColor=[UIColor whiteColor];
        btn.layer.borderWidth=0.5f;
        _leftBtn.hidden=NO;
        [_rightBtn setTitle:@"调整步骤" forState:UIControlStateNormal];
    }
    
    if (_isEditing)
    {
        _longPressGesture=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGesture:)];
        _longPressGesture.minimumPressDuration=0.5f;
        [_tableView addGestureRecognizer:_longPressGesture];
    }
    else
    {
        [_tableView removeGestureRecognizer:_longPressGesture];
        _longPressGesture=nil;
    }
    
    [_tableView reloadData];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _titleImageView.textField.text = [_cookProxy dishName];
    _titleImageView.image=self.cookProxy.frontImage;
    [_tableView reloadData];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}


-(void)popEditViewControllerAnimated:(BOOL)animated
{
    NSMutableArray *arrVC = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    
    [arrVC removeLastObject];
    int i;
    for (i=0; i<arrVC.count; i++) {
        UIViewController *vc = [arrVC objectAtIndex:i];
        if ([vc isKindOfClass:[PhotoViewController class]]) {
            NSRange range = NSMakeRange(i, arrVC.count-i);
            [arrVC removeObjectsInRange:range];
            break;
        }
    }
    
    [self.navigationController setViewControllers:arrVC animated:animated];
}

-(BOOL)checkValueIfValid
{
    NSString *typeString = ([self.cookProxy isKindOfClass:[CookBookProxy class]])?
    @"菜谱":@"作品";
    
    NSString *hintTitleString = [NSString stringWithFormat:@"你的%@还需要一个标题哦~", typeString];
    NSString *hintPhotoString = [NSString stringWithFormat:@"本%@不包含任何图片，请添加照片后继续",typeString];
//    [SVProgressHUD setMinimumDismissTimeInterval:1];
    if (_titleImageView.textField.text.length <= 0) {
//        [SVProgressHUD showInfoWithStatus:@"您需要一个标题哦"];
        [MBProgressHUD showHUDAutoDismissWithString:hintTitleString andDim:NO];
        return NO;
    }
    
    if (self.cookProxy.cookPhotoProxy.arrLoaclPhotos.count==0) {
//        [SVProgressHUD showInfoWithStatus:@"您需要一张图片哦"];
        [MBProgressHUD showHUDAutoDismissWithString:hintPhotoString andDim:NO];
        return NO;
    }
    
    return YES;
}

-(void)didClickWith:(UIView *)alertView  buttonAtIndex:(NSUInteger)buttonIndex;
{
    if (alertView == _cancelEditAlert)
    {
        if (buttonIndex==1)
        {
            if (_bAgainEdit) {
                [self.navigationController popViewControllerAnimated:NO];
            } else {
                [[CookDataManager shareInstance] recoverCookDataDraft:_cookProxy.cookBaseId];
                
                [self popEditViewControllerAnimated:YES];
            }
        }
        else if(buttonIndex==2)
        {
            [self saveBtnClick:nil];
        }
    }
}


-(void)leftButtonClick:(UIButton *)button
{
    if (_bFromDraft) {
        if (_bAgainEdit) {
            [self.navigationController popViewControllerAnimated:NO];
        } else {
            [[CookDataManager shareInstance] recoverCookDataDraft:_cookProxy.cookBaseId];
            
            [self popEditViewControllerAnimated:YES];
        }
    
    } else {
        _cancelEditAlert =[[MCAlertview alloc]initWithMessage:@"保存至草稿箱？" CancelButton:@"取消" andCancelBtnBackGround:nil OkButton:@"确定" andOkBtnColor:nil];
        _cancelEditAlert.delegate=self;
        [_cancelEditAlert show];
    }
}


-(void)rightButtonClick:(UIButton *)button
{
    
    if (![self checkValueIfValid]) {
        return;
    }

//    if(self.cookProxy.cookPhotoProxy.arrLoaclPhotos.count>0)
//    {
//        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
//        UIView *firstResponder = [keyWindow performSelector:@selector(firstResponder)];
//        [firstResponder resignFirstResponder];

    if ([_cookProxy isKindOfClass:[CookBookProxy class]]) {
        [MBProgressHUD showHUDAutoDismissWithString:@"提交成功，正在为您上传菜谱" andDim:NO];
    } else if ([_cookProxy isKindOfClass:[CookProductProxy class]]) {
        [MBProgressHUD showHUDAutoDismissWithString:@"提交成功，正在为您上传作品" andDim:NO];
    }
    
        if (_curFirstRespond) {
            [_curFirstRespond resignFirstResponder];
            _curFirstRespond = nil;
        }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self prepareCookData];
        [_cookProxy saveCookDataAndUploading:YES];
    });
    

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)( 1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_bAgainEdit) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        } else {
            [self popEditViewControllerAnimated:YES];
        }
    });
    
}

- (void)prepareCookData
{
    if ([self.cookProxy isKindOfClass:[CookBookProxy class]])
    {
        NSMutableArray *materArray=[[NSMutableArray alloc]init];
        for (NSDictionary *dictory in self.materialsArray)
        {
            NSMutableDictionary *dict=[NSMutableDictionary dictionary];
            NSUInteger index=[self.materialsArray indexOfObject:dictory];
            [dict setObject:[NSNumber numberWithInteger:index] forKey:kBookFoodPropertySerialNumber];
            [dict setObject:[dictory objectForKey:@"Mater"] forKey:kBookFoodPropertyFoodName];
            [dict setObject:[dictory objectForKey:@"Num"] forKey:kBookFoodPropertyQuantity];
            [dict setObject:@"" forKey:kBookFoodPropertyPurchaseUrl];
            [materArray addObject:dict];
        }
        
        self.cookProxy.dictBaseInfo[kBookPropertyFoodMaterials]=materArray;
        self.cookProxy.dictBaseInfo[kBookPropertyDishName]=_titleImageView.textField.text.length?_titleImageView.textField.text:@"";
//        self.cookProxy.dictBaseInfo[kBookPropertyDescription]=_customTextView.textView.text;
        self.cookProxy.dictBaseInfo[kBookPropertyStepNumbers]=@(self.cookProxy.cookPhotoProxy.arrLoaclPhotos.count);
        
//        self.cookProxy.dictBaseInfo[kBookPropertyTips]=@[_tipsTextView.textView.text.length?_tipsTextView.textView.text:@""];
        self.cookProxy.dictBaseInfo[kBookPropertyIsPublish]=@(1);
        self.cookProxy.dictBaseInfo[kBookPropertyEditTime]=[NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]];
        
    }
    else if ([self.cookProxy isKindOfClass:[CookProductProxy class]])
    {
        self.cookProxy.dictBaseInfo[kProductPropertyDishName] =_titleImageView.textField.text.length?_titleImageView.textField.text:@"";
//        self.cookProxy.dictBaseInfo[kProductPropertyDescription] = _customTextView.textField.text;
//        self.cookProxy.dictBaseInfo[kProductPropertyFollowBookId] = @"aa-bb-cc";
        self.cookProxy.dictBaseInfo[kProductPropertyPhotoNumbers] = @(self.cookProxy.cookPhotoProxy.arrLoaclPhotos.count);
//        self.cookProxy.dictBaseInfo[kProductPropertyTopic] = @"参与话题";
//        self.cookProxy.dictBaseInfo[kProductPropertyTags] = @"标签";
//        self.cookProxy.dictBaseInfo[kProductPropertyTips] = @[_tipsTextView.textView.text.length?_tipsTextView.textView.text:@""];
//        self.cookProxy.dictBaseInfo[kProductPropertyKind] = @"分类";
//        self.cookProxy.dictBaseInfo[kProductPropertySubKind] = @"子分类";
        self.cookProxy.dictBaseInfo[kProductPropertyIsPublished] = @(1);
        self.cookProxy.dictBaseInfo[kProductPropertyEditTime] = [NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]];
        
        self.cookProxy.dictBaseInfo[kProductPropertyVisitNumbers] = @(0);
        self.cookProxy.dictBaseInfo[kProductPropertyFavorNumbers] = @(0);
        self.cookProxy.dictBaseInfo[kProductPropertyCommentNumbers] = @(0);
    }
}

-(NSArray *)convertMaterials:(NSMutableArray *)arrNetFormat
{
    if (!arrNetFormat.count) {
        return nil;
    }
    NSMutableArray * arr = [NSMutableArray arrayWithCapacity:arrNetFormat.count];
    for (NSMutableDictionary *d in arrNetFormat) {
        NSMutableDictionary *dictLoacl = [NSMutableDictionary dictionary];
        dictLoacl[@"Mater"] = d[kBookFoodPropertyFoodName];
        dictLoacl[@"Num"] = d[kBookFoodPropertyQuantity];
        
        [arr addObject:dictLoacl];
    }
    
    return arr;
}

- (void)arrangeFoodMaterialsViews:(NSArray *)array
{
    self.materialsArray=array;
    
    for (UIView *view in _materView.subviews)
    {
        [view removeFromSuperview];
    }
    
    [_materView removeFromSuperview];
    _materView=nil;
    
    
    UIImage *lineImage=[UIImage imageNamed:@"dotted_line"];
    _singleLineView.lineImageView.frame=CGRectMake(10, _singleLineView.frame.size.height-lineImage.size.height, ScreenWidth-20, lineImage.size.height);
    
    if (array.count<=0)
    {
        _materView=[[UIView alloc]initWithFrame:CGRectMake(0,_customTextView.frame.origin.y+_customTextView.frame.size.height+50+lineImage.size.height, ScreenWidth, 100)];
        
        CustomLineView *lineView=[[CustomLineView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
        lineView.leftLabel.text=@"添加用料";
        lineView.leftLabel.textColor=[UIColor lightGrayColor];
        lineView.delegate=self;
        [_materView addSubview:lineView];
    }
    else
    {
        _materView=[[UIView alloc]initWithFrame:CGRectMake(0,_customTextView.frame.origin.y+_customTextView.frame.size.height+50+lineImage.size.height, ScreenWidth, 50*(array.count+1))];
        
        for (int i=0; i<array.count; i++)
        {
            NSDictionary *dict=[array objectAtIndex:i];
            CustomLineView *lineView=[[CustomLineView alloc]initWithFrame:CGRectMake(0, i*50, ScreenWidth, 50)];
            lineView.leftLabel.text=[dict objectForKey:@"Mater"];
            lineView.rightLabel.text=[dict objectForKey:@"Num"];
            lineView.delegate=self;
            [_materView addSubview:lineView];
        }
    }
    
    
    _materView.backgroundColor=[UIColor whiteColor];
    
    UIImage *headImage=[UIImage imageNamed:@"practice_icon"];
    UIImageView *headImageView =[[UIImageView alloc]initWithFrame:CGRectMake(10, _materView.frame.size.height-50+(50-headImage.size.height)/2, headImage.size.width, headImage.size.height)];
    headImageView.image=headImage;
    [_materView addSubview:headImageView];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20+headImage.size.width, _materView.frame.size.height-50, ScreenWidth-20-headImage.size.width, 50)];
    label.text=@"做法";
    label.font=[UIFont systemFontOfSize:18];
    label.textColor=[UIColor colorWithHexString:@"#343434"];
    label.backgroundColor=[UIColor clearColor];
    [_materView addSubview:label];
    
    _headView.frame=CGRectMake(0, 0, ScreenWidth, _customTextView.frame.origin.y+_customTextView.frame.size.height+50+_materView.frame.size.height);
    [_headView addSubview:_materView];
    
    [_headView layoutSubviews];
    [_headView setNeedsDisplay];
    
    _tableView.tableHeaderView=_headView;
    
    [_tableView reloadData];
}

#pragma mark - AnimationImageViewDelegate
-(void)puzzleBtnClick:(UIImageView *)view
{
    MenuEditTableViewCell *cell;
    if (IS_OS_8_OR_LATER)
    {
        cell = (MenuEditTableViewCell *)view.superview.superview;
    }
    else
    {
        cell = (MenuEditTableViewCell *)view.superview.superview.superview;
    }
    
    NSIndexPath *indexPath=[_tableView indexPathForCell:cell];
    
    CATransition* transition = [CATransition animation];
    transition.type = kCATransitionPush;//可更改为其他方式
    transition.subtype = kCATransitionFromTop;//可更改为其他方式
    
    PhotoViewController *photoVC=[[PhotoViewController alloc]init];
    photoVC.enterType=SubsequentEnterPuzzleVC;
    photoVC.businessType=self.businessType;
    
    __block __weak MenuEditorViewController* wSelf = self;
    __block __weak CustomImageView * wTitleImageView = _titleImageView;
    __block __weak UITableView * wTableView = _tableView;
    self.usePuzzleImage = ^(UIImage *image) {
        [wSelf.cookProxy replaceImage:image atIndex:indexPath.row];
        wTitleImageView.image=wSelf.cookProxy.frontImage;
        [wTableView reloadData];
        wSelf.usePuzzleImage = nil;
    };
    
    
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:photoVC animated:NO];
    
}

-(void)exChangeBtnClick:(UIImageView *)view
{
    MenuEditTableViewCell *cell;
    if (IS_OS_8_OR_LATER)
    {
        cell = (MenuEditTableViewCell *)view.superview.superview;
    }
    else
    {
        cell = (MenuEditTableViewCell *)view.superview.superview.superview;
    }
    
    NSIndexPath *indexPath=[_tableView indexPathForCell:cell];
    
    CATransition* transition = [CATransition animation];
    transition.type = kCATransitionPush;//可更改为其他方式
    transition.subtype = kCATransitionFromTop;//可更改为其他方式
    transition.removedOnCompletion = YES;

    PhotoViewController *photoVC=[[PhotoViewController alloc]init];
    photoVC.enterType=SubseReplacePhotoVC;
    photoVC.businessType=self.businessType;
    photoVC.backImageValue=^(UIImage *image)
    {
        [self.cookProxy replaceImage:image atIndex:indexPath.row];
        _titleImageView.image=self.cookProxy.frontImage;
        [_tableView reloadData];
    };
 
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:photoVC animated:NO];
}

-(void)deleteBtnClick:(UIImageView *)view
{
    MenuEditTableViewCell *cell;
    if (IS_OS_8_OR_LATER)
    {
        cell = (MenuEditTableViewCell *)view.superview.superview;
    }
    else
    {
        cell = (MenuEditTableViewCell *)view.superview.superview.superview;
    }
    
    [cell.contentImageView hideSubView];
    
    NSIndexPath *indexPath=[_tableView indexPathForCell:cell];
    [self.cookProxy.cookPhotoProxy removeImageAtIndex:indexPath.row];
    _titleImageView.image=self.cookProxy.frontImage;
    [_tableView reloadData];
}

-(void)animationImageClick:(UIImageView *)view
{
    MenuEditTableViewCell *cell;
    if (IS_OS_8_OR_LATER)
    {
        cell = (MenuEditTableViewCell *)view.superview.superview;
    }

    else
    {
        cell = (MenuEditTableViewCell *)view.superview.superview.superview;
    }

    for (int i=0; i<self.cookProxy.cookPhotoProxy.arrLoaclPhotos.count; i++)
    {
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:i inSection:0];
        MenuEditTableViewCell *cell1=[_tableView cellForRowAtIndexPath:indexPath];
        if (cell!=cell1)
        {
            [cell1.contentImageView hideSubView];
        }
    }}


#pragma mark - CustomLineDelegate
-(void)customLineViewClick:(UIView *)view
{
    MaterialsViewController *materVC=[[MaterialsViewController alloc]init];
    if (self.materialsArray.count>0)
    {
        materVC.listArray=self.materialsArray;
    }
    
    materVC.backValue=^(NSMutableArray *array)
    {
        [self arrangeFoodMaterialsViews:array];
    };
    [self presentViewController:materVC animated:YES completion:nil];

}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView==_tableView)
    {
        CGFloat yOffset  = scrollView.contentOffset.y;
        
        CGFloat xOffset = yOffset*_titleImageView.bounds.size.width/_titleImageView.bounds.size.height;
        
        if (yOffset>135)
        {
//            _navView.backgroundColor=RGBACOLOR(176, 116, 67, 1);
            _navView.backgroundColor=[UIColor colorWithWhite:1 alpha:1];
            [_navView.leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_navView.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            _navView.lineView.hidden=NO;
            if ([[_cookProxy dishName] length]>0)
            {
                _navView.centerLabel.text=[_cookProxy dishName];
            }
            else
            {
                if ([_cookProxy isKindOfClass:[CookBookProxy class]])
                {
                    _navView.centerLabel.text=@"输入菜谱名称";
                }
                else if([_cookProxy isKindOfClass:[CookProductProxy class]])
                {
                    _navView.centerLabel.text=@"输入美食名称";
                }
            }
            
            _titleImageView.frame = _titleImageViewFrame;
        }
        else if (yOffset<=0)
        {
//            _navView.backgroundColor=RGBACOLOR(176, 116, 67, 0);
            _navView.backgroundColor=[UIColor colorWithWhite:1 alpha:0.0f];
            [_navView.leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_navView.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _navView.lineView.hidden=YES;
            _navView.centerLabel.text=@"";
            
            _titleImageView.frame = CGRectMake(_titleImageViewFrame.origin.x+xOffset/2, _titleImageViewFrame.origin.y+yOffset, _titleImageViewFrame.size.width-xOffset, _titleImageViewFrame.size.height-yOffset);
        }
        else
        {
//            _navView.backgroundColor=RGBACOLOR(73, 142, 46, yOffset/115);
            _navView.backgroundColor=[UIColor colorWithWhite:1 alpha:yOffset/115];
            [_navView.leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_navView.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _navView.lineView.hidden=YES;
            _navView.centerLabel.text=@"";
            
            _titleImageView.frame = _titleImageViewFrame;
        }
    }
}


#pragma mark - UITableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cellID";
    MenuEditTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    for (UIView *view in cell.contentView.subviews)
    {
        for (UIView *subView in view.subviews)
        {
            [subView removeFromSuperview];
        }
        [view removeFromSuperview];
    }
    cell=nil;
    
    if (cell==nil)
    {
        cell=[[MenuEditTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    
//    CookPhoto *photo =[self.cookProxy.cookPhotoProxy.arrLoaclPhotos objectAtIndex:indexPath.row];
//    [cell configData:_isEditing andCookPhoto:photo];
    [cell configData:self.cookProxy atRow:indexPath.row isEditing:_isEditing];
    cell.delegate=self;
    cell.contentImageView.delegate=self;

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)didChangeTextViewSize:(double)height diff:(CGFloat)diff andCell:(MenuEditTableViewCell *)cell
{
    NSIndexPath *indexPath=[_tableView indexPathForCell:cell];
    CookPhoto *photo=[self.cookProxy.cookPhotoProxy.arrLoaclPhotos objectAtIndex:indexPath.row];
    photo.story = cell.textView.text;

    if (diff > 0.01 || diff < -0.01)
    {
        if (_tableView.contentOffset.y+diff>=0 &&
            _tableView.contentOffset.y+diff<=_tableView.contentSize.height) {
            [_tableView setContentOffset:CGPointMake(_tableView.contentOffset.x, _tableView.contentOffset.y+diff) animated:YES];
        }
        
        [_tableView beginUpdates];
        [_tableView endUpdates];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableView)
    {
        CookPhoto *photo=[self.cookProxy.cookPhotoProxy.arrLoaclPhotos objectAtIndex:indexPath.row];
        UIImage *image=[photo getImageWithCookDataId:self.cookProxy.cookBaseId];
        
        double imageHeight = 0;
        if (image) {
           imageHeight =((ScreenWidth-20) *(image.size.height))/image.size.width;
        }
        MenuEditTableViewCell *cell = [[MenuEditTableViewCell alloc] init];
        CGSize size = [cell getFitStringTextSize:photo.story];
    
        return imageHeight+size.height+10+20;
    }
    
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cookProxy.cookPhotoProxy.arrLoaclPhotos.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(void)tapGesture:(UITapGestureRecognizer *)tapGesture
{
    CGPoint point=[tapGesture locationInView:tapGesture.view];
    NSLog(@"%f,%f",point.x,point.y);
}


-(void)longPressGesture:(UILongPressGestureRecognizer *)gesture
{
    switch (gesture.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            [self jx_gestureBegan:gesture];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            if (!_canEdgeScroll) {
                [self jx_gestureChanged:gesture];
            }
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            [self jx_gestureEndedOrCancelled:gesture];
        }
            break;
        default:
            break;
    }
}

- (void)jx_updateDataSourceAndCellFromIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    if ([_tableView numberOfSections] == 1)
    {
        //只有一组
//        [self.cookProxy.cookPhotoProxy.arrLoaclPhotos exchangeObjectAtIndex:fromIndexPath.row withObjectAtIndex:toIndexPath.row];
        [self.cookProxy.cookPhotoProxy exchangeImageIndex:fromIndexPath.row withImageIndex:toIndexPath.row];
        //交换cell
        [_tableView moveRowAtIndexPath:fromIndexPath toIndexPath:toIndexPath];
        _titleImageView.image=self.cookProxy.frontImage;
        
    }
    else
    {
        //有多组
//        id fromData = self.dictArray[fromIndexPath.section][fromIndexPath.row];
//        id toData = self.dictArray[toIndexPath.section][toIndexPath.row];
//        NSMutableArray *fromArray = [self.dictArray [fromIndexPath.section] mutableCopy];
//        NSMutableArray *toArray = [self.dictArray[toIndexPath.section] mutableCopy];
//        [fromArray replaceObjectAtIndex:fromIndexPath.row withObject:toData];
//        [toArray replaceObjectAtIndex:toIndexPath.row withObject:fromData];
//        [self.dictArray replaceObjectAtIndex:fromIndexPath.section withObject:fromArray];
//        [self.dictArray replaceObjectAtIndex:toIndexPath.section withObject:toArray];
//        //交换cell
//        [_tableView beginUpdates];
//        [_tableView moveRowAtIndexPath:fromIndexPath toIndexPath:toIndexPath];
//        [_tableView moveRowAtIndexPath:toIndexPath toIndexPath:fromIndexPath];
//        [_tableView endUpdates];
    }
}


- (void)jx_gestureEndedOrCancelled:(UILongPressGestureRecognizer *)gesture
{
    if (_canEdgeScroll)
    {
        [self jx_stopEdgeScroll];
    }
    //返回交换后的数据源
    
    UITableViewCell *cell = [_tableView cellForRowAtIndexPath:_selectedIndexPath];
    [UIView animateWithDuration:0.25 animations:^{
        _tempView.frame = cell.frame;
    } completion:^(BOOL finished) {
        cell.hidden = NO;
        [_tempView removeFromSuperview];
        _tempView = nil;
    }];
}

- (void)jx_stopEdgeScroll
{
    if (_edgeScrollTimer)
    {
        [_edgeScrollTimer invalidate];
        _edgeScrollTimer = nil;
    }
}



- (void)jx_gestureChanged:(UILongPressGestureRecognizer *)gesture
{
    CGPoint point = [gesture locationInView:gesture.view];
    NSIndexPath *currentIndexPath = [_tableView indexPathForRowAtPoint:point];
    if (currentIndexPath && ![_selectedIndexPath isEqual:currentIndexPath]) {
        //交换数据源和cell
        [self jx_updateDataSourceAndCellFromIndexPath:_selectedIndexPath toIndexPath:currentIndexPath];
        _selectedIndexPath = currentIndexPath;
    }
    //让截图跟随手势
    _tempView.center = CGPointMake(_tempView.center.x, point.y);
}

-(void)jx_startEdgeScroll
{
    _edgeScrollTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(jx_processEdgeScroll)];
    [_edgeScrollTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}


- (void)jx_processEdgeScroll
{
    [self jx_gestureChanged:_longPressGesture];
    CGFloat minOffsetY = _tableView.contentOffset.y + _edgeScrollRange;
    CGFloat maxOffsetY = _tableView.contentOffset.y + _tableView.bounds.size.height - _edgeScrollRange;
    CGPoint touchPoint = _tempView.center;
    //处理上下达到极限之后不再滚动tableView，其中处理了滚动到最边缘的时候，当前处于edgeScrollRange内，但是tableView还未显示完，需要显示完tableView才停止滚动
    if (touchPoint.y < _edgeScrollRange) {
        if (_tableView.contentOffset.y <= 0) {
            return;
        }else {
            if (_tableView.contentOffset.y - 1 < 0) {
                return;
            }
            [_tableView setContentOffset:CGPointMake(_tableView.contentOffset.x, _tableView.contentOffset.y - 1) animated:NO];
            _tempView.center = CGPointMake(_tempView.center.x, _tempView.center.y - 1);
        }
    }
    if (touchPoint.y > _tableView.contentSize.height - _edgeScrollRange) {
        if (_tableView.contentOffset.y >= _tableView.contentSize.height - _tableView.bounds.size.height) {
            return;
        }else {
            if (_tableView.contentOffset.y + 1 > _tableView.contentSize.height - _tableView.bounds.size.height) {
                return;
            }
            [_tableView setContentOffset:CGPointMake(_tableView.contentOffset.x, _tableView.contentOffset.y + 1) animated:NO];
            _tempView.center = CGPointMake(_tempView.center.x, _tempView.center.y + 1);
        }
    }
    //处理滚动
    CGFloat maxMoveDistance = 20;
    if (touchPoint.y < minOffsetY) {
        //cell在往上移动
        CGFloat moveDistance = (minOffsetY - touchPoint.y)/_edgeScrollRange*maxMoveDistance;
        [_tableView setContentOffset:CGPointMake(_tableView.contentOffset.x, _tableView.contentOffset.y - moveDistance) animated:NO];
        _tempView.center = CGPointMake(_tempView.center.x, _tempView.center.y - moveDistance);
    }else if (touchPoint.y > maxOffsetY) {
        //cell在往下移动
        CGFloat moveDistance = (touchPoint.y - maxOffsetY)/_edgeScrollRange*maxMoveDistance;
        [_tableView setContentOffset:CGPointMake(_tableView.contentOffset.x, _tableView.contentOffset.y + moveDistance) animated:NO];
        _tempView.center = CGPointMake(_tempView.center.x, _tempView.center.y + moveDistance);
    }
}

- (void)jx_gestureBegan:(UILongPressGestureRecognizer *)gesture
{
    CGPoint point = [gesture locationInView:gesture.view];
    NSIndexPath *selectedIndexPath = [_tableView indexPathForRowAtPoint:point];
    if (!selectedIndexPath) {
        return;
    }
    //开启边缘滚动
    [self jx_startEdgeScroll];
    
    //每次移动开始获取一次数据源
    _selectedIndexPath = selectedIndexPath;
    
    MenuEditTableViewCell *cell=[_tableView cellForRowAtIndexPath:selectedIndexPath];
    _tempView = [self jx_snapshotViewWithInputView:cell];
    
    //配置默认样式
    _tempView.layer.shadowColor = [UIColor grayColor].CGColor;
    _tempView.layer.masksToBounds = NO;
    _tempView.layer.cornerRadius = 0;
    _tempView.layer.shadowOffset = CGSizeMake(-5, 0);
    _tempView.layer.shadowOpacity = 0.4;
    _tempView.layer.shadowRadius = 5;
    
    _tempView.frame = cell.frame;
    [_tableView addSubview:_tempView];
    //隐藏cell
    cell.hidden = YES;
    [UIView animateWithDuration:0.25 animations:^{
        _tempView.center = CGPointMake(_tempView.center.x, point.y);
    }];
}

- (UIView *)jx_snapshotViewWithInputView:(UIView *)inputView
{
    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, NO, 0);
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
    return snapshot;
}

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidChanged:(UITextField *)textField
{
    [self.cookProxy setDishName:textField.text];
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    if (textField.tag==100)
//    {
//        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
////        if ([self.cookProxy isKindOfClass:[CookBookProxy class]])
////        {
////            self.cookProxy.dictBaseInfo[kBookPropertyDishName]=newString ;
////        }
////        else if ([self.cookProxy isKindOfClass:[CookProductProxy class]])
////        {
////            self.cookProxy.dictBaseInfo[kProductPropertyDishName]=newString;
////        }
//        [self.cookProxy setDishName:newString];
//    }
//    return YES;
//}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    _curFirstRespond = textField;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag==100)
    {
//        if ([self.cookProxy isKindOfClass:[CookBookProxy class]])
//        {
//            self.cookProxy.dictBaseInfo[kBookPropertyDishName]=textField.text;
//        }
//        else if ([self.cookProxy isKindOfClass:[CookProductProxy class]])
//        {
//            self.cookProxy.dictBaseInfo[kProductPropertyDishName]=textField.text;
//        }
        [self.cookProxy setDishName:textField.text];
    }
    _curFirstRespond = nil;
}



-(void)didCellTextViewBeginEditing:(UITextView *)textView
{
    _curFirstRespond = textView;
}


-(void)didTextViewEndEdit:(NSIndexPath *)indexPath andText:(NSString *)textStr
{
    if (indexPath)
    {
        CookPhoto *photo=[self.cookProxy.cookPhotoProxy.arrLoaclPhotos objectAtIndex:indexPath.row];
        photo.story=textStr;
    }
    
    _curFirstRespond = nil;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)viewTouchMoved:(NSNotification *)notification
//{
//    if (_curFirstRespond) {
//        [_curFirstRespond resignFirstResponder];
//        _curFirstRespond = nil;
//    }
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
