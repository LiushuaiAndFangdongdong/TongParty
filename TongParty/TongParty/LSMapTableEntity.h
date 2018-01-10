//
//  LSMapTableEntity.h
//  TongParty
//
//  Created by 刘帅 on 2018/1/4.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "DDModel.h"

@interface LSMapTableEntity : DDModel

/**
 桌子id
 */
@property (nonatomic , copy)NSString *id;

/**
 桌子分类
 */
@property (nonatomic , copy)NSString *activity;

/**
 开始时间
 */
@property (nonatomic , copy)NSString *begin_time;

/**
 限制人数
 */
@property (nonatomic , copy)NSString *person_num;

/**
 纬度
 */
@property (nonatomic , copy)NSString *latitude;

/**
 经度
 */
@property (nonatomic , copy)NSString *longitude;

/**
 活动名称
 */
@property (nonatomic , copy)NSString *custom;

/**
 活动图标
 */
@property (nonatomic , copy)NSString *image;


/**
 当前时间
 */
@property (nonatomic , copy)NSString *serviceTime;
@end
