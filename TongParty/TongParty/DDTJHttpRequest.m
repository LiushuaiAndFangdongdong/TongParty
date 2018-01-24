//
//  DDTJHttpRequest.m
//  TongParty
//
//  Created by 方冬冬 on 2017/10/30.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDTJHttpRequest.h"
#import "DDUserInfoModel.h"
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
            dict(result.data);
        } else {
            failure();
        }
        //[MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        failure();
    }];
}

/**上传相册*/
+ (void)uploadUserAlbumWithToken:(NSString *)token images:(NSArray *)images block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    
    [self uploadMultiImageWithAction:kTJUserUploadAlbumAPI params:md images:images success:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        [MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } fail:^{
        //
    }];
    
}

// 他人用户详情
+ (void)getOtherUserDetailInfoWithToken:(NSString *)token fid:(NSString *)fid block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure {
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self setWithMutableDict:md key:@"fid" value:fid];
    
    [self postWithAction:kTJOtherUserInfoDetailAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
    } failure:^{
        failure();
    }];
}

/**关注用户*/
+ (void)careOtherUserByfid:(NSString *)fid is_special:(NSString *)is_special block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure {
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:[DDUserSingleton shareInstance].token];
    [self setWithMutableDict:md key:@"fid" value:fid];
    [self setWithMutableDict:md key:@"is_special" value:is_special];
    
    [self postWithAction:kTJCareOtherUserAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
    } failure:^{
        failure();
    }];
}

/**取消关注用户*/
+ (void)cancelCareOtherUserByfid:(NSString *)fid block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure  {
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:[DDUserSingleton shareInstance].token];
    [self setWithMutableDict:md key:@"fid" value:fid];
    
    [self postWithAction:kTJCancelcareOtherUserAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
    } failure:^{
        failure();
    }];
}

/**获取我关注列表*/
+ (void)getCareListblock:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure {
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:[DDUserSingleton shareInstance].token];
    [self postWithAction:kTJCareListAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
    } failure:^{
        failure();
    }];
}

/**获取关注我列表*/
+ (void)getCaredListblock:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure {
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:[DDUserSingleton shareInstance].token];
    [self postWithAction:kTJCaredListAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
    } failure:^{
        failure();
    }];
}

/**获取他人关注列表*/
+ (void)getOhterCareListByFid:(NSString *)fid block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure {
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:[DDUserSingleton shareInstance].token];
    [self setWithMutableDict:md key:@"fid" value:fid];
    [self postWithAction:kTJCaredListAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
    } failure:^{
        failure();
    }];
}

/**获取他人被关注列表*/
+ (void)getOhterCaredListByFid:(NSString *)fid block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure {
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:[DDUserSingleton shareInstance].token];
    [self setWithMutableDict:md key:@"fid" value:fid];
    [self postWithAction:kTJOtherCaredListAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
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
        // [MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
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
        //[MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
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
        //[MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
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
        //[MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
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
        //[MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
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
        //[MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        //
    }];
}

/**添加地址标签*/
+ (void)addCustomAddressLabelWithName:(NSString *)name block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure {
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:TOKEN];
    [self setWithMutableDict:md key:@"name" value:name];
    [self postWithAction:@"/tongju/api/set_addr_label.php" params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        //[MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        //
    }];
}

/**
 获取桌子地图
 
 @param range 范围
 @param activity 活动ID json数组
 @param begin_time 开始时间
 @param end_time 结束时间
 @param text 搜索文本
 @param dict 成功
 @param failure 失败
 */
+ (void)getMapTablesWithRange:(NSString *)range
                     activity:(NSArray *)activity
                   begin_time:(NSString*)begin_time
                     end_time:(NSString*)end_time
                         text:(NSString *)text
                          lon:(NSString *)lon
                          lat:(NSString *)lat
                        block:(void(^)(NSDictionary *dict))dict
                      failure:(void(^)())failure {
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    NSString *jsonStr;
    if (activity) {
        NSData *data=[NSJSONSerialization dataWithJSONObject:activity options:NSJSONWritingPrettyPrinted error:nil];
        jsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    }
    if (!range) {
        range = @"3000";
    }
    [self setWithMutableDict:md key:@"token" value:TOKEN];
    [self setWithMutableDict:md key:@"range" value:range];
    [self setWithMutableDict:md key:@"begin_time" value:begin_time];
    [self setWithMutableDict:md key:@"end_time" value:end_time];
    [self setWithMutableDict:md key:@"text" value:text];
    [self setWithMutableDict:md key:@"activity" value:jsonStr];
    [self setWithMutableDict:md key:@"lon" value:lon];
    [self setWithMutableDict:md key:@"lat" value:lat];
    
    [self postWithAction:@"/tongju/api/get_table_map.php" params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        //[MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        
    }];
}

/**
 获取地址标签
 
 @param dict 成功
 @param failure 失败
 */
+ (void)getAddrLabelsblock:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure {
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:TOKEN];
    [self postWithAction:@"/tongju/api/get_addr_label.php" params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        //[MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        //
    }];
}

