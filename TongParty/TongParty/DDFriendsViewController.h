//
//  DDFriendsViewController.h
//  TongParty
//
//  Created by 方冬冬 on 2017/9/27.
//  Copyright © 2017年 桐聚. All rights reserved.
//
//好友、关注、被关注、打赏明细页面

#import "DDBaseTableViewController.h"

typedef NS_ENUM(NSUInteger, DDFriendsViewControllerStyle) {
    /** 个人相册*/
    DDFriendCurrentUserStyle = 0,
    /** 他人相册*/
    DDFriendOtherUserStyle,
};

typedef NS_ENUM(NSUInteger, DDFriendsStyle) {
    /** 常规好友列表*/
    DDFriendsStyleNormal = 0,
    /** 关注*/
    DDFriendsStyleCare,
    /** 被关注*/
    DDFriendsStyleCared,
    /** 打赏明细*/
    DDFriendsStyleReward,
    /** 黑名单*/
    DDFriendsStyleBlackList
};


@interface DDFriendsViewController : DDBaseTableViewController
@property (nonatomic, assign) DDFriendsStyle style;
@property (nonatomic, assign) DDFriendsViewControllerStyle type;
@property (nonatomic, copy) NSString *fid;
@end

