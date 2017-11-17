//
//  DDResponseModel.h
//  TongParty
//
//  Created by 方冬冬 on 2017/10/30.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDModel.h"

typedef NS_ENUM(NSUInteger, DDResponseState) {
    kDDResponseStateSuccess = 0, //网络请求成功
    kDDResponseStateFailure,     //网络请求失败
};

@interface DDResponseModel : DDModel
@property (nonatomic, copy)   NSString *status;    //错误码
@property (nonatomic, strong) id       data;          //数据
@property (nonatomic, copy)   NSString *msg;       //服务器返回消息(英文)
@property (nonatomic, copy)   NSString *msg_cn;    //服务器返回消息(中文)
@end
