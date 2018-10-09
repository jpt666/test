
//
//  TopScrollView.m
//  CookBook
//
//  Created by 你好 on 16/4/25.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "TopScrollView.h"
#import <UIImageView+WebCache.h>
@implementation TopScrollView
{
    UIPageControl *_pageControl;
    UIScrollView *_scrollView;
    UIView * _backgroudView;
    NSInteger _tempPage;
    NSTimer *_myTimer;
}


-(instancetype)initWithframe:(CGRect)rect andImages:(NSArray *)images
{
    self=[super initWithFrame:rect];
    if (self) {
        
        self.imageArray=[[NSMutableArray alloc]initWithCapacity:0];
        
        _backgroudView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:_backgroudView];
        
        _scrollView=[[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.contentSize=CGSizeMake(self.bounds.size.width*3,self.bounds.size.height);
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.showsVerticalScrollIndicator=NO;
        _scrollView.bounces=NO;
        _scrollView.pagingEnabled=YES;
        [self addSubview:_scrollView];
        
        for (int j=0; j<images.count; j++)
        {
            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(j*self.bounds.size.width,0, self.bounds.size.width,self.bounds.size.height)];
            imageView.image=[UIImage imageNamed:PLACE_HOLDER_COOK_IMAGE];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            [_scrollView addSubview:imageView];
        }
        
        _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(rect.size.width-70, rect.size.height-20, 70, 20)];
        _pageControl.numberOfPages=images.count;
        //设置当前页数,默认是0
        _pageControl.currentPage=0;
        _pageControl.pageIndicatorTintColor=RGBACOLOR(73, 142, 46, 0.2);
        _pageControl.currentPageIndicatorTintColor=RGBACOLOR(176, 116, 67, 1);
        //处理哪个小圆点被选中的方法
        [_pageControl addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_pageControl];
    }
    return self;
}

-(void)setAppearanceViewAlpha:(CGFloat)alpha
{
    _scrollView.alpha = alpha;
    _pageControl.alpha = alpha;
}

-(void)configData
{
    for (UIImageView *view in _scrollView.subviews)
    {
        [view removeFromSuperview];
    }

    _scrollView.contentSize=CGSizeMake(self.bounds.size.width*(self.imageArray.count+2),self.bounds.size.height);
    _pageControl.numberOfPages=self.imageArray.count;

    if (self.imageArray.count<2)
    {
        _pageControl.hidden=YES;
    }
    
    
    _scrollView.delegate=self;
    

    for (int j=0; j<self.imageArray.count; j++)
    {
        NSDictionary *dict=[self.imageArray objectAtIndex:j];
        NSString *imageUrl=imageUrl=dict[@"image"];
        
        RecommendImageView *imageView=[[RecommendImageView alloc]initWithFrame:CGRectMake((j+1)*self.bounds.size.width,0, self.bounds.size.width,self.bounds.size.height)];
        imageView.delegate=self;
        imageView.dict=dict;
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:PLACE_HOLDER_COOK_IMAGE]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [_scrollView addSubview:imageView];
    }
    
    NSDictionary *firstDict=[self.imageArray firstObject];
    NSString *firstImageUrl=firstDict[@"image"];
    
    RecommendImageView *firstImageView=[[RecommendImageView alloc]initWithFrame:CGRectMake(0,0, self.bounds.size.width,self.bounds.size.height)];
    firstImageView.delegate=self;
    firstImageView.dict=firstDict;
    [firstImageView sd_setImageWithURL:[NSURL URLWithString:firstImageUrl] placeholderImage:[UIImage imageNamed:PLACE_HOLDER_COOK_IMAGE]];
    firstImageView.contentMode = UIViewContentModeScaleAspectFill;
    firstImageView.clipsToBounds = YES;
    [_scrollView addSubview:firstImageView];
    
    NSDictionary *lastDict=[self.imageArray firstObject];
    NSString *lastImageUrl=lastDict[@"image"];
    
    RecommendImageView *lastImageView=[[RecommendImageView alloc]initWithFrame:CGRectMake((self.imageArray.count+1)*self.bounds.size.width,0, self.bounds.size.width,self.bounds.size.height)];
    lastImageView.delegate=self;
    lastImageView.dict=lastDict;
    [lastImageView sd_setImageWithURL:[NSURL URLWithString:lastImageUrl] placeholderImage:[UIImage imageNamed:PLACE_HOLDER_COOK_IMAGE]];
    lastImageView.contentMode = UIViewContentModeScaleAspectFill;
    lastImageView.clipsToBounds = YES;
    [_scrollView addSubview:lastImageView];
    
    [_scrollView scrollRectToVisible:CGRectMake(self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height) animated:NO];
    
    if (_myTimer)
    {
        [_myTimer invalidate];
        _myTimer = nil;
    }
    
    _myTimer = [NSTimer timerWithTimeInterval:4.0f target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
    [[NSRunLoop  currentRunLoop] addTimer:_myTimer forMode:NSDefaultRunLoopMode];

    
}



