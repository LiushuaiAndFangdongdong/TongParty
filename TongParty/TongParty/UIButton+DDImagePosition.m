//
//  UIButton+DDImagePosition.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/22.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "UIButton+DDImagePosition.h"

@implementation UIButton (DDImagePosition)
/**
 *  设置图片与文字样式
 */
- (void)layoutButtonWithEdgeInsetsStyle:(DDButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space; {
    /**
     * 知识点：titleEdgeInsets是title相对于其上下左右的inset，跟tableView的contentInset是类似的，
     * 如果只有title，那它上下左右都是相对于button的，image也是一样；
     * 如果同时有image和label，那这时候image的上左下是相对于button，右边是相对于label的；title的上右下是相对于button，左边是相对于image的。
     
     它们只是image和button相较于原来位置的偏移量，那什么是原来的位置呢？就是没有设置edgeInset时候的位置了。
     如果要image在右边，label在左边，那image的左边相对于button的左边右移了labelWidth的距离，image的右边相对于label的左边右移了labelWidth的距离
     所以，self.oneButton.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth);为什么是负值呢？因为这是contentInset，是偏移量，不是距离
     同样的，label的右边相对于button的右边左移了imageWith的距离，label的左边相对于image的右边左移了imageWith的距离
     所以self.oneButton.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWith, 0, imageWith);
     
     */
    
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    
    //系统最低版本8.0
    labelWidth = self.titleLabel.intrinsicContentSize.width;
    labelHeight = self.titleLabel.intrinsicContentSize.height;
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    /**
     MKButtonEdgeInsetsStyleTop, // image在上，label在下
     MKButtonEdgeInsetsStyleLeft, // image在左，label在右
     MKButtonEdgeInsetsStyleBottom, // image在下，label在上
     MKButtonEdgeInsetsStyleRight // image在右，label在左
     */
    
    switch (style) {
        case DDButtonEdgeInsetsStyleTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
        }
            break;
        case DDButtonEdgeInsetsStyleLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case DDButtonEdgeInsetsStyleBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
        }
            break;
        case DDButtonEdgeInsetsStyleRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        }
            break;
        default:
            break;
    }
    
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets; 
}

@end



