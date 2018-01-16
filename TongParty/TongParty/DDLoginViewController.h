//
//  DDLoginViewController.h
//  TongParty
//
//  Created by 方冬冬 on 2017/10/28.
//  Copyright © 2017年 桐聚. All rights reserved.
//
//登录

#import "DDBaseViewController.h"

@interface DDLoginViewController : DDBaseViewController
@property (nonatomic, copy) void(^islogSuccess)(BOOL isSuccess);
@property (nonatomic, assign) BOOL isModen;
@property (nonatomic, assign) BOOL isPopToRoot;
@end
