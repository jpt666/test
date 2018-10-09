//
//  PhotoListViewController.m
//  CookBook
//
//  Created by 你好 on 16/4/14.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "PhotoListViewController.h"
#import "NavView.h"
#import "BottomView.h"
#import "PreviewViewController.h"
#import "PhotoTableViewCell.h"
#import <Photos/Photos.h>
#import "PreviewViewController.h"
#import "MenuEditorViewController.h"
#import "ImageManager.h"
#import "CookProductProxy.h"
#import "CookBookProxy.h"
#import "UIImage+fixOrientation.h"
#import "PersonalViewController.h"
#import "PuzzleViewController.h"
#import "BottomSelectView.h"
//#import <SVProgressHUD.h>
#import "MBProgressHUD+Helper.h"

@interface PhotoListViewController ()<UITableViewDataSource,UITableViewDelegate>

@end


@implementation PhotoListViewController
{
    UITableView *_tableView;
    NavView *_navView;
    BottomView *_bottomView;
    BottomSelectView *_bottomSelectView;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    _navView=[[NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navView.centerLabel.text=@"相册";
    [_navView.rightButton setTitle:@"取消" forState:UIControlStateNormal];
    [_navView.rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navView];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.rowHeight=(ScreenWidth-6)/4+5;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView=[UIView new];
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self.view addSubview:_tableView];
    
    
    if ((self.enterType!=SubseReplacePhotoVC)&&(self.enterType!=SubseReplaceFromPersonVC)&&(self.enterType!=SubsequentEnterPuzzleVC))
    {
        _tableView.contentInset=UIEdgeInsetsMake(0, 0, 150, 0);

        _bottomView=[[BottomView alloc]initWithFrame:CGRectMake(0, ScreenHeight-49, ScreenWidth, 49)];
        [_bottomView.leftButton setTitle:@"预览" forState:UIControlStateNormal];
        _bottomView.layer.borderColor=[UIColor lightGrayColor].CGColor;
        [_bottomView.rightButton setTitle:@"确定" forState:UIControlStateNormal];
        [_bottomView.rightButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_bottomView.leftButton addTarget:self action:@selector(bottomLeftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView.rightButton addTarget:self action:@selector(bottomRightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_bottomView];
    }
    else if (self.enterType==SubsequentEnterPuzzleVC)
    {
        double width=(ScreenWidth-50)/4;
        
        _bottomSelectView=[[BottomSelectView alloc]initWithFrame:CGRectMake(0, ScreenHeight-width-70, ScreenWidth, width+70)];
        _bottomSelectView.backgroundColor=RGBACOLOR(212, 212, 212, 1);
//        if (!self.puzzleImages) {
//            self.puzzleImages = [NSMutableArray array];
//        }
////        _bottomSelectView.dataArray=[ImageManager shareInstance].puzzleImageArray;
//        _bottomSelectView.dataArray = self.puzzleImages;
        [self.view addSubview:_bottomSelectView];
        [_bottomSelectView.startButton addTarget:self action:@selector(startButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomSelectView configData];
        
        _tableView.frame=CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-_bottomSelectView.bounds.size.height);
    }
    
    
    if ([ImageManager shareInstance].selectImageArray.count>0)
    {
        _bottomView.leftButton.enabled=YES;
        _bottomView.rightButton.enabled=YES;
        [_bottomView.rightButton setTitle:[NSString stringWithFormat:@"确定(%lu)",(unsigned long)[ImageManager shareInstance].selectImageArray.count] forState:UIControlStateNormal];
        _bottomView.rightButton.backgroundColor=RGBACOLOR(176, 116, 67, 1);
        [_bottomView.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_bottomView.leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _bottomView.rightButton.layer.borderWidth=0.0f;
    }
    else
    {
        _bottomView.leftButton.enabled=NO;
        _bottomView.rightButton.enabled=NO;
        [_bottomView.rightButton setTitle:[NSString stringWithFormat:@"确定"] forState:UIControlStateNormal];
        [_bottomView.rightButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_bottomView.leftButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _bottomView.rightButton.backgroundColor=[UIColor clearColor];
        _bottomView.rightButton.layer.borderWidth=0.5f;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.enterType == SubsequentEnterPuzzleVC) {
        _bottomSelectView.dataArray = self.puzzleImages;
        [_bottomSelectView configData];
    }
}


-(void)startButtonClick:(UIButton *)button
{
//    PHImageRequestOptions *imageRequestOption = [[PHImageRequestOptions alloc] init];
//    imageRequestOption.synchronous = YES;
//    imageRequestOption.resizeMode = PHImageRequestOptionsResizeModeExact;
//    PHCachingImageManager *cachImageManager=[[PHCachingImageManager alloc]init];
//    double r=[UIScreen mainScreen].scale;
//    
//    NSMutableArray *imageArray=[[NSMutableArray alloc]init];
//    
//    for (NSDictionary *dict in [ImageManager shareInstance].puzzleImageArray)
//    {
//        PHAsset *asset=[dict objectForKey:@"asset"];
//        [cachImageManager requestImageForAsset:asset targetSize:CGSizeMake(ScreenWidth*r, ScreenHeight*r) contentMode:PHImageContentModeAspectFit options:imageRequestOption resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info)
//         {
//             [imageArray addObject:[result fixOrientation]];
//         }];
//    }
    if (self.enterType != SubsequentEnterPuzzleVC) {
        return;
    }
    
    if (self.puzzleImages.count < 2) {
//        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
//        [SVProgressHUD setMinimumDismissTimeInterval:1.5f];
//        [SVProgressHUD showErrorWithStatus:@"拼图功能至少需要2张图片！"];
        [MBProgressHUD showHUDAutoDismissWithString:@"拼图功能至少需要2张图片！" andDim:NO];
        return;
    }
    [[ImageManager shareInstance].puzzleImageArray removeAllObjects];
    
    CATransition* transition = [CATransition animation];
    transition.type = kCATransitionPush;//可更改为其他方式
    transition.subtype = kCATransitionFromBottom;//可更改为其他方式
    transition.removedOnCompletion = YES;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    

    PuzzleViewController *puzzleVc;
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[PuzzleViewController class]]) {
            puzzleVc = (PuzzleViewController *)vc;
            break;
        }
    }
    
    if (puzzleVc)
    {
        puzzleVc.arrImages = self.puzzleImages;
        [self.navigationController popToViewController:puzzleVc animated:NO];
    }
    else
    {
        
        UIViewController *menuVc;
        for (UIViewController *vc in self.navigationController.viewControllers)
        {
            if ([vc isKindOfClass:[MenuEditorViewController class]]) {
                menuVc = vc;
                break;
            }
        }
        
        puzzleVc = [[PuzzleViewController alloc] init];
        puzzleVc.arrImages = self.puzzleImages;
        puzzleVc.vcUsePuzzle = menuVc;
        [self.navigationController pushViewController:puzzleVc animated:NO];
    }
}


-(void)rightButtonClick:(UIButton *)button
{
    CATransition* transition = [CATransition animation];
    transition.type = kCATransitionPush;//可更改为其他方式
    transition.subtype = kCATransitionFromBottom;//可更改为其他方式
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    
    if (self.enterType==FirstEnterPhotoVC)
    {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
    else if((self.enterType==SubsequentEnterPhotoVC)||(self.enterType==SubseReplacePhotoVC))
    {
        [[ImageManager shareInstance].puzzleImageArray removeAllObjects];
        for (UIViewController *vc in self.navigationController.viewControllers)
        {
            if ([vc isKindOfClass:[MenuEditorViewController class]])
            {
                [self.navigationController popToViewController:vc animated:NO];
                break;
            }
        }
    }
    else if (self.enterType==SubseReplaceFromPersonVC)
    {
        for (UIViewController *vc in self.navigationController.viewControllers)
        {
            if ([vc isKindOfClass:[PersonalViewController class]])
            {
                [self.navigationController popToViewController:vc animated:NO];
                break;
            }
        }
    } else if (self.enterType == SubsequentEnterPuzzleVC) {
        
        [[ImageManager shareInstance].puzzleImageArray removeAllObjects];
        
        [self.puzzleImages removeAllObjects];
        [self.puzzleImages addObjectsFromArray:_tmpPuzzleImages];
        
        [_tmpPuzzleImages removeAllObjects];
        _tmpPuzzleImages = nil;
        
        NSInteger count = self.navigationController.viewControllers.count;
        UIViewController * vc;
        for (NSInteger i=count-2; i>=0; i--) {
            vc = [self.navigationController.viewControllers objectAtIndex:i];
            if ([vc isKindOfClass:[MenuEditorViewController class]] ||
                [vc isKindOfClass:[PuzzleViewController class]]) {
                break;
            }
        }
        if (vc) {
            [self.navigationController popToViewController:vc animated:NO];
        }
    }
}

-(void)bottomLeftBtnClick:(UIButton *)button
{
    PreviewViewController *previewVC = [[PreviewViewController alloc] initWithCollectionViewLayout:[PreviewViewController photoPreviewViewLayoutWithSize:[UIScreen mainScreen].bounds.size]];
    previewVC.enterType=self.enterType;
    previewVC.businessType=self.businessType;
    [self.navigationController pushViewController:previewVC animated:YES];
}

-(void)bottomRightBtnClick:(UIButton *)button
{
    CATransition* transition = [CATransition animation];
    transition.type = kCATransitionPush;//可更改为其他方式
    transition.subtype = kCATransitionFromTop;//可更改为其他方式
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    
    
    PHImageRequestOptions *imageRequestOption = [[PHImageRequestOptions alloc] init];
    imageRequestOption.synchronous = YES;
    imageRequestOption.resizeMode = PHImageRequestOptionsResizeModeExact;
    PHCachingImageManager *cachImageManager=[[PHCachingImageManager alloc]init];
    double r=[UIScreen mainScreen].scale;
    NSMutableArray *imageArray=[[NSMutableArray alloc]init];
    
    if (self.enterType==SubsequentEnterPuzzleVC)
    {
//        for (NSDictionary *dict in [ImageManager shareInstance].puzzleImageArray)
//        {
//            PHAsset *asset=[dict objectForKey:@"asset"];
//            [cachImageManager requestImageForAsset:asset targetSize:CGSizeMake(ScreenWidth*r, ScreenHeight*r) contentMode:PHImageContentModeAspectFit options:imageRequestOption resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info)
//             {
//                 [imageArray addObject:[result fixOrientation]];
//             }];
//        }
//        
//        [[ImageManager shareInstance].puzzleImageArray removeAllObjects];
//        for (UIViewController *vc in self.navigationController.viewControllers)
//        {
//            if ([vc isKindOfClass:[MenuEditorViewController class]])
//            {
//                [((MenuEditorViewController *)vc).cookProxy appendImages:imageArray];
//                [self.navigationController popToViewController:vc animated:YES];
//            }
//        }
    }
    else
    {
        for (NSDictionary *dict in [ImageManager shareInstance].selectImageArray)
        {
            PHAsset *asset=[dict objectForKey:@"asset"];
            
            CGFloat maxDim = DefaultFixScreenWidth;
            if (asset.pixelHeight > DefaultFixScreenWidth &&
                asset.pixelWidth > DefaultFixScreenWidth) {
                if (asset.pixelHeight > asset.pixelWidth) {
                    maxDim = asset.pixelHeight*DefaultFixScreenWidth/asset.pixelWidth;
                } else {
                    maxDim = asset.pixelWidth*DefaultFixScreenWidth/asset.pixelHeight;
                }
            }
            
            [cachImageManager requestImageForAsset:asset targetSize:CGSizeMake(maxDim, maxDim) contentMode:PHImageContentModeAspectFit options:imageRequestOption resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info)
//            [cachImageManager requestImageForAsset:asset targetSize:CGSizeMake(ScreenWidth*r, ScreenHeight*r) contentMode:PHImageContentModeAspectFit options:imageRequestOption resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info)
             {
                 [imageArray addObject:[result fixOrientation]];
             }];
        }
        
        [[ImageManager shareInstance].selectImageArray removeAllObjects];
        
        if (self.enterType==FirstEnterPhotoVC)
        {
            MenuEditorViewController *menuEditVC=[[MenuEditorViewController alloc]init];
            menuEditVC.businessType=self.businessType;
            
            if (self.businessType==UploadMenuBusiness)
            {
                CookBookProxy *cookBookProxy=[[CookBookProxy alloc]initWithImages:imageArray];
                menuEditVC.cookProxy=cookBookProxy;
            }
            else if (self.businessType==ShowFoodBusiness)
            {
                CookProductProxy *cookProductProxy=[[CookProductProxy alloc]initWithImages:imageArray];
                menuEditVC.cookProxy=cookProductProxy;
            }
            [self.navigationController pushViewController:menuEditVC animated:NO];
        }
        else if(self.enterType==SubsequentEnterPhotoVC)
        {
            for (UIViewController *vc in self.navigationController.viewControllers)
            {
                if ([vc isKindOfClass:[MenuEditorViewController class]])
                {
                    [((MenuEditorViewController *)vc).cookProxy appendImages:imageArray];
                    [self.navigationController popToViewController:vc animated:YES];
                }
            }
        }
    }
}


#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId=@"cellId";
    PhotoTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil)
    {
        cell=[[PhotoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    double r=[UIScreen mainScreen].scale;
    NSDictionary *dict=[self.dataArray objectAtIndex:indexPath.row];
    PHAssetCollection *collection=[dict objectForKey:@"collection"];
    PHFetchResult *result=[PHAsset fetchAssetsInAssetCollection:collection options:nil];
    NSString *str=[NSString stringWithFormat:@"%@  (%lu)",collection.localizedTitle,(unsigned long)[result count]];
    cell.albumLabel.text=str;
    NSDictionary *d=[[dict objectForKey:@"array"] firstObject];
    PHAsset *asset=[d objectForKey:@"asset"];
    
    PHImageRequestOptions *options=[[PHImageRequestOptions alloc]init];
    options.resizeMode=PHImageRequestOptionsResizeModeExact;
    [[PHImageManager defaultManager]requestImageForAsset:asset targetSize:CGSizeMake((ScreenWidth-6)/4*r,(ScreenWidth-6)/4*r) contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        cell.headImageView.image=result;
    }];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict=[self.dataArray objectAtIndex:indexPath.row];
    CATransition* transition = [CATransition animation];
    transition.type = kCATransitionPush;//可更改为其他方式
    transition.subtype = kCATransitionFromRight;//可更改为其他方式
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    self.backValue(dict);
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
