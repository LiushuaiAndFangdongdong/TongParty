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

/**上传相册*/
+ (void)uploadUserAlbumWithToken:(NSString *)token images:(NSArray *)images block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;


#pragma mark  ------------- 桌子 -- - ----

/**创建桌子
 * @token  用户token
 * @activity 活动id
 * @custom   活动名称 ---->若为自定义，为0
 * @title   桌子标题
 * @place  桌子地点
 * @begin_time  开始时间  ----目前只能创建当天的(距离当前时间24小时以内)
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
                    failure:(void(^)())failure;

/**获取桌子列表
 * @token  用户token
 * @lon  自己的经度
 * @lat  自己的纬度
 * @position_lon  筛选位置的经度
 * @position_lat  筛选位置的纬度
 * @activity 活动id
 * @begin_time  开始时间
 * @position   地址id
 * @page 页数
 */
+ (void)getDeskListsWithToken:(NSString *)token
                   activity:(NSString *)activity
                       page:(NSInteger)page
                         lat:(NSString *)lat
                         lon:(NSString *)lon
                 position_lat:(NSString *)position_lat
                 position_lon:(NSString *)position_lon
                 begin_time:(NSString *)begin_time
                      block:(void(^)(NSDictionary *dict))dict
                    failure:(void(^)())failure;


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
                      failure:(void(^)())failure;
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
                       failure:(void(^)())failure;

/**获取banner
 * @token  用户token
 */
+ (void)headerBannerWithToken:(NSString *)token
                        block:(void(^)(NSDictionary *dict))dict
                      failure:(void(^)())failure;

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
                         failure:(void(^)())failure;

/**获取桌子详情
 * @token  用户token
 * @tid 桌子id
 */
+ (void)getDeskDetailInfoWithToken:(NSString *)token
                               tid:(NSString *)tid
                             block:(void(^)(NSDictionary *dict))dict
                           failure:(void(^)())failure;

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
                           failure:(void(^)())failure;

/**申请加入桌子
 * @token  用户token
 * @tid 桌子id
 * @t_uid  桌子创建人id
 */
+ (void)applyJoinDeskWithToken:(NSString *)token
                              tid:(NSString *)tid
                              t_uid:(NSString *)t_uid
                            block:(void(^)(NSDictionary *dict))dict
                          failure:(void(^)())failure;

/**用户通过加入桌子
 * @token  用户token
 * @tid 桌子id
 * @t_uid  桌子创建人id
 */
+ (void)userAcceptJoinDeskWithToken:(NSString *)token
                           tid:(NSString *)tid
                         t_uid:(NSString *)t_uid
                         block:(void(^)(NSDictionary *dict))dict
                       failure:(void(^)())failure;
/**参与者签到桌子
 * @token  用户token
 * @tid 桌子id
 * @t_uid  桌子创建人id
 */
+ (void)othersSigninDeskWithToken:(NSString *)token
                                tid:(NSString *)tid
                              t_uid:(NSString *)t_uid
                              block:(void(^)(NSDictionary *dict))dict
                            failure:(void(^)())failure;

/**桌主发送公告
 * @token  用户token
 * @tid 桌子id
 * @nid  公告id
 */
+ (void)masterSendNoticeWithToken:(NSString *)token
                              tid:(NSString *)tid
                              nid:(NSString *)nid
                            block:(void(^)(NSDictionary *dict))dict
                          failure:(void(^)())failure;

#pragma mark  ------------- 消息 -- - ----
/** 获取用户未读消息条数
 * @token
 */
+ (void)getMessageNumWithToken:(NSString *)token
                         block:(void(^)(NSDictionary *dict))dict
                       failure:(void(^)())failure;

/** 获取用户消息列表
 * @token
 */
+ (void)getMessageListsWithToken:(NSString *)token
                         block:(void(^)(NSDictionary *dict))dict
                       failure:(void(^)())failure;

/** 获取用户具体的消息
 * @token
 * @mid 消息类型id
 * @tid 桌子id
 */
+ (void)getMessageContentWithToken:(NSString *)token
                              mid:(NSString *)mid
                               tid:(NSString *)tid
                         block:(void(^)(NSDictionary *dict))dict
                       failure:(void(^)())failure;

/** 用户删除消息
 * @token
 */
+ (void)deleteMessageWithToken:(NSString *)token
                           mid:(NSString *)mid
                         block:(void(^)(NSDictionary *dict))dict
                       failure:(void(^)())failure;

/** 获取用户充值信息
 * @token
 */
+ (void)getUserRechargeInfoWithToken:(NSString *)token
                         block:(void(^)(NSDictionary *dict))dict
                       failure:(void(^)())failure;


/** 获取打赏记录
 * @token
 */
+ (void)getRewardRecordWithToken:(NSString *)token
                               block:(void(^)(NSDictionary *dict))dict
                             failure:(void(^)())failure;

/** 获取他人打赏记录
 * @token
 * @fid
 */
+ (void)getOthersRewardRecordWithToken:(NSString *)token
                                   fid:(NSString *)fid
                           block:(void(^)(NSDictionary *dict))dict
                         failure:(void(^)())failure;

/** 获取标签列表
 * @token
 */
+ (void)getUserLabelListsWithToken:(NSString *)token
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













