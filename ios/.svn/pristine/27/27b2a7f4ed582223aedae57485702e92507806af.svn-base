//
//  PreviewViewController.m
//  CookBook
//
//  Created by 你好 on 16/4/14.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "PreviewViewController.h"
#import "PreviewCollectionViewCell.h"
#import "MenuEditorViewController.h"
#import "ImageManager.h"
#import <Photos/Photos.h>
#import "CookProductProxy.h"
#import "CookBookProxy.h"
#import "UIImage+fixOrientation.h"
#import "PersonalViewController.h"
#import "BottomView.h"
@interface PreviewViewController ()<PreViewCollectionCellSingleTapDelegate>

@end

@implementation PreviewViewController
{
    UIView *_topBar;
    UILabel *_topLabel;
    BottomView *_bottomView;
}
static NSString * const reuseIdentifier = @"PreviewCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.scrollsToTop = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.contentSize = CGSizeMake(self.view.frame.size.width * [ImageManager shareInstance].selectImageArray.count, self.view.frame.size.height);
    self.collectionView.pagingEnabled = YES;
    [self.collectionView registerClass:[PreviewCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    _topBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
//    _topBar.backgroundColor = RGBACOLOR(250, 133, 39, 1);
    _topBar.backgroundColor= [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.7];
    [self.view addSubview:_topBar];

    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, _topBar.bounds.size.height-1, _topBar.bounds.size.width, 1)];
    lineView.backgroundColor=RGBACOLOR(1, 1, 1, 0.1);
    [_topBar addSubview:lineView];
    
    UIImage *backImage=[UIImage imageNamed:@"back"];
    UIButton *backButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame =CGRectMake(0, 20, 50, 44);;
    [backButton setImage:backImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_topBar addSubview:backButton];
    
    _topLabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-50, 26,30, 30)];
    _topLabel.backgroundColor=RGBACOLOR(176, 116, 67, 1);
    _topLabel.textColor=[UIColor whiteColor];
    _topLabel.font=[UIFont systemFontOfSize:16];
    _topLabel.layer.cornerRadius=15;
    _topLabel.clipsToBounds=YES;
    _topLabel.textAlignment=NSTextAlignmentCenter;
    _topLabel.text=[NSString stringWithFormat:@"%d",(int)(self.collectionView.contentOffset.x/ScreenWidth+1)];
    [_topBar addSubview:_topLabel];
    
    NSString *str=[NSString stringWithFormat:@"确定(%lu)",[ImageManager shareInstance].selectImageArray.count];
    _bottomView=[[BottomView alloc]initWithFrame:CGRectMake(0, ScreenHeight-49, ScreenWidth, 49)];
    _bottomView.leftButton.hidden=YES;
    _bottomView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _bottomView.rightButton.layer.borderWidth=0.0f;
    _bottomView.rightButton.backgroundColor=RGBACOLOR(176, 116, 67, 1);
    [_bottomView.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_bottomView.rightButton setTitle:str forState:UIControlStateNormal];
    [_bottomView.rightButton addTarget:self action:@selector(okButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_bottomView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)okButtonClick:(UIButton *)button
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
        for (NSDictionary *dict in [ImageManager shareInstance].puzzleImageArray)
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
        
        [[ImageManager shareInstance].puzzleImageArray removeAllObjects];
        for (UIViewController *vc in self.navigationController.viewControllers)
        {
            if ([vc isKindOfClass:[MenuEditorViewController class]])
            {
                [((MenuEditorViewController *)vc).cookProxy appendImages:imageArray];
                [self.navigationController popToViewController:vc animated:YES];
            }
        }
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
        
        if((self.enterType==SubsequentEnterPhotoVC)||(self.enterType==SubseReplacePhotoVC))
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
        else if (self.enterType==FirstEnterPhotoVC)
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
        else if (self.enterType==SubseReplaceFromPersonVC)
        {
            for (UIViewController *vc in self.navigationController.viewControllers)
            {
                if ([vc isKindOfClass:[PersonalViewController class]])
                {
                    [self.navigationController popToViewController:vc animated:YES];
                }
            }
        }
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

#pragma mark - PreViewCollectionCellSingleTapDelegate
-(void)singleTap
{
    if (_topBar.frame.origin.y==0)
    {
        [UIView animateWithDuration:0.15 animations:^{
            _topBar.frame=CGRectMake(0, -64, ScreenWidth, 64);
            _bottomView.frame=CGRectMake(0, ScreenHeight, ScreenWidth, 50);
        }];
    }
    else
    {
        [UIView animateWithDuration:0.15 animations:^{
            _topBar.frame=CGRectMake(0, 0, ScreenWidth, 64);
            _bottomView.frame=CGRectMake(0, ScreenHeight-50, ScreenWidth, 50);
        }];
    }
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _topLabel.text=[NSString stringWithFormat:@"%d",(int)(self.collectionView.contentOffset.x/ScreenWidth+1)];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(self.enterType==SubsequentEnterPuzzleVC)
    {
        return [ImageManager shareInstance].puzzleImageArray.count;
    }
    else
    {
        return [ImageManager shareInstance].selectImageArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PreviewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSDictionary *dict=nil;
    if(self.enterType==SubsequentEnterPuzzleVC)
    {
        dict=[[ImageManager shareInstance].puzzleImageArray objectAtIndex:indexPath.row];
    }
    else
    {
        dict=[[ImageManager shareInstance].selectImageArray objectAtIndex:indexPath.row];
    }

    PHImageRequestOptions *imageRequestOption = [[PHImageRequestOptions alloc] init];
    imageRequestOption.synchronous = YES;
    imageRequestOption.resizeMode = PHImageRequestOptionsResizeModeExact;
    PHCachingImageManager *cachImageManager=[[PHCachingImageManager alloc]init];
    double r=[UIScreen mainScreen].scale;
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
//    [cachImageManager requestImageForAsset:asset targetSize:CGSizeMake(ScreenWidth*r, ScreenHeight*r) contentMode:PHImageContentModeAspectFit options:imageRequestOption resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info)
    {
        [cell configCellWithImage:result];
    }];
    
    cell.delegate=self;
    return cell;
}

#pragma mark <UICollectionViewDelegate>


/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

+ (UICollectionViewLayout *)photoPreviewViewLayoutWithSize:(CGSize)size {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(size.width, size.height);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    return layout;
}


@end
