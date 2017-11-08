//
//  AppDelegate+AppService.h
//  TongParty
//
//  Created by 方冬冬 on 2017/9/13.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (AppService)


/**
 *  进入图片浏览器
 */
//- (void)phontoBroserPush:(NSNotification *)note;

/**
 *  bug日志反馈
 */
- (void)registerBugly;

/**
 *  基本配置
 */
- (void)configurationLaunchUserOption;

/**
 *  高德地图注册
 */
- (void)registerAmap;

/**
 *  友盟注册
 */
- (void)registerUmeng;
/**
 *  Mob注册
 */

- (void)registerMob;

/**
 *  检查更新
 */
- (void)checkAppUpDataWithshowOption:(BOOL)showOption;

/**
 *  上传用户设备信息
 */
- (void)upLoadMessageAboutUser;


@end
