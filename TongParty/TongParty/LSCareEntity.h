//
//  LSCareEntity.h
//  TongParty
//
//  Created by 刘帅 on 2017/12/14.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDModel.h"

@interface LSCareEntity : DDModel
/**
 好友id
 */
@property (nonatomic, copy)NSString *friend_id;

/**
 好友昵称
 */
@property (nonatomic, copy)NSString *name;

/**
 头像
 */
@property (nonatomic, copy)NSString *image;

/**
 桌子id
 */
@property (nonatomic, copy)NSString *tid;

/**
 开始时间
 */
@property (nonatomic, copy)NSString *begin_time;

/**
 桌子地点
 */
@property (nonatomic, copy)NSString *place;

/**
 活动名称
 */
@property (nonatomic, copy)NSString *activity;

/**
 桌主id
 */
@property (nonatomic, copy)NSString *t_uid;
@end
