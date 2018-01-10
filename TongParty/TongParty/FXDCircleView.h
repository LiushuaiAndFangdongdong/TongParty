//
//  FXDCircleView.h
//  TongParty
//
//  Created by 方冬冬 on 2018/1/4.
//  Copyright © 2018年 桐聚. All rights reserved.
//

//发现附近页面的转动摩天轮
#import <UIKit/UIKit.h>
#import "DDNearUserModel.h"
#import "DDNearTableModel.h"

@interface FXDCircleView : UIView
- (void)updateNearUserWithArray:(NSArray<DDNearUserModel *>*)userArr;
- (void)updateNearTableWithArray:(NSArray<DDNearTableModel *>*)tableArr;
@end

