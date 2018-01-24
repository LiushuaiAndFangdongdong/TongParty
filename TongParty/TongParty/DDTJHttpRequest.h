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


/**他人用户详情页*/
+ (void)getOtherUserDetailInfoWithToken:(NSString *)token fid:(NSString *)fid block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

/**关注用户*/
+ (void)careOtherUserByfid:(NSString *)fid is_special:(NSString *)is_special block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

/**取消关注用户*/
+ (void)cancelCareOtherUserByfid:(NSString *)fid block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

/**获取我关注列表*/
+ (void)getCareListblock:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

/**获取关注我列表*/
+ (void)getCaredListblock:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

/**获取他人关注列表*/
+ (void)getOhterCareListByFid:(NSString *)fid block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

/**获取他人被关注列表*/
+ (void)getOhterCaredListByFid:(NSString *)fid block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

/**上传用户头像*/
+ (void)upUserHeaderImage:(UIImage *)image block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

/**用户信息完善*/
+ (void)upUserInfoWith:(id)model block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

/**获取用户标签*/
+ (void)getUserLabelsblock:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

/**添加用户标签*/
+ (void)addUserLabels:(NSString *)label block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

/**删除用户标签*/
+ (void)deleteUserLabels:(NSString *)label block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

/**实名认证*/
+ (void)realnameAuthWithToken:(NSString *)token real_name:(NSString *)real_name id_number:(NSString *)id_number positive:(UIImage *)poImage negative:(UIImage *)neImage block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

/**获取黑名单列表*/
+ (void)getblacklistblock:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

/**添加黑名单*/
+ (void)addBlacklistByfid:(NSString *)fid block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

/**删除黑名单*/
+ (void)deleteBlacklistByfid:(NSString *)fid block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

/**举报用户*/
+ (void)reportUserBybid:(NSString *)bid text:(NSString *)text block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

/**更改用户隐私状态*/
+ (void)editUserPrivacyName:(NSString *)name status:(NSString *)status block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

/**获取用户隐私状态*/
+ (void)getPrivacyblock:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

/**修改当前密码*/
+ (void)editCurrentPwdwithNewpwd:(NSString *)newpwd block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

/**设置备注名*/
+ (void)setUserRemark:(NSString *)remark fid:(NSString *)fid block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

/**手机号绑定*/
+ (void)bindMobile:(NSString *)mobile code:(NSString *)code block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

/**获取礼物字典*/
+ (void)getGiftsDicblock:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;
#pragma mark  ------------- 桌子 -- - ----


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
                      failure:(void(^)())failure;
/**
 获取地址标签
 
 @param dict 成功
 @param failure 失败
 */
+ (void)getAddrLabelsblock:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

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
                        failure:(void(^)())failure;


/**
 获取商家详情

 @param sid 商家id
 @param dict 成功
 @param failure 失败
 */
+ (void)getShopDetailWithSid:(NSString *)sid
                       block:(void(^)(NSDictionary *dict))dict
                     failure:(void(^)())failure;

/**
 搜索商户

 @param text 搜索文本
 @param dict 成功
 @param failure 失败
 */
+ (void)searchShopWithText:(NSString *)text
                       block:(void(^)(NSDictionary *dict))dict
                     failure:(void(^)())failure;

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

/**参与者签到需要扫的的二维码
 * @token  用户token
 * @tid 桌子id
 */
+ (void)paraintsSignQRWithToken:(NSString *)token
                            tid:(NSString *)tid
                          block:(void(^)(NSDictionary *dict))dict
                        failure:(void(^)())failure;

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

/**参与者退出桌子
 * @token  用户token
 * @tid 桌子id
 * @t_uid  桌子创建人id
 */
+ (void)parintsQuitDeskWithToken:(NSString *)token
                              tid:(NSString *)tid
                            t_uid:(NSString *)t_uid
                            block:(void(^)(NSDictionary *dict))dict
                          failure:(void(^)())failure;

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
                         failure:(void(^)())failure;

/**游客关注桌子
 * @token  用户token
 * @tid 桌子id
 */
+ (void)vistorCaredDeskWithToken:(NSString *)token
                                  tid:(NSString *)tid
                                block:(void(^)(NSDictionary *dict))dict
                         failure:(void(^)())failure;

/**游客取消关注桌子
 * @token  用户token
 * @tid 桌子id
 */
+ (void)vistorCancelCaredDeskWithToken:(NSString *)token
                             tid:(NSString *)tid
                           block:(void(^)(NSDictionary *dict))dict
                         failure:(void(^)())failure;

/**用户关注的桌子列表
 * @token  用户token
 * @tid 桌子id
 */
+ (void)userCaredDeskListWithToken:(NSString *)token
                                 block:(void(^)(NSDictionary *dict))dict
                               failure:(void(^)())failure;

