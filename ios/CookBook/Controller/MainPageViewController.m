//
//  MainViewController.m
//  CookBook
//
//  Created by zhangxi on 16/4/7.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "MainPageViewController.h"
#import "ShoppingCartView.h"
#import "TopScrollView.h"
#import "TitleView.h"
#import "GradientImageView.h"
#import "CategoryView.h"
#import "HotSellGoodsCell.h"
#import "UserManager.h"
#import "GroupsPropertyKeys.h"
#import "CommodityDetailViewController.h"
#import "GroupPurDetailViewController.h"
#import "WebViewController.h"
#import "DetailContentViewController.h"
#import "CookbookReformer.h"
#import "CookProductReformer.h"
#import "CookRecipeIndexReformer.h"
#import "MJRefresh.h"
#import "GoodsPropertyKeys.h"
#import "MBProgressHUD+Helper.h"
#import "UIImage+GIF.h"
#import "DictImageView.h"

@interface MainPageViewController ()<UITableViewDelegate,UITableViewDataSource,RetrieveRequestDelegate,UIScrollViewDelegate>



@end

@implementation MainPageViewController
{
    UIScrollView *_scrollView;
    TitleView *_titleView;
    GradientImageView *_gradientImageView;
    CategoryView *_categoryView;
    TitleView *_tableHeadView;
    UITableView *_tableView;
    UILabel *_titlelabel;
    UILabel *_subTitleLabel;
    UIView *_centerLineView;
    UIView *_lineView;
    TopScrollView *_topScrollView;
    NSMutableArray *_dataArray;
    
    CGFloat _tableViewOffset;
    
    NSDictionary * _dataObject;
    
    RetrieveRequest * _businessIndexRequest;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.view.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    
    [self.rdv_tabBarController setTabBarHidden:NO animated:NO];
    
    _dataArray=[[NSMutableArray alloc]initWithCapacity:0];
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth , ScreenHeight-49)];
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:_scrollView];
    
    NSMutableArray *imageArray=[[NSMutableArray alloc]init];
    for (int j=0; j<4; j++)
    {
        NSString *str=[NSString stringWithFormat:@""];
        [imageArray addObject:str];
    }
    
    _topScrollView=[[TopScrollView alloc]initWithframe:CGRectMake(0, 0, ScreenWidth, (ScreenWidth/320)*220) andImages:imageArray];
    _topScrollView.delegate=self;
    [_scrollView addSubview:_topScrollView];
    
    _titleView=[[TitleView alloc]initWithFrame:CGRectMake(0, _topScrollView.frame.size.height+_topScrollView.frame.origin.y, ScreenWidth, 40)];
    _titleView.frontView.backgroundColor=RGBACOLOR(73, 139, 46, 1);
    _titleView.titleLabel.text=@"人气推荐";
    [_scrollView addSubview:_titleView];
    
    _gradientImageView=[[GradientImageView alloc]initWithFrame:CGRectMake(0, _titleView.frame.origin.y+_titleView.frame.size.height, ScreenWidth,  (ScreenWidth-18)/16*9)];
    [_scrollView addSubview:_gradientImageView];
    
    _titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(0,_gradientImageView.frame.size.height/2-25, _gradientImageView.frame.size.width, 20)];
    _titlelabel.font=[UIFont systemFontOfSize:16];
    _titlelabel.textColor=[UIColor whiteColor];
    _titlelabel.textAlignment=NSTextAlignmentCenter;
    [_gradientImageView addSubview:_titlelabel];
    
    _centerLineView=[[UIView alloc]initWithFrame:CGRectZero];
    _centerLineView.backgroundColor=[UIColor whiteColor];
    [_gradientImageView addSubview:_centerLineView];
    
    _subTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, _gradientImageView.frame.size.height/2+6, _gradientImageView.frame.size.width, 20)];
    _subTitleLabel.textColor=[UIColor whiteColor];
    _subTitleLabel.font=[UIFont boldSystemFontOfSize:20];
    _subTitleLabel.shadowColor=RGBACOLOR(1, 1, 1, 0.5);
    _subTitleLabel.shadowOffset= CGSizeMake(0, -1.0);
    _subTitleLabel.textAlignment=NSTextAlignmentCenter;
    [_gradientImageView addSubview:_subTitleLabel];
    
    UIImage *mainPageLeftImage=[UIImage imageNamed:@"mainPage_left"];
    
    UITapGestureRecognizer *tapLeftGesuture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(categoryTapGesture:)];
    tapLeftGesuture.numberOfTapsRequired=1;
    tapLeftGesuture.numberOfTouchesRequired=1;
    
    UITapGestureRecognizer *tapRightTopGesuture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(categoryTapGesture:)];
    tapRightTopGesuture.numberOfTapsRequired=1;
    tapRightTopGesuture.numberOfTouchesRequired=1;
    
    UITapGestureRecognizer *tapRightBottomGesuture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(categoryTapGesture:)];
    tapRightBottomGesuture.numberOfTapsRequired=1;
    tapRightBottomGesuture.numberOfTouchesRequired=1;
    
    _categoryView=[[CategoryView alloc]initWithFrame:CGRectMake(0, _gradientImageView.frame.origin.y+_gradientImageView.frame.size.height, ScreenWidth,(ScreenWidth/2*mainPageLeftImage.size.height)/mainPageLeftImage.size.width)];
    [_categoryView.leftImageView addGestureRecognizer:tapLeftGesuture];
    [_categoryView.rightTopImageView addGestureRecognizer:tapRightTopGesuture];
    [_categoryView.rightBottomImageView addGestureRecognizer:tapRightBottomGesuture];
    [_scrollView addSubview:_categoryView];
    
    _lineView=[[UIView alloc]initWithFrame:CGRectMake(0, _categoryView.frame.origin.y+_categoryView.frame.size.height, ScreenWidth, 10)];
    _lineView.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    [_scrollView addSubview:_lineView];
    
    _tableHeadView=[[TitleView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    _tableHeadView.frontView.backgroundColor=RGBACOLOR(176, 116, 67, 1);
    _tableHeadView.titleLabel.text=@"热销商品";
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _lineView.frame.origin.y+_lineView.frame.size.height, ScreenWidth, ScreenHeight-49) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.scrollEnabled = NO;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    [_scrollView addSubview:_tableView];
    
    _tableViewOffset = _tableView.frame.origin.y - _scrollView.frame.origin.y;
    
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshBusinessIndex];
    }];
    [header setTitle:@"正在获取数据中..." forState:MJRefreshStateRefreshing];
    _scrollView.mj_header = header;
    
    _tableView.tableHeaderView=_tableHeadView;
    
    _scrollView.contentSize=CGSizeMake(ScreenWidth, _tableView.frame.origin.y+_tableView.frame.size.height);
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
    
    if (!_dataObject) {
        [MBProgressHUD showLoadingWithDim:NO];
        [self refreshBusinessIndex];
    }
}


