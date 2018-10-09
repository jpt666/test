//
//  UpdateCommentPointViewController.m
//  CookBook
//
//  Created by 你好 on 16/9/6.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "UpdateCommentPointViewController.h"
#import "NavView.h"
#import "UpdateComPointTableCell.h"
@interface UpdateCommentPointViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation UpdateCommentPointViewController
{
    NavView *_navView;
    UITableView *_tableView;
    UIButton *_saveButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    _navView=[[NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navView.centerLabel.text=@"修改收货人";
    [_navView.leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_navView.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navView];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 74, ScreenWidth, ScreenHeight-74) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.scrollEnabled=NO;
    _tableView.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    [self.view addSubview:_tableView];

    CGRect rect=[_tableView rectForSection:0];
    _saveButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _saveButton.frame=CGRectMake(10, rect.origin.y+rect.size.height+50, ScreenWidth-20, 50);
    [_saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [_saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _saveButton.backgroundColor=[UIColor lightGrayColor];
    [_saveButton addTarget:self action:@selector(saveButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_tableView addSubview:_saveButton];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (([self validatePhone:self.mobile])&&(self.name.length>0))
    {
        _saveButton.enabled=YES;
        _saveButton.backgroundColor=RGBACOLOR(176, 116, 67, 1);
    }
    else
    {
        _saveButton.enabled=NO;
        _saveButton.backgroundColor=[UIColor lightGrayColor];
    }
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

-(void)saveButtonClick:(UIButton *)button
{
    if (_saveEdit) {
        _saveEdit(self.name, self.mobile);
        _saveEdit = nil;
    }
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - UITableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIDE=@"cellIDE";
    UpdateComPointTableCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIDE];
    if (cell==nil)
    {
        cell=[[UpdateComPointTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIDE];
    }
    
    if (indexPath.row==0)
    {
        cell.textField.text = self.name;
        cell.textField.placeholder=@"收货人姓名";
    }
    else if (indexPath.row==1)
    {
        cell.textField.text = self.mobile;
        cell.textField.placeholder=@"手机号码";
        cell.textField.keyboardType=UIKeyboardTypeNumberPad;
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
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}



-(void)textFieldDidChange:(NSNotification *)nsnotification
{
    UpdateComPointTableCell *nameTextCell=[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    self.name = nameTextCell.textField.text;
    
    UpdateComPointTableCell *phoneTextCell=[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    if (phoneTextCell.textField.text.length>11)
    {
        phoneTextCell.textField.text=[phoneTextCell.textField.text substringToIndex:11];
    }
    self.mobile = phoneTextCell.textField.text;
    
    if (([self validatePhone:phoneTextCell.textField.text])&&(nameTextCell.textField.text.length>0))
    {
        _saveButton.enabled=YES;
        _saveButton.backgroundColor=RGBACOLOR(176, 116, 67, 1);
    }
    else
    {
        _saveButton.enabled=NO;
        _saveButton.backgroundColor=[UIColor lightGrayColor];
    }
}




//正则判断手机号码格式
-(BOOL)validatePhone:(NSString *)phone
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:phone] == YES)
        || ([regextestcm evaluateWithObject:phone] == YES)
        || ([regextestct evaluateWithObject:phone] == YES)
        || ([regextestcu evaluateWithObject:phone] == YES))
    {
        if([regextestcm evaluateWithObject:phone] == YES) {
            NSLog(@"China Mobile");
        } else if([regextestct evaluateWithObject:phone] == YES) {
            NSLog(@"China Telecom");
        } else if ([regextestcu evaluateWithObject:phone] == YES) {
            NSLog(@"China Unicom");
        } else {
            NSLog(@"Unknow");
        }
        
        return YES;
    }
    else
    {
        return NO;
    }
}



-(void)leftButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
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
