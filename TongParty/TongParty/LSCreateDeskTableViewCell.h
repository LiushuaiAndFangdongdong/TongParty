//
//  LSCreateDeskTableViewCell.h
//  TongParty
//
//  Created by 刘帅 on 2017/10/28.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDBaseTableViewCell.h"

typedef NS_ENUM(NSUInteger, LSCreateDeslCellStyle) {
    /** 活动，主题*/
    LSCreateCellSytleActionAndTheme,
    /** 时间，地点*/
    LSCreateCellSytleTimeAndAddress,
    /** 人数，预估市场，人均消费*/
    LSCreateCellSytleMembersEstimatePerCapita,
    /** 描述*/
    LSCreateCellSytleDescription,
    /** 是否参加心跳桌*/
    LSCreateCellSytleIsJoinDesk,
};

@interface LSCreateDeskTableViewCell : DDBaseTableViewCell


@property (nonatomic, assign)LSCreateDeslCellStyle style;

@property (nonatomic, copy) void(^onClickBlcok)(NSInteger index);

- (void)updateWithObj:(id)obj;

@end
