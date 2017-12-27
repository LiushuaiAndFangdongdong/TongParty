//
//  LSPrivateEntity.h
//  TongParty
//
//  Created by 刘帅 on 2017/12/19.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDModel.h"

@interface LSPrivateEntity : DDModel

/**
 手机
 */
@property (nonatomic, copy)NSString *phone;

/**
 地址
 */
@property (nonatomic, copy)NSString *addr;

/**
 桌子
 */
@property (nonatomic, copy)NSString *desk;

/**
 照片
 */
@property (nonatomic, copy)NSString *photo;
@end
