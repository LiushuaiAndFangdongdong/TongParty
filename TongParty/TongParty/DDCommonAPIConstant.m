
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




