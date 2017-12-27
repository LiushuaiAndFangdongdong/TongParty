//
//  DDMasterMessageModel.h
//  TongParty
//
//  Created by 方冬冬 on 2017/12/11.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDModel.h"

@interface DDMessageModel : DDModel

@property (nonatomic, copy) NSString *begin_time;//开始时间
@property (nonatomic, copy) NSString *custom; //活动名称
@property (nonatomic, copy) NSString *mid;//消息类型id
@property (nonatomic, copy) NSString *num;//未读条数
@property (nonatomic, copy) NSString *tid;  //桌子id
//@property (nonatomic, copy) NSString *msg; //msg[id]--消息id  msg[msg_text]--消息内容 msg[uptime]发布时间
@property (nonatomic, copy) NSString *msg_id;
@property (nonatomic, copy) NSString *msg_text;
@property (nonatomic, copy) NSString *uptime;
@end













