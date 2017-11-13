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
@property (nonatomic, assign)CGFloat           current_height;
@property (nonatomic, copy) void(^onClickBlcok)(NSInteger index);
@property (nonatomic, copy) void(^expandMoreBlcok)(CGFloat final_height);

- (void)updateWithObj:(id)obj;
- (void)putStringToChildView:(NSString *)string;

@end
