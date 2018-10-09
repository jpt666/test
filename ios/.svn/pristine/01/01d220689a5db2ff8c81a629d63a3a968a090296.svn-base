//
//  PhotoViewController.m
//  CookBook
//
//  Created by 你好 on 16/4/14.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "PhotoViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "PhotoCollectionViewCell.h"
#import "NavView.h"
#import "BottomView.h"
#import "CustomFlowLayout.h"
#import "PreviewViewController.h"
#import <Photos/Photos.h>
#import "PhotoListViewController.h"
#import "MainPageViewController.h"
#import "MenuEditorViewController.h"
#import "ImageManager.h"
#import "CookProductProxy.h"
#import "CookBookProxy.h"
#import "PersonalViewController.h"
#import "UIImage+fixOrientation.h"
#import "PuzzleViewController.h"
//#import <SVProgressHUD.h>
#import "MBProgressHUD+Helper.h"
#import "BottomSelectView.h"
#import <AVFoundation/AVFoundation.h>
#import "NSData+Md5.h"
@interface PhotoViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong)NSMutableArray *selectArray;

@end

#define GROUPNUM @"GroupNum"
#define GROUPNAME @"GroupName"
#define PHOTOARRAY  @"photoArray"
static NSString *cellIdentifier = @"PhotoListCell";

@implementation PhotoViewController
{
    __block NSMutableArray *_dataArray;
    ALAssetsLibrary *library;
    __block NSMutableArray *_allArray;
    __block NSMutableDictionary *_dictIndexPath2Image;
    NSMutableArray *_photoArray;
    UICollectionView *_collectionView;
    NavView *_navView;
    BottomView *_bottomView;
    BottomSelectView *_bottomSelectView;
    
    NSMutableArray * _tmpPuzzleImages;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addObserver:self forKeyPath:@"selectArray" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"dataSourceSizeChanged"];
    
    if (self.enterType == SubsequentEnterPuzzleVC) {
        _bottomSelectView.dataArray = self.puzzleImages;
        [_bottomSelectView configData];
        
        if (!_tmpPuzzleImages.count) {
            _tmpPuzzleImages = [self.puzzleImages mutableCopy];
        }
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self removeObserver:self forKeyPath:@"selectArray"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    
    _dataArray=[[NSMutableArray alloc] initWithCapacity:0];
    _allArray=[[NSMutableArray alloc] initWithCapacity:0];
    _dictIndexPath2Image = [[NSMutableDictionary alloc] initWithCapacity:0];
    self.selectArray=[[NSMutableArray alloc]initWithCapacity:0];
    
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    
    _navView=[[NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navView.leftButton.frame=CGRectMake(-5, 20, 50, 44);
    _navView.rightButton.frame=CGRectMake(ScreenWidth-55, 20, 50, 44);
    [_navView.leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_navView.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_navView.rightButton setTitle:@"取消" forState:UIControlStateNormal];
    [_navView.rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navView];
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
//    CustomFlowLayout *flowLayout=[[CustomFlowLayout alloc]init];
    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) collectionViewLayout:flowLayout];
    _collectionView.dataSource=self;
    _collectionView.delegate=self;
    _collectionView.backgroundColor=[UIColor clearColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    _collectionView.alwaysBounceVertical=YES;
//    if (IS_IOS_8)
//    {
//        [_collectionView registerClass:[CollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];//注册header的view
//    }
    [_collectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    [self.view addSubview:_collectionView];
    
    
    
    if ((self.enterType!=SubseReplacePhotoVC)&&(self.enterType!=SubseReplaceFromPersonVC)&&(self.enterType!=SubsequentEnterPuzzleVC))
    {
        _collectionView.contentInset=UIEdgeInsetsMake(0, 0, 150, 0);

        _bottomView=[[BottomView alloc]initWithFrame:CGRectMake(0, ScreenHeight-49, ScreenWidth, 49)];
        [_bottomView.leftButton setTitle:@"预览" forState:UIControlStateNormal];
        _bottomView.leftButton.enabled=NO;
        _bottomView.rightButton.enabled=NO;
        _bottomView.leftButton.layer.borderColor=[UIColor lightGrayColor].CGColor;
        [_bottomView.rightButton setTitle:@"确定" forState:UIControlStateNormal];
        _bottomView.layer.borderColor=[UIColor lightGrayColor].CGColor;
        [_bottomView.leftButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
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
        [self.view addSubview:_bottomSelectView];
        
        _collectionView.frame=CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-_bottomSelectView.bounds.size.height);
        
        [_bottomSelectView.startButton addTarget:self action:@selector(startButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if  (!self.puzzleImages) {
            self.puzzleImages = [NSMutableArray array];
        }
        
    }
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (status == PHAuthorizationStatusDenied) {
                [MBProgressHUD showHUDAutoDismissWithString:@"请到系统设置界面打开相册访问权限" andDim:NO];
            } else if (status == PHAuthorizationStatusAuthorized) {
                [self loadPhotos];
            }
        });
    }];
    
    
//    library = [[ALAssetsLibrary alloc] init];
//    dispatch_queue_t dispatchQueue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_async(dispatchQueue, ^(void) {
//        [library enumerateGroupsWithTypes:ALAssetsGroupAll
//                               usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
//                                   // 遍历每个相册中的项ALAsset
//                                   if ([group numberOfAssets]>0)
//                                   {
//                                        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
//                                        [dict setObject:[NSNumber numberWithInteger:[group numberOfAssets]] forKey:GROUPNUM];
//                                        [dict setObject:[group valueForProperty:ALAssetsGroupPropertyName] forKey:GROUPNAME];
//                                       __block  NSMutableArray *photoArray=[[NSMutableArray alloc]init];
//                                       [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index,BOOL *stop) {
//                                           if (result)
//                                           {
//                              
//                                               NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
//                                               [dict setObject:result forKey:@"asset"];
//                                               [dict setObject:[NSNumber numberWithBool:NO] forKey:@"isSelected"];
//                                               [photoArray addObject:dict];
//                                           }
//                                       }];
//                                       [dict setObject:photoArray forKey:PHOTOARRAY];
//                                       [_allArray addObjectsFromArray:photoArray];
//                                       [_dataArray addObject:dict];
//                                       dispatch_async(dispatch_get_main_queue(), ^{
//                                           [_collectionView reloadData];
//                                       });
//                                   }
//                               }
//                             failureBlock:^(NSError *error) {
//                                 NSLog(@"Failed to enumerate the asset groups.");
//                             }];
//    });
}