/**
 获取商户列表
 
 @param content 内容 （可选）
 @param price_star 人均下线 （可选）
 @param price_end 人均上线 （可选）
 @param position_lat 经度范围 （可选）
 @param position_lon 纬度范围 （可选）
 @param star_time 开始时间 （可选）
 @param end_time 结束时间 （可选）
 @param dict 成功
 @param failure 失败
 */
+ (void)getShopListsWithContent:(NSArray *)content
                     price_star:(NSString *)price_star
                      price_end:(NSString *)price_end
                   position_lat:(NSString *)position_lat
                   position_lon:(NSString *)position_lon
                      star_time:(NSString *)star_time
                       end_time:(NSString *)end_time
                          range:(NSString *)range
                          block:(void(^)(NSDictionary *dict))dict
                        failure:(void(^)())failure {
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    NSString *jsonStr;
    if (content) {
        NSData *data=[NSJSONSerialization dataWithJSONObject:content options:NSJSONWritingPrettyPrinted error:nil];
        jsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    }
    [self setWithMutableDict:md key:@"token" value:TOKEN];
    [self setWithMutableDict:md key:@"content" value:jsonStr];
    [self setWithMutableDict:md key:@"price_star" value:price_star];
    [self setWithMutableDict:md key:@"price_end" value:price_end];
    [self setWithMutableDict:md key:@"position_lat" value:position_lat];
    [self setWithMutableDict:md key:@"position_lon" value:position_lon];
    [self setWithMutableDict:md key:@"star_time" value:star_time];
    [self setWithMutableDict:md key:@"end_time" value:end_time];
    [self setWithMutableDict:md key:@"range" value:range];
    [self postWithAction:@"/tongju/api/get_shop_list.php" params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        //[MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        
    }];
}

/**
 获取商家详情
 
 @param sid 商家id
 @param dict 成功
 @param failure 失败
 */
+ (void)getShopDetailWithSid:(NSString *)sid
                       block:(void(^)(NSDictionary *dict))dict
                     failure:(void(^)())failure {
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:TOKEN];
    [self setWithMutableDict:md key:@"sid" value:sid];
    [self postWithAction:@"/tongju/api/get_shop_info.php" params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        //[MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        
    }];
}

/**
 搜索商户
 
 @param text 搜索文本
 @param dict 成功
 @param failure 失败
 */
+ (void)searchShopWithText:(NSString *)text
                     block:(void(^)(NSDictionary *dict))dict
                   failure:(void(^)())failure {
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:TOKEN];
    [self setWithMutableDict:md key:@"text" value:text];
    [self postWithAction:@"/tongju/api/search_shop.php" params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        //[MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        
    }];
}

/**创建桌子*/
+ (void)createDeskWithToken:(NSString *)token
                        sid:(NSString *)sid
                   activity:(NSString *)activity
                     custom:(NSString *)custom
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
                      image:(NSArray *)image
                      block:(void(^)(NSDictionary *dict))dict
                    failure:(void(^)())failure{
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self setWithMutableDict:md key:@"activity" value:activity];
    [self setWithMutableDict:md key:@"custom" value:custom];
    [self setWithMutableDict:md key:@"title" value:title];
    [self setWithMutableDict:md key:@"place" value:place];
    [self setWithMutableDict:md key:@"begin_time" value:begin_time];
    [self setWithMutableDict:md key:@"person_num" value:person_num];
    [self setWithMutableDict:md key:@"time_range" value:time_range];
    [self setWithMutableDict:md key:@"average_price" value:average_price];
    [self setWithMutableDict:md key:@"description" value:description];
    [self setWithMutableDict:md key:@"is_heart" value:!is_heart ? @"1" : is_heart];
    [self setWithMutableDict:md key:@"latitude" value:latitude];
    [self setWithMutableDict:md key:@"longitude" value:longitude];
    [self setWithMutableDict:md key:@"sid" value:!sid? @"0" : sid];
    
    [self uploadMultiImageWithAction:kTJCreateDeskAPI params:md images:image success:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        [MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } fail:^{
        //
    }];
    
}

/**获取桌子列表*/
+ (void)getDeskListsWithToken:(NSString *)token
                     activity:(NSArray *)activity
                         page:(NSInteger)page
                          lat:(NSString *)lat
                          lon:(NSString *)lon
                 position_lat:(NSString *)position_lat
                 position_lon:(NSString *)position_lon
                   begin_time:(NSString *)begin_time
                     end_time:(NSString *)end_time
                        range:(NSString *)range
                         text:(NSString *)text
                       order1:(NSString *)order1
                       order2:(NSString *)order2
                        block:(void(^)(NSDictionary *dict))dict
                      failure:(void(^)())failure;{
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    NSString *jsonStr;
    if (activity) {
        NSData *data=[NSJSONSerialization dataWithJSONObject:activity options:NSJSONWritingPrettyPrinted error:nil];
        jsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    }
    
    [self setWithMutableDict:md key:@"token" value:token];
    [self setWithMutableDict:md key:@"activity" value:jsonStr];
    [self setWithMutableDict:md key:@"order1" value:order1];
    [self setWithMutableDict:md key:@"order2" value:order2];
    [self setWithMutableDict:md key:@"text" value:text];
    [self setWithMutableDict:md key:@"range" value:range];
    [self setWithMutableDict:md key:@"lat" value:lat];
    [self setWithMutableDict:md key:@"lon" value:lon];
    [self setWithMutableDict:md key:@"position_lat" value:position_lat];
    [self setWithMutableDict:md key:@"position_lon" value:position_lon];
    [self setWithMutableDict:md key:@"begin_time" value:begin_time];
    [self setWithMutableDict:md key:@"end_time" value:end_time];
    [self setWithMutableDict:md key:@"page" value:@(page)];
    
    [self postWithAction:kTJGetDeskListsAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
       // [MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        //
    }];
}

