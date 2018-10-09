//
//  ContentScrollView.m
//  CookBook
//
//  Created by zhangxi on 16/4/18.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "ContentScrollView.h"

@implementation ContentScrollView
{
    UIScrollView * _scrollView;
    UIView * _lineView;
    NSMutableArray * _arrBtns;
    NSMutableArray * _arrTableViews;
    NSInteger _selectedIndex;
    NSInteger _num;
    NSInteger _titleInsetX;
    CGFloat _titleHeight;
    UIView * _titleView;
}

-(void)setDataSource:(id<ContentScrollViewDataSource>)dataSource
{
    _dataSource = dataSource;
    [self configUI];
}


-(void)configUI
{    
    self.backgroundColor=[UIColor whiteColor];
    
    _num = [self.dataSource numberOfPagesInContentScrollView:self];
    _selectedIndex = [self.dataSource initialSelectedIndex:self];;
    
    _arrBtns = [NSMutableArray arrayWithCapacity:_num];
    _arrTableViews = [NSMutableArray arrayWithCapacity:_num];
    
    _titleHeight = 50;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(titleHeight:)]) {
        _titleHeight = [self.dataSource titleHeight:self];
    }
    
    _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, _titleHeight)];
    _titleView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    _titleView.alpha = 0.0;
    [self addSubview:_titleView];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _titleHeight, self.bounds.size.width, self.bounds.size.height-_titleHeight)];
    _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width*_num, _scrollView.bounds.size.height-_titleHeight);
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    _titleInsetX = [self.dataSource titleBottomLineInsetX:self];
    CGRect lineViewFrame = CGRectMake(_titleInsetX, 48, (self.bounds.size.width-_titleInsetX*2)/_num, 2);
    _lineView=[[UIView alloc]initWithFrame:lineViewFrame];
    _lineView.backgroundColor=[UIColor orangeColor];
    [self addSubview:_lineView];

    _arrBtns = [self.dataSource arrayButtonForContentScrollView:self];
    _arrTableViews = [self.dataSource arrayTableViewForContentScrollView:self];
    
    
    for(int i=0; i<_num; i++) {
        UIButton * btn = [_arrBtns objectAtIndex:i];
        btn.frame=CGRectMake(_titleInsetX+i*(self.bounds.size.width-_titleInsetX*2)/_num, 0, (self.bounds.size.width-_titleInsetX*2)/_num, 50);
        btn.tag = i;
        
        if (i == _selectedIndex) {
            btn.selected = YES;
        }
        
        [btn addTarget:self action:@selector(titleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        NSInteger y = 0;
        y = [self.dataSource tableViewTopOffset:self];
        
        UITableView *tableView = [_arrTableViews objectAtIndex:i];
        tableView.frame = CGRectMake(i*_scrollView.bounds.size.width, y, _scrollView.bounds.size.width, _scrollView.bounds.size.height-y);
        [_scrollView addSubview:tableView];
        
        
//        UIView * headerView =[self.dataSource headerViewForContentScrollView:self atTableViewIndex:i];
//        if (headerView) {
//            CGFloat h = [self.dataSource heightForContentScrollView:self atTableViewIndex:i];
//            tableView.contentInset = UIEdgeInsetsMake(h, 0, 0, 0);
//            headerView.frame = CGRectMake(0, -h, headerView.bounds.size.width, h);
//            [tableView addSubview:headerView];
//        }
    }
    

    [_scrollView setContentOffset:CGPointMake(_selectedIndex*_scrollView.bounds.size.width, 0) animated:NO];
    [self updateButtonStatus];
}

-(void)titleBtnClicked:(UIButton *)button
{
    if (button.tag == _selectedIndex) {
        return;
    }
    
    _selectedIndex = button.tag;
    [self updateButtonStatus];
    
    [_scrollView setContentOffset:CGPointMake(_selectedIndex*_scrollView.bounds.size.width, 0) animated:YES];
}

-(void)updateButtonStatus
{
    for (UIButton * btn in _arrBtns) {
        if (btn.tag == _selectedIndex) {
            btn.selected = YES;
        } else {
            btn.selected = NO;
        }
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        _lineView.frame=CGRectMake(_titleInsetX+_selectedIndex*(self.bounds.size.width-_titleInsetX*2)/_num, 48, (self.bounds.size.width-_titleInsetX*2)/_num, 2);
    }];
    
    if (_delegate && [_delegate respondsToSelector:@selector(didContentScrollView:showTableView:indexOfTableviews:)]) {
        [_delegate didContentScrollView:self showTableView:[_arrTableViews objectAtIndex:_selectedIndex] indexOfTableviews:_selectedIndex];
    }
}

-(void)setSelectIndex:(NSInteger)index
{
    if (index < 0 || index >= _num) {
        return;
    }
    
    _selectedIndex = index;
    [self updateButtonStatus];
}

- (CGFloat)getTitleHeight
{
    return _titleHeight;
}

- (void)setTitleAlpha:(CGFloat)alpha
{
    _titleView.alpha = alpha;
//    for (UIButton *btn in _arrBtns) {
//        btn.alpha = alpha;
//    }
    
}

- (void)setTitleBackgroundColor:(UIColor *)color
{
    _titleView.backgroundColor = color;
}

-(void)scrollEnd
{
    NSInteger index =_scrollView.contentOffset.x/_scrollView.bounds.size.width;
    
    if (index == _selectedIndex) {
        return;
    }
    
    _selectedIndex = index;
    [self updateButtonStatus];
    
    [UIView animateWithDuration:0.1 animations:^{
        _lineView.frame=CGRectMake(_titleInsetX+_selectedIndex*(self.bounds.size.width-_titleInsetX*2)/_num, 48, (self.bounds.size.width-_titleInsetX*2)/_num, 2);
    }];
//    
//    if (_delegate && [_delegate respondsToSelector:@selector(didShowTableView:)]) {
//        [_delegate didShowTableView:[_arrTableViews objectAtIndex:_selectedIndex]];
//    }
}

//-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
//{
//    if (![super pointInside:point withEvent:event]) {
//        return NO;
//    }
//    return _scrollEnabled;
//}

#pragma mark scrollViewDelegate

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        [self scrollEnd];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollEnd];
}


@end
