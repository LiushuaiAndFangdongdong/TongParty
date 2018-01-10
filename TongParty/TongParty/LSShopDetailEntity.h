//
//  LSShopDetailEntity.h
//  TongParty
//
//  Created by 刘帅 on 2018/1/3.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "DDModel.h"

@interface LSShopDetailEntity : DDModel
/**
 商户id
 */
@property (nonatomic, copy) NSString *id;

/**
 纬度
 */
@property (nonatomic, copy) NSString *longitude;

/**
 电话
 */
@property (nonatomic, copy) NSString *phone;

/**
 经度
 */
@property (nonatomic, copy) NSString *latitude;

/**
 地址
 */
@property (nonatomic, copy) NSString *address;

/**
 商圈
 */
@property (nonatomic, copy) NSString *trad_area;

/**
 图片
 */
@property (nonatomic, strong) NSArray *photo;

/**
 商户名称
 */
@property (nonatomic, copy) NSString *name;

/**
 商户介绍
 */
@property (nonatomic, copy) NSString *introduction;

/**
 人均消费
 */
@property (nonatomic, copy) NSString *average_price;

/**
 评分
 */
@property (nonatomic, copy) NSString *star;
@end