- (void)applicationDidBecomeActive:(NSNotification *)notify
{
    [self refreshBusinessIndex];
}


- (void)refreshBusinessIndex
{
    if(_businessIndexRequest) {
        [_businessIndexRequest cancel];
    }
    
    _businessIndexRequest = [[RetrieveRequest alloc] init];
    _businessIndexRequest.delegate = self;
    [_businessIndexRequest getRequestWithUrl:[GlobalVar shareGlobalVar].businessIndexUrl andParam:nil];
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _scrollView) {
        if (_scrollView.contentOffset.y>=_tableViewOffset) {
            _tableView.frame = CGRectMake(_tableView.frame.origin.x, _scrollView.contentOffset.y, _tableView.frame.size.width, _tableView.frame.size.height);
            
            [_tableView setContentOffset:CGPointMake(0, _scrollView.contentOffset.y-_tableViewOffset)];
        } else {
            _tableView.frame = CGRectMake(_tableView.frame.origin.x, _scrollView.frame.origin.y+_tableViewOffset, _tableView.frame.size.width, _tableView.frame.size.height);
            [_tableView setContentOffset:CGPointMake(0, 0)];
        }
    }
}


#pragma mark - UITableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"HotSellGoodsCell";
    HotSellGoodsCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil)
    {
        cell=[[HotSellGoodsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSDictionary *dict=[_dataArray objectAtIndex:indexPath.row];
    [cell configData:dict andIndexpath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *priceBackImage=[UIImage imageNamed:@"price_back_icon"];
    NSDictionary *dict=[_dataArray objectAtIndex:indexPath.row];
    NSString *descStr=dict[@"product"][kGoodsPropertyDesc];
    return ScreenWidth/16*9+100+priceBackImage.size.height+[HotSellGoodsCell heightForText:descStr];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict=[_dataArray objectAtIndex:indexPath.row];
    
    CommodityDetailViewController *commodityDetailVC=[[CommodityDetailViewController alloc]init];
    commodityDetailVC.vcFromType=FromMainPageVC;
    commodityDetailVC.detailGoods=dict[@"product"];
    [self.navigationController pushViewController:commodityDetailVC animated:YES];
}


//-(double)heightForText:(NSString *)str
//{
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    [paragraphStyle setLineSpacing:7];//调整行间距
//    
//    CGRect rect= [str boundingRectWithSize:CGSizeMake(ScreenWidth-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSParagraphStyleAttributeName:paragraphStyle} context:nil];
//    
//    double height=rect.size.height;
//    if (height>70)
//    {
//        height=70;
//    }
//    return height;
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - RetrieveRequestDelegate
-(void)didRetrieveDataSuccess:(RetrieveRequest *)request
{
    if (request == _businessIndexRequest) {
        [MBProgressHUD dismissHUD];
        _dataObject = [NSDictionary dictionaryWithDictionary:request.rawData];
        if ([_scrollView.mj_header isRefreshing])
        {
            [_scrollView.mj_header endRefreshing];
        }
        [self configMainPageData:_dataObject];
    }
}

-(void)didRetrieveDataFailed:(RetrieveRequest *)request
{
    if (request == _businessIndexRequest) {
        if ([_scrollView.mj_header isRefreshing]) {
            [_scrollView.mj_header endRefreshing];
        }
    }
    
    [MBProgressHUD showHUDAutoDismissWithError:request.error andDim:NO];
}

#pragma mark - TopScrollViewDelegate

-(void)didSelectImageView:(NSDictionary *)dict
{
    if ([dict[@"category"] isEqualToString:@"web"])
    {
        WebViewController *webVC=[[WebViewController alloc]init];
        webVC.url=dict[@"source"];
        [self.navigationController pushViewController:webVC animated:YES];
    }
    else if ([dict[@"category"] isEqualToString:@"bulk"])
    {
        GroupPurDetailViewController *groupPurDetailVC=[[GroupPurDetailViewController alloc]init];
        groupPurDetailVC.detailUrl=dict[@"source"];
        [self.navigationController pushViewController:groupPurDetailVC animated:YES];
    }
    else if ([dict[@"category"] isEqualToString:@"dish"])
    {
        DetailContentViewController *detailContentVC=[[DetailContentViewController alloc]init];
        detailContentVC.dict= [CookProductReformer convertLocalProductDataFromNetProduct:dict[@"source"]];
        detailContentVC.cookType=CookProductType;
        [self.navigationController pushViewController:detailContentVC animated:YES];
    }
    else if ([dict[@"category"] isEqualToString:@"recipe"])
    {
        DetailContentViewController *detailContentVC=[[DetailContentViewController alloc]init];
        detailContentVC.dict= [CookBookReformer convertLocalBookDataFromNetBook:dict[@"source"]];
        detailContentVC.cookType=CookBookType;
        [self.navigationController pushViewController:detailContentVC animated:YES];
    }
}




#pragma mark - CategroyBtnClick

-(void)categoryTapGesture:(UITapGestureRecognizer *)tapGesture
{
    DictImageView *imageView=(DictImageView *)tapGesture.view;
    NSDictionary * detailGoods = imageView.dict[@"product"];
    
    if (detailGoods)
    {
        CommodityDetailViewController *commodityDetailVC=[[CommodityDetailViewController alloc]init];
        commodityDetailVC.vcFromType=FromMainPageVC;
        commodityDetailVC.detailGoods= detailGoods;
        [self.navigationController pushViewController:commodityDetailVC animated:YES];
    }
}

-(void)configMainPageData:(NSDictionary *)object
{
    _topScrollView.imageArray=object[@"slides"];
    [_topScrollView configData];
    
    _dataArray=object[@"hot_products"];
    
    NSDictionary *gradientDict=[object[@"hot_bulks"] firstObject];
    _gradientImageView.imageArray=gradientDict[kGroupsPropertyCovers];
    _gradientImageView.userInteractionEnabled=YES;
    _gradientImageView.dict=gradientDict;
    [_gradientImageView configData];
    
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    tapGesture.numberOfTapsRequired=1;
    tapGesture.numberOfTouchesRequired=1;
    [_gradientImageView addGestureRecognizer:tapGesture];
    
    NSString *str=gradientDict[kGroupsPropertyCategory];
    CGRect rect=[str boundingRectWithSize:CGSizeMake(_gradientImageView.frame.size.width, 20) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
    _centerLineView.frame=CGRectMake(_gradientImageView.frame.size.width/2-rect.size.width/2, _gradientImageView.frame.size.height/2-1, rect.size.width, 1);

    _titlelabel.text=str;
    _subTitleLabel.text=gradientDict[kGroupsPropertyTitle];

    [_gradientImageView bringSubviewToFront:_titlelabel];
    [_gradientImageView bringSubviewToFront:_subTitleLabel];
    [_gradientImageView bringSubviewToFront:_centerLineView];
    
    NSMutableArray *hotProductArray=object[@"hot_products"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %@", @"stick", [NSNumber numberWithBool:YES]];
    NSMutableArray *array=(NSMutableArray *)[hotProductArray filteredArrayUsingPredicate:predicate];
    if (array.count>0)
    {
        [_categoryView configData:array];
    }
    
    [_tableView reloadData];
    
    _scrollView.contentSize = CGSizeMake(ScreenWidth, _tableViewOffset+_tableView.contentSize.height);
}

-(void)tapGesture:(UITapGestureRecognizer *)tapGesture
{
    GradientImageView *gradientImageView=(GradientImageView *)tapGesture.view;
    if (gradientImageView.dict)
    {
        GroupPurDetailViewController *groupPurDetailVC=[[GroupPurDetailViewController alloc]init];
        groupPurDetailVC.detailUrl=gradientImageView.dict[@"url"];
        [self.navigationController pushViewController:groupPurDetailVC animated:YES];
    }
}

#pragma mark - onEventAction

//-(void)onEventAction:(AppEventType)type object:(id)object
//{
//    [super onEventAction:type object:object];
//    
//    switch (type) {
//        case UI_EVENT_USER_GET_HOMEPAGELIST_SUCC:
//        {
//            _dataObject = object;
//            if ([_scrollView.mj_header isRefreshing]) {
//                [_scrollView.mj_header endRefreshing];
//            }
//            [self configMainPageData:object];
//        }
//            break;
//        case UI_EVENT_USRE_GET_HOMEPAGELIST_FAILED:
//        {
//            
//        }
//            break;
//        default:
//            break;
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
