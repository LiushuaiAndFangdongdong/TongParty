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
    [self setWithMutableDict:md key:@"longitude" value:longitude];
    [self setWithMutableDict:md key:@"latitude" value:latitude];
    [self setWithMutableDict:md key:@"label" value:label];
    [self setWithMutableDict:md key:@"addr" value:addr];
    [self setWithMutableDict:md key:@"detail" value:detail];

    [self postWithAction:kTJAddAddressAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
        dict(result.data);
        } else {
            failure();
        }
        [MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        //
    }];
}

/**用户自定义地址列表*/
+ (void)getCustomAddressListWithToken:(NSString *)token block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    
    [self getWithAction:kTJGetAddressListAPI params:md type:kDDHttpResponseTypeText block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        [MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        //
    }];
}


/**修改地址*/
+ (void)editCustomAddressWithToken:(NSString *)token aid:(NSString *)aid latitude:(NSString *)latitude longitude:(NSString *)longitude label:(NSString *)label addr:(NSString *)addr detail:(NSString *)detail block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self setWithMutableDict:md key:@"aid" value:aid];
    [self setWithMutableDict:md key:@"longitude" value:longitude];
    [self setWithMutableDict:md key:@"latitude" value:latitude];
    [self setWithMutableDict:md key:@"label" value:label];
    [self setWithMutableDict:md key:@"addr" value:addr];
    [self setWithMutableDict:md key:@"detail" value:detail];
    
    [self postWithAction:kTJEditAddressAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        [MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        //
    }];
}


/**删除地址*/
+ (void)deleteCustomAddressWithToken:(NSString *)token aid:(NSString *)aid  block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self setWithMutableDict:md key:@"aid" value:aid];
    
    [self postWithAction:kTJDeleteAddressAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        [MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        //
    }];
}

/**设置默认地址*/
+ (void)setDefaultAddressWithToken:(NSString *)token aid:(NSString *)aid  block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self setWithMutableDict:md key:@"aid" value:aid];
    
    [self postWithAction:kTJSetDefaultAddressAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        [MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        //
    }];
}

/**创建桌子*/
+ (void)createDeskWithToken:(NSString *)token
                   activity:(NSString *)activity
                      title:(NSString *)title
                      place:(NSString *)place
                 begin_time:(NSString *)begin_time
                 person_num:(NSString *)person_num
                 time_range:(NSString *)time_range
              average_price:(NSString *)average_price
                description:(NSString *)description
                   is_heart:(NSString *)is_heart
                   latitude:(NSString *)latitude
                  longitude:(NSString *)longitude
                      image:(NSString *)image
                      block:(void(^)(NSDictionary *dict))dict
                    failure:(void(^)())failure{
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self setWithMutableDict:md key:@"activity" value:activity];
    [self setWithMutableDict:md key:@"title" value:title];
    [self setWithMutableDict:md key:@"place" value:place];
    [self setWithMutableDict:md key:@"begin_time" value:begin_time];
    [self setWithMutableDict:md key:@"person_num" value:person_num];
    [self setWithMutableDict:md key:@"time_range" value:time_range];
    [self setWithMutableDict:md key:@"average_price" value:average_price];
    [self setWithMutableDict:md key:@"description" value:description];
    [self setWithMutableDict:md key:@"is_heart" value:is_heart];
    [self setWithMutableDict:md key:@"latitude" value:latitude];
    [self setWithMutableDict:md key:@"longitude" value:longitude];
    [self setWithMutableDict:md key:@"image" value:image];
    
    [self postWithAction:kTJCreateDeskAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        [MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        //
    }];
    
}

@end