- (void)loadPhotos
{
    PHFetchOptions *option=[[PHFetchOptions alloc]init];
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    
    PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
    PHFetchResult *resultAll=[PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAny options:nil];
    
    NSMutableArray *assetArray=[[NSMutableArray alloc]initWithCapacity:0];
    
    for (PHAssetCollection *collection in result)
    {
        PHFetchResult *resultAsset=[PHAsset fetchAssetsInAssetCollection:collection options:option];
        if ([resultAsset count]>0)
        {
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            [dict setObject:collection forKey:@"collection"];
            NSMutableArray *array=[[NSMutableArray alloc]init];
            for (PHAsset *asset in resultAsset)
            {
                [assetArray addObject:asset];
                NSMutableDictionary *dictory=[[NSMutableDictionary alloc]init];
                [dictory setObject:[NSNumber numberWithBool:NO] forKey:@"isSelected"];
                [dictory setObject:asset forKey:@"asset"];
                [array addObject:dictory];
            }
            
            [dict setObject:array forKey:@"array"];
            [_dataArray insertObject:dict atIndex:0];
            [_allArray addObjectsFromArray:[dict objectForKey:@"array"]];
            _navView.centerLabel.text=collection.localizedTitle;
        }
    }
    
    for (PHAssetCollection *collection in resultAll)
    {
        PHFetchResult *result =[PHAsset fetchAssetsInAssetCollection:collection options:option];
        if ([result count]>0)
        {
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            
            [dict setObject:collection forKey:@"collection"];
            
            NSMutableArray *array=[[NSMutableArray alloc]init];
            for (PHAsset *asset in result)
            {
                [assetArray addObject:asset];
                NSMutableDictionary *dictory=[[NSMutableDictionary alloc]init];
                [dictory setObject:[NSNumber numberWithBool:NO] forKey:@"isSelected"];
                [dictory setObject:asset forKey:@"asset"];
                [array addObject:dictory];
            }
            [dict setObject:array forKey:@"array"];
            [_dataArray addObject:dict];
        }
    }
    
    
    
    [_collectionView reloadData];
}

