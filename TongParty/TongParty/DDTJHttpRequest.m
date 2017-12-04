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
    [self setWithMutableDict:md key:@"is_heart" value:is_heart];
    [self setWithMutableDict:md key:@"latitude" value:latitude];
    [self setWithMutableDict:md key:@"longitude" value:longitude];
    
//    UIImage *image1 = [
    
//    NSArray *images =
    
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
                     activity:(NSString *)activity
                         page:(NSInteger)page
                          lat:(NSString *)lat
                          lon:(NSString *)lon
                 position_lat:(NSString *)position_lat
                 position_lon:(NSString *)position_lon
                   begin_time:(NSString *)begin_time
                        block:(void(^)(NSDictionary *dict))dict
                      failure:(void(^)())failure;{
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self setWithMutableDict:md key:@"activity" value:activity];
    [self setWithMutableDict:md key:@"lat" value:lat];
    [self setWithMutableDict:md key:@"lon" value:lon];
    [self setWithMutableDict:md key:@"position_lat" value:position_lat];
    [self setWithMutableDict:md key:@"position_lon" value:position_lon];
    [self setWithMutableDict:md key:@"begin_time" value:begin_time];
    [self setWithMutableDict:md key:@"page" value:@(page)];
    
    [self postWithAction:kTJGetDeskListsAPI params:md type:kDDHttpResponseTypeJson block:^(DDResponseModel *result) {
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
        [MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
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
        [MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
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
        [MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
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
            failure();
        }
        [MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
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

/**申请加入桌子
 * @token  用户token
 * @tid 桌子id
 * @t_uid  桌子创建人id
 */
+ (void)applyJoinDeskWithToken:(NSString *)token
                           tid:(NSString *)tid
                         t_uid:(NSString *)t_uid
                         block:(void(^)(NSDictionary *dict))dict
                       failure:(void(^)())failure{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    [self setWithMutableDict:md key:@"token" value:token];
    [self setWithMutableDict:md key:@"tid" value:tid];
    [self setWithMutableDict:md key:@"t_uid" value:t_uid];
    
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
        [MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
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
        [MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
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
        [MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
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
    [self setWithMutableDict:md key:@"mid" value:mid];
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
        [MBProgressHUD showMessage:result.msg_cn toView:[UIApplication sharedApplication].keyWindow];
    } failure:^{
        //
    }];
}

@end












