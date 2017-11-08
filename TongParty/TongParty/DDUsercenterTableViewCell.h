//
//  DDUsercenterTableViewCell.h
//  TongParty
//
//  Created by 方冬冬 on 2017/9/25.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDBaseTableViewCell.h"
#import "DDUserInfoModel.h"

typedef NS_ENUM(NSUInteger, DDUserCellStyle) {
    /** 各种值*/
    DDUserCellStyleVariousNumbers,
    /** 打赏明细*/
    DDUserCellStyleTongCoin,
    /** 相册*/
    DDUserCellStyleAlbum,
    /** 活动历史*/
    DDUserCellStyleActivities
};

@interface DDUsercenterTableViewCell : DDBaseTableViewCell

@property (nonatomic, copy) void(^variousNumberClickBlcok)(NSInteger index);
@property (nonatomic, copy) void(^activityHistoryClickBlcok)(NSInteger index);
@property (nonatomic, assign) DDUserCellStyle style;
- (void)updateWithModel:(DDUserInfoModel *)model;
@end









