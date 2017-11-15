//
//  DDCommonConstant.h
//  TongParty
//
//  Created by 方冬冬 on 2017/9/14.
//  Copyright © 2017年 桐聚. All rights reserved.
//
// 普通公共常量

#import <Foundation/Foundation.h>

@interface DDCommonConstant : NSObject

/** 当前纬度*/
UIKIT_EXTERN NSString *const kNHUserCurrentLatitude;
/** 当前经度*/
UIKIT_EXTERN NSString *const kNHUserCurrentLongitude;
/** 是否登陆*/
UIKIT_EXTERN NSString *const kNHHasLoginFlag;
/** 网络请求成功*/
UIKIT_EXTERN NSString *const kNHRequestSuccessNotification;
@end
