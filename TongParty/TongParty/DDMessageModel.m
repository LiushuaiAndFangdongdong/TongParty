
//
//  DDMasterMessageModel.m
//  TongParty
//
//  Created by 方冬冬 on 2017/12/11.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDMessageModel.h"
#import <MJExtension/MJExtension.h>

@implementation DDMessageModel

/* 设置模型属性名和字典key之间的映射关系 */
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
    return @{
             @"msg_id" : @"msg.id",
             @"msg_text" : @"msg.msg_text",
             @"uptime" : @"msg.uptime"
             };
}

@end
