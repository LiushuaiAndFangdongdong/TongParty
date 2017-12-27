//
//  LSTableEntity.h
//  TongParty
//
//  Created by 刘帅 on 2017/12/13.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDModel.h"

@interface LSTableEntity : DDModel

/**
 桌子ID
 */
@property (nonatomic, copy)NSString *tid;

/**
 桌主ID
 */
@property (nonatomic, copy)NSString *t_uid;

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
@end
