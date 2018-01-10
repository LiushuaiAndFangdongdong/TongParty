//
//  LSAdmRegionEntity.h
//  TongParty
//
//  Created by 刘帅 on 2017/12/28.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDModel.h"

@interface LSAdmRegionEntity : DDModel

/**
 地址id
 */
@property (nonatomic, copy)NSString *id;

/**
 上级id
 */
@property (nonatomic, copy)NSString *pid;

/**
 地址名称
 */
@property (nonatomic, copy)NSString *name;

/**
 子级
 */
@property (nonatomic, strong)NSArray *children;

/**
 纬度
 */
@property (nonatomic, copy)NSString *latitude;

/**
 经度
 */
@property (nonatomic, copy)NSString *longitude;
@end
