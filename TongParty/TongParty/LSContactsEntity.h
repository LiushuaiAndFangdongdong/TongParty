//
//  LSContactsEntity.h
//  TongParty
//
//  Created by 刘帅 on 2017/12/13.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDModel.h"

@interface LSContactsEntity : DDModel

/**
 用户ID
 */
@property (nonatomic, copy)NSString *id;

/**
 用户名称
 */
@property (nonatomic, copy)NSString *name;

/**
 用户头像
 */
@property (nonatomic, copy)NSString *image;

/**
 用户手机号
 */
@property (nonatomic, copy)NSString *mobile;

/**
 是否为好友
 */
@property (nonatomic, copy)NSString *is_friend;

@end