-(void)startButtonClick:(UIButton *)button
{
    if (self.enterType != SubsequentEnterPuzzleVC) {
        return;
    }
    
    if (self.puzzleImages.count < 2) {
        
//        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
//        [SVProgressHUD setMinimumDismissTimeInterval:1.5f];
//        [SVProgressHUD showInfoWithStatus:@"拼图功能至少需要2张图片！"];
        [MBProgressHUD showHUDAutoDismissWithString:@"拼图功能至少需要2张图片！" andDim:NO];
        
        return;
    }
    
    
    CATransition* transition = [CATransition animation];
    transition.type = kCATransitionPush;//可更改为其他方式
    transition.subtype = kCATransitionFromBottom;//可更改为其他方式
    transition.removedOnCompletion = YES;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    
    [[ImageManager shareInstance].puzzleImageArray removeAllObjects];
    
    PuzzleViewController *puzzleVc;
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[PuzzleViewController class]]) {
            puzzleVc = (PuzzleViewController *)vc;
            break;
        }
    }
    
    if (puzzleVc) {
        puzzleVc.arrImages = self.puzzleImages;
        [self.navigationController popToViewController:puzzleVc animated:NO];
    } else {
        
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

-(void)leftButtonClick:(UIButton *)button
{
    CATransition* transition = [CATransition animation];
    transition.type = kCATransitionPush;//可更改为其他方式
    transition.subtype = kCATransitionFromLeft;//可更改为其他方式
    
    PhotoListViewController *photoListVC=[[PhotoListViewController alloc]init];
    photoListVC.dataArray=_dataArray;
    photoListVC.enterType=self.enterType;
    photoListVC.businessType=self.businessType;
    photoListVC.puzzleImages = self.puzzleImages;
    photoListVC.tmpPuzzleImages = _tmpPuzzleImages;
    photoListVC.backValue=^(NSDictionary *dict){
        PHAssetCollection *collection = [dict objectForKey:@"collection"];
        _navView.centerLabel.text=collection.localizedTitle;
        [_allArray removeAllObjects];
        [_allArray addObjectsFromArray:[dict objectForKey:@"array"]];
        [_dictIndexPath2Image removeAllObjects];
        [_collectionView reloadData];
    };
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:photoListVC animated:NO];
}

-(void)rightButtonClick:(UIButton *)button
{
    if (self.enterType==SubsequentEnterPuzzleVC)
    {
        [[ImageManager shareInstance].puzzleImageArray removeAllObjects];
        
        [self.puzzleImages removeAllObjects];
        [self.puzzleImages addObjectsFromArray:_tmpPuzzleImages];
        
        [_tmpPuzzleImages removeAllObjects];
        _tmpPuzzleImages = nil;
    }
    
    CATransition* transition = [CATransition animation];
    transition.type = kCATransitionPush;//可更改为其他方式
    transition.subtype = kCATransitionFromBottom;//可更改为其他方式
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController popViewControllerAnimated:NO];
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
    transition.subtype = kCATransitionFromBottom;//可更改为其他方式
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
//        [[ImageManager shareInstance].puzzleImageArray removeAllObjects];
//        
//        UIViewController *vc;
//        for (vc in self.navigationController.viewControllers) {
//            if ([vc isKindOfClass:[PuzzleViewController class]]) {
//            }
//        }
//        
//        PuzzleViewController *pVc = [[PuzzleViewController alloc] init];
//        pVc.arrImages = imageArray;
//        [self.navigationController pushViewController:pVc animated:NO];

