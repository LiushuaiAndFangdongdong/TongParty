//
//  LSPersonEntity.h
//  TongParty
//
//  Created by 刘帅 on 2018/1/18.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "DDModel.h"

@interface LSPersonEntity : DDModel

/**
 请求时间
 */
@property (nonatomic, copy)NSString *uptime;

/**
 id
 */
@property (nonatomic, copy)NSString *uid;

/**
 信用分
 */
@property (nonatomic, copy)NSString *score;

/**
 经度
 */
@property (nonatomic, copy)NSString *longitude;

/**
 纬度
 */
@property (nonatomic, copy)NSString *latitude;

/**
 距离
 */
@property (nonatomic, copy)NSString *distance;

/**
 签名
 */
@property (nonatomic, copy)NSString *signature;

/**
 头像
 */
@property (nonatomic, copy)NSString *image;

/**
 是否发送过申请
 */
@property (nonatomic, copy)NSString *is_send;

/**
 名字
 */
@property (nonatomic, copy)NSString *name;

/**
 性别
 */
@property (nonatomic, copy)NSString *sex;

@property (nonatomic, copy)NSString *status;
@end
