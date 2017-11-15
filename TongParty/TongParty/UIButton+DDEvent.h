//
//  UIButton+DDEvent.h
//  TongParty
//
//  Created by 方冬冬 on 2017/9/22.
//  Copyright © 2017年 桐聚. All rights reserved.
//
//设置联系点击按钮的时间间隔/控制次数

#import <UIKit/UIKit.h>

@interface UIButton (DDEvent)
/** 按钮点击时间间隔 */
@property (nonatomic, assign) NSTimeInterval dd_timeInterval;
@end