/**获取要参加的桌子列表（参加）
 * @token  用户token
 * @lat 纬度
 * @lon  经度
 * @page 页数
 */
+ (void)getJoinedDeskWithToken:(NSString *)token
                           lat:(NSString *)lat
                           lon:(NSString *)lon
                         block:(void(^)(NSDictionary *dict))dict
                       failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self setWithMutableDict:md key:@"lat" value:lat];
    [self setWithMutableDict:md key:@"lon" value:lon];
    
    [self postWithAction:kTJGetJoinedDeskListsAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        //[MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        //
    }];
}

/**获取关注的桌子列表（感兴趣）
 * @token  用户token
 * @lat 纬度
 * @lon  经度
 * @page 页数
 */
+ (void)getInterestedDeskWithToken:(NSString *)token
                               lat:(NSString *)lat
                               lon:(NSString *)lon
                             block:(void(^)(NSDictionary *dict))dict
                           failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self setWithMutableDict:md key:@"lat" value:lat];
    [self setWithMutableDict:md key:@"lon" value:lon];
    
    [self postWithAction:kTJGetInterestedDeskListsAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        //[MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        //
    }];
}

/**获取banner
 * @token  用户token
 */
+ (void)headerBannerWithToken:(NSString *)token
                        block:(void(^)(NSDictionary *dict))dict
                      failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self postWithAction:kTJHeaderBannerAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        //[MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        //
    }];
}

/**获取桌子地图
 * @token  用户token
 * @lat 经度
 * @lon 纬度
 * @range   范围（米）
 */
+ (void)getDeskMapRangeWithToken:(NSString *)token
                             lat:(NSString *)lat
                             lon:(NSString *)lon
                           range:(NSString *)range
                           block:(void(^)(NSDictionary *dict))dict
                         failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self setWithMutableDict:md key:@"lat" value:lat];
    [self setWithMutableDict:md key:@"lon" value:lon];
    [self setWithMutableDict:md key:@"range" value:range];
    
    [self postWithAction:kTJGetMapRangeDesksAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
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

/**获取桌子详情
 * @token  用户token
 * @tid 桌子id
 */
+ (void)getDeskDetailInfoWithToken:(NSString *)token
                               tid:(NSString *)tid
                             block:(void(^)(NSDictionary *dict))dict
                           failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self setWithMutableDict:md key:@"tid" value:tid];
    
    [self postWithAction:kTJDetailDeskInfoAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
        [MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
            failure();
        }
//        [MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        //
    }];
}

/**桌主签到桌子
 * @token  用户token
 * @tid 桌子id
 * @lat
 * @lon
 */
