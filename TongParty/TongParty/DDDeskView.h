//
//  DDDeskView.h
//  TongParty
//
//  Created by 方冬冬 on 2017/10/12.
//  Copyright © 2017年 桐聚. All rights reserved.
//
//桌子

#import <UIKit/UIKit.h>
#import "DDTableInfoModel.h"

@interface DDDeskView : UIView
- (void)updateDeskInfoWithModel:(DDTableInfoModel *)model;
// 定时器消除
- (void)timerDealloc;
@end
