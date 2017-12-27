//
//  DDSexInfoView.h
//  TongParty
//
//  Created by 方冬冬 on 2017/10/31.
//  Copyright © 2017年 桐聚. All rights reserved.
//
//进入ta的个人页面，男女显示的资料

#import <UIKit/UIKit.h>

//typedef NS_ENUM(NSUInteger, DDSexInfoStyle) {
//    /** 男*/
//    DDSexInfoStyleMale,
//    /** 女*/
//    DDSexInfoStyleFemale
//};

@interface DDSexInfoView : UIView
//@property (nonatomic, assign) DDSexInfoStyle style;
- (void)updateValueWithModel:(id)model;
@end







