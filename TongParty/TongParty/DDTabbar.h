//
//  DDTabbar.h
//  WitCity
//
//  Created by 方冬冬 on 16/7/19.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DDTabbar;
@protocol DDTabbarDelegate <UITabBarDelegate>

@optional
//点击中间按钮
-(void)tabBarDidClickPlusButton:(DDTabbar *)tabBar;
@end

@interface DDTabbar : UITabBar
@property(nonatomic,weak)id <DDTabbarDelegate> tabDelegate;
@end
