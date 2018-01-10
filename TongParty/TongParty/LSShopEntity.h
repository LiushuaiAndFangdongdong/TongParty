//
//  LSShopEntity.h
//  TongParty
//
//  Created by 刘帅 on 2018/1/3.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "DDModel.h"

@interface LSShopEntity : DDModel

/**
 商户id
 */
@property (nonatomic, copy) NSString *id;

/**
 开始时间
 */
@property (nonatomic, copy) NSString *star_time;

/**
 结束时间
 */
@property (nonatomic, copy) NSString *end_time;

/**
 纬度
 */
@property (nonatomic, copy) NSString *longitude;

/**
 经度
 */
@property (nonatomic, copy) NSString *latitude;

/**
 地址
 */
@property (nonatomic, copy) NSString *address;

/**
 评分
 */
@property (nonatomic, copy) NSString *star;

/**
 区域
 */
@property (nonatomic, copy) NSString *trad_area;

/**
 图片
 */
@property (nonatomic, copy) NSString *image;

/**
 所在地
 */
@property (nonatomic, copy) NSString *district;

/**
 商户名称
 */
@property (nonatomic, copy) NSString *name;

/**
 人均消费
 */
@property (nonatomic, copy) NSString *average_price;
@end