+ (void)hosterSigninDeskWithToken:(NSString *)token
                              tid:(NSString *)tid
                              lat:(NSString *)lat
                              lon:(NSString *)lon
                            block:(void(^)(NSDictionary *dict))dict
                          failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self setWithMutableDict:md key:@"tid" value:tid];
    [self setWithMutableDict:md key:@"lat" value:lat];
    [self setWithMutableDict:md key:@"lon" value:lon];
    
    [self postWithAction:kTJHosterSignInAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
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
/**参与者签到需要扫的的二维码
 * @token  用户token
 * @tid 桌子id
 */
+ (void)paraintsSignQRWithToken:(NSString *)token
                            tid:(NSString *)tid
                          block:(void(^)(NSDictionary *dict))dict
                        failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self setWithMutableDict:md key:@"tid" value:tid];
    
    [self postWithAction:kTJPartintsSignQRAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
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
/**申请加入桌子
 * @token  用户token
 * @tid 桌子id
 * @t_uid  桌子创建人id
 * @prop 加入券数量
 */
+ (void)applyJoinDeskWithToken:(NSString *)token
                           tid:(NSString *)tid
                         t_uid:(NSString *)t_uid
                          prop:(NSString *)prop
                         block:(void(^)(NSDictionary *dict))dict
                       failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self setWithMutableDict:md key:@"tid" value:tid];
    [self setWithMutableDict:md key:@"t_uid" value:t_uid];
    [self setWithMutableDict:md key:@"prop" value:prop];
    [self setWithMutableDict:md key:@"m" value:@"apply"];

    [self postWithAction:kTJApplyJoinInDeskAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
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

/**用户通过加入桌子
 * @token  用户token
 * @tid 桌子id
 * @t_uid  桌子创建人id
 */
+ (void)userAcceptJoinDeskWithToken:(NSString *)token
                                tid:(NSString *)tid
                              t_uid:(NSString *)t_uid
                              block:(void(^)(NSDictionary *dict))dict
                            failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self setWithMutableDict:md key:@"tid" value:tid];
    [self setWithMutableDict:md key:@"t_uid" value:t_uid];
    
    [self postWithAction:kTJUserAcceptJoinDeskAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
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

/**参与者签到桌子
 * @token  用户token
 * @tid 桌子id
 * @t_uid  桌子创建人id
 */
+ (void)othersSigninDeskWithToken:(NSString *)token
                              tid:(NSString *)tid
                            t_uid:(NSString *)t_uid
                            block:(void(^)(NSDictionary *dict))dict
                          failure:(void(^)())failure{
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self setWithMutableDict:md key:@"tid" value:tid];
    [self setWithMutableDict:md key:@"t_uid" value:t_uid];
    
    [self postWithAction:kTJUserSignInDeskAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
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
/**参与者退出桌子
 * @token  用户token
 * @tid 桌子id
 * @t_uid  桌子创建人id
 */
+ (void)parintsQuitDeskWithToken:(NSString *)token
                             tid:(NSString *)tid
                           t_uid:(NSString *)t_uid
                           block:(void(^)(NSDictionary *dict))dict
                         failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self setWithMutableDict:md key:@"tid" value:tid];
    [self setWithMutableDict:md key:@"t_uid" value:t_uid];
    
    [self postWithAction:kTJUserSignOutDeskAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
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
/**桌主审核申请者
 * @token  用户token
 * @tid 桌子id
 * @sid  被审核用户id
 * @m   1--同意，2--拒绝
 */
+ (void)masterCheckApplicantWithToken:(NSString *)token
                                  tid:(NSString *)tid
                                  sid:(NSString *)sid
                                    m:(NSString *)m
                                block:(void(^)(NSDictionary *dict))dict
                              failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self setWithMutableDict:md key:@"tid" value:tid];
    [self setWithMutableDict:md key:@"sid" value:sid];
    [self setWithMutableDict:md key:@"m" value:m];
    [self postWithAction:kTJHosterVerifyOthersAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        //[MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        //
    }];
}
/**游客关注桌子
 * @token  用户token
 * @tid 桌子id
 */
+ (void)vistorCaredDeskWithToken:(NSString *)token
                             tid:(NSString *)tid
                           block:(void(^)(NSDictionary *dict))dict
                         failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self setWithMutableDict:md key:@"tid" value:tid];
    
    [self postWithAction:kTJUserCaredDeskAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
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
/**游客取消关注桌子
 * @token  用户token
 * @tid 桌子id
 */
+ (void)vistorCancelCaredDeskWithToken:(NSString *)token
                                   tid:(NSString *)tid
                                 block:(void(^)(NSDictionary *dict))dict
                               failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self setWithMutableDict:md key:@"tid" value:tid];
    
    [self postWithAction:kTJUserUncaredDeskAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
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
/**用户关注的桌子列表
 * @token  用户token
 * @tid 桌子id
 */
+ (void)userCaredDeskListWithToken:(NSString *)token
                             block:(void(^)(NSDictionary *dict))dict
                           failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    
    [self postWithAction:kTJUserCaredDeskListsAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
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
/**桌子感兴趣的人
 * @token  用户token
 * @tid 桌子id
 * @lon 经度
 * @lat 纬度
 */
+ (void)deskCaredUserListWithToken:(NSString *)token
                               tid:(NSString *)tid
                               lon:(NSString *)lon
                               lat:(NSString *)lat
                             block:(void(^)(NSDictionary *dict))dict
                           failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self setWithMutableDict:md key:@"tid" value:tid];
    [self setWithMutableDict:md key:@"lon" value:lon];
    [self setWithMutableDict:md key:@"lat" value:lat];
    
    [self postWithAction:kTJDeskInterestedPeopleAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        //[MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        //
    }];
}
/**桌子申请的用户
 * @token  用户token
 * @tid 桌子id
 * @lon 经度
 * @lat 纬度
 */
+ (void)deskApplyUserListWithToken:(NSString *)token
                               tid:(NSString *)tid
                               lon:(NSString *)lon
                               lat:(NSString *)lat
                             block:(void(^)(NSDictionary *dict))dict
                           failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self setWithMutableDict:md key:@"tid" value:tid];
    [self setWithMutableDict:md key:@"lon" value:lon];
    [self setWithMutableDict:md key:@"lat" value:lat];
    
    [self postWithAction:kTJDeskApplyPeopleAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        //[MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        //
    }];
}

/**
 邀请用户进桌
 
 @param tid 桌子id
 @param to_id 被邀请人id
 @param prop 邀请券数量
 @param dict 成功
 @param failure 失败
 */
