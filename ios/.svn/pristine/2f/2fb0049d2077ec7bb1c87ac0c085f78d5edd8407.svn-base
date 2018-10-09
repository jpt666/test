//
//  MaterialsViewController.m
//  CookBook
//
//  Created by 你好 on 16/4/15.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "MaterialsViewController.h"
#import "NavView.h"
#import "MaterTableViewCell.h"
@interface MaterialsViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@end

@implementation MaterialsViewController
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    
    UIView * _curResponder;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    _dataArray=[[NSMutableArray alloc]initWithCapacity:0];
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [dict setObject:@"" forKey:@"Mater"];
    [dict setObject:@"" forKey:@"Num"];
    [_dataArray addObject:dict];
    
    
    if (self.listArray.count>0)
    {
        [_dataArray removeAllObjects];
        [_dataArray addObjectsFromArray:self.listArray];
    }
    
    
    NavView *navView=[[NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    [navView.leftButton setTitle:@"取消" forState:UIControlStateNormal];
    [navView.rightButton setTitle:@"完成" forState:UIControlStateNormal];
    navView.leftButton.frame=CGRectMake(5, 20, 50, 44);
    navView.rightButton.frame=CGRectMake(ScreenWidth-55, 20, 50, 44);
    [navView.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [navView.rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:navView];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    
    UIView *footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    footView.backgroundColor=[UIColor whiteColor];
    footView.userInteractionEnabled=YES;
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 43.5, ScreenWidth, 0.5)];
    lineView.backgroundColor=[UIColor lightGrayColor];
    [footView addSubview:lineView];
    
    UIImage *addImage=[UIImage imageNamed:@"add_mater"];
    
    UIImageView *addImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20,(44-addImage.size.height)/2, addImage.size.width, addImage.size.height)];
    addImageView.image=addImage;
    addImageView.userInteractionEnabled=YES;
    [footView addSubview:addImageView];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(30+addImage.size.width, 0, ScreenWidth-30-addImage.size.width, 44)];
    label.backgroundColor=[UIColor clearColor];
    label.text=@"增加一行";
    label.textColor=[UIColor lightGrayColor];
    [footView addSubview:label];
    _tableView.tableFooterView=footView;

    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    tapGesture.numberOfTapsRequired=1;
    tapGesture.numberOfTouchesRequired=1;
    [footView addGestureRecognizer:tapGesture];
    
}



-(void)leftButtonClick:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)rightButtonClick:(UIButton *)button
{
//    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
//    UIView *firstResponder = [keyWindow performSelector:@selector(firstResponder)];
//    [firstResponder resignFirstResponder];
    
    if (_curResponder) {
        [_curResponder resignFirstResponder];
    }
    
    NSMutableArray *array=[[NSMutableArray alloc]init];
    for (NSDictionary *dict in _dataArray)
    {
        BOOL flag = NO;
        
        if ([[dict objectForKey:@"Mater"]length]>0)
        {
            flag=YES;
        }
     
        if ([[dict objectForKey:@"Num"]length]>0)
        {
            flag=YES;
        }
        
        if (flag)
        {
            [array addObject:dict];
        }
    }
    self.backValue(array);
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)tapGesture:(UITapGestureRecognizer *)tapGesture
{
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [dict setObject:@"" forKey:@"Mater"];
    [dict setObject:@"" forKey:@"Num"];
    [_dataArray addObject:dict];
    
    [_tableView reloadData];
}


#pragma mark - UITableViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
//    UIView *firstResponder = [keyWindow performSelector:@selector(firstResponder)];
//    [firstResponder resignFirstResponder];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cellID";
    MaterTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    for (UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    cell=nil;

    if (cell==nil)
    {
       cell=[[MaterTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }

    
    NSDictionary *dict=[_dataArray objectAtIndex:indexPath.row];
    cell.leftTextField.placeholder=@"用料:例如鸡蛋";
    cell.rightTextField.placeholder=@"用量:例如3个";
    cell.leftTextField.text=[dict objectForKey:@"Mater"];
    cell.rightTextField.text=[dict objectForKey:@"Num"];
    
    cell.leftTextField.delegate=self;
    cell.rightTextField.delegate=self;
    
    cell.leftTextField.returnKeyType=UIReturnKeyDone;
    cell.rightTextField.returnKeyType=UIReturnKeyDone;
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

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataArray.count>1)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle ==UITableViewCellEditingStyleDelete)
    {
        [_dataArray removeObjectAtIndex:indexPath.row];
        [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    _curResponder = textField;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    _curResponder = nil;
    MaterTableViewCell *cell;
    
    if (IS_OS_8_OR_LATER)
    {
        cell = (MaterTableViewCell *)textField.superview.superview.superview;
    }
    else
    {
        cell = (MaterTableViewCell *)textField.superview.superview.superview.superview;
    }
    
    NSIndexPath *indexPath=[_tableView indexPathForCell:cell];
    NSMutableDictionary *dict=[_dataArray objectAtIndex:indexPath.row];
    if (cell.leftTextField==textField)
    {
        if (textField.text.length>0)
        {
            [dict setObject:textField.text forKey:@"Mater"];
        }
        else
        {
            [dict setObject:@"" forKey:@"Mater"];
        }
    }
    else if (cell.rightTextField==textField)
    {
        if (textField.text.length>0)
        {
            [dict setObject:textField.text forKey:@"Num"];
        }
        else
        {
            [dict setObject:@"" forKey:@"Num"];
        }
    }    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
