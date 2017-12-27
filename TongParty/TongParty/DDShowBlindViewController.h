//
//  DDShowBlindViewController.h
//  TongParty
//
//  Created by 方冬冬 on 2017/9/29.
//  Copyright © 2017年 桐聚. All rights reserved.
//
//显示绑定的手机号码、微信、QQ、微博

#import "DDBaseViewController.h"
#import "DDUserInfoModel.h"

typedef NS_ENUM(NSUInteger, DDSocialBlindType) {
    /** 手机号码*/
    DDSocialBlindTypePhone = 0,
    /** 微信*/
    DDSocialBlindTypeWx,
    /** QQ*/
    DDSocialBlindTypeQQ,
    /** 微博 */
    DDSocialBlindTypeWeibo
};

@interface DDShowBlindViewController : DDBaseViewController
@property (nonatomic, assign) DDSocialBlindType type;
@property (nonatomic, strong)DDUserInfoModel *userModel;
@end

