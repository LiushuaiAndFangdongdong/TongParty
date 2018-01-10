//
//  LSActivityEntity.h
//  TongParty
//
//  Created by 刘帅 on 2017/12/27.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDModel.h"

@interface LSActivityEntity : DDModel


/**
 父级id
 */
@property (nonatomic, copy)NSString *parent_id;

/**
 活动ID
 */
@property (nonatomic, copy)NSString *id;

/**
 活动名称
 */
@property (nonatomic, copy)NSString *name;

/**
 排序
 */
@property (nonatomic, copy)NSString *rank;

/**
 是否热门
 */
@property (nonatomic, copy)NSString *is_hot;

/**
 子级别
 */
@property (nonatomic, strong)NSArray *child;

/**
 是否被选择
 */
@property (nonatomic, assign)BOOL is_selected;
@end
