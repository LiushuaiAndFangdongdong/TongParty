//
//  DDMainHelper.m
//  TongParty
//
//  Created by 方冬冬 on 2017/8/17.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDMainHelper.h"

static DDMainHelper *helper = nil;

@implementation DDMainHelper

+(instancetype)shareHelper
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[DDMainHelper alloc] init];
    });
    
    return helper;
}


#pragma mark - 神奇的load方法
+(void)load{
    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
#pragma mark ListeningAppDelegate
        [[DDMainHelper shareHelper] ListeningLifeCycleAndRegisteredAPNS];
        
    });
    
}

- (void)ListeningLifeCycleAndRegisteredAPNS
{
    //注册AppDelegate默认回调监听
    [self _setupAppDelegateNotifications];
    
    //注册apns
    [self _registerRemoteNotification];
    
    
}
// 监听系统生命周期回调，以便将需要的事件传给SDK
- (void)_setupAppDelegateNotifications
{
    [kNotificationCenter addObserver:self selector:@selector(appWillResignActiveNotif:)name:UIApplicationWillResignActiveNotification object:nil];
    [kNotificationCenter addObserver:self selector:@selector(appDidBecomeActiveNotif:)name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [kNotificationCenter addObserver:self selector:@selector(appWillEnterForegroundNotif:)name:UIApplicationWillEnterForegroundNotification object:nil];
    [kNotificationCenter addObserver:self selector:@selector(appWillEnterBackgroundNotif:)name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    [kNotificationCenter addObserver:self selector:@selector(application_OpenURL_SourceApplication_Annotation:) name:_NotificationNameForAppDelegateBackOff object:nil];
    [kNotificationCenter addObserver:self selector:@selector(userDidTakeScreenshot:)name:UIApplicationUserDidTakeScreenshotNotification object:nil];
}
//app-app or web-app互调-回调
- (void)application_OpenURL_SourceApplication_Annotation:(NSNotification *)notif
{
    
    NSString *urlStr = [notif.object absoluteString];
    if ([urlStr hasPrefix:@"basicframework://"]) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:urlStr delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
}

- (void)appWillResignActiveNotif:(NSNotification*)notif
{
    NSLog(@"程序进入非活跃状态！");
}

- (void)appDidBecomeActiveNotif:(NSNotification*)notif
{
    NSLog(@"程序进入活跃状态！");
}

- (void)appWillEnterBackgroundNotif:(NSNotification*)notif
{
    NSLog(@"程序进入后台！");
}

- (void)appWillEnterForegroundNotif:(NSNotification*)notif
{
    NSLog(@"程序进入前台！");
}

- (void)userDidTakeScreenshot:(NSNotification *)notification
{
    
    //人为截屏, 模拟用户截屏行为, 获取所截图片
//    [DDMainHelper GetlatestImageForTakeScreenshot:YES finished:^(UIImage *image) {
//        NSLog(@"我要分享");
//    }];
//    UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
//    UIView *snapView = [rootViewController.view snapshotViewAfterScreenUpdates:NO];
//    UIImage *shareImage = [self createImageWithView:snapView];
    
    
}
- (UIImage *)createImageWithView:(UIView *)view
{
    
    CGSize s = view.bounds.size;
    
    //第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，设置为[UIScreen mainScreen].scale可以保证转成的图片不失真。
    UIGraphicsBeginImageContextWithOptions(s, NO,[UIScreen mainScreen].scale);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}

#pragma mark - register apns
// 注册推送
- (void)_registerRemoteNotification
{
    UIApplication *application = [UIApplication sharedApplication];
    application.applicationIconBadgeNumber = 0;
    
    if([application respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    
#if !TARGET_IPHONE_SIMULATOR
    
    //iOS8 注册APNS
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        [application registerForRemoteNotifications];
    }else{
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:
                                                
                                                (UIUserNotificationTypeBadge |
                                                 UIUserNotificationTypeSound |
                                                 UIUserNotificationTypeAlert)
                                                                                 categories:nil];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
#else
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge |
          UIUserNotificationTypeSound |
          UIUserNotificationTypeAlert)];
        
#endif
        
    }
#endif
}






- (void)dealloc
{
    [kNotificationCenter removeObserver:self];
}


@end






