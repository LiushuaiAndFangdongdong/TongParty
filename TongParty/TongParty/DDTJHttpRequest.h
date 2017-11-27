//
//  DDTJHttpRequest.h
//  TongParty
//
//  Created by 方冬冬 on 2017/10/30.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDResponseBaseHttp.h"

@interface DDTJHttpRequest : DDResponseBaseHttp

#pragma mark  ------------- 用户个人信息 -- - ----
/**获取短信验证码*/
+ (void)msgCodeWithUsername:(NSString *)username block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;
/**注册*/
+ (void)registerWithMobile:(NSString *)mobile passwd:(NSString *)passwd code:(NSString *)code block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;
/**登录*/
+ (void)loginWithMobile:(NSString *)mobile password:(NSString *)password block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;
/**用户详情页*/
+ (void)getUserDetailInfoWithToken:(NSString *)token block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

#pragma mark  ------------- 桌子 -- - ----

/**创建桌子
 * @token  用户token
 * @activity 桌子分类id
 * @title   桌子标题
 * @place  桌子地点
 * @begin_time  开始时间
 * @person_num   限制人数
 * @time_range   限制时长
 * @average_price  人均消费
 * @description    描述
 * @is_heart     是否心跳桌  1为心跳、0为不心跳
 * @latitude    经度
 * @longitude   纬度
 * @image     桌子图片
 */
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
                    failure:(void(^)())failure;

#pragma mark  ------------- 地址 -- - ----

/**添加地址*/
+ (void)addCustomAddressWithToken:(NSString *)token latitude:(NSString *)latitude longitude:(NSString *)longitude label:(NSString *)label addr:(NSString *)addr detail:(NSString *)detail block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

/**用户自定义地址列表*/
+ (void)getCustomAddressListWithToken:(NSString *)token block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

/**修改地址*/
+ (void)editCustomAddressWithToken:(NSString *)token aid:(NSString *)aid latitude:(NSString *)latitude longitude:(NSString *)longitude label:(NSString *)label addr:(NSString *)addr detail:(NSString *)detail block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

/**删除地址*/
+ (void)deleteCustomAddressWithToken:(NSString *)token aid:(NSString *)aid  block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

/**设置默认地址*/
+ (void)setDefaultAddressWithToken:(NSString *)token aid:(NSString *)aid  block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;



@end













