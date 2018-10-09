//
//  GroupTapView.h
//  CookBook
//
//  Created by 你好 on 16/8/10.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupTapView : UIView

@property (nonatomic,retain)UILabel *leftLabel;
@property (nonatomic,retain)UILabel *rightLabel;
//@property (nonatomic,strong)NSNumber * bulkId;
@property (nonatomic,strong)NSDictionary * dictBulkData;
@property (nonatomic,assign)id delegate;

@end



@protocol GroupTapViewDelegate <NSObject>

-(void)groupTapViewClick:(GroupTapView *)tapView;

@end
