//
//  BottomSelectView.m
//  CookBook
//
//  Created by 你好 on 16/5/23.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "BottomSelectView.h"
//#import <Photos/Photos.h>
#import "ImageManager.h"
#import "DelButton.h"
@interface BottomSelectView()

@end

@implementation BottomSelectView
{
    UILabel *_titleLabel;
    UIButton *_numButton;
    UIScrollView *_scrollView;
//    UIButton *_startButton;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        double width=(ScreenWidth-50)/4;
     
        _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 140, 30)];
        _titleLabel.backgroundColor=[UIColor clearColor];
        _titleLabel.text=@"请选择1-6张图片";
        [self addSubview:_titleLabel];
        
        _numButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _numButton.frame=CGRectMake(150, 7, 26, 26);
        [_numButton setTitle:@"0" forState:UIControlStateNormal];
        [_numButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _numButton.backgroundColor=RGBACOLOR(176, 116, 67, 1);
        _numButton.layer.cornerRadius=13;
        _numButton.clipsToBounds=YES;
        [self addSubview:_numButton];
        
        self.startButton =[UIButton buttonWithType:UIButtonTypeCustom];
        self.startButton.frame=CGRectMake(ScreenWidth-90, 7,80, 26);
        self.startButton.layer.cornerRadius=13;
        self.startButton.clipsToBounds=YES;
        [self.startButton setTitle:@"开始拼图" forState:UIControlStateNormal];
        self.startButton.titleLabel.font=[UIFont systemFontOfSize:14];
        [self.startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.startButton.backgroundColor=RGBACOLOR(176, 116, 67, 1);
        self.startButton.enabled=NO;
        [self addSubview:self.startButton];
        
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, ScreenWidth, self.bounds.size.height-40)];
        _scrollView.showsVerticalScrollIndicator=NO;
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.userInteractionEnabled=YES;
//        _scrollView.contentSize=CGSizeMake(10*10+width*9, _scrollView.bounds.size.height);
        [self addSubview:_scrollView];
    }
    return self;
}


-(void)configData
{
    for (UIView *view in _scrollView.subviews)
    {
        [view removeFromSuperview];
    }
    
    if (self.dataArray.count>0)
    {
        _startButton.enabled=YES;
    }
    else
    {
        _startButton.enabled=NO;
    }
    
    [_numButton setTitle:[NSString stringWithFormat:@"%ld",self.dataArray.count] forState:UIControlStateNormal];

    double width=(ScreenWidth-50)/4;

    _scrollView.contentSize=CGSizeMake(10*(self.dataArray.count+1)+width*self.dataArray.count, _scrollView.bounds.size.height);
    
//   double r=[UIScreen mainScreen].scale;
    
//    PHImageRequestOptions *options=[[PHImageRequestOptions alloc]init];
//    options.resizeMode=PHImageRequestOptionsResizeModeExact;
    
    for (int i=0; i<self.dataArray.count; i++)
    {
//        NSDictionary *dict=[self.dataArray objectAtIndex:i];
//        PHAsset *asset=[dict objectForKey:@"asset"];
        
        UIImage *image = [self.dataArray objectAtIndex:i];
        
        UIImageView *selectImageView=[[UIImageView alloc]initWithFrame:CGRectMake((i+1)*10+i*width, (_scrollView.bounds.size.height-width)/2, width, width)];
        selectImageView.userInteractionEnabled=YES;
        selectImageView.contentMode = UIViewContentModeScaleAspectFill;
        selectImageView.clipsToBounds = YES;
//        [[PHImageManager defaultManager]requestImageForAsset:asset targetSize:CGSizeMake((ScreenWidth-6)/4*r, (ScreenWidth-6)/4*r) contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
//            selectImageView.image=result;
//        }];
        selectImageView.image = image;
        [_scrollView addSubview:selectImageView];

        UIImage *delImage=[UIImage imageNamed:@"del_image"];
        DelButton *deleteBtn=[DelButton buttonWithType:UIButtonTypeCustom];
        deleteBtn.frame=CGRectMake(selectImageView.frame.origin.x-5, selectImageView.frame.origin.y-7.5, delImage.size.width+5, delImage.size.height+5);
//        deleteBtn.dict=dict;
        deleteBtn.tag = i;
        [deleteBtn setBackgroundImage:delImage forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_scrollView addSubview:deleteBtn];
    }
    
    [_scrollView setContentOffset:CGPointMake(_scrollView.contentSize.width>_scrollView.bounds.size.width?_scrollView.contentSize.width-_scrollView.bounds.size.width:0, 0) animated:YES];
    
}

-(void)deleteBtnClick:(DelButton *)button
{
    if (button.tag < 0 ||
        button.tag >= self.dataArray.count) {
        return;
    }
//    [self.dataArray removeObject:button.dict];
    [self.dataArray removeObjectAtIndex:button.tag];
//    [[ImageManager shareInstance].puzzleImageArray removeObject:button.dict];
//    [[ImageManager shareInstance].puzzleImageArray removeObjectAtIndex:button.tag];
    
    [self configData];
}










@end
