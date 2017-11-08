//
//  DDBannerPageControl.h
//  TongParty
//
//  Created by 方冬冬 on 2017/9/15.
//  Copyright © 2017年 桐聚. All rights reserved.
//
//  界面顶部轮播视图，自定义pageControl，类似于UIPageControl

#import <UIKit/UIKit.h>

@interface DDBannerPageControl : UIView

@property (nonatomic, assign) NSInteger numberOfItems;
/** 当前索引*/
@property (nonatomic, assign) NSInteger currentIndex;
/** 每一个item的宽度*/
@property (nonatomic, assign) CGFloat pageWidth;
/** item间隙，类似于collectionview的item间隙 水平方向*/
@property (nonatomic, assign) CGFloat pageSpace;

/** 选中颜色*/
@property (nonatomic, strong) UIColor *selectedItemColor;
/** 正常颜色*/
@property (nonatomic, strong) UIColor *normalItemColor;

+ (instancetype)pageControl;
@end
