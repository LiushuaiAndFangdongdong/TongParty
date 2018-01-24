//
//  LSNoticeMessageEntity.h
//  TongParty
//
//  Created by 刘帅 on 2018/1/19.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "DDModel.h"

@interface LSNoticeMessageEntity : DDModel

/**
 消息内容
 */
@property (nonatomic, copy) NSString *msg_text;

/**
 发送时间
 */
@property (nonatomic, copy) NSString *uptime;

/**
 发送人性别
 */
@property (nonatomic, copy) NSString *sex;

/**
 消息id
 */
@property (nonatomic, copy) NSString *id;

/**
 发送人头像
 */
@property (nonatomic, copy) NSString *image;

/**
 桌子id
 */
@property (nonatomic, copy) NSString *tid;

/**
 发送人昵称
 */
@property (nonatomic, copy) NSString *name;

/**
 发送人id
 */
@property (nonatomic, copy) NSString *from_id;
@end
