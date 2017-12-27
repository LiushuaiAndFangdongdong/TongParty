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
/** 他人用户详情*/
UIKIT_EXTERN NSString *const kTJOtherUserInfoDetailAPI;
/** 关注用户*/
UIKIT_EXTERN NSString *const kTJCareOtherUserAPI;
/** 取消关注用户*/
UIKIT_EXTERN NSString *const kTJCancelcareOtherUserAPI;
/**获取我关注列表*/
UIKIT_EXTERN NSString *const kTJCareListAPI;
/**获取关注我列表*/
UIKIT_EXTERN NSString *const kTJCaredListAPI;
/**获取他人被关注列表*/
UIKIT_EXTERN NSString *const kTJOtherCaredListAPI;
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
/**上传用户头像*/
UIKIT_EXTERN NSString *const kTJUpUserHeaderAPI;


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
/** 获取券的信息*/
UIKIT_EXTERN NSString *const kTJTicketsInfoAPI;


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

/** 系统消息*/
UIKIT_EXTERN NSString *const MSG_TYPE_SYS;
/** 打赏通知*/
UIKIT_EXTERN NSString *const MSG_TYPE_REWORD;
/** 我的关注*/
UIKIT_EXTERN NSString *const MSG_TYPE_ATTENTION;
/** 申请回复*/
UIKIT_EXTERN NSString *const MSG_TYPE_APPLY;
/** 邀请我加入的*/
UIKIT_EXTERN NSString *const MSG_TYPE_INVITE;
/** 桌主消息*/
UIKIT_EXTERN NSString *const MSG_TYPE_HOST;
/** 参加桌子消息*/
UIKIT_EXTERN NSString *const MSG_TYPE_JOIN;


@end





