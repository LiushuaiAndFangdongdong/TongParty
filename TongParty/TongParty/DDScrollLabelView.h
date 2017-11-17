//
//  DDScrollLabelView.h
//  TongParty
//
//  Created by 方冬冬 on 2017/10/11.
//  Copyright © 2017年 桐聚. All rights reserved.
//
//滚动跑马灯

#import <UIKit/UIKit.h>

@class DDScrollLabelView;

typedef NS_ENUM(NSInteger, ScrollDirectionType) {
    FromLeftType        = 0,
    FromRightType       = 1,
    
};

@protocol DDScrollLabelViewDelegate <NSObject>

@optional
- (void)drawMarqueeView:(DDScrollLabelView *)drawMarqueeView animationDidStopFinished:(BOOL)finished;
@end


@interface DDScrollLabelView : UIView
// 协议
@property (nonatomic, weak) id <DDScrollLabelViewDelegate> delegate;

// 速度
@property (nonatomic) CGFloat                               speed;

// 方向
@property (nonatomic) ScrollDirectionType                   marqueeDirection;

// 容器
- (void)addContentView:(UIView *)view;

// 开始
- (void)startAnimation;

// 停止
- (void)stopAnimation;

// 暂停
- (void)pauseAnimation;

// 恢复
- (void)resumeAnimation;
@end
