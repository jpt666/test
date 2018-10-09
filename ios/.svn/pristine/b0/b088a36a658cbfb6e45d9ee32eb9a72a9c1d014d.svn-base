//
//  MoreContentView.h
//  CookBook
//
//  Created by 你好 on 16/5/18.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"
#import "CookBaseProxy.h"
#import "CookBookPropertyKeys.h"
#import "CookProductPropertyKeys.h"

@interface MoreContentView : UIView

@property (nonatomic,assign)id delegate;


-(instancetype)initWith:(NSMutableArray *)array nickName:(NSString *)nickname imagemd5:(NSString *)md5 cookType:(CookType)type yOffSet:(double)yOffet;

@end


@protocol MoreContentViewDelegate <NSObject>

-(void)didClickContentView:(NSDictionary *)dict CookType:(CookType)type;

@end