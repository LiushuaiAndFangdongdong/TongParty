
//
//  DDUserInfoManager.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/14.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDUserInfoManager.h"
#import "DDFileCacheManager.h"

static DDUserInfoManager *_singleton = nil;

@implementation DDUserInfoManager
+ (instancetype)sharedManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleton = [[DDUserInfoManager alloc] init];
    });
    return _singleton;
}

// 当前用户信息
- (DDTJUserInfoModel *)currentUserInfo {
    
    id obj = [DDFileCacheManager getObjectByFileName:NSStringFromClass([DDTJUserInfoModel class])];
    if (obj != nil) {
        return  obj;
    }
    return nil;
}

// 重置用户信息
- (void)resetUserInfoWithUserInfo:(DDTJUserInfoModel *)userInfo {
    [userInfo archive];
}

// 登陆
- (void)didLoginInWithUserInfo:(id)userInfo {
    
    DDTJUserInfoModel *userinfo = [DDTJUserInfoModel modelWithDictionary:userInfo];
    [userinfo archive];
    
    [DDFileCacheManager saveUserData:@YES forKey:kNHHasLoginFlag];
}

// 退出登陆
- (void)didLoginOut {
    [DDFileCacheManager removeObjectByFileName:NSStringFromClass([DDTJUserInfoModel class])];
    
    [DDFileCacheManager saveUserData:@NO forKey:kNHHasLoginFlag];
}

// 判断是否是登陆状态
- (BOOL)isLogin {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kNHHasLoginFlag];
}

@end