+ (void)inviteUserJoinTableWithTid:(NSString *)tid
                             to_id:(NSString *)to_id
                              prop:(NSNumber *)prop
                             block:(void(^)(NSDictionary *dict))dict
                           failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:TOKEN];
    [self setWithMutableDict:md key:@"tid" value:tid];
    [self setWithMutableDict:md key:@"to_id" value:to_id];
    [self setWithMutableDict:md key:@"prop" value:prop];
    
    [self postWithAction:@"/tongju/api/user_invite_table.php" params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        [MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        
    }];
}

/** 获取收到的桌子邀请
 * @token  用户token
 */
+ (void)getDeskInviteListsWithToken:(NSString *)token
                              block:(void(^)(NSDictionary *dict))dict
                            failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    
    [self postWithAction:kTJReceiveDeskInviteListAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
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
/**邀请好友页面
 * @token  用户token
 * @tid  桌子id
 */
+ (void)inviteFriendsListsWithToken:(NSString *)token
                                tid:(NSString *)tid
                              block:(void(^)(NSDictionary *dict))dict
                            failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self setWithMutableDict:md key:@"tid" value:tid];
    
    [self postWithAction:kTJDeskInviteFriedAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            [MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
            failure();
        }
        
    } failure:^{
        //
    }];
}
/**邀请好友加入桌子
 * @token  用户token
 * @tid 桌子id
 * @fid 被邀请人id
 */
+ (void)inviteFriendJoinDeskWithToken:(NSString *)token
                                  tid:(NSString *)tid
                                  fid:(NSString *)fid
                                block:(void(^)(NSDictionary *dict))dict
                              failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self setWithMutableDict:md key:@"tid" value:tid];
    [self setWithMutableDict:md key:@"fid" value:fid];
    [self postWithAction:kTJInviteFriedsJoinDeskAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
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
/**桌主发送公告
 * @token  用户token
 * @tid 桌子id
 * @nid  公告id
 */
+ (void)masterSendNoticeWithToken:(NSString *)token
                              tid:(NSString *)tid
                              nid:(NSString *)nid
                            block:(void(^)(NSDictionary *dict))dict
                          failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self setWithMutableDict:md key:@"tid" value:tid];
    [self setWithMutableDict:md key:@"nid" value:nid];
    
    [self postWithAction:kTJHosterSendNoticeAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
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

/**获取券的信息
 * @token  用户token
 * @m 1.邀请券   2加入券
 */
+ (void)getTicketsInfoWithToken:(NSString *)token
                              m:(NSString *)m
                          block:(void(^)(NSDictionary *dict))dict
                        failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self setWithMutableDict:md key:@"m" value:m];
    
    [self postWithAction:kTJTicketsInfoAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
//        [MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        //
    }];
}

#pragma mark ---------------  消息  ------------

/** 获取用户未读消息数量
 * @token
 */
+ (void)getMessageNumWithToken:(NSString *)token
                         block:(void(^)(NSDictionary *dict))dict
                       failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self postWithAction:kTJUserMessageNumAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        //[MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        //
    }];
}

/** 获取用户消息列表
 * @token
 */
+ (void)getMessageListsWithToken:(NSString *)token
                           block:(void(^)(NSDictionary *dict))dict
                         failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self postWithAction:kTJUserMessageListsAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        //[MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        //
    }];
}

/** 获取用户具体的消息
 * @token
 * @mid 消息类型id
 * @tid 桌子id
 */
+ (void)getMessageContentWithToken:(NSString *)token
                               mid:(NSString *)mid
                               tid:(NSString *)tid
                             block:(void(^)(NSDictionary *dict))dict
                           failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self setWithMutableDict:md key:@"mid" value:mid];
    [self setWithMutableDict:md key:@"tid" value:tid];
    [self postWithAction:kTJUserMessageContentAPI params:md type:kDDHttpResponseTypeText block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        //[MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        //
    }];
}

/** 用户删除消息
 * @token
 */
+ (void)deleteMessageWithToken:(NSString *)token
                           mid:(NSString *)mid
                         block:(void(^)(NSDictionary *dict))dict
                       failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self setWithMutableDict:md key:@"msg_id" value:mid];
    [self postWithAction:kTJUserDeleteMessageAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
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

/** 获取用户充值信息
 * @token
 */
+ (void)getUserRechargeInfoWithToken:(NSString *)token
                               block:(void(^)(NSDictionary *dict))dict
                             failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self postWithAction:kTJUserRechargeMessageAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
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

/** 获取打赏记录
 * @token
 */
+ (void)getRewardRecordWithToken:(NSString *)token
                           block:(void(^)(NSDictionary *dict))dict
                         failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self postWithAction:kTJUserRewardRecordAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
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

/** 获取他人打赏记录
 * @token
 * @fid
 */
+ (void)getOthersRewardRecordWithToken:(NSString *)token
                                   fid:(NSString *)fid
                                 block:(void(^)(NSDictionary *dict))dict
                               failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self setWithMutableDict:md key:@"fid" value:fid];
    [self postWithAction:kTJUserRewardOthersRecordAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
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

/** 获取标签列表
 * @token
 */
+ (void)getUserLabelListsWithToken:(NSString *)token
                             block:(void(^)(NSDictionary *dict))dict
                           failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self postWithAction:kTJUserLabelListsAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        //[MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        //
    }];
}

