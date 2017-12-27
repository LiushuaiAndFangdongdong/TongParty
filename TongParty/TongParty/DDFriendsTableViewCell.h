//
//  DDFriendsTableViewCell.h
//  TongParty
//
//  Created by 方冬冬 on 2017/9/27.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDBaseTableViewCell.h"

typedef NS_ENUM(NSUInteger, DDFriendsCellStyle) {
    /** 常规好友列表*/
    DDFriendsCellStyleNormal = 0,
    /** 关注*/
    DDFriendsCellStyleCare,
    /** 被关注*/
    DDFriendsCellStyleCared,
    /** 打赏明细*/
    DDFriendsCellStyleReward,
    /** 黑名单*/
    DDFriendsCellStyleBlackList
};

@interface DDFriendsTableViewCell : DDBaseTableViewCell
@property (nonatomic, assign) DDFriendsCellStyle style;

- (void)updateWithEntity:(id)entity;
@end

