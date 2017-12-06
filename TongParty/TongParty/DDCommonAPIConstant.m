
//
//  DDCommonAPIConstant.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/14.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDCommonAPIConstant.h"

@implementation DDCommonAPIConstant

/** host*/
NSString *const kTJHostAPI = @"http://103.37.160.99";
//NSString *const kTJHostAPI = @"http://192.168.1.111";

/** 获取验证码*/
NSString *const kTJLoginSendCodeAPI = @"/tongju/api/get_verify_code.php";
/** 注册*/
NSString *const kTJUserRegisterAPI = @"/tongju/api/register.php";
/** 登录*/
NSString *const kTJUserLoginAPI = @"/tongju/api/login.php";
/** 信息完善*/
NSString *const kTJUserInfoEditAPI = @"/tongju/api/set_user_info.php";
/** 用户详情*/
NSString *const kTJUserInfoDetailAPI = @"/tongju/api/get_user_info.php";
/** 修改密码*/
NSString *const kTJUserChangePasswordAPI = @"/tongju/api/update_pwd.php";
/** 忘记密码*/
NSString *const kTJUserFindPasswordAPI = @"/tongju/api/forget_pwd.php";

/** 上传相册 */
NSString *const kTJUserUploadAlbumAPI = @"/tongju/api/set_user_photo.php";



/** 添加地址*/
NSString *const kTJAddAddressAPI = @"/tongju/api/set_user_addr.php";
/** 修改地址*/
NSString *const kTJEditAddressAPI = @"/tongju/api/update_user_addr.php";
/** 删除地址*/
NSString *const kTJDeleteAddressAPI = @"/tongju/api/delete_user_addr.php";
/** 获取地址列表*/
NSString *const kTJGetAddressListAPI = @"/tongju/api/get_user_addr.php";
/** 设置默认地址*/
NSString *const kTJSetDefaultAddressAPI = @"/tongju/api/set_default_addr.php";


/** 创建桌子*/
NSString *const kTJCreateDeskAPI = @"/tongju/api/set_table_info.php";
/** 桌子列表*/
NSString *const kTJGetDeskListsAPI = @"/tongju/api/get_table_list.php";
/** 获取要参加的桌子列表（参加）*/
NSString *const kTJGetJoinedDeskListsAPI = @"/tongju/api/get_join_table.php";
/** 获取关注的桌子列表（感兴趣）*/
NSString *const kTJGetInterestedDeskListsAPI = @"/tongju/api/get_like_table.php";
/** banner*/
NSString *const kTJHeaderBannerAPI = @"/tongju/api/get_banner.php";
/** 获取桌子地图(即一定范围内的活动)*/
NSString *const kTJGetMapRangeDesksAPI = @"/tongju/api/get_table_map.php";
/** 获取桌子详情*/
NSString *const kTJDetailDeskInfoAPI = @"/tongju/api/get_table_info.php";
/** 桌主签到桌子*/
NSString *const kTJHosterSignInAPI = @"/tongju/api/table_sign.php";
/** 申请加入桌子*/
NSString *const kTJApplyJoinInDeskAPI = @"/tongju/api/user_in_table.php?m=apply";
/** 用户通过加入桌子*/
NSString *const kTJUserAcceptJoinDeskAPI = @"/tongju/api/user_in_table.php?m=join";
/** 参与者签到桌子*/
NSString *const kTJUserSignInDeskAPI = @"/tongju/api/user_in_table.php?m=sign";
/** 参与者退出桌子*/
NSString *const kTJUserSignOutDeskAPI = @"/tongju/api/user_in_table.php?m=quit";
/** 桌主审核参与者*/
NSString *const kTJHosterVerifyOthersAPI = @"/tongju/api/examine_join_table.php";
/** 用户关注桌子*/
NSString *const kTJUserCaredDeskAPI = @"/tongju/api/set_like_table.php";
/** 用户取消关注桌子*/
NSString *const kTJUserUncaredDeskAPI = @"/tongju/api/delete_like_table.php";
/** 用户关注桌子列表*/
NSString *const kTJUserCaredListsAPI = @"/tongju/api/get_like_table.php";
/** 桌子感兴趣的人*/
NSString *const kTJDeskInterestedPeopleAPI = @"/tongju/api/get_table_like.php";
/** 桌子申请的用户*/
NSString *const kTJDeskApplyPeopleAPI = @"/tongju/api/get_table_wait.php";
/** 邀请好友页面*/
NSString *const kTJDeskInviteFriedAPI = @"/tongju/api/invitation_friend.php";
/** 邀请好友加入桌子*/
NSString *const kTJInviteFriedsJoinDeskAPI = @"/tongju/api/send_invitation.php?m=join";
/** 桌主发送公告*/
NSString *const kTJHosterSendNoticeAPI = @"/tongju/api/send_notice.php";



