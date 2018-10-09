//
//  ApplySuccViewController.m
//  CookBook
//
//  Created by 你好 on 16/9/8.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "ApplySuccViewController.h"
#import "NavView.h"
#import "MineInfoViewController.h"
@interface ApplySuccViewController ()

@end

@implementation ApplySuccViewController
{
    NavView *_navView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES];
    
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    
    _navView=[[NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    [_navView.leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_navView.leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_navView.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _navView.centerLabel.text=@"团主资格审核";
    _navView.rightButton.titleLabel.font=[UIFont systemFontOfSize:16];
    [self.view addSubview:_navView];
  
    UIImage *centerImage=[UIImage imageNamed:@"ID_icon"];
    UIImageView *centerImageView=[[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth-centerImage.size.width)/2, 64+(ScreenHeight-64-centerImage.size.height)/3, centerImage.size.width, centerImage.size.height)];
    centerImageView.image=centerImage;
    [self.view addSubview:centerImageView];
    
    NSString *string=@"提交成功,一家一农会在2个工作日之内联系您，请保持电话畅通!";
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    [paragraphStyle setLineSpacing:5.0f];//调整行间距
//    [attributedString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:RGBACOLOR(166, 166, 166, 1),NSParagraphStyleAttributeName:paragraphStyle} range:NSMakeRange(0, string.length)];

    UILabel *bottomLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, centerImageView.frame.origin.y+centerImageView.frame.size.height+20, ScreenWidth-30, 50)];
//    bottomLabel.attributedText=attributedString;
    bottomLabel.textColor=RGBACOLOR(166, 166, 166, 1);
    bottomLabel.font=[UIFont systemFontOfSize:20];
    bottomLabel.text=string;
    bottomLabel.numberOfLines=2;
    bottomLabel.lineBreakMode=NSLineBreakByTruncatingTail;
    [self.view addSubview:bottomLabel];
    
}



-(void)leftButtonClick:(UIButton *)button
{
    for (UIViewController *vc in self.navigationController.viewControllers)
    {
        if ([vc isKindOfClass:[MineInfoViewController class]])
        {
            [self.navigationController popToViewController:vc animated:YES];
        }
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
