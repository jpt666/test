//
//  ListAlertView.m
//  CookBook
//
//  Created by 你好 on 16/9/7.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "ListAlertView.h"
#import "LimitTableViewCell.h"
@interface ListAlertView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,retain)UIView *backgroundview;
@property (nonatomic,retain)UIView *alertView;
@property (nonatomic,retain)UILabel *titleLabel;
@property (nonatomic,retain)UILabel *subTitleLabel;
@property (nonatomic,retain)UIButton *sureButton;
@property (nonatomic,retain)UITableView *tableView;


@end

@implementation ListAlertView
{
    NSMutableArray *_dataArray;
}

-(instancetype)initWithArray:(NSMutableArray *)array
{
    if (self = [super initWithFrame:[[UIApplication sharedApplication] keyWindow].frame])
    {
        _dataArray=[[NSMutableArray alloc]initWithArray:array];
        
        [self configUI];
    }
    return self;
}


-(void)configUI
{
    self.backgroundview = [[UIView alloc] initWithFrame:[[UIApplication sharedApplication] keyWindow].frame];
    self.backgroundview.backgroundColor = [UIColor blackColor];
    self.backgroundview.alpha = 0.4;
    [self addSubview:self.backgroundview];
    
    UIView * keywindow = [[UIApplication sharedApplication] keyWindow];
    
    self.alertView = [[UIView alloc] init];
    self.alertView.layer.cornerRadius = 8;
    self.alertView.center=self.backgroundview.center;
    self.alertView.backgroundColor = [UIColor whiteColor];
    self.alertView.clipsToBounds = YES;
    self.alertView.alpha=0.0;
    [self addSubview:self.alertView];
    
    NSString *subTitle= (self.alertType == AlertTypeLimit)?@"部分商品超过限购数量,请重新选择商品!":@"部分商品数量不足,请重新选择商品!";
    
    CGRect rect = [subTitle boundingRectWithSize:CGSizeMake(keywindow.frame.size.width-50, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    
    
    if (_dataArray.count>4)
    {
        self.alertView.frame=CGRectMake(0, 0, keywindow.frame.size.width-30, 30+315+rect.size.height);
    }
    else
    {
        self.alertView.frame=CGRectMake(0, 0, keywindow.frame.size.width-30, 30+115+_dataArray.count*30+rect.size.height);
    }
    
    
    self.alertView.center=self.backgroundview.center;

    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.alertView.bounds.size.width, 50)];
    self.titleLabel.backgroundColor=RGBACOLOR(73, 141, 46, 1);
    self.titleLabel.text=@"温馨提示";
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
    [self.alertView addSubview:self.titleLabel];
    
    self.subTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, self.titleLabel.frame.origin.y+self.titleLabel.frame.size.height+15, self.alertView.bounds.size.width-20, rect.size.height)];
    self.subTitleLabel.text=subTitle;
    self.subTitleLabel.font=[UIFont systemFontOfSize:17];
    self.subTitleLabel.numberOfLines=0;
    self.subTitleLabel.lineBreakMode=NSLineBreakByTruncatingTail;
    [self.alertView addSubview:self.subTitleLabel];
    
    UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.alertView.bounds.size.width, 15)];
    UIView *footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.alertView.bounds.size.width, 15)];
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, self.subTitleLabel.frame.origin.y+self.subTitleLabel.frame.size.height, self.alertView.bounds.size.width, self.alertView.bounds.size.height-110-rect.size.height)];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView=headView;
    self.tableView.tableFooterView=footView;
    [self.alertView addSubview:self.tableView];
    
    self.sureButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.sureButton setTitleColor:[UIColor colorWithHexString:@"#4e4e4e"] forState:UIControlStateNormal];
    self.sureButton.layer.borderColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.3].CGColor;
    self.sureButton.layer.borderWidth=0.5;
    [self.sureButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    self.sureButton.frame=CGRectMake(0, self.alertView.bounds.size.height-50, self.alertView.bounds.size.width, 50);
    [self.alertView addSubview:self.sureButton];
    
    if (_dataArray.count>4)
    {
        self.tableView.scrollEnabled=YES;
    }
    else
    {
        self.tableView.scrollEnabled=NO;
    }
    [self.tableView reloadData];
    
}

#pragma mark - UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cellID";
    LimitTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil)
    {
        cell=[[LimitTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSDictionary *dict=[_dataArray objectAtIndex:indexPath.row];
    cell.leftLabel.text=[NSString stringWithFormat:@"%ld %@",indexPath.row+1,dict[@"product_title"]];
    
    if (self.alertType == AlertTypeLimit) {
        cell.rightLabel.text=[NSString stringWithFormat:@"超出%ld箱",([dict[@"quantity"] integerValue]+[dict[@"purchased"] integerValue]-[dict[@"product_limit"] integerValue])];
    } else if (self.alertType == AlertTypeNotEnough) {
        cell.rightLabel.text=@"数量不足";
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}



-(void)clickButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(didClickButton:)])
    {
        [self.delegate didClickButton:self];
    }
    [self dismiss];
}

-(void)dismiss
{
    [UIView animateWithDuration:0.35 animations:^{
        self.alertView.alpha=0.0;
    }completion:^(BOOL finished) {
        for (UIView *view in self.alertView.subviews) {
            [view removeFromSuperview];
        }
        [self removeFromSuperview];
        self.alertView = nil;
    }];
}



- (void)show {
    UIView * keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview:self];
    
    self.subTitleLabel.text = (self.alertType == AlertTypeLimit)?@"部分商品超过限购数量,请重新选择商品!":@"部分商品数量不足,请重新选择商品!";
    
    [UIView animateWithDuration:0.35 animations:^{
        self.alertView.alpha=1;
    }];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
