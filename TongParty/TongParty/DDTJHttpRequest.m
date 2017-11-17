//
//  DDTJHttpRequest.m
//  TongParty
//
//  Created by 方冬冬 on 2017/10/30.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDTJHttpRequest.h"

@implementation DDTJHttpRequest


//获取短信验证码
+ (void)msgCodeWithUsername:(NSString *)username block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure
{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"mobile" value:username];
    [self getWithAction:kTJLoginSendCodeAPI params:md  type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
            [MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        failure();
    }];
}
//注册
+ (void)registerWithMobile:(NSString *)mobile passwd:(NSString *)passwd code:(NSString *)code block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"mobile" value:mobile];
    [self setWithMutableDict:md key:@"password" value:passwd];
    [self setWithMutableDict:md key:@"code" value:code];
    [self getWithAction:kTJUserRegisterAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        [MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        failure();
    }];
}
//登录
+ (void)loginWithMobile:(NSString *)mobile password:(NSString *)password block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"mobile" value:mobile];
    [self setWithMutableDict:md key:@"password" value:password];
    [self getWithAction:kTJUserLoginAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            NSDictionary *d = result.data;
            NSLog(@"%@",d);
            DDUserSingleton *user = [DDUserSingleton shareInstance];
            user = [DDUserSingleton mj_objectWithKeyValues:d];
            [kNotificationCenter postNotificationName:kUpdateUserInfoNotification object:nil];
            [kNotificationCenter postNotificationName:kUpdateUserInfoNotification object:nil];
            dict(result.data);
        } else {
            failure();
        }
        [MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        failure();
    }];
}
//用户详情页
+ (void)getUserDetailInfoWithToken:(NSString *)token block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self getWithAction:kTJUserInfoDetailAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            NSDictionary *d = result.data;
            NSLog(@"%@",d);
//            DDUserSingleton *user = [DDUserSingleton shareInstance];
//            user = [DDUserSingleton mj_objectWithKeyValues:d];
//            [kNotificationCenter postNotificationName:kUpdateUserInfoNotification object:nil];
//            [kNotificationCenter postNotificationName:kUpdateUserInfoNotification object:nil];
            dict(result.data);
        } else {
            failure();
        }
        [MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        failure();
    }];
}
@end