-(void)pageChange:(UIPageControl *)pageControl
{
    double x=pageControl.currentPage*ScreenWidth;
    _scrollView.contentOffset=CGPointMake(x, 0);
}


#pragma mark - RecommendImageViewDelegate

-(void)didClickImageView:(RecommendImageView *)imageView
{
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectImageView:)]) {
        [_delegate didSelectImageView:imageView.dict];
    }
}


- (void)runTimePage
{
    NSInteger page = _pageControl.currentPage;
    page ++;
    [self turnPage:page];
}

- (void)turnPage:(NSInteger)page
{
    _tempPage = page;
    [_scrollView scrollRectToVisible:CGRectMake(self.bounds.size.width * (page + 1), 0, self.bounds.size.width, self.bounds.size.height) animated:YES];
}


#pragma mark - UIScrollViewDelegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (_myTimer)
    {
        [_myTimer invalidate];
        _myTimer = nil;
    }
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if (!_myTimer)
    {
        _myTimer = [NSTimer timerWithTimeInterval:4.0f target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
        [[NSRunLoop  currentRunLoop] addTimer:_myTimer forMode:NSDefaultRunLoopMode];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWith = _scrollView.frame.size.width;
    NSInteger page = floor((_scrollView.contentOffset.x - pageWith/([self.imageArray count]+2))/pageWith) + 1;
    page --; //默认从第二页开始
    _pageControl.currentPage = page;
}



-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWith = self.bounds.size.width;
    NSInteger currentPage = floor((scrollView.contentOffset.x - pageWith/ ([self.imageArray count]+2)) / pageWith) + 1;
    if (currentPage == 0)
    {
        if (self.currentIndex)
        {
            self.currentIndex=self.imageArray.count-1;
        }
        [scrollView scrollRectToVisible:CGRectMake(self.bounds.size.width * self.imageArray.count, 0, self.bounds.size.width, self.bounds.size.height) animated:NO];
        _pageControl.currentPage=self.imageArray.count;
    }
    else if(currentPage == self.imageArray.count + 1)
    {
        if (self.currentIndex)
        {
            self.currentIndex=0;
        }
        [scrollView scrollRectToVisible:CGRectMake(self.bounds.size.width, 0, self.bounds.size.width,self.frame.size.height) animated:NO];
        _pageControl.currentPage=0;
    }
    else
    {
        if (self.currentIndex)
        {
            self.currentIndex=currentPage-1;
        }
    }
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (_tempPage == 0)
    {
        [_scrollView scrollRectToVisible:CGRectMake(self.bounds.size.width * self.imageArray.count, 0, self.bounds.size.width, self.bounds.size.height) animated:NO];
    }
    else if(_tempPage == self.imageArray.count)
    {
        [_scrollView scrollRectToVisible:CGRectMake(self.frame.size.width, 0, self.bounds.size.width,self.bounds.size.height) animated:NO];
    }
}


@end
