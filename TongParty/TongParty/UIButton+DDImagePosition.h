//
//  UIButton+DDImagePosition.h
//  TongParty
//
//  Created by 方冬冬 on 2017/9/22.
//  Copyright © 2017年 桐聚. All rights reserved.
//
//设置button中文字和图片的布局

#import <UIKit/UIKit.h>

// 定义一个枚举（包含了四种类型的button）
typedef NS_ENUM(NSUInteger, DDButtonEdgeInsetsStyle) {
    DDButtonEdgeInsetsStyleTop, // image在上，label在下
    DDButtonEdgeInsetsStyleLeft, // image在左，label在右
    DDButtonEdgeInsetsStyleBottom, // image在下，label在上
    DDButtonEdgeInsetsStyleRight // image在右，label在左
};

@interface UIButton (DDImagePosition)
/**
 *  设置图片与文字样式
 */
- (void)layoutButtonWithEdgeInsetsStyle:(DDButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;
@end
