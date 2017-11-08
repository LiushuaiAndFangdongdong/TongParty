//
//  AppDelegate+AppRootVC.h
//  TongParty
//
//  Created by 方冬冬 on 2017/9/13.
//  Copyright © 2017年 桐聚. All rights reserved.
//
/*===============================================================================
 
 AppDelegate的UI方面的维护：启动页、引导页、启动视频等；
 
 ===============================================================================*/


#import "AppDelegate.h"

@interface AppDelegate (AppRootVC)

#pragma mark - 判断App是否首次打开 -
-(void)isAppFirstOpen;
-(void)setTabbarController;
-(void)setRootVC;
@end
