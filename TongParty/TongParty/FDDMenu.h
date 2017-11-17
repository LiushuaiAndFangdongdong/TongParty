//
//  FDDMenu.h
//  TongParty
//
//  Created by 方冬冬 on 2017/10/31.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FDDMenuItem.h"

// Menu将要显示的通知
extern NSString * const DDMenuWillAppearNotification;
// Menu已经显示的通知
extern NSString * const DDMenuDidAppearNotification;
// Menu将要隐藏的通知
extern NSString * const DDMenuWillDisappearNotification;
// Menu已经隐藏的通知
extern NSString * const DDMenuDidDisappearNotification;

typedef void(^DDMenuSelectedItem)(NSInteger index, FDDMenuItem *item);

typedef enum {
    DDMenuBackgrounColorEffectSolid      = 0, //!<背景显示效果.纯色
    DDMenuBackgrounColorEffectGradient   = 1, //!<背景显示效果.渐变叠加
} DDMenuBackgrounColorEffect;

@interface FDDMenu : NSObject
+ (void)showMenuInView:(UIView *)view fromRect:(CGRect)rect menuItems:(NSArray *)menuItems selected:(DDMenuSelectedItem)selectedItem;

+ (void)dismissMenu;
+ (BOOL)isShow;

// 主题色
+ (UIColor *)tintColor;
+ (void)setTintColor:(UIColor *)tintColor;

// 圆角
+ (CGFloat)cornerRadius;
+ (void)setCornerRadius:(CGFloat)cornerRadius;

// 箭头尺寸
+ (CGFloat)arrowSize;
+ (void)setArrowSize:(CGFloat)arrowSize;

// 标题字体
+ (UIFont *)titleFont;
+ (void)setTitleFont:(UIFont *)titleFont;

// 背景效果
+ (DDMenuBackgrounColorEffect)backgrounColorEffect;
+ (void)setBackgrounColorEffect:(DDMenuBackgrounColorEffect)effect;

// 是否显示阴影
+ (BOOL)hasShadow;
+ (void)setHasShadow:(BOOL)flag;

// 选中颜色
+ (UIColor*)selectedColor;
+ (void)setSelectedColor:(UIColor*)selectedColor;

// 分割线颜色
+ (UIColor*)separatorColor;
+ (void)setSeparatorColor:(UIColor*)separatorColor;

/// 菜单元素垂直方向上的边距值
+ (CGFloat)menuItemMarginY;
+ (void)setMenuItemMarginY:(CGFloat)menuItemMarginY;

@end
