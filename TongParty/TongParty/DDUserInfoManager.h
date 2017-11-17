//
//  DDUserInfoManager.h
//  TongParty
//
//  Created by 方冬冬 on 2017/9/14.
//  Copyright © 2017年 桐聚. All rights reserved.
//
//  用户信息管理类

#import <Foundation/Foundation.h>
#import "DDTJUserInfoModel.h"

@interface DDUserInfoManager : NSObject
+ (instancetype)sharedManager;

/**
 *  登录成功
 */
- (void)didLoginInWithUserInfo:(id)userInfo;

/**
 *  退出
 */
- (void)didLoginOut;

/**
 *  获取用户信息
 */
- (DDTJUserInfoModel *)currentUserInfo;

/**
 *  更新缓存中的用户信息
 */
- (void)resetUserInfoWithUserInfo:(DDTJUserInfoModel *)userInfo;

/**
 *  用来记录是否是登陆状态
 */
@property (nonatomic, assign) BOOL isLogin;

@end
