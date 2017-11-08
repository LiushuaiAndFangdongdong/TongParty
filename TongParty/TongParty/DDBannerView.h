//
//  DDBannerView.h
//  TongParty
//
//  Created by 方冬冬 on 2017/9/15.
//  Copyright © 2017年 桐聚. All rights reserved.
//
//顶部的banner轮播图

#import <UIKit/UIKit.h>

@class DDBannerViewCell, NHDiscoverRotate_bannerElementBanner_url_URL, NHDiscoverRotate_bannerElement;

@interface DDBannerView : UIView
/** 数据源*/
@property (nonatomic, strong) NSArray <NHDiscoverRotate_bannerElement *>*modelArray;
/** 点击回调*/
@property (nonatomic, copy) void(^bannerViewGoToPageHandle)(DDBannerViewCell *cell, NHDiscoverRotate_bannerElement *bannerUrlModel);
@end
