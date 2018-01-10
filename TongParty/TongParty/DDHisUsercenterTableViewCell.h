//
//  DDHisUsercenterTableViewCell.h
//  TongParty
//
//  Created by 方冬冬 on 2017/10/31.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDBaseTableViewCell.h"

typedef NS_ENUM(NSUInteger, DDHisUserCellStyle) {
    /** 用户基本资料*/
    DDHisUserCellStyleUserInfo,
    /** 各种值*/
    DDHisUserCellStyleVariousNumbers,
    /** 打赏明细*/
    DDHisUserCellStyleTongCoin,
    /** 相册*/
    DDHisUserCellStyleAlbum,
    /** 活动历史*/
    DDHisUserCellStyleActivities
};

@interface DDHisUsercenterTableViewCell : DDBaseTableViewCell
@property (nonatomic, copy) void(^variousNumberClickBlcok)(NSInteger index);
@property (nonatomic, copy) void(^activityHistoryClickBlcok)(NSInteger index);
@property (nonatomic, copy) void(^careBtnClickBlcok)(BOOL isCare);
@property (nonatomic, copy)void(^playReward)();
@property (nonatomic, assign) DDHisUserCellStyle style;
- (void)updateValueWith:(id)model;
@end











