//
//  LSFriendEntity.h
//  TongParty
//
//  Created by 刘帅 on 2017/12/11.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDModel.h"
@interface LSFriendEntity : DDModel

/**
 好友id
 */
@property (nonatomic, copy)NSString *friend_id;

/**
 好友昵称
 */
@property (nonatomic, copy)NSString *name;

/**
 好友真实姓名
 */
@property (nonatomic, copy)NSString *remark;

/**
 头像
 */
@property (nonatomic, copy)NSString *image;

/**
 桌子
 */
@property (nonatomic, strong)NSArray *table;
@end
