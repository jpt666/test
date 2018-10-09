//
//  DraftTableViewCell.m
//  CookBook
//
//  Created by zhangxi on 16/4/19.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "DraftTableViewCell.h"
#import "CookProductProxy.h"
#import "CookBookProxy.h"
#import "GlobalVar.h"
#import "MGSwipeButton.h"


@implementation DraftTableViewCell
{
    CookBaseProxy * _dataProxy;
    CGFloat _rowHeight;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andRowHeight:(CGFloat)rowHeight;
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _rowHeight = rowHeight;
        [self configUI];
    }
    return self;
}


-(void)configUI
{
    _frontCoverView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 10, self.bounds.size.width*4/9, _rowHeight-20)];
    _frontCoverView.clipsToBounds = YES;
    _frontCoverView.contentMode = UIViewContentModeScaleAspectFill;
    [self.swipeContentView addSubview:_frontCoverView];
    
    _cookTypeString = [[UILabel alloc] initWithFrame:CGRectMake(8+_frontCoverView.bounds.size.width+16,25, 29, 18)];
    _cookTypeString.font = [GlobalVar shareGlobalVar].sysSmallFont;
    _cookTypeString.textColor=[UIColor whiteColor];
    _cookTypeString.layer.cornerRadius=3;
    _cookTypeString.textAlignment=NSTextAlignmentCenter;
    _cookTypeString.font=[UIFont systemFontOfSize:12];
    _cookTypeString.clipsToBounds=YES;
    [self.swipeContentView addSubview:_cookTypeString];
    
    _dishName = [[UILabel alloc] initWithFrame:CGRectMake(61+_frontCoverView.bounds.size.width, 20,  ScreenWidth-_frontCoverView.bounds.size.width-71, 26)];
    _dishName.textColor = [UIColor colorWithHexString:@"#343434"];
    _dishName.font = [GlobalVar shareGlobalVar].sysMediumFont;
//    _dishName.text = @"暖冬治愈系";
//    _dishName.backgroundColor = [UIColor redColor];
    [self.swipeContentView addSubview:_dishName];
    
    _editStatus = [[UILabel alloc] initWithFrame:CGRectMake(8+_frontCoverView.bounds.size.width+16, 50, self.bounds.size.width/2, 20)];
    _editStatus.font = [GlobalVar shareGlobalVar].sysSmallFont;
    //_editStatus.backgroundColor = [UIColor greenColor];
    _editStatus.textColor = RGBACOLOR(176, 116, 67, 1);
//    _editStatus.text = @"上传失败，点击重试";
//    _editStatus.userInteractionEnabled = YES;
    [self.swipeContentView addSubview:_editStatus];
    
    _progress = [[UIProgressView alloc] initWithFrame:CGRectMake(8+_frontCoverView.bounds.size.width+16, 105, ScreenWidth-_frontCoverView.bounds.size.width-37, 10)];
    _progress.backgroundColor=[UIColor redColor];
    
    [self.swipeContentView addSubview:_progress];
    
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(uploadingStatusTapped:)];
//    [_editStatus addGestureRecognizer:tapGesture];
    
    
    _editTime = [[UILabel alloc] initWithFrame:CGRectMake(8+_frontCoverView.bounds.size.width+16, 75, self.bounds.size.width-_frontCoverView.bounds.size.width, 20)];
    _editTime.font = [GlobalVar shareGlobalVar].sysSmallFont;
//    _editTime.backgroundColor = [UIColor greenColor];
    _editTime.textColor = [UIColor lightGrayColor];
    _editTime.font=[UIFont systemFontOfSize:14];
//    _editTime.text = @"编辑于4月4日 11:56";
    [self.swipeContentView addSubview:_editTime];
    
    self.lineView=[[UIView alloc]initWithFrame:CGRectMake(10, 119.5, ScreenWidth-20, 0.5)];
    self.lineView.backgroundColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.5];
    [self.swipeContentView addSubview:self.lineView];
    
    MGSwipeButton *btn = [MGSwipeButton buttonWithTitle:nil icon:[UIImage imageNamed:@"close"] backgroundColor:RGBACOLOR(176, 116, 67, 1) callback:^BOOL(MGSwipeTableCell *sender) {
        [_dataProxy deleteCookData];
        return YES;
    }];
    
    self.rightButtons = [NSArray arrayWithObject:btn];
    self.rightSwipeSettings.transition = MGSwipeTransitionRotate3D;
}

-(void)setupWithCookData:(CookBaseProxy *)cookData
{
    _dataProxy = cookData;
    
    _frontCoverView.image = [cookData frontImage];
    _dishName.text = [cookData dishName];
    
    if ([cookData isKindOfClass:[CookBookProxy class]]) {
        _cookTypeString.text = @"菜谱";
        _cookTypeString.backgroundColor = RGBACOLOR(176, 116, 67, 1);
        
        if (!_dishName.text.length) {
            _dishName.text = @"未命名的菜谱";
        }
    } else if ([cookData isKindOfClass:[CookProductProxy class]]) {
        _cookTypeString.text = @"作品";
        _cookTypeString.backgroundColor = [UIColor orangeColor];
        
        if (!_dishName.text.length) {
            _dishName.text = @"未命名的作品";
        }
    }
    
    if (CookDataStatusDraft == cookData.cookDataStatus) {
        _editStatus.text = @"未完成";
        _editStatus.userInteractionEnabled = NO;
        _progress.hidden = YES;
    } else if (CookDataStatusUploading == cookData.cookDataStatus) {
        _editStatus.text = @"正在上传";
        _editStatus.userInteractionEnabled = NO;
        _progress.hidden = NO;
        [_progress setProgress:cookData.uploadingProgress animated:NO];
    } else if (CookDataStatusUploadError == cookData.cookDataStatus) {
        _editStatus.text = @"上传失败，点击重试";
        _editStatus.userInteractionEnabled = YES;
        _progress.hidden = YES;
    }
    
    NSDate *currentDate = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate]; // Get necessary date components
    NSInteger curYear = [components year];
    
    NSDate *editDate = [NSDate dateWithTimeIntervalSince1970:[cookData editTime]];
    components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:editDate];
    NSInteger editYear = [components year];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if (editYear != curYear) {
        [dateFormatter setDateFormat:@"编辑于yyyy年MM月dd日 HH:mm"];
    } else {
        [dateFormatter setDateFormat:@"编辑于MM月dd日 HH:mm"];
    }
    _editTime.text = [dateFormatter stringFromDate:editDate];
}

-(void)setUploadProgress:(CGFloat)progress
{
    [_progress setProgress:progress animated:NO];
}

//-(void)uploadingStatusTapped:(UITapGestureRecognizer *)gesture
//{
//    if (_dataProxy.cookDataStatus == CookDataStatusUploadError) {
//        [_dataProxy uploadCookData];
//    }
//}

@end
