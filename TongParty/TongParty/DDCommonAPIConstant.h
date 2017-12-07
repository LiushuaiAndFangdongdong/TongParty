//
//  DDCommonAPIConstant.h
//  TongParty
//
//  Created by 方冬冬 on 2017/9/14.
//  Copyright © 2017年 桐聚. All rights reserved.
//
//  接口常量

#import <Foundation/Foundation.h>

@interface DDCommonAPIConstant : NSObject

#pragma mark - host
/** host*/
UIKIT_EXTERN NSString *const kTJHostAPI;
/** 获取验证码*/
UIKIT_EXTERN NSString *const kTJLoginSendCodeAPI;
/** 注册*/
UIKIT_EXTERN NSString *const kTJUserRegisterAPI;
/** 登录*/
UIKIT_EXTERN NSString *const kTJUserLoginAPI;
/** 信息完善*/
UIKIT_EXTERN NSString *const kTJUserInfoEditAPI;
/** 用户详情*/
UIKIT_EXTERN NSString *const kTJUserInfoDetailAPI;
/** 修改密码*/
UIKIT_EXTERN NSString *const kTJUserChangePasswordAPI;
/** 忘记密码*/
UIKIT_EXTERN NSString *const kTJUserFindPasswordAPI;

/** 上传相册 */
UIKIT_EXTERN NSString *const kTJUserUploadAlbumAPI;


/** 添加地址*/
UIKIT_EXTERN NSString *const kTJAddAddressAPI;
/** 修改地址*/
UIKIT_EXTERN NSString *const kTJEditAddressAPI;
/** 删除地址*/
UIKIT_EXTERN NSString *const kTJDeleteAddressAPI;
/** 获取地址列表*/
UIKIT_EXTERN NSString *const kTJGetAddressListAPI;
/** 设置默认地址*/
UIKIT_EXTERN NSString *const kTJSetDefaultAddressAPI;


/** 创建桌子*/
UIKIT_EXTERN NSString *const kTJCreateDeskAPI;
/** 获取桌子列表*/
UIKIT_EXTERN NSString *const kTJGetDeskListsAPI;
/** 获取要参加的桌子列表（参加）*/
UIKIT_EXTERN NSString *const kTJGetJoinedDeskListsAPI;
/** 获取关注的桌子列表（感兴趣）*/
UIKIT_EXTERN NSString *const kTJGetInterestedDeskListsAPI;
/** banner*/
UIKIT_EXTERN NSString *const kTJHeaderBannerAPI;
/** 获取桌子地图(即一定范围内的活动)*/
UIKIT_EXTERN NSString *const kTJGetMapRangeDesksAPI;
/** 获取桌子详情*/
UIKIT_EXTERN NSString *const kTJDetailDeskInfoAPI;
/** 桌主签到桌子*/
UIKIT_EXTERN NSString *const kTJHosterSignInAPI;
/** 参与者签到桌子的二维码*/
UIKIT_EXTERN NSString *const kTJPartintsSignQRAPI;
/** 申请加入桌子*/
UIKIT_EXTERN NSString *const kTJApplyJoinInDeskAPI;
/** 用户通过加入桌子*/
UIKIT_EXTERN NSString *const kTJUserAcceptJoinDeskAPI;
/** 参与者签到桌子*/
UIKIT_EXTERN NSString *const kTJUserSignInDeskAPI;
/** 参与者退出桌子*/
UIKIT_EXTERN NSString *const kTJUserSignOutDeskAPI;
/** 桌主审核参与者*/
UIKIT_EXTERN NSString *const kTJHosterVerifyOthersAPI;
/** 用户关注桌子*/
UIKIT_EXTERN NSString *const kTJUserCaredDeskAPI;
/** 用户取消关注桌子*/
UIKIT_EXTERN NSString *const kTJUserUncaredDeskAPI;
/** 用户关注桌子列表*/
UIKIT_EXTERN NSString *const kTJUserCaredDeskListsAPI;
/** 桌子感兴趣的人*/
UIKIT_EXTERN NSString *const kTJDeskInterestedPeopleAPI;
/** 桌子申请的用户*/
UIKIT_EXTERN NSString *const kTJDeskApplyPeopleAPI;
/** 收到的桌子邀请*/
UIKIT_EXTERN NSString *const kTJReceiveDeskInviteListAPI;
/** 邀请好友页面*/
UIKIT_EXTERN NSString *const kTJDeskInviteFriedAPI;
/** 邀请好友加入桌子*/
UIKIT_EXTERN NSString *const kTJInviteFriedsJoinDeskAPI;
/** 桌主发送公告*/
UIKIT_EXTERN NSString *const kTJHosterSendNoticeAPI;