/**桌子感兴趣的用户
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
                           failure:(void(^)())failure;

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
                           failure:(void(^)())failure;

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
                           failure:(void(^)())failure;

/** 获取收到的桌子邀请
 * @token  用户token
 */
+ (void)getDeskInviteListsWithToken:(NSString *)token
                             block:(void(^)(NSDictionary *dict))dict
                           failure:(void(^)())failure;

/**邀请好友页面
 * @token  用户token
 */
+ (void)inviteFriendsListsWithToken:(NSString *)token
                                tid:(NSString *)tid
                             block:(void(^)(NSDictionary *dict))dict
                           failure:(void(^)())failure;

/**邀请好友加入桌子
 * @token  用户token
 * @tid 桌子id
 * @fid 被邀请人id
 */
+ (void)inviteFriendJoinDeskWithToken:(NSString *)token
                               tid:(NSString *)tid
                               fid:(NSString *)fid
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

/**获取券的信息
 * @token  用户token
 * @m 1.邀请券   2加入券
 */
+ (void)getTicketsInfoWithToken:(NSString *)token
                              m:(NSString *)m
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



/**
 获取好友列表
 @param token 参数token
 */
+ (void)getFriendsListWithToken:(NSString *)token
                          block:(void(^)(NSDictionary *dict))dict
                        failure:(void(^)())failure;

/**
 获取他人好友列表
 @param fid 参数fid
 */
+ (void)getFriendsListWithFid:(NSString *)fid
                        block:(void(^)(NSDictionary *dict))dict
                      failure:(void(^)())failure;


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
                          failure:(void(^)())failure;

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
                      failure:(void(^)())failure;

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
                             failure:(void(^)())failure;

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
                         failure:(void(^)())failure;

/**
 获取个人相册
 
 @param token 参数token
 @param dict 成功
 @param failure 失败
 */
+ (void)getUserAlbumWithToken:(NSString *)token
                        block:(void(^)(NSDictionary *dict))dict
                      failure:(void(^)())failure;

/**
 查看他人相册
 
 @param fid id
 @param dict 成功
 @param failure 失败
 */
+ (void)getOtherUserAlbumByFid:(NSString *)fid
                         block:(void(^)(NSDictionary *dict))dict
                       failure:(void(^)())failure;


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
                         failure:(void(^)())failure;

/**
 选择活动
 
 @param dict 成功
 @param failure 失败
 */
+ (void)getActivitiesListblock:(void(^)(NSDictionary *dict))dict
                       failure:(void(^)())failure;

/**
 搜索活动

 @param text 搜索文本
 @param dict 成功
 @param failure 失败
 */
+ (void)searchActivityByText:(NSString *)text
                       block:(void(^)(NSDictionary *dict))dict
                       failure:(void(^)())failure;

/**
 自定义活动

 @param name 活动名称
 @param dict 成功
 @param failure 失败
 */
+ (void)customActivitieWith:(NSString *)name
                      block:(void(^)(NSDictionary *dict))dict
                       failure:(void(^)())failure;


/**
 获取行政区

 @param pid 当前地址的id
 @param dict 成功
 @param failure 失败
 */
+ (void)getAdministrativeRegionWith:(NSString *)pid
                              block:(void(^)(NSDictionary *dict))dict
                            failure:(void(^)())failure;

/**
 获取行政区子级
 
 @param pid 当前地址的id
 @param dict 成功
 @param failure 失败
 */
+ (void)getAdministrativeChildRegionWith:(NSString *)pid
                              block:(void(^)(NSDictionary *dict))dict
                            failure:(void(^)())failure;


/**
 获取地铁字典

 @param aid 当前市区id
 @param dict 成功
 @param failure 失败
 */
+ (void)getSubwayDataWithAid:(NSString *)aid
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


/**添加地址标签*/
+ (void)addCustomAddressLabelWithName:(NSString *)name block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;


/**
 获取附近内容
 
 @param lat 纬度
 @param lon 经度
 */

+ (void)getNearByDiscoverWithLat:(NSString *)lat lon:(NSString *)lon block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

/**
 获取附近桌子卡片
 
 @param lat 纬度
 @param lon 经度
 @param page 页码
 */
+ (void)getNearRecommendCardsWithLat:(NSString *)lat lon:(NSString *)lon page:(NSInteger)page block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

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
+ (void)matchJoinLoveDeskWithToken:(NSString *)token activity:(NSString *)activity begin_time:(NSString *)begin_time end_time:(NSString *)end_time average_price:(NSString *)average_price end_price:(NSString *)end_price lat:(NSString *)lat lon:(NSString *)lon range:(NSString *)range block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;
@end













