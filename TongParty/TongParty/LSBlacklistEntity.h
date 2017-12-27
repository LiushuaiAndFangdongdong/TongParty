//
//  LSBlacklistEntity.h
//  TongParty
//
//  Created by 刘帅 on 2017/12/19.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDModel.h"

@interface LSBlacklistEntity : DDModel

/**
 用户id
 */
@property (nonatomic, copy)NSString *id;

/**
 昵称
 */
@property (nonatomic, copy)NSString *name;

/**
 头像
 */
@property (nonatomic, copy)NSString *image;

/**
 拉黑时间
 */
@property (nonatomic, copy)NSString *uptime;

@end