//        for (UIViewController *vc in self.navigationController.viewControllers)
//        {
//            if ([vc isKindOfClass:[MenuEditorViewController class]])
//            {
//                [((MenuEditorViewController *)vc).cookProxy appendImages:imageArray];
//                [self.navigationController popToViewController:vc animated:NO];
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
//            [cachImageManager requestImageForAsset:asset targetSize:CGSizeMake(ScreenWidth*r, ScreenHeight*r) contentMode:PHImageContentModeAspectFit options:imageRequestOption resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info)
//             {682d0cfb5ad1cdda82797ee03e3243f1
//                 [imageArray addObject:[result fixOrientation]];
//             }];
            [cachImageManager requestImageForAsset:asset targetSize:CGSizeMake(maxDim, maxDim) contentMode:PHImageContentModeAspectFit options:imageRequestOption resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info)
             {
                 [imageArray addObject:[result fixOrientation]];
             }];

        }
        
        [[ImageManager shareInstance].selectImageArray removeAllObjects];
        
        if (self.enterType==FirstEnterPhotoVC)
        {
            MenuEditorViewController *menuEditVC=[[MenuEditorViewController alloc]init];
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
            menuEditVC.businessType=self.businessType;
            
            [self.navigationController pushViewController:menuEditVC animated:NO];
        }
        else if(self.enterType==SubsequentEnterPhotoVC)
        {
            for (UIViewController *vc in self.navigationController.viewControllers)
            {
                if ([vc isKindOfClass:[MenuEditorViewController class]])
                {
                    [((MenuEditorViewController *)vc).cookProxy appendImages:imageArray];
                    [self.navigationController popToViewController:vc animated:NO];
                }
            }
        }
    }
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"selectArray"])
    {
        if (self.selectArray.count>0)
        {
            _bottomView.rightButton.enabled=YES;
            _bottomView.leftButton.enabled=YES;
            [_bottomView.rightButton setTitle:[NSString stringWithFormat:@"确定(%lu)",(unsigned long)self.selectArray.count] forState:UIControlStateNormal];
            _bottomView.rightButton.backgroundColor=RGBACOLOR(176, 116, 67, 1);
            [_bottomView.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_bottomView.leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            _bottomView.rightButton.layer.borderWidth=0.0f;
        }
        else
        {
            _bottomView.rightButton.enabled=NO;
            _bottomView.leftButton.enabled=NO;
            [_bottomView.rightButton setTitle:[NSString stringWithFormat:@"确定"] forState:UIControlStateNormal];
            [_bottomView.rightButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [_bottomView.leftButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            _bottomView.rightButton.backgroundColor=[UIColor clearColor];
            _bottomView.rightButton.layer.borderWidth=0.5f;
        }
    }
}



#pragma mark - UICollectionViewDeleagte
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSDictionary *dict=[_allArray objectAtIndex:indexPath.row];

    if (_dictIndexPath2Image[@(indexPath.row)])
    {
        cell.imageView.image = _dictIndexPath2Image[@(indexPath.row)];
    }
    else
    {
        PHAsset *asset=[dict objectForKey:@"asset"];
        
        double r=[UIScreen mainScreen].scale;
        
        PHImageRequestOptions *options=[[PHImageRequestOptions alloc]init];
        options.resizeMode=PHImageRequestOptionsResizeModeExact;
        
        [[PHImageManager defaultManager]requestImageForAsset:asset targetSize:CGSizeMake(PHOTO_LIST_SIZE.width*r,PHOTO_LIST_SIZE.height*r) contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            cell.imageView.image=result;
            _dictIndexPath2Image[@(indexPath.row)] = result;
        }];
    }

    if ([[dict objectForKey:@"isSelected"] boolValue])
    {
        cell.selectView.hidden=NO;
        NSInteger index=[self.selectArray indexOfObject:dict];
        cell.selectView.text=[NSString stringWithFormat:@"%ld",(long)index+1];
    }
    else
    {
        cell.selectView.hidden=YES;
    }
    return cell;
}


//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _allArray.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    if (self.isMoment==NO)
//    {
//        if (section==0)
//        {
//            return CGSizeZero;
//        }
//    }
//    else
//    {
//        return CGSizeMake(ScreenWidth, 40);
//    }
//    
//    return CGSizeZero;
//}
//
////显示header和footer的回调方法
//
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    //如果想要自定义header，只需要定义UICollectionReusableView的子类A，然后在该处使用，注意AIdentifier要设为注册的字符串，此处为“header”
//    if (kind == UICollectionElementKindSectionHeader)
//    {
//        NSDictionary *dict=[_dataArray objectAtIndex:indexPath.section];
//        
//        CollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
//        NSDateFormatter *dateFormate=[[NSDateFormatter alloc]init];
//        [dateFormate setDateFormat:@"yyyy MM dd"];
//        PHAssetCollection *collection=[dict objectForKey:@"collection"];
//        
//        if (collection.localizedTitle.length>0)
//        {
//            view.label.text=[NSString stringWithFormat:@"%@  %@",[dateFormate stringFromDate:collection.startDate],collection.localizedTitle];
//        }
//        else
//        {
//            view.label.text=[NSString stringWithFormat:@"%@",[dateFormate stringFromDate:collection.startDate]];
//        }
//        
//        view.backgroundColor=[UIColor colorWithWhite:1 alpha:0.7];
//        return view;
//    }
//    return nil;
//}