/**
 获取好友列表
 @param token 参数token
 */
+ (void)getFriendsListWithToken:(NSString *)token
                          block:(void(^)(NSDictionary *dict))dict
                        failure:(void(^)())failure {
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self postWithAction:@"/tongju/api/get_friend_list.php" params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        // [MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        //
    }];
}

/**
 获取他人好友列表
 @param fid 参数fid
 */
+ (void)getFriendsListWithFid:(NSString *)fid
                        block:(void(^)(NSDictionary *dict))dict
                      failure:(void(^)())failure {
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:[DDUserSingleton shareInstance].token];
    [self setWithMutableDict:md key:@"fid" value:fid];
    [self postWithAction:@"/tongju/api/get_friend_list.php" params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        // [MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        //
    }];
}

/**
 添加好友
 
 @param token token
 @param fid 好友id
 @param dict 成功回调
 @param failure 失败回调
 */
+ (void)addFriendsToListWithToken:(NSString *)token
                              fid:(NSString *)fid
                            block:(void(^)(NSDictionary *dict))dict
                          failure:(void(^)())failure {
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self setWithMutableDict:md key:@"fid" value:fid];
    [self postWithAction:@"/tongju/api/set_user_friend.php" params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        
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

/**
 删除好友
 
 @param token token
 @param fid 好友id
 @param dict 成功回调
 @param failure 失败回调
 */
+ (void)deleteFriendWithToken:(NSString *)token
                          fid:(NSString *)fid
                        block:(void(^)(NSDictionary *dict))dict
                      failure:(void(^)())failure {
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self setWithMutableDict:md key:@"fid" value:fid];
    [self postWithAction:@"/tongju/api/delete_user_friend.php" params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        
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

/**
 邀请添加好友
 
 @param token token
 @param fid 好友id
 @param dict 成功回调
 @param failure 失败回调
 */
+ (void)inviteFriendsToListWithToken:(NSString *)token
                                 fid:(NSString *)fid
                               block:(void(^)(NSDictionary *dict))dict
                             failure:(void(^)())failure {
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self setWithMutableDict:md key:@"fid" value:fid];
    [self postWithAction:@"/tongju/api/send_invitation.php?m=friend" params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        
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

/**
 获取个人相册
 
 @param token 参数token
 @param dict 成功
 @param failure 失败
 */
+ (void)getUserAlbumWithToken:(NSString *)token
                        block:(void(^)(NSDictionary *dict))dict
                      failure:(void(^)())failure {
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self getWithAction:@"/tongju/api/get_user_photo.php" params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        //  [MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        //
    }];
}

/**
 查看他人相册
 
 @param fid id
 @param dict 成功
 @param failure 失败
 */
+ (void)getOtherUserAlbumByFid:(NSString *)fid
                         block:(void(^)(NSDictionary *dict))dict
                       failure:(void(^)())failure {
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:[DDUserSingleton shareInstance].token];
    [self setWithMutableDict:md key:@"fid" value:fid];
    
    [self postWithAction:@"/tongju/api/get_other_photo.php" params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        //  [MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        //
    }];
}

/**
 删除照片
 
 @param token 参数token
 @param photoId 照片id
 @param dict 成功
 @param failure 失败
 */
+ (void)deleteUserAlbumWithToken:(NSString *)token
                         photoId:(NSString *)photoId
                           block:(void(^)(NSDictionary *dict))dict
                         failure:(void(^)())failure {
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self setWithMutableDict:md key:@"pid" value:photoId];
    
    [self postWithAction:@"/tongju/api/delete_user_photo.php" params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        
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

/**
 选择活动
 
 @param dict 成功
 @param failure 失败
 */
+ (void)getActivitiesListblock:(void(^)(NSDictionary *dict))dict
                       failure:(void(^)())failure  {
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:TOKEN];
    
    [self postWithAction:@"/tongju/api/selective_activity.php" params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        //[MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        //
    }];
}

/**
 搜索活动
 
 @param text 搜索文本
 @param dict 成功
 @param failure 失败
 */
+ (void)searchActivityByText:(NSString *)text
                       block:(void(^)(NSDictionary *dict))dict
                     failure:(void(^)())failure {
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:TOKEN];
    [self setWithMutableDict:md key:@"text" value:text];
    [self postWithAction:@"/tongju/api/search_activity.php" params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        //[MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        
    }];
}

/**
 自定义活动
 
 @param name 活动名称
 @param dict 成功
 @param failure 失败
 */
+ (void)customActivitieWith:(NSString *)name block:(void(^)(NSDictionary *dict))dict
                    failure:(void(^)())failure {
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:TOKEN];
    [self setWithMutableDict:md key:@"name" value:name];
    [self postWithAction:@"/tongju/api/set_activity.php" params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        //[MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        //
    }];
}

