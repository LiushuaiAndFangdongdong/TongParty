//
//  DDAnimationManager.h
//  TongParty
//
//  Created by 方冬冬 on 2017/9/14.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDAnimationManager : NSObject

/**
 *  为某个视图添加
 */
+ (void)addTransformAnimationForView:(UIView *)view;

/**
 *  让某一个视图抖动
 *
 *  @param viewToShake 需要抖动的视图
 */
+ (void)shakeView:(UIView*)viewToShake;
@end
