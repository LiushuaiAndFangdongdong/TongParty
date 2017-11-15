//
//  DDTJShareManager.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/14.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDTJShareManager.h"

static DDTJShareManager *_singleton = nil;


@implementation DDTJShareManager

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleton = [[self alloc] init];
    });
    return _singleton;
}

- (void)registerAllPlatForms {
    
    //打开日志
    [[UMSocialManager defaultManager] openLog:YES];
    //打开图片水印
    [UMSocialGlobal shareInstance].isClearCacheWhenGetUserInfo = NO;
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:UmengAppKey];
    
    //设置微信聊天
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WetChatAppId appSecret:WetChatAppSecret redirectURL:@"https://www.baidu.com/home/news/data/newspage?nid=16194802801658600217&n_type=0&p_from=1&dtype=-1"];
    //微信朋友圈
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatTimeLine appKey:WetChatAppId appSecret:WetChatAppSecret redirectURL:@"https://www.baidu.com/home/news/data/newspage?nid=16194802801658600217&n_type=0&p_from=1&dtype=-1"];
    //QQ
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:ShareQQAppID appSecret:ShareQQAppKey redirectURL:@"https://www.baidu.com/home/news/data/newspage?nid=16194802801658600217&n_type=0&p_from=1&dtype=-1"];
    //新浪微博
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:SinaWeiboAppKey appSecret:SinaWeiboAppSecret redirectURL:kSinaRedirectURI];

}

-(void)manageShareWithSharedType:(UMSocialPlatformType)platformType
                           title:(NSString *)title
                            desc:(NSString *)desc
                           image:(NSString *)image
                        shareUrl:(NSString *)shareUrl
                        controller:(UIViewController *)controller{
    
    NSString *message;
    switch (platformType) {
            case UMSocialPlatformType_WechatSession:
        {
            //微信好友
            message = @"您还没有安装,请先安装微信";
        }
            break;

            case UMSocialPlatformType_WechatTimeLine:
        {
            //朋友圈
            message = @"您还没有安装,请先安装微信";
        }
            break;
            
            case UMSocialPlatformType_QQ:
        {
            //QQ
            message = @"您还没有安装,请先安装QQ";
        }
            break;
            
            case UMSocialPlatformType_Sina:
        {
            //新浪微博
            message = @"您还没有安装,请先安装新浪微博";
        }
            break;
        default:
            break;
    }
    
    if(![[UMSocialManager defaultManager] isInstall:platformType]){
        [MBProgressHUD showMessage:message toView:controller.view];
        return ;
    }
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:desc thumImage:[UIImage imageNamed:image]];
    //设置网页地址
    shareObject.webpageUrl = shareUrl;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
            [MBProgressHUD showMessage:@"分享失败" toView:controller.view];
        }else{
            NSLog(@"response data is %@",data);
            [MBProgressHUD showMessage:@"分享成功" toView:controller.view];
        }
    }];
}

//只分享图片
-(void)shareImageWithSharedType:(UMSocialPlatformType)platformType image:(UIImage *)image controller:(UIViewController *)controller{
    NSString *message;
    switch (platformType) {
        case UMSocialPlatformType_WechatSession:
        {
            //微信好友
            message = @"您还没有安装,请先安装微信";
        }
            break;
            
        case UMSocialPlatformType_WechatTimeLine:
        {
            //朋友圈
            message = @"您还没有安装,请先安装微信";
        }
            break;
            
        case UMSocialPlatformType_QQ:
        {
            //QQ
            message = @"您还没有安装,请先安装QQ";
        }
            break;
            
        case UMSocialPlatformType_Sina:
        {
            //新浪微博
            message = @"您还没有安装,请先安装新浪微博";
        }
            break;
        default:
            break;
    }
    
    if(![[UMSocialManager defaultManager] isInstall:platformType]){
        [MBProgressHUD showMessage:message toView:controller.view];
        return ;
    }
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        //创建图片内容对象
        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
        //如果有缩略图，则设置缩略图
        shareObject.thumbImage = [UIImage imageNamed:@"icon"];
        [shareObject setShareImage:image];
        
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
            if (error) {
                NSLog(@"************Share fail with error %@*********",error);
                [MBProgressHUD showMessage:@"分享失败" toView:controller.view];
            }else{
                [MBProgressHUD showMessage:@"分享成功" toView:controller.view];
            }
        }];
}

- (void)shareSucceed {
    
}

@end

