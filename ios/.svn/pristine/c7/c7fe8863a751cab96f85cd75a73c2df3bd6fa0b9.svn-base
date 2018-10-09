//
//  PTContentView.m
//  PinTuDemo
//
//  Created by zhangxi on 16/5/18.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "PTContentView.h"


@implementation PTContentView
{
    NSInteger _storyBoardIndex;
    NSString * _styleFileName;
    
    NSDictionary *_styleDict;
    
//    CGPoint _startPt;
    CGPoint _orgPt;
    
    PTImageEditView * _crossView;
    PTImageEditView * _tmpView;
    
    
    BOOL _bBeginMove;
    BOOL _bImageEditZooming;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _bRealMoveMode = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentViewTouchBeign:) name:NotifyScreenTouchBegin object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentViewTouchMoved:) name:NotifyScreenTouchMoved object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentViewTouchEnded:) name:NotifyScreenTouchEnded object:nil];
        [self initView];
    }
    return self;
}

-(void)contentViewTouchBeign:(NSNotification *)notification
{
    if (_bBeginMove) {
        return;
    }
    
    UITouch *touch = [notification object];
    CGPoint pt = [touch locationInView:self];
    _crossView = [self point:pt crossViewExclude:nil];
    if (_crossView) {
        _orgPt = _crossView.center;
        _crossView.contentView.scrollEnabled = YES;
    }
}

-(void)contentViewTouchMoved:(NSNotification *)notification
{
    if (_bImageEditZooming) {
        return;
    }
    
    UITouch *touch = [notification object];
    
    if (_crossView) {
        
        CGPoint pt = [touch locationInView:self];
        if (_bBeginMove) {
            _crossView.center = pt;
            _crossView.contentView.scrollEnabled = NO;
            
            _tmpView = [self point:pt crossViewExclude:_crossView];
            
            if (_tmpView && _tmpView != _crossView && _bRealMoveMode) {
                [UIView animateWithDuration:0.2 animations:^{
//                    tmpView.alpha = 1.0;
                    
                    _crossView.transform = CGAffineTransformIdentity;
//                    _crossView.alpha = 1.0;
                    [self exchangeImageEditView:_crossView withImageEditView:_tmpView];
                    
                    _crossView.transform = CGAffineTransformMakeScale(1.1, 1.1);
//                    _crossView.alpha = 0.5;
                }];
            }
        } else {
            
            _tmpView = [self point:pt crossViewExclude:nil];
            
            if (_tmpView != _crossView) {
                
                _bBeginMove = YES;
                [self bringSubviewToFront:_crossView];
                
                [UIView animateWithDuration:0.2 animations:^{
                    _crossView.center = pt;
                    _crossView.transform = CGAffineTransformMakeScale(1.1, 1.1);
                    _crossView.alpha = 0.5;
                    
                }];
            }
        }
        
    }
}

-(void)contentViewTouchEnded:(NSNotification *)notification
{
    UITouch *touch = [notification object];
    CGPoint pt = [touch locationInView:self];
    
    if (_bBeginMove) {
        

        if (!_bRealMoveMode) {
            
            if (_tmpView) {
                [UIView animateWithDuration:0.2 animations:^{
                    _tmpView.layer.borderColor = [UIColor clearColor].CGColor;
                    _tmpView.layer.borderWidth = 0;
                    
                    _crossView.transform = CGAffineTransformIdentity;
                    [self exchangeImageEditView:_crossView withImageEditView:_tmpView];
                }];
            } else {
                
                _crossView.transform = CGAffineTransformIdentity;
                _crossView.alpha = 1.0;
                _crossView.center = _orgPt;
            }
        } else {
            
            _crossView.transform = CGAffineTransformIdentity;
            _crossView.alpha = 1.0;
            
            _crossView.frame = _crossView.fixedFrame;
            [_crossView layoutImageData];
            if (_crossView.center.x == _orgPt.x &&
                _crossView.center.y == _orgPt.y) {
                [_crossView recoverImageZoomScale];
            }
        }
    }
    _bBeginMove = NO;
    _crossView = nil;
    _orgPt = CGPointZero;
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if (_bBeginMove) {
        return YES;
    }
    
    return [super pointInside:point withEvent:event];
}


-(void)initView
{
    _contentViewArray = [NSMutableArray arrayWithCapacity:MAX_PINTU_NUM];
    
    for (int i=0; i<MAX_PINTU_NUM; i++) {
        PTImageEditView * view = [[PTImageEditView alloc] init];
        view.tag = i;
        
//        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(imageEditViewLongPressed:)];
//        [view addGestureRecognizer:longGesture];

        [self resetImageEditView:view];
        [_contentViewArray addObject:view];
        [self addSubview:view];
    }

    
//    TouchActionDetectView *tView = [[TouchActionDetectView alloc] initWithFrame:self.bounds];
//    tView.delegate = self;
//    tView.backgroundColor = [UIColor clearColor];
//    [self addSubview:tView];
}


