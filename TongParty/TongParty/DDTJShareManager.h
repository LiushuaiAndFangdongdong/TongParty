//
//  DDTJShareManager.h
//  TongParty
//
//  Created by 方冬冬 on 2017/9/14.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMSocialCore/UMSocialCore.h>

/**
 *  三方类型
 */
typedef NS_ENUM(NSUInteger, DDTJShareType) {
    /** QQ*/
    DDTJShareTypeQQ = 1,
    /** QQ空间*/
    DDTJShareTypeQZone,
    /** 微信会话*/
    DDTJShareTypeWechatSession,
    /** 微信朋友圈*/
    DDTJShareTypeWechat,
    /** 微博*/
    DDTJShareTypeWeibo,
};

@interface DDTJShareManager : NSObject
+ (instancetype)sharedManager;

- (void)shareWithSharedType:(DDTJShareType)shareType
                      image:(UIImage *)image
                        url:(NSString *)url
                    content:(NSString *)content
                 controller:(UIViewController *)controller;

- (void)registerAllPlatForms;

-(void)manageShareWithSharedType:(UMSocialPlatformType)platformType title:(NSString *)title desc:(NSString *)desc image:(NSString *)image shareUrl:(NSString *)shareUrl controller:(UIViewController *)controller;
//只分享图片
-(void)shareImageWithSharedType:(UMSocialPlatformType)platformType image:(UIImage *)image controller:(UIViewController *)controller;
@end






