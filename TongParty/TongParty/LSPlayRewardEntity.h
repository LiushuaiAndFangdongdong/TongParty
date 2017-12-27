//
//  LSPlayRewardEntity.h
//  TongParty
//
//  Created by 刘帅 on 2017/12/10.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDModel.h"

@interface LSPlayRewardEntity : DDModel
/**
 打赏人id
 */
@property (nonatomic, copy)NSString *id;

/**
 打赏人昵称
 */
@property (nonatomic, copy)NSString *name;

/**
 头像
 */
@property (nonatomic, copy)NSString *image;

/**
 性别
 */
@property (nonatomic, copy)NSString *sex;

/**
 礼物id
 */
@property (nonatomic, copy)NSString *gid;

/**
 礼物名称
 */
@property (nonatomic, copy)NSString *gift_text;
@end