-(void)setStoryBoardIndex:(NSInteger)storyBoardIndex
{
    _storyBoardIndex = storyBoardIndex;
    _styleFileName = nil;
    NSString *picCountFlag = @"";
    switch (_arrImages.count) {
        case 2:
            picCountFlag = @"two";
            break;
        case 3:
            picCountFlag = @"three";
            break;
        case 4:
            picCountFlag = @"four";
            break;
        case 5:
            picCountFlag = @"five";
            break;
        case 6:
            picCountFlag = @"six";
            break;
        default:
            break;
    }
    if (![picCountFlag isEqualToString:@""]) {
        _styleFileName = [NSString stringWithFormat:@"template_%@_%ld.plist",picCountFlag,(long)storyBoardIndex];
        _styleDict = nil;
        _styleDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle].resourcePath
                                                                 stringByAppendingPathComponent:_styleFileName]];
        if (_styleDict) {
            [self resetAllView];
            [self resetStyle];
        }
    }
}

- (void)resetAllView
{
    for (PTImageEditView *v in _contentViewArray) {
        [self resetImageEditView:v];
    }
}

- (void)resetStyle
{
    if (!_styleDict) {
        return;
    }
    
    CGSize superSize = CGSizeFromString([[_styleDict objectForKey:@"SuperViewInfo"] objectForKey:@"size"]);
//    superSize = [PTContentView sizeScaleWithSize:superSize xScale:superSize.width/self.bounds.size.width yScale:superSize.height/self.bounds.size.height];
    NSArray *subViewArray = [_styleDict objectForKey:@"SubViewArray"];
    for(int j = 0; j < [subViewArray count]; j++)
    {
        CGRect rect = CGRectZero;
        UIBezierPath *path = nil;
        UIBezierPath *pathInSuper = nil;
        UIImage *image = [self.arrImages objectAtIndex:j];

        NSDictionary *subDict = [subViewArray objectAtIndex:j];
        if([subDict objectForKey:@"frame"])
        {
            rect = CGRectFromString([subDict objectForKey:@"frame"]);
            rect = [PTContentView rectScaleWithRect:rect xScale:superSize.width/self.bounds.size.width yScale:superSize.height/self.bounds.size.height];
//            rect.origin.x = rect.origin.x * self.frame.size.width/superSize.width;
//            rect.origin.y = rect.origin.y * self.frame.size.height/superSize.height;
//            rect.size.width = rect.size.width * self.frame.size.width/superSize.width;
//            rect.size.height = rect.size.height * self.frame.size.height/superSize.height;
        }
        rect = [self rectWithArray:[subDict objectForKey:@"pointArray"] andSuperSize:superSize];
        if ([subDict objectForKey:@"pointArray"]) {
            NSArray *pointArray = [subDict objectForKey:@"pointArray"];
            path = [UIBezierPath bezierPath];
            pathInSuper = [UIBezierPath bezierPath];
            if (pointArray.count > 2) {//当点的数量大于2个的时候
                //生成点的坐标
                for(int i = 0; i < [pointArray count]; i++)
                {
                    NSString *pointString = [pointArray objectAtIndex:i];
                    if (pointString) {
                        CGPoint point = CGPointFromString(pointString);
                        point = [PTContentView pointScaleWithPoint:point xScale:superSize.width/self.bounds.size.width yScale:superSize.height/self.bounds.size.height];
                        
                        if (i == 0) {
                            [pathInSuper moveToPoint:point];
                        }else{
                            [pathInSuper addLineToPoint:point];
                        }
                        
                        point.x -= rect.origin.x;
                        point.y -= rect.origin.y;
                        if (i == 0) {
                            [path moveToPoint:point];
                        }else{
                            [path addLineToPoint:point];
                        }
                    }
                    
                }
            }else{
                //点的坐标就是rect的四个角
                [path moveToPoint:CGPointMake(0, 0)];
                [path addLineToPoint:CGPointMake(rect.size.width, 0)];
                [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height)];
                [path addLineToPoint:CGPointMake(0, rect.size.height)];
                
                [pathInSuper moveToPoint:rect.origin];
                [pathInSuper addLineToPoint:CGPointMake(rect.origin.x+rect.size.width, rect.origin.y)];
                [pathInSuper addLineToPoint:CGPointMake(rect.origin.x+rect.size.width, rect.origin.y+rect.size.height)];
                [pathInSuper addLineToPoint:CGPointMake(rect.origin.x, rect.origin.y+rect.size.height)];
            }
            [path closePath];
            [pathInSuper closePath];
        }
        
        if (j < [_contentViewArray count]) {
            PTImageEditView *imageEditView = (PTImageEditView *)[_contentViewArray objectAtIndex:j];
            imageEditView.delegate = self;
//            imageEditView.frame = rect;
//            imageEditView.backgroundColor = [UIColor grayColor];
            imageEditView.scopePath = path;
            imageEditView.pathInSuper = pathInSuper;
            [imageEditView setImageData:image andFrame:rect];
            imageEditView.fixedFrame = rect;
        }
    }
}


