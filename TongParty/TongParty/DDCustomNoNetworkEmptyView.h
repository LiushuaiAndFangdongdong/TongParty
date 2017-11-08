//
//  DDCustomNoNetworkEmptyView.h
//  TongParty
//
//  Created by 方冬冬 on 2017/9/14.
//  Copyright © 2017年 桐聚. All rights reserved.
//
//  没有网络时候显示的视图

#import <UIKit/UIKit.h>

@interface DDCustomNoNetworkEmptyView : UIView
/** 没有网络，重试*/
@property (nonatomic, copy) void(^customNoNetworkEmptyViewDidClickRetryHandle)(DDCustomNoNetworkEmptyView *view);
@end
