//
//  DDTabbar.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/19.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDTabbar.h"

@interface DDTabbar ()
@property (nonatomic, weak) UIButton *plusBtn;
@end
@implementation DDTabbar

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 添加一个按钮到tabbar中
        UIButton *plusBtn = [[UIButton alloc] init];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"fb_x"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setImage:[UIImage imageNamed:@"tab_fb_default"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        plusBtn.size = plusBtn.currentBackgroundImage.size;
        [plusBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusBtn];
        self.plusBtn = plusBtn;
    }
    return self;
}


-(void)plusClick {
    //通知代理
    if ([self.tabDelegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.tabDelegate tabBarDidClickPlusButton:self];
    }
}

-(void)layoutSubviews {
    
    [super layoutSubviews];
    //设置加号的位置
    self.plusBtn.centerX = self.width *0.5;
    self.plusBtn.centerY = self.height * 0.5 - 5;
    
    //设置其他tabbarButton的位置和尺寸
    CGFloat tabBarButtonW  = self.width / 5;
    CGFloat tabbarButtonIndex = 0;
    
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            child.width = tabBarButtonW;
            child.x = tabbarButtonIndex *tabBarButtonW;
            //增加索引
            tabbarButtonIndex ++;
            if (tabbarButtonIndex == 2) {
                tabbarButtonIndex ++;
            }
        }
    }
}

@end