/**
 获取行政区
 
 @param pid 当前地址的id
 @param dict 成功
 @param failure 失败
 */
+ (void)getAdministrativeRegionWith:(NSString *)pid
                              block:(void(^)(NSDictionary *dict))dict
                            failure:(void(^)())failure {
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:TOKEN];
    [self setWithMutableDict:md key:@"pid" value:pid];
    
    [self postWithAction:@"/tongju/api/get_addr_parent.php" params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        //[MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        //
    }];
}

/**
 获取行政区子级
 
 @param pid 当前地址的id
 @param dict 成功
 @param failure 失败
 */
+ (void)getAdministrativeChildRegionWith:(NSString *)pid
                                   block:(void(^)(NSDictionary *dict))dict
                                 failure:(void(^)())failure {
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:TOKEN];
    [self setWithMutableDict:md key:@"pid" value:pid];
    
    [self postWithAction:@"/tongju/api/get_addr_list.php" params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        //[MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        
    }];
}

/**
 获取地铁字典
 
 @param aid 当前市区id
 @param dict 成功
 @param failure 失败
 */
+ (void)getSubwayDataWithAid:(NSString *)aid
                       block:(void(^)(NSDictionary *dict))dict
                     failure:(void(^)())failure {
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:TOKEN];
    [self setWithMutableDict:md key:@"aid" value:aid];
    
    [self postWithAction:@"/tongju/api/get_subway_list.php" params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        //[MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        
    }];
}

/**
 通讯录好友
 
 @param token token
 @param phones 参数
 @param dict 成功回调
 @param failure 失败回调
 */
+ (void)getContactsListWithToken:(NSString *)token
                           phone:(NSString *)phones
                           block:(void(^)(NSDictionary *dict))dict
                         failure:(void(^)())failure {
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    NSString *headerStr = @"[122334";
    NSString *endStr = @"122233]";
    [self setWithMutableDict:md key:@"phones" value:[NSString stringWithFormat:@"%@,%@%@",headerStr,phones,endStr]];
    NSLog(@"%@",[NSString stringWithFormat:@"%@,%@%@",headerStr,phones,endStr]);
    [self postWithAction:@"/tongju/api/get_phone_friend.php" params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        // [MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        //
    }];
}

/**上传用户头像*/
+ (void)upUserHeaderImage:(UIImage *)image block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure {
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:[DDUserSingleton shareInstance].token];
    NSMutableArray *images = [NSMutableArray array];
    NSDictionary *imagedict = @{@"name":@"image",@"image":image};
    [images addObject:imagedict];
    [self uploadInfoContainImageWithAction:kTJUpUserHeaderAPI params:md images:images success:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        //[MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } fail:^{
        
    }];
}

/**用户信息完善*/
+ (void)upUserInfoWith:(id)model block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure {
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    DDUserInfoModel *uModel = (DDUserInfoModel *)model;
    md = uModel.mj_keyValues;
    [self setWithMutableDict:md key:@"token" value:[DDUserSingleton shareInstance].token];
    
    [self postWithAction:@"/tongju/api/set_user_info.php" params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
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

/**获取用户标签*/
+ (void)getUserLabelsblock:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure {
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:[DDUserSingleton shareInstance].token];
    [self postWithAction:@"/tongju/api/get_user_label.php" params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        //[MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        //
    }];
}

/**添加用户标签*/
+ (void)addUserLabels:(NSString *)label block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure {
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:[DDUserSingleton shareInstance].token];
    [self setWithMutableDict:md key:@"label" value:label];
    [self postWithAction:@"/tongju/api/set_user_label.php" params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
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

/**实名认证*/
+ (void)realnameAuthWithToken:(NSString *)token real_name:(NSString *)real_name id_number:(NSString *)id_number positive:(UIImage *)poImage negative:(UIImage *)neImage block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure {
    NSMutableArray *images = [NSMutableArray array];
    NSDictionary *fImage = @{@"name":@"positive",@"image":poImage};
    [images addObject:fImage];
    NSDictionary *nImage = @{@"name":@"negative",@"image":neImage};
    [images addObject:nImage];
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:[DDUserSingleton shareInstance].token];
    [self setWithMutableDict:md key:@"real_name" value:real_name];
    [self setWithMutableDict:md key:@"id_number" value:id_number];
    [self uploadInfoContainImageWithAction:@"/tongju/api/user_certification.php" params:md images:images success:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        [MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } fail:^{
        
    }];
}

/**获取黑名单列表*/
+ (void)getblacklistblock:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure {
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:[DDUserSingleton shareInstance].token];
    [self postWithAction:@"/tongju/api/get_blacklist.php" params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        // [MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        //
    }];
}

