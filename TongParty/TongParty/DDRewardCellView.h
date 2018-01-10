//
//  DDRewardCellView.h
//  TongParty
//
//  Created by 方冬冬 on 2017/9/25.
//  Copyright © 2017年 桐聚. All rights reserved.
//
//打赏明细

#import <UIKit/UIKit.h>
#import "DDUserInfoModel.h"

typedef NS_ENUM(NSUInteger, DDRewardType) {
    /** 自己的打赏明细进入*/
    DDRewardTypeNormal,
    /** 进入别的页面，打赏别人*/
    DDRewardTypeHis
};
@interface DDRewardCellView : UIView
@property (nonatomic, assign) DDRewardType type;
@property (nonatomic, copy)void(^playReward)();
- (void)updateWithModel:(DDUserInfoModel *)model;
@end




