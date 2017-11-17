//
//  AppDelegate+AppService.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/13.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "AppDelegate+AppService.h"

@implementation AppDelegate (AppService)

- (void)registerBugly {
    
}


- (void)configurationLaunchUserOption {
    
}

- (void)registerAmap {
    
    [AMapServices sharedServices].apiKey = AMapKey;
}


- (void)registerUmeng{
    
//    [[UMSocialManager defaultManager] setUmSocialAppkey:UmengAppKey];
//    [UMSocialData setAppKey:UmengAppKey];
//
//    //设置微信AppId、appSecret，分享url
//    [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];
//    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
//    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
//    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
//    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3921700954" secret:@"04b48b094faeb16683c32669824ebdad" RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
}

- (void)registerMob {
    
}

- (void)checkAppUpDataWithshowOption:(BOOL)showOption {
    
}

- (void)upLoadMessageAboutUser {
    
}


@end