- (void)resetImageEditView:(PTImageEditView *)view
{
    [view setImageData:nil andFrame:CGRectZero];
    [view setClipsToBounds:YES];
    [view setBackgroundColor:[UIColor grayColor]];
    view.pathInSuper = nil;
    view.scopePath = nil;

    [view setUserInteractionEnabled:YES];
}


- (CGRect)rectWithArray:(NSArray *)array andSuperSize:(CGSize)superSize
{
    CGRect rect = CGRectZero;
    CGFloat minX = INT_MAX;
    CGFloat maxX = 0;
    CGFloat minY = INT_MAX;
    CGFloat maxY = 0;
    for (int i = 0; i < [array count]; i++) {
        NSString *pointString = [array objectAtIndex:i];
        CGPoint point = CGPointFromString(pointString);
        if (point.x <= minX) {
            minX = point.x;
        }
        if (point.x >= maxX) {
            maxX = point.x;
        }
        if (point.y <= minY) {
            minY = point.y;
        }
        if (point.y >= maxY) {
            maxY = point.y;
        }
        rect = CGRectMake(minX, minY, maxX - minX, maxY - minY);
    }
    rect = [PTContentView rectScaleWithRect:rect xScale:superSize.width/self.bounds.size.width yScale:superSize.height/self.bounds.size.height];
    return rect;
}


+ (CGRect)rectScaleWithRect:(CGRect)rect xScale:(CGFloat)xScale yScale:(CGFloat)yScale
{
    if (xScale<=0) {
        xScale = 1.0f;
    }
    
    if (yScale<=0) {
        yScale = 1.0f;
    }
    
    CGRect retRect = CGRectZero;
    retRect.origin.x = rect.origin.x/xScale;
    retRect.origin.y = rect.origin.y/yScale;
    retRect.size.width = rect.size.width/xScale;
    retRect.size.height = rect.size.height/yScale;
    return  retRect;
}

+ (CGPoint)pointScaleWithPoint:(CGPoint)point xScale:(CGFloat)xScale yScale:(CGFloat)yScale
{
    if (xScale<=0) {
        xScale = 1.0f;
    }
    
    if (yScale<=0) {
        yScale = 1.0f;
    }
    CGPoint retPointt = CGPointZero;
    retPointt.x = point.x/xScale;
    retPointt.y = point.y/yScale;
    return  retPointt;
}


+ (CGSize)sizeScaleWithSize:(CGSize)size xScale:(CGFloat)xScale yScale:(CGFloat)yScale
{
    if (xScale<=0) {
        xScale = 1.0f;
    }
    
    if (yScale<=0) {
        yScale = 1.0f;
    }
    CGSize retSize = CGSizeZero;
    retSize.width = size.width/xScale;
    retSize.height = size.height/yScale;
    return  retSize;
}



- (PTImageEditView *)point:(CGPoint)point crossViewExclude:(PTImageEditView *)imageEditView
{
    PTImageEditView *v = nil;
    for (PTImageEditView *imageEditV in _contentViewArray) {
        if (imageEditV == imageEditView) {
            continue;
        }
        if ([imageEditV.pathInSuper containsPoint:point]) {
            if (!_bRealMoveMode) {
                //imageEditV.alpha = 0.8;
                imageEditV.layer.borderColor = [UIColor redColor].CGColor;
                imageEditV.layer.borderWidth = 4;
            }
            v = imageEditV;
        } else {
            //imageEditV.alpha = 1;
            imageEditV.layer.borderColor = [UIColor clearColor].CGColor;
            imageEditV.layer.borderWidth = 0;
        }
    }
    return v;
}

