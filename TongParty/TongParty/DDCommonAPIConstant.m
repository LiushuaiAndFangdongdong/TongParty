
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

#pragma mark - 登录注册部分
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
/** 用户详情*/
NSString *const kTJOtherUserInfoDetailAPI = @"/tongju/api/get_otheruser_info.php";
/** 关注用户*/
NSString *const kTJCareOtherUserAPI = @"/tongju/api/set_like_friend.php";
/** 取消关注用户*/
NSString *const kTJCancelcareOtherUserAPI = @"/tongju/api/delete_like_friend.php";
/**获取我关注列表*/
NSString *const kTJCareListAPI = @"/tongju/api/get_like_friend.php";
/**获取关注我列表*/
NSString *const kTJCaredListAPI = @"/tongju/api/get_belike.php";
/**获取他人关注列表*/
//NSString *const kTJOtherCareListAPI = @"/tongju/api/get_belike.php";
/**获取他人被关注列表*/
NSString *const kTJOtherCaredListAPI = @"/tongju/api/get_other_belike.php";
/**上传用户头像*/
NSString *const kTJUpUserHeaderAPI = @"/tongju/api/set_user_header.php";
#pragma mark - 地址部分
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


#pragma mark - 桌子部分
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
/** 参与者签到桌子的二维码*/
NSString *const kTJPartintsSignQRAPI = @"/tongju/api/get_sign_code.php";
/** 申请加入桌子*/
NSString *const kTJApplyJoinInDeskAPI = @"/tongju/api/user_in_table.php";
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
NSString *const kTJUserCaredDeskListsAPI = @"/tongju/api/get_like_table.php";
/** 桌子感兴趣的人*/
NSString *const kTJDeskInterestedPeopleAPI = @"/tongju/api/get_table_like.php";
/** 桌子申请的用户*/
NSString *const kTJDeskApplyPeopleAPI = @"/tongju/api/get_table_wait.php";
/** 收到的桌子邀请*/
NSString *const kTJReceiveDeskInviteListAPI = @"/tongju/api/get_table_invite.php";
/** 邀请好友页面*/
NSString *const kTJDeskInviteFriedAPI = @"/tongju/api/invitation_friend.php";
/** 邀请好友加入桌子*/
NSString *const kTJInviteFriedsJoinDeskAPI = @"/tongju/api/send_invitation.php";
/** 桌主发送公告*/
NSString *const kTJHosterSendNoticeAPI = @"/tongju/api/send_notice.php";
/** 获取券的信息*/
NSString *const kTJTicketsInfoAPI = @"/tongju/api/get_prop.php";



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
/** 获取好友列表*/
NSString *const kTJUserFriendListsAPI = @"/tongju/api/get_friend_list.php";




/** 系统消息*/
NSString *const MSG_TYPE_SYS = @"1";
/** 打赏通知*/
NSString *const MSG_TYPE_REWORD = @"2";
/** 我的关注*/
NSString *const MSG_TYPE_ATTENTION = @"3";
/** 申请回复*/
NSString *const MSG_TYPE_APPLY = @"4";
/** 邀请我加入的*/
NSString *const MSG_TYPE_INVITE = @"5";
/** 桌主消息*/
NSString *const MSG_TYPE_HOST = @"7";
/** 参加桌子消息*/
NSString *const MSG_TYPE_JOIN = @"8";


@end