/** 获取用户未读消息条数*/
UIKIT_EXTERN NSString *const kTJUserMessageNumAPI;
/** 获取用户消息列表*/
UIKIT_EXTERN NSString *const kTJUserMessageListsAPI;
/** 获取用户消息具体内容*/
UIKIT_EXTERN NSString *const kTJUserMessageContentAPI;
/** 获取删除消息*/
UIKIT_EXTERN NSString *const kTJUserDeleteMessageAPI;
/** 获取用户充值消息*/
UIKIT_EXTERN NSString *const kTJUserRechargeMessageAPI;
/** 获取打赏记录*/
UIKIT_EXTERN NSString *const kTJUserRewardRecordAPI;
/** 获取他人打赏记录*/
UIKIT_EXTERN NSString *const kTJUserRewardOthersRecordAPI;
/** 获取标签列表*/
UIKIT_EXTERN NSString *const kTJUserLabelListsAPI;





#pragma mark - HOME / 首页
/** 内涵动态列表*/
UIKIT_EXTERN NSString *const kNHHomeServiceListAPI;
/** 内涵当前用户关注的用户发布的动态列表*/
UIKIT_EXTERN NSString *const kNHHomeAttentionDynamicListAPI;
/** 内涵某个动态评论列表*/
UIKIT_EXTERN NSString *const kNHHomeDynamicCommentListAPI;
/** 内涵某个分类的动态列表*/
UIKIT_EXTERN NSString *const kNHHomeCategoryDynamicListAPI;
/** 内涵举报动态*/
UIKIT_EXTERN NSString *const kNHHomeReportDynamicAPI;
/** 内涵点赞动态*/
UIKIT_EXTERN NSString *const kNHHomeDynamicLikeAPI;

#pragma mark - DISCOVER / 发现
/** 内涵热吧列表和轮播图*/
UIKIT_EXTERN NSString *const kNHDiscoverHotListAPI;
/** 内涵当前用户订阅的热吧列表*/
UIKIT_EXTERN NSString *const kNHDiscoverSubscribeListAPI;
/** 内涵搜索用户列表*/
UIKIT_EXTERN NSString *const kNHDiscoverSearchUserListAPI;
/** 内涵搜索热吧列表*/
UIKIT_EXTERN NSString *const kNHDiscoverSearchHotDraftListAPI;
/** 内涵搜索动态列表*/
UIKIT_EXTERN NSString *const kNHDiscoverSearchDynamicListAPI;
/** 内涵附近的用户列表*/
UIKIT_EXTERN NSString *const kNHDiscoverNearByUserListAPI;
/** 内涵推荐的用户列表*/
UIKIT_EXTERN NSString *const kNHDiscoverRecommendUserListAPI;

#pragma mark - PUBLISH / 发布
/** 内涵用户发布动态可选择的热吧列表*/
UIKIT_EXTERN NSString *const kNHUserPublishSelectDraftListAPI;
/** 内涵用户发布动态*/
UIKIT_EXTERN NSString *const kNHUserPublishDraftAPI;

#pragma mark - USER / 用户
/** 内涵用户个人信息*/
UIKIT_EXTERN NSString *const kNHUserProfileInfoAPI;
/** 内涵用户的关注用户列表*/
UIKIT_EXTERN NSString *const kNHUserFansListAPI;
/** 内涵用户的粉丝列表*/
UIKIT_EXTERN NSString *const kNHUserAttentionListAPI;
/** 内涵用户的投稿列表*/
UIKIT_EXTERN NSString *const kNHUserPublishDraftListAPI;
/** 内涵用户的收藏列表*/
UIKIT_EXTERN NSString *const kNHUserColDynamicListAPI;
/** 内涵用户的评论列表*/
UIKIT_EXTERN NSString *const kNHUserDynamicCommentListAPI;
/** 内涵用户的黑名单列表*/
UIKIT_EXTERN NSString *const kNHUserBlackUserListAPI;
/** 内涵用户的积分*/
UIKIT_EXTERN NSString *const kNHUserPointAPI;


#pragma mark - CHECK / 审核
/** 内涵审核的动态列表*/
UIKIT_EXTERN NSString *const kNHCheckDynamicListAPI;

@end
