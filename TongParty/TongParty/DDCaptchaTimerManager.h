//
//  DDCaptchaTimerManager.h
//  TongParty
//
//  Created by 方冬冬 on 2017/12/5.
//  Copyright © 2017年 桐聚. All rights reserved.
//
//单例计时器（页面切换仍然计时）

#import <Foundation/Foundation.h>

@interface DDCaptchaTimerManager : NSObject

@property (nonatomic,assign)__block int timeout;
+ (id)sharedTimerManager;
- (void)countDown;
@end
