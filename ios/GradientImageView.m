//
//  GradientImageView.m
//  CookBook
//
//  Created by 你好 on 16/6/2.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "GradientImageView.h"
#import <UIImageView+WebCache.h>
#import "LTransitionImageView.h"
@implementation GradientImageView
{
    NSTimer *_myTimer;
    NSMutableArray *_downImageArray;
    UIImage *_currentImage;
    LTransitionImageView *_transitionView;
    AnimationDirection _lastDirection;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        _transitionView=[[LTransitionImageView alloc]initWithFrame:self.bounds];
        _transitionView.hidden=YES;
        _transitionView.contentMode=UIViewContentModeScaleAspectFill;
        _transitionView.clipsToBounds=YES;
        _transitionView.animationDuration=2.0f;
        _transitionView.animationDirection=AnimationDirectionRightToLeft;
        [self addSubview:_transitionView];
        
        self.backView=[[UIView alloc]initWithFrame:self.bounds];
        self.backView.backgroundColor=RGBACOLOR(1, 1, 1, 0.3);
        self.backView.hidden=YES;
        [self addSubview:self.backView];
        
               
        self.image=[UIImage imageNamed:PLACE_HOLDER_COOK_IMAGE];
        _downImageArray=[[NSMutableArray alloc]init];
    }
    return self;
}



-(void)configData
{
    [_downImageArray removeAllObjects];
    _currentImage = nil;
    _transitionView.image = nil;

    if (_myTimer)
    {
        [_myTimer invalidate];
        _myTimer = nil;
    }
    
    if (self.imageArray.count>0)
    {
//        if (_myTimer)
//        {
//            [_myTimer invalidate];
//            _myTimer = nil;
//        }
        
        for (int i=0;i<self.imageArray.count;i++)
        {
            
            NSString *str=[self.imageArray objectAtIndex:i];
            NSURL *imageUrl=[NSURL URLWithString:str];
            
            if (![[SDWebImageManager sharedManager]diskImageExistsForURL:imageUrl])
            {
                [[SDWebImageManager sharedManager]downloadImageWithURL:[NSURL URLWithString:str] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                    if (i==0)
                    {
                        _currentImage=image;
                    }
                    
                    if (!error && image) {
                        [[SDWebImageManager sharedManager]saveImageToCache:image forURL:imageURL];
                        [_downImageArray addObject:image];
                    }
                }];
            }
            else
            {
                UIImage *image=[[SDImageCache sharedImageCache]imageFromDiskCacheForKey:str];
                [_downImageArray addObject:image];
            }
        }
        
        
        
        _myTimer = [NSTimer timerWithTimeInterval:4.0f target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
        [[NSRunLoop  currentRunLoop] addTimer:_myTimer forMode:NSDefaultRunLoopMode];
        
        [self runTimePage];
    }
}


-(void)runTimePage
{
    if (_downImageArray.count>=2)
    {
        self.image=nil;
        _transitionView.hidden=NO;
        self.backView.hidden=NO;
        NSInteger index=[_downImageArray indexOfObject:_currentImage];
        if(NSNotFound==index)
        {
            index=0;
            _currentImage=[_downImageArray firstObject];
        }
        
        _transitionView.image=_currentImage;
        _transitionView.animationDirection=arc4random()%4;
        
        if (index+1==_downImageArray.count)
        {
            index=0;
            _currentImage=[_downImageArray firstObject];
        }
        else
        {
            _currentImage=[_downImageArray objectAtIndex:index+1];
        }
    }
    else if(_downImageArray.count==1)
    {
        self.image=nil;
        self.backView.hidden=NO;
        _transitionView.hidden=NO;
        _currentImage=[_downImageArray firstObject];
        _transitionView.image=_currentImage;
    }
}
- (void)dealloc
{
    self.imageArray = nil;
    _downImageArray = nil;
    
    if (_myTimer)
    {
        [_myTimer invalidate];
        _myTimer = nil;
    }
    
}

@end