/** 获取用户未读消息条数*/
NSString *const kTJUserMessageNumAPI = @"/tongju/api/get_msg_num.php";
/** 获取用户消息列表*/
NSString *const kTJUserMessageListsAPI = @"/tongju/api/get_msg_list.php";
/** 获取用户消息具体内容*/
NSString *const kTJUserMessageContentAPI = @"/tongju/api/receive_msg.php";
/** 用户删除消息*/
NSString *const kTJUserDeleteMessageAPI = @"/tongju/api/delete_msg.php";
/** 获取用户充值消息*/
NSString *const kTJUserRechargeMessageAPI = @"/tongju/api/get_user_deposit.php";
/** 获取打赏记录*/
NSString *const kTJUserRewardRecordAPI = @"/tongju/api/get_user_be_praised.php";
/** 获取他人打赏记录*/
NSString *const kTJUserRewardOthersRecordAPI = @"/tongju/api/get_other_be_praised.php";
/** 获取标签列表*/
NSString *const kTJUserLabelListsAPI = @"/tongju/api/get_label_list.php";




#pragma mark - HOME / 首页
/** 内涵动态列表*/
NSString *const kNHHomeServiceListAPI = @"http://lf.snssdk.com/neihan/service/tabs";;
/** 内涵当前用户关注的用户发布的动态列表*/
NSString *const kNHHomeAttentionDynamicListAPI = @"http://lf.snssdk.com/neihan/dongtai/dongtai_list/v1/";
/** 内涵某个动态评论列表*/
NSString *const kNHHomeDynamicCommentListAPI = @"http://isub.snssdk.com/neihan/comments/";
/** 内涵某个分类的动态列表*/
NSString *const kNHHomeCategoryDynamicListAPI = @"http://lf.snssdk.com/neihan/stream/category/data/v2/";
/** 内涵举报动态*/
NSString *const kNHHomeReportDynamicAPI = @"http://lf.snssdk.com/feedback/2/report";
/** 内涵点赞动态*/
NSString *const kNHHomeDynamicLikeAPI = @"http://isub.snssdk.com/2/data/item_action/";

#pragma mark - DISCOVER / 发现
/** 内涵热吧列表和轮播图*/
NSString *const kNHDiscoverHotListAPI = @"http://lf.snssdk.com/2/essay/discovery/v3/";
/** 内涵当前用户订阅的热吧列表*/
NSString *const kNHDiscoverSubscribeListAPI = @"http://i.snssdk.com/api/2/essay/zone/subscribe_categories/";
/** 内涵搜索用户列表*/
NSString *const kNHDiscoverSearchUserListAPI = @"http://lf.snssdk.com/api/2/essay/user/search/";
/** 内涵搜索热吧列表*/
NSString *const kNHDiscoverSearchHotDraftListAPI = @"http://lf.snssdk.com/api/2/essay/category/search/";
/** 内涵搜索动态列表*/
NSString *const kNHDiscoverSearchDynamicListAPI = @"http://lf.snssdk.com/api/2/essay/content/search_all/";
/** 内涵附近的用户列表*/
NSString *const kNHDiscoverNearByUserListAPI = @"http://lf.snssdk.com/neihan/user/nearby/v1/";
/** 内涵推荐的用户列表*/
NSString *const kNHDiscoverRecommendUserListAPI = @"http://lf.snssdk.com/neihan/user_relation/recommend_list/v1/";;

#pragma mark - PUBLISH / 发布
/** 内涵用户发布动态可选择的热吧列表*/
NSString *const kNHUserPublishSelectDraftListAPI = @"http://lf.snssdk.com/neihan/category/post_list";;
/** 内涵用户发布动态*/
NSString *const kNHUserPublishDraftAPI = @"http://lf.snssdk.com/2/essay/zone/ugc/post/v2/";

#pragma mark - USER / 用户
/** 内涵用户个人信息*/
NSString *const kNHUserProfileInfoAPI = @" http://isub.snssdk.com/neihan/user/profile/v2/";;
/** 内涵用户的关注用户列表*/
NSString *const kNHUserFansListAPI = @"http://lf.snssdk.com/neihan/user_relation/get_following/v1/";;
/** 内涵用户的粉丝列表*/
NSString *const kNHUserAttentionListAPI = @"http://lf.snssdk.com/neihan/user_relation/get_followed/v1/";;
/** 内涵用户的投稿列表*/
NSString *const kNHUserPublishDraftListAPI = @"http://lf.snssdk.com/2/essay/zone/user/posts/";;
/** 内涵用户的收藏列表*/
NSString *const kNHUserColDynamicListAPI = @"http://lf.snssdk.com/neihan/user/favorites/v2/";
/** 内涵用户的评论列表*/
NSString *const kNHUserDynamicCommentListAPI = @"http://isub.snssdk.com/neihan/user/comments/v2/";
/** 内涵用户的黑名单列表*/
NSString *const kNHUserBlackUserListAPI = @"http://lf.snssdk.com/neihan/user_relation/get_blocking/v1";
/** 内涵用户的积分*/
NSString *const kNHUserPointAPI;


#pragma mark - CHECK / 审核
/** 内涵审核的动态列表*/
NSString *const kNHCheckDynamicListAPI = @"http://lf.snssdk.com/2/essay/zone/ugc/recent/v1/";
@end




