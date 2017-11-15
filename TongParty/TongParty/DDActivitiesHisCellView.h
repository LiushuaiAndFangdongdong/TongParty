//
//  DDActivitiesHisCellView.h
//  TongParty
//
//  Created by 方冬冬 on 2017/9/25.
//  Copyright © 2017年 桐聚. All rights reserved.
//
//活动历史

#import <UIKit/UIKit.h>
#import "DDUserInfoModel.h"

@interface DDActivitiesHisCellView : UIView
@property (nonatomic, copy) void(^activityHistoryClickBlcok)(NSInteger index);
- (void)updateWithModel:(DDUserInfoModel *)model;
@end