- (void)imageEditViewLongPressed:(UILongPressGestureRecognizer *)gesture
{
//    PTImageEditView * imageEditView = (PTImageEditView *)gesture.view;
//    static PTImageEditView * tmpView = nil;
//    if (gesture.state == UIGestureRecognizerStateBegan) {
//        _startPt = [gesture locationInView:self];
//        _orgPt = gesture.view.center;
//        
//        tmpView = nil;
//        
//        [self bringSubviewToFront:gesture.view];
//        
//        [UIView animateWithDuration:0.2 animations:^{
//            imageEditView.transform = CGAffineTransformMakeScale(1.1, 1.1);
//            imageEditView.alpha = 0.8;
//        }];
//    } else if (gesture.state == UIGestureRecognizerStateChanged) {
//        
//        CGPoint newPoint = [gesture locationInView:self];
//        CGFloat deltaX = newPoint.x-_startPt.x;
//        CGFloat deltaY = newPoint.y-_startPt.y;
//        imageEditView.center = CGPointMake(imageEditView.center.x+deltaX, imageEditView.center.y+deltaY);
//        
//        tmpView = [self point:newPoint crossViewExclude:imageEditView];
//        
//        if (_bRealMoveMode) {
//            if (tmpView ) {
//                [UIView animateWithDuration:0.2 animations:^{
//                    tmpView.alpha = 1.0;
//                    
//                    imageEditView.transform = CGAffineTransformIdentity;
//                    imageEditView.alpha = 1.0;
//                    [self exchangeImageEditView:imageEditView withImageEditView:tmpView];
//                    
//                    imageEditView.transform = CGAffineTransformMakeScale(1.1, 1.1);
//                    imageEditView.alpha = 0.8;
//                    
//                    imageEditView.center = newPoint;
//                }];
//            }
//        }
//    
//        _startPt = newPoint;
//        
//    } else if (gesture.state == UIGestureRecognizerStateEnded ||
//               gesture.state == UIGestureRecognizerStateCancelled) {
//        
//        if (_bRealMoveMode) {
//            imageEditView.transform = CGAffineTransformIdentity;
//            imageEditView.alpha = 1.0;
//            
//            imageEditView.frame = imageEditView.fixedFrame;
//            [imageEditView layoutImageData];
//            if (imageEditView.center.x == _orgPt.x &&
//                imageEditView.center.y == _orgPt.y) {
//                [imageEditView recoverImageZoomScale];
//            }
//        } else {
//            if (tmpView) {
//                [UIView animateWithDuration:0.2 animations:^{
//                    tmpView.alpha = 1.0;
//                    
//                    imageEditView.transform = CGAffineTransformIdentity;
//                    imageEditView.alpha = 1.0;
//                    [self exchangeImageEditView:imageEditView withImageEditView:tmpView];
//                }];
//                
//            } else {
//                [UIView animateWithDuration:0.2 animations:^{
//                    tmpView.alpha = 1.0;
//                    imageEditView.transform = CGAffineTransformIdentity;
//                    imageEditView.alpha = 1.0;
//                    imageEditView.center = _orgPt;
//                }];
//            }
//        }
//    }
}

- (void)exchangeImageEditView:(PTImageEditView *)srcView withImageEditView:(PTImageEditView *)destView
{
    if (!srcView || !destView ||
        srcView.tag == destView.tag) {
        return;
    }
    
    [_arrImages exchangeObjectAtIndex:srcView.tag withObjectAtIndex:destView.tag];
    [_contentViewArray exchangeObjectAtIndex:srcView.tag withObjectAtIndex:destView.tag];
    
     NSInteger tag = srcView.tag;
    srcView.tag = destView.tag;
    destView.tag = tag;
    
    CGRect tmpRect = srcView.fixedFrame;
    UIBezierPath *tmpPath = srcView.scopePath;
    UIBezierPath *tmpSuperPath = srcView.pathInSuper;
//    CGFloat tmpScale = srcView.currentScale;

    srcView.scopePath = destView.scopePath;
    srcView.fixedFrame = destView.fixedFrame;
    srcView.pathInSuper = destView.pathInSuper;
    //    srcView.currentScale = destView.currentScale;
    srcView.frame = destView.fixedFrame;
    [srcView layoutImageData];


    destView.scopePath = tmpPath;
    destView.pathInSuper = tmpSuperPath;
    destView.fixedFrame = tmpRect;
    destView.frame = tmpRect;
//    destView.currentScale = srcView.currentScale;
    [destView layoutImageData];

}

- (void)tapInsideWithEditView:(PTImageEditView *)imageEditView
{
    
}

- (void)zoomingImageEditView:(BOOL)bZooming
{
    _bImageEditZooming = bZooming;
}

//-(void)view:(PTImageEditView*)view touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    CGPoint pt = [[touches anyObject] locationInView:self];
//    int c = 0;
//}
//
//-(void)view:(PTImageEditView*)view touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    
//}
//-(void)view:(PTImageEditView*)view touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotifyScreenTouchBegin object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotifyScreenTouchMoved object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotifyScreenTouchEnded object:nil];
}

@end