/**添加黑名单*/
+ (void)addBlacklistByfid:(NSString *)fid block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure {
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:[DDUserSingleton shareInstance].token];
    [self setWithMutableDict:md key:@"fid" value:fid];
    [self postWithAction:@"/tongju/api/set_blacklist.php" params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        
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

/**删除黑名单*/
+ (void)deleteBlacklistByfid:(NSString *)fid block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure {
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:[DDUserSingleton shareInstance].token];
    [self setWithMutableDict:md key:@"fid" value:fid];
    
    [self postWithAction:@"/tongju/api/delete_blacklist.php" params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        
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

/**举报用户*/
+ (void)reportUserBybid:(NSString *)bid text:(NSString *)text block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure {
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:[DDUserSingleton shareInstance].token];
    [self setWithMutableDict:md key:@"bid" value:bid];
    [self setWithMutableDict:md key:@"text" value:text];
    
    [self postWithAction:@"/tongju/api/set_report.php" params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
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

/**更改用户隐私状态*/
+ (void)editUserPrivacyName:(NSString *)name status:(NSString *)status block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure {
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:[DDUserSingleton shareInstance].token];
    [self setWithMutableDict:md key:@"name" value:name];
    [self setWithMutableDict:md key:@"status" value:status];
    
    [self postWithAction:@"/tongju/api/set_privacy.php" params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        //[MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        //
    }];
}

/**获取用户隐私状态*/
+ (void)getPrivacyblock:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure {
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:[DDUserSingleton shareInstance].token];
    [self postWithAction:@"/tongju/api/get_user_setup.php" params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        //[MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        //
    }];
}

/**修改当前密码*/
+ (void)editCurrentPwdwithNewpwd:(NSString *)newpwd block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure {
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:[DDUserSingleton shareInstance].token];
    [self setWithMutableDict:md key:@"newpwd" value:newpwd];
    [self postWithAction:@"/tongju/api/update_pwd.php" params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
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

/**设置备注名*/
+ (void)setUserRemark:(NSString *)remark fid:(NSString *)fid block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure {
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:[DDUserSingleton shareInstance].token];
    [self setWithMutableDict:md key:@"fid" value:fid];
    [self setWithMutableDict:md key:@"remark" value:remark];
    [self postWithAction:@"/tongju/api/set_friend_remark.php" params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        
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

/**手机号绑定*/
+ (void)bindMobile:(NSString *)mobile code:(NSString *)code block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure {
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:[DDUserSingleton shareInstance].token];
    [self setWithMutableDict:md key:@"code" value:code];
    [self setWithMutableDict:md key:@"mobile" value:mobile];
    [self postWithAction:@"/tongju/api/binding_phone.php" params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
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


/**获取礼物字典*/
+ (void)getGiftsDicblock:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure {
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:[DDUserSingleton shareInstance].token];
    [self postWithAction:@"/tongju/api/get_gift_list.php" params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        //[MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        //
    }];
}

/**
 获取附近内容
 
 @param lat 纬度
 @param lon 经度
 */

+ (void)getNearByDiscoverWithLat:(NSString *)lat lon:(NSString *)lon block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:[DDUserSingleton shareInstance].token];
    [self setWithMutableDict:md key:@"lat" value:lat];
    [self setWithMutableDict:md key:@"lon" value:lon];
    [self postWithAction:@"/tongju/api/get_find.php" params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        //[MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        //
    }];
}

/**
 获取附近桌子卡片
 
 @param lat 纬度
 @param lon 经度
 @param page 页码
 */
+ (void)getNearRecommendCardsWithLat:(NSString *)lat lon:(NSString *)lon page:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:[DDUserSingleton shareInstance].token];
    [self setWithMutableDict:md key:@"lat" value:lat];
    [self setWithMutableDict:md key:@"lon" value:lon];
    [self setWithMutableDict:md key:@"page" value:@(page)];
    [self postWithAction:@"/tongju/api/get_find_cord.php" params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
        if (result.status.integerValue == kDDResponseStateSuccess) {
            dict(result.data);
        } else {
            failure();
        }
        //[MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        //
    }];
}


/**
 匹配加入心跳桌
 
 @param token 用户token
 @param activity 活动id
 @param begin_time  开始时间
 @param end_time  开始时间上限
 @param average_price 人均
 @param end_price  人均上限
 @param lat 纬度
 @param lon 经度
 @param range  范围
 */
+ (void)matchJoinLoveDeskWithToken:(NSString *)token
                          activity:(NSString *)activity
                        begin_time:(NSString *)begin_time
                          end_time:(NSString *)end_time
                     average_price:(NSString *)average_price
                         end_price:(NSString *)end_price
                               lat:(NSString *)lat
                               lon:(NSString *)lon
                             range:(NSString *)range
                             block:(void(^)(NSDictionary *dict))dict
                           failure:(void(^)())failure{
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self setWithMutableDict:md key:@"activity" value:activity];
    [self setWithMutableDict:md key:@"begin_time" value:begin_time];
    [self setWithMutableDict:md key:@"end_time" value:end_time];
    [self setWithMutableDict:md key:@"average_price" value:average_price];
    [self setWithMutableDict:md key:@"end_price" value:end_price];
    [self setWithMutableDict:md key:@"range" value:range];
    [self setWithMutableDict:md key:@"lat" value:lat];
    [self setWithMutableDict:md key:@"lon" value:lon];
    [self postWithAction:@"/tongju/api/join_heart_table.php" params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
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