//定义每个UICollectionView 的大小
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


//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *dict=[_allArray objectAtIndex:indexPath.row];
    
    if((self.enterType==SubseReplacePhotoVC)||(self.enterType==SubseReplaceFromPersonVC))
    {
        PHImageRequestOptions *imageRequestOption = [[PHImageRequestOptions alloc] init];
        imageRequestOption.synchronous = YES;
        imageRequestOption.resizeMode = PHImageRequestOptionsResizeModeExact;
        PHCachingImageManager *cachImageManager=[[PHCachingImageManager alloc]init];
        double r=[UIScreen mainScreen].scale;
        
        
        PHAsset * asset = [dict objectForKey:@"asset"];
        
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
        
//        [cachImageManager requestImageForAsset:[dict objectForKey:@"asset"] targetSize:CGSizeMake(ScreenWidth*r, ScreenHeight*r) contentMode:PHImageContentModeAspectFit options:imageRequestOption resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info)
         {
             self.backImageValue(result);
             for (UIViewController *vc in self.navigationController.viewControllers)
             {
                 if (self.enterType==SubseReplacePhotoVC)
                 {
                     if ([vc isKindOfClass:[MenuEditorViewController class]])
                     {
                         [self.navigationController popToViewController:vc animated:YES];
                     }
                 }
                 else if (self.enterType==SubseReplaceFromPersonVC)
                 {
                     if ([vc isKindOfClass:[PersonalViewController class]])
                     {
                         [self.navigationController popToViewController:vc animated:YES];
                     }
                 }
             }
         }];
    }
    else if(self.enterType==SubsequentEnterPuzzleVC)
    {
        if (self.puzzleImages.count >= 6)
        {
//            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
//            [SVProgressHUD setMinimumDismissTimeInterval:1.5f];
//            [SVProgressHUD showErrorWithStatus:@"最多只能选6张"];
            
            [MBProgressHUD showHUDAutoDismissWithString:@"最多只能选6张" andDim:NO];
        }
        else
        {
            PHAsset *asset=[dict objectForKey:@"asset"];
            double r=[UIScreen mainScreen].scale;
            PHImageRequestOptions *options=[[PHImageRequestOptions alloc]init];
            options.resizeMode=PHImageRequestOptionsResizeModeExact;
            
            [[PHImageManager defaultManager]requestImageForAsset:asset targetSize:CGSizeMake(ScreenWidth*r,  asset.pixelHeight*ScreenWidth/asset.pixelWidth*r) contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                
                if ([info[PHImageResultIsDegradedKey] integerValue] == 0) {
                    [self.puzzleImages addObject:result];
                    [_bottomSelectView configData];
                }
            }];
            
            [ImageManager shareInstance].puzzleImageArray = [self mutableArrayValueForKey:@"selectArray"];
            [[ImageManager shareInstance].puzzleImageArray addObject:dict];
        }
    }
    else
    {
        if ([[dict objectForKey:@"isSelected"] boolValue])
        {
            [dict setObject:[NSNumber numberWithBool:NO] forKey:@"isSelected"];
            
            [ImageManager shareInstance].selectImageArray = [self mutableArrayValueForKey:@"selectArray"];
            [[ImageManager shareInstance].selectImageArray removeObject:dict];
        }
        else
        {
            [dict setObject:[NSNumber numberWithBool:YES] forKey:@"isSelected"];
            
            [ImageManager shareInstance].selectImageArray = [self mutableArrayValueForKey:@"selectArray"];
            [[ImageManager shareInstance].selectImageArray addObject:dict];
        }
        
        [_collectionView reloadData];
    }
}


//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
