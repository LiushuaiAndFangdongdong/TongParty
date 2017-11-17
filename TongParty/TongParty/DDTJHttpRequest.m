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

/**添加地址*/
+ (void)addCustomAddressWithToken:(NSString *)token
                         latitude:(NSString *)latitude
                        longitude:(NSString *)longitude
                            label:(NSString *)label
                             addr:(NSString *)addr
                           detail:(NSString *)detail
                            block:(void(^)(NSDictionary *dict))dict
                          failure:(void(^)())failure{
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self setWithMutableDict:md key:@"longitude" value:@40.0109391301];
    [self setWithMutableDict:md key:@"latitude" value:@116.489103210];
    [self setWithMutableDict:md key:@"label" value:label];
    [self setWithMutableDict:md key:@"addr" value:addr];
    [self setWithMutableDict:md key:@"detail" value:detail];

//    [self postWithAction:kTJAddAddressAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
//        if (result.status.integerValue == kDDResponseStateSuccess) {
//        dict(result.data);
//        } else {
//            failure();
//        }
//        [MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
//    } failure:^{
//        //
//    }];

[self getWithAction:kTJAddAddressAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
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


/**修改地址*/
+ (void)editCustomAddressWithToken:(NSString *)token aid:(NSString *)aid latitude:(NSString *)latitude longitude:(NSString *)longitude label:(NSString *)label addr:(NSString *)addr detail:(NSString *)detail block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
}


/**删除地址*/
+ (void)deleteCustomAddressWithToken:(NSString *)token aid:(NSString *)aid  block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    
}

/**设置默认地址*/
+ (void)setDefaultAddressWithToken:(NSString *)token aid:(NSString *)aid  block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    
}

/**用户自定义地址列表*/
+ (void)getCustomAddressListWithToken:(NSString *)token block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    
}

@end












