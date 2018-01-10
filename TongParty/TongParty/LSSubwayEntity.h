//
//  LSSubwayEntity.h
//  TongParty
//
//  Created by 刘帅 on 2018/1/5.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "DDModel.h"

@interface LSSubwayEntity : DDModel


/**
 地址id
 */
@property (nonatomic, copy)NSString *id;


/**
 地址名称
 */
@property (nonatomic, copy)NSString *name;

/**
 上级id
 */
@property (nonatomic, copy)NSString *pid;

/**
 纬度
 */
@property (nonatomic, copy)NSString *latitude;

/**
 经度
 */
@property (nonatomic, copy)NSString *longitude;

/**
 子级
 */
@property (nonatomic, strong)NSArray *children;
@end
