//
//  PuzzleViewController.m
//  CookBook
//
//  Created by zhangxi on 16/5/23.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "PuzzleViewController.h"
#import "NavView.h"
#import "PTStoryBoardView.h"
#import "PTContentView.h"
#import "PhotoViewController.h"
#import "ResponderViewController.h"


@interface PuzzleViewController ()<PTStoryboardViewDelegate>

@end

@implementation PuzzleViewController
{
    NavView * _navView;
    PTContentView *_ptContentView;
    PTStoryBoardView *_ptStoryboardView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNavView];
    [self initNavView];
    
    [self initContentView];
    [self initContentView];
    
    [self initAdjustButton];
    [self initAdjustButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setupStoryboardView];
    
    _ptContentView.arrImages = self.arrImages;
    [_ptContentView setStoryBoardIndex:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initContentView
{
    _ptContentView = [[PTContentView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64-49-40)];
    _ptContentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_ptContentView];
}


- (void)setupStoryboardView;
{
    if (_ptStoryboardView) {
        [_ptStoryboardView removeFromSuperview];
        _ptStoryboardView = nil;
    }
    _ptStoryboardView = [[PTStoryBoardView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-49, self.view.bounds.size.width, 49) imagesCount:self.arrImages.count];
    _ptStoryboardView.backgroundColor = [UIColor clearColor];
    _ptStoryboardView.delegate = self;
    [self.view addSubview:_ptStoryboardView];
}

- (void)didSelectedStoryboardIndex:(NSInteger)storyboardIndex forImagesCount:(NSInteger)imagesCount
{
    [_ptContentView setStoryBoardIndex:storyboardIndex];
}

- (void)initAdjustButton
{
    UIImage *image = [UIImage imageNamed:@"add_puzzle"];
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setTitle:@"添加/删除" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.frame = CGRectMake((self.view.bounds.size.width-image.size.width)/2, _navView.bounds.size.height+_ptContentView.bounds.size.height+5, image.size.width, image.size.height);
    btn.layer.cornerRadius = 3;
    
    [btn addTarget:self action:@selector(adjustImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


- (void)initNavView
{
    _navView=[[NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    [_navView.leftButton setTitle:@"取消" forState:UIControlStateNormal];
    [_navView.leftButton addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_navView.rightButton setTitle:@"完成" forState:UIControlStateNormal];
    [_navView.rightButton addTarget:self action:@selector(finishButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navView];
}

- (UIImage *)snapShotContent
{
    UIGraphicsBeginImageContextWithOptions(_ptContentView.bounds.size, YES, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [_ptContentView.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)cancelButtonClicked:(UIButton *)btn
{
    [self.navigationController popToViewController:_vcUsePuzzle animated:YES];
}

- (void)finishButtonClicked:(UIButton *)btn
{
    UIImage * image = [self snapShotContent];
    
    if ([_vcUsePuzzle isKindOfClass:[ResponderViewController class]]) {
        ResponderViewController *vc = (ResponderViewController*)_vcUsePuzzle;
        if (vc && vc.usePuzzleImage) {
            vc.usePuzzleImage(image);
            [self.navigationController popToViewController:vc animated:YES];
        }
    }
}

- (void)adjustImage:(UIButton *)btn
{
    PhotoViewController *pVc = [[PhotoViewController alloc] init];
    pVc.enterType = SubsequentEnterPuzzleVC;
    pVc.puzzleImages = self.arrImages;
    
    [self.navigationController pushViewController:pVc animated:YES];
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
