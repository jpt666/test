//
//  CreateGroupVC3.m
//  CookBook
//
//  Created by 你好 on 16/8/11.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "CreateGroupVC3.h"
#import "NavView.h"
#import "SetGroupTimeView.h"
#import "PickUpTableViewCell.h"
#import "DatePickerView.h"
#import "MyGroupBuyViewController.h"
#import "PickUpAddressViewController.h"
#import "MBProgressHUD+Helper.h"
#import "GlobalVar.h"
#import "NSDate+ZXAdd.h"
#import "GoodsCategoryPropertyKeys.h"
#import "GoodsPropertyKeys.h"
#import "SetUpGroupTextView.h"
#import "GroupsPropertyKeys.h"
#import "RetrieveBulkDataRequest.h"

typedef NS_ENUM(NSInteger, GroupGoodsKind) {
    GroupGoodsKindFruit = 1,
    GroupGoodsKindSeafood = 2
};


@interface CreateGroupVC3 ()<UITableViewDelegate,UITableViewDataSource,RetrieveRequestDelegate>

@end

@implementation CreateGroupVC3
{
    NavView *_navView;
    UITableView *_tableView;
    SetGroupTimeView *_startTimeView;
    SetGroupTimeView *_endTimeView;
    SetGroupTimeView *_preditTimeView;
    SetUpGroupTextView *_groupAreaView;
    SetGroupTimeView *_deliverMethodView;
    SetGroupTimeView *_addressView;
    UIButton *_backButton;
    DatePickerView *_startDatePickView;
    DatePickerView *_endDatePickView;
    DatePickerView *_preditPickView;
    UIButton *_pickUpButton;
    UIButton *_sendOutButton;

    RetrieveBulkDataRequest *_createBulkRequest;
    UIView *_pickSetView;
    
    NSMutableArray *_arrPickAddr;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    
    _navView=[[NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navView.centerLabel.text=@"完善团购信息";
    [_navView.leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_navView.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_navView.rightButton setTitle:@"完成" forState:UIControlStateNormal];
    [_navView.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_navView.rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _navView.rightButton.exclusiveTouch = YES;
    [self.view addSubview:_navView];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    [self.view addSubview:_tableView];
    
    NSString *descStr=@"到货时间规则:\n1.海鲜：每周三之前截团，在当周周末到货；每周三之后截团，在下周周末到货；\n2.水果：截团后第二天可到货，也可指定第二天及之后的日期到货。";
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];//调整行间距
    
    NSMutableAttributedString *attrString=[[NSMutableAttributedString alloc]initWithString:descStr];
    [attrString addAttributes:@{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#4e4e4e" alpha:0.5]} range:NSMakeRange(0, descStr.length)];
    
    CGRect rect= [descStr boundingRectWithSize:CGSizeMake(ScreenWidth-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSParagraphStyleAttributeName:paragraphStyle} context:nil];
    
    UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 340+rect.size.height)];
    headView.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 10, ScreenWidth, rect.size.height+210.5)];
    topView.backgroundColor=[UIColor whiteColor];
    _startTimeView=[[SetGroupTimeView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    _startTimeView.leftLabel.text=@"开始时间";

    
    _startTimeView.date = [NSDate dateWithTimeInterval:ONE_HOUR_SECOND_TIMEINTERVAL sinceDate:[NSDate date]];
    [topView addSubview:_startTimeView];
    
    _endTimeView=[[SetGroupTimeView alloc]initWithFrame:CGRectMake(0, _startTimeView.frame.origin.y+_startTimeView.frame.size.height, ScreenWidth, 50)];
    _endTimeView.leftLabel.text=@"截止时间";
    _endTimeView.date = [NSDate dateWithTimeInterval:ONE_DAY_TIMEINTERVAL sinceDate:_startTimeView.date];
    [topView addSubview:_endTimeView];
    
    _preditTimeView=[[SetGroupTimeView alloc]initWithFrame:CGRectMake(0, _endTimeView.frame.origin.y+_endTimeView.frame.size.height, ScreenWidth, 50)];
    _preditTimeView.leftLabel.text=@"预计到货时间";
    _preditTimeView.rightLabel.hidden=YES;
    [topView addSubview:_preditTimeView];

    UILabel *ruleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, _preditTimeView.frame.origin.y+_preditTimeView.frame.size.height+5, ScreenWidth-20, rect.size.height)];
    ruleLabel.lineBreakMode=NSLineBreakByWordWrapping;
    ruleLabel.numberOfLines=0;
    ruleLabel.attributedText=attrString;
    [topView addSubview:ruleLabel];
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(10, ruleLabel.frame.origin.y+ruleLabel.frame.size.height+5, ScreenWidth-20, 0.5)];
    lineView.backgroundColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.3];
    [topView addSubview:lineView];
    
    _groupAreaView=[[SetUpGroupTextView alloc]initWithFrame:CGRectMake(0, topView.bounds.size.height-50, ScreenWidth, 50)];
    _groupAreaView.titleLabel.text=@"团购区域";
    _groupAreaView.textField.placeholder = @"请输入";
    [topView addSubview:_groupAreaView];
    
    UIView *centerView=[[UIView alloc]initWithFrame:CGRectMake(0, topView.frame.origin.y+topView.frame.size.height+10, ScreenWidth, 100)];
    centerView.backgroundColor=[UIColor whiteColor];
    _deliverMethodView=[[SetGroupTimeView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, 50)];
    _deliverMethodView.leftLabel.text=@"配送方式";
    _deliverMethodView.centerLabel.hidden=YES;
    _deliverMethodView.rightLabel.hidden=YES;
    [centerView addSubview:_deliverMethodView];
    
    _pickUpButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [_pickUpButton setTitle:@"上门自提" forState:UIControlStateNormal];
    _pickUpButton.titleLabel.font=[UIFont systemFontOfSize:16];
    [_pickUpButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [_pickUpButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_pickUpButton setImage:[UIImage imageNamed:@"selected_green_icon"] forState:UIControlStateSelected];
    [_pickUpButton setImage:[UIImage imageNamed:@"normal_round_icon"] forState:UIControlStateNormal];
    [_pickUpButton addTarget:self action:@selector(pickUpButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [centerView addSubview:_pickUpButton];
    
    _sendOutButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [_sendOutButton setTitle:@"送货上门" forState:UIControlStateNormal];
    _sendOutButton.titleLabel.font=[UIFont systemFontOfSize:16];
    [_sendOutButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [_sendOutButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_sendOutButton setImage:[UIImage imageNamed:@"selected_green_icon"] forState:UIControlStateSelected];
    [_sendOutButton setImage:[UIImage imageNamed:@"normal_round_icon"] forState:UIControlStateNormal];
    [_sendOutButton addTarget:self action:@selector(sendOutButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [centerView addSubview:_sendOutButton];
    
    ReceiveMode recieveMode = [self.selectedCategory[kGroupsPropertyRecieveMode] integerValue];
    if (recieveMode == ReceiveModePickUpAndDeliver) {
        _pickUpButton.frame=CGRectMake(10, 50, ScreenWidth/3, 50);
        _sendOutButton.frame=CGRectMake(ScreenWidth/3+30, 50, ScreenWidth/3, 50);
    } else if (recieveMode == ReceiveModePickUp) {
        _pickUpButton.frame=CGRectMake(10, 50, ScreenWidth/3, 50);
        _sendOutButton.hidden = YES;
    } else if (recieveMode == ReceiveModeDeliver) {
        _sendOutButton.frame=CGRectMake(10, 50, ScreenWidth/3, 50);
        _pickUpButton.hidden = YES;
    } else {
        _pickUpButton.hidden = YES;
        _sendOutButton.hidden = YES;
    }
    
    _pickSetView=[[UIView alloc]initWithFrame:CGRectMake(0, centerView.frame.origin.y+centerView.frame.size.height+10, ScreenWidth, 49.5)];
    _pickSetView.backgroundColor=[UIColor whiteColor];
    UILabel *pickUpLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, ScreenWidth-20, 49.5)];
    pickUpLabel.text=@"自提点设置";
    [_pickSetView addSubview:pickUpLabel];
    _pickSetView.hidden = YES;

    UIButton *editButton=[UIButton buttonWithType:UIButtonTypeCustom];
    editButton.frame=CGRectMake(ScreenWidth-60, 0, 50, 49.5);
    [editButton setImage:[UIImage imageNamed:@"edit_icon_dark"] forState:UIControlStateNormal];
    [editButton addTarget:self action:@selector(editButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_pickSetView addSubview:editButton];
    
    UIView *bottomLineView=[[UIView alloc]initWithFrame:CGRectMake(10, _pickSetView.bounds.size.height-0.5, _pickSetView.bounds.size.width-20, 0.5)];
    bottomLineView.backgroundColor=[UIColor colorWithHexString:@"#4e4e4e" alpha:0.3];
    [_pickSetView addSubview:bottomLineView];
    
    headView.frame=CGRectMake(0, 0, ScreenWidth, _pickSetView.frame.origin.y+_pickSetView.frame.size.height);
    
    [headView addSubview:topView];
    [headView addSubview:centerView];
    [headView addSubview:_pickSetView];
    
    _tableView.tableHeaderView=headView;
    
    _backButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.frame=self.view.bounds;
    _backButton.backgroundColor=RGBACOLOR(1, 1, 1, 0.0);
    [_backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backButton];
    _backButton.hidden=YES;
    
    _startDatePickView=[[DatePickerView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 280)];
    _startDatePickView.titleLabel.text=@"开始时间";
    [_startDatePickView.finishButton addTarget:self action:@selector(startFinishButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _startDatePickView.datePicker.date = _startTimeView.date;
    [self.view addSubview:_startDatePickView];
    
    _endDatePickView=[[DatePickerView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 280)];
    _endDatePickView.titleLabel.text=@"截止时间";
    [_endDatePickView.finishButton addTarget:self action:@selector(endFinishButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view  addSubview:_endDatePickView];
    
    _preditPickView=[[DatePickerView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 280)];
    _preditPickView.titleLabel.text=@"预计到货时间";
    _preditPickView.datePicker.datePickerMode = UIDatePickerModeDate;
    [_preditPickView.finishButton addTarget:self action:@selector(preditFinishButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_preditPickView];
    
    UITapGestureRecognizer *startTimeTapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(startTimeTapGesture:)];
    startTimeTapGesture.numberOfTapsRequired=1;
    startTimeTapGesture.numberOfTouchesRequired=1;
    [_startTimeView addGestureRecognizer:startTimeTapGesture];
    
    UITapGestureRecognizer *endTimeTapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endTimeTapGesture:)];
    endTimeTapGesture.numberOfTapsRequired=1;
    endTimeTapGesture.numberOfTouchesRequired=1;
    [_endTimeView addGestureRecognizer:endTimeTapGesture];
    
    UITapGestureRecognizer *preditTapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(preditTapGesture:)];
    preditTapGesture.numberOfTapsRequired=1;
    preditTapGesture.numberOfTouchesRequired=1;
    [_preditTimeView addGestureRecognizer:preditTapGesture];
    
    [self setExpireDate:_endTimeView.date];
}

-(BOOL)checkValueValid
{
    if (!self.bulkTitle.length) {
        [MBProgressHUD showHUDAutoDismissWithString:@"未填写团购标题" andDim:NO];
        return NO;
    }
    
    if (!_groupAreaView.textField.text.length) {
        [MBProgressHUD showHUDAutoDismissWithString:@"未输入区域" andDim:NO];
        return NO;
    }
    
    if (!_pickUpButton.selected && !_sendOutButton.selected) {
        [MBProgressHUD showHUDAutoDismissWithString:@"未选择收货方式" andDim:NO];
        return NO;
    }
    
    if ( _pickUpButton.selected && !_arrPickAddr.count) {
        [MBProgressHUD showHUDAutoDismissWithString:@"未选择自提点" andDim:NO];
        return NO;
    }
    
    if (!_selectedGoods.count) {
        [MBProgressHUD showHUDAutoDismissWithString:@"未选择商品" andDim:NO];
        return NO;
    }
    return YES;
}

-(NSMutableDictionary *)makeBulkData
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    dict[@"title"] = self.bulkTitle;
    dict[@"category"] = self.selectedCategory[kGoodsCategoryPropertyId];
    
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *d in _arrPickAddr) {
        [arr addObject:d[kDispatcherPropertyId]];
    }
    dict[@"storages"] = arr;
    
    dict[@"start_time"] = @([_startTimeView.date timeIntervalSince1970]*1000000);
    dict[@"dead_time"] = @([_endTimeView.date timeIntervalSince1970]*1000000);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    dict[@"arrived_time"] = [formatter stringFromDate:_preditTimeView.date];
    
    dict[@"location"] = _groupAreaView.textField.text;
    
    if (_pickUpButton.isSelected && _sendOutButton.isSelected) {
        dict[@"receive_mode"] = @(ReceiveModePickUpAndDeliver);
    } else if (_pickUpButton.isSelected) {
        dict[@"receive_mode"] = @(ReceiveModePickUp);
    } else if (_sendOutButton.isSelected) {
        dict[@"receive_mode"] = @(ReceiveModeDeliver);
    }
   
    NSMutableArray* arrGoods = [NSMutableArray array];
    for (NSDictionary *d in self.selectedGoods) {
        [arrGoods addObject:d[kGoodsPropertyId]];
    }
    dict[@"products"] = arrGoods;
    
    return dict;
}

-(void)createBulkRequestWithParam:(NSDictionary *)dict
{
    [MBProgressHUD showLoadingWithDim:YES];
    if (_createBulkRequest) {
        [_createBulkRequest cancel];
    }
    _createBulkRequest = [[RetrieveBulkDataRequest alloc] init];
    _createBulkRequest.delegate = self;
    [_createBulkRequest postRequestWithUrl:[GlobalVar shareGlobalVar].bulkListUrl andParam:dict];
}


-(NSDate *)calcReceivingWithEndDate:(NSDate *)date goodsKind:(NSInteger)kind
{
    if (kind == GroupGoodsKindFruit)
    {
        //水果
        NSDateComponents *comps = [NSDate componentsFromTimeInterval1970:[date timeIntervalSince1970]+ONE_DAY_TIMEINTERVAL];
        NSTimeInterval timeInterval = [NSDate timeIntervalSince1970byYear:[comps year] Month:[comps month] day:[comps day] hour:18 min:0];
        return [NSDate dateWithTimeIntervalSince1970:timeInterval];
    }
    else if (kind == GroupGoodsKindSeafood)
    {
        //海鲜
        NSDateComponents * comps = [NSDate componentsFromTimeInterval1970:[date timeIntervalSince1970]];
        NSInteger weekday = [comps weekday]-1;
        
        if (weekday >=0 && weekday <=3) {
            date = [NSDate dateWithTimeInterval:(6-weekday)*ONE_DAY_TIMEINTERVAL sinceDate:date];
        } else {
            date = [NSDate dateWithTimeInterval:(6-weekday+7)*ONE_DAY_TIMEINTERVAL sinceDate:date];
        }
        return date;
    }
    
    return date;
}

-(void)setExpireDate:(NSDate *)date
{
    _endTimeView.date = date;
    _endDatePickView.datePicker.date = date;
    _preditTimeView.date = [self calcReceivingWithEndDate:_endTimeView.date goodsKind:[self.selectedCategory[kGoodsCategoryPropertyId] integerValue]];
    
    _preditPickView.datePicker.minimumDate = _preditTimeView.date;
    _preditPickView.datePicker.date = _preditTimeView.date;
}

-(void)correctExpireDateWithStart:(NSDate *)date
{
    if ([_endTimeView.date compare:date] < 0) {
        _endTimeView.date = date;
        
        _endDatePickView.datePicker.minimumDate = date;
        _endDatePickView.datePicker.date = date;
        
        [self setExpireDate:date];
    }
}

-(void)preditFinishButtonClick:(UIButton *)button
{
    _preditTimeView.date = _preditPickView.datePicker.date;
    [self backButtonClick:nil];
}


-(void)startFinishButtonClick:(UIButton *)button
{
    _startTimeView.date = _startDatePickView.datePicker.date;
    
    [self correctExpireDateWithStart:_startTimeView.date];
    
    [self backButtonClick:nil];
}

-(void)endFinishButtonClick:(UIButton *)button
{
    [self setExpireDate:_endDatePickView.datePicker.date];
    [self backButtonClick:nil];
}

-(void)preditTapGesture:(UITapGestureRecognizer *)tapGesture
{
    if ([self.selectedCategory[kGoodsCategoryPropertyId] integerValue] == GroupGoodsKindFruit) {
        [_groupAreaView.textField resignFirstResponder];
        _backButton.hidden=NO;
        [UIView animateWithDuration:0.15 animations:^{
            _preditPickView.frame=CGRectMake(0, ScreenHeight-280, ScreenWidth, 280);
            _backButton.backgroundColor=RGBACOLOR(1, 1, 1, 0.4);
        }];
    }
}

-(void)startTimeTapGesture:(UITapGestureRecognizer *)tapGesture
{
    [_groupAreaView.textField resignFirstResponder];
    _backButton.hidden=NO;
    [UIView animateWithDuration:0.15 animations:^{
        _startDatePickView.frame=CGRectMake(0, ScreenHeight-280, ScreenWidth, 280);
        _backButton.backgroundColor=RGBACOLOR(1, 1, 1, 0.4);
    } completion:^(BOOL finished) {
        if ([_startTimeView.date compare:[NSDate date]] < 0) {
            _startTimeView.date = [NSDate date];
        }
        _startDatePickView.datePicker.minimumDate = [NSDate date];
        _startDatePickView.datePicker.date = _startTimeView.date;
        
        [self correctExpireDateWithStart:_startTimeView.date];
    }];
}

-(void)endTimeTapGesture:(UITapGestureRecognizer *)tapGesture
{
    [_groupAreaView.textField resignFirstResponder];
    _backButton.hidden=NO;
    [UIView animateWithDuration:0.15 animations:^{
        _endDatePickView.frame=CGRectMake(0, ScreenHeight-280, ScreenWidth, 280);
        _backButton.backgroundColor=RGBACOLOR(1, 1, 1, 0.4);
    } completion:^(BOOL finished) {
        _endDatePickView.datePicker.minimumDate = _startDatePickView.datePicker.date;
    }];
}



-(void)backButtonClick:(UIButton *)button
{
    [UIView animateWithDuration:0.15 animations:^{
        _startDatePickView.frame=CGRectMake(0, ScreenHeight, ScreenWidth, 280);
        _endDatePickView.frame=CGRectMake(0, ScreenHeight, ScreenWidth, 280);
        _preditPickView.frame=CGRectMake(0, ScreenHeight, ScreenWidth, 280);
        _backButton.backgroundColor=RGBACOLOR(1, 1, 1, 0);
    }completion:^(BOOL finished) {
        _backButton.hidden=YES;
    }];
}

-(void)pickUpButtonClick:(UIButton *)button
{
    button.selected=!button.selected;
    _pickSetView.hidden = !button.selected;
    [_tableView reloadData];
}


-(void)sendOutButtonClick:(UIButton *)button
{
    button.selected=!button.selected;
}

#pragma mark - RetrieveRequestDelegate
-(void)didRetrieveDataSuccess:(RetrieveRequest *)request
{
    
    if (request == _createBulkRequest) {
        
        [MBProgressHUD dismissHUD];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:REFRESH_MY_GROUPBUY object:nil];
        
        for (UIViewController *vc in self.navigationController.viewControllers)
        {
            if ([vc isKindOfClass:[MyGroupBuyViewController class]])
            {
                [self.navigationController popToViewController:vc animated:YES];
            }
        }
    }
}

-(void)didRetrieveDataFailed:(RetrieveRequest *)request
{
    if (request == _createBulkRequest) {
        [MBProgressHUD showHUDAutoDismissWithError:request.error andDim:NO];
    }
}

#pragma mark - UITabelViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cellID";
    PickUpTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil)
    {
        cell=[[PickUpTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.hidden = _pickSetView.hidden;
    
    NSDictionary *dict = [_arrPickAddr objectAtIndex:indexPath.row];
    [cell configData:dict];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrPickAddr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.5;
}


#pragma mark - buttonClick

-(void)editButtonClick:(UIButton *)button
{
    PickUpAddressViewController *pickUpAddressViewController=[[PickUpAddressViewController alloc]init];
    pickUpAddressViewController.selectedAddr = _arrPickAddr;
    pickUpAddressViewController.selectComplete = ^(NSMutableArray *selectArray) {
        _arrPickAddr = selectArray;
        [_tableView reloadData];
    };
    [self.navigationController pushViewController:pickUpAddressViewController animated:YES];
}

-(void)leftButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightButtonClick:(UIButton *)button
{
    if ([self checkValueValid])
    {
        NSDictionary *dictParam = [self makeBulkData];
        [self createBulkRequestWithParam:dictParam];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
