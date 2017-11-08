//
//  DDTabbarViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/13.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDTabbarViewController.h"
#import "DDNavViewController.h" //导航栏页面
#import "DDHomeMainVC.h"//首页
#import "DDDeskViewController.h"//桌子页面
#import "DDDiscoverViewController.h"//发现页面
#import "DDUsercenterVc.h"         //个人中心
#import "PlusAnimate.h"
#import "LSCreateDeskVC.h"

@interface DDTabbarViewController ()<CYTabBarDelegate>
@end

@implementation DDTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [CYTabBarConfig shared].selectedTextColor = [UIColor orangeColor];
    [CYTabBarConfig shared].textColor = [UIColor grayColor];
    [CYTabBarConfig shared].backgroundColor = [UIColor whiteColor];
    [CYTabBarConfig shared].selectIndex = 0 ;
    [CYTabBarConfig shared].centerBtnIndex = 2;
    // 设置子控制器
    //---------------- 首页 ---------------
    DDNavViewController *nav1 = [[DDNavViewController alloc]initWithRootViewController:[DDHomeMainVC new]];
    [self addChildController:nav1 title:@"首页" imageName:@"tab_sy_default" selectedImageName:@"tab_sy_selected"];
    //---------------- 桌子 ---------------
    DDNavViewController *nav2 = [[DDNavViewController alloc]initWithRootViewController:[DDDeskViewController new]];
    [self addChildController:nav2 title:@"桌子" imageName:@"tab_zb_default" selectedImageName:@"tab_zb_selected"];
    //---------------- 发现 ---------------
    DDNavViewController *nav3 = [[DDNavViewController alloc]initWithRootViewController:[DDDiscoverViewController new]];
    [self addChildController:nav3 title:@"发现" imageName:@"tab_fw_default" selectedImageName:@"tab_fw_selected"];
    //---------------- 个人 ---------------
    DDNavViewController   *nav4 = [[DDNavViewController alloc]initWithRootViewController:[DDUsercenterVc new]];
    [self addChildController:nav4 title:@"我的" imageName:@"tab_sq_default" selectedImageName:@"tab_sq_selected"];
    //---------------- 中间凸出 ---------------
    [self addCenterController:nil bulge:YES title:nil imageName:@"tabbar_center" selectedImageName:@"tabbar_center"];
    self.tabbar.delegate = self;
    
    // 监听中间按钮弹出视图子按钮点击事件
    [kNotificationCenter addObserver:self selector:@selector(didSelectBtnWithBtnTag:) name:@"centerPopAction" object:nil];
    
}

- (void)didSelectBtnWithBtnTag:(NSNotification *)notification {
    UIButton *btn = (UIButton *)notification.object;
    
    NSLog(@"-----------%ld",btn.tag);
    switch (btn.tag) {
        case 0:{
            DDNavViewController   *nav = [[DDNavViewController alloc]initWithRootViewController:[LSCreateDeskVC new]];
            [self presentViewController:nav animated:YES completion:nil];
        }break;
        case 1:{
            
            
        }break;
        default:
            break;
    }
}
#pragma mark - CYTabBarDelegate
//中间按钮点击
- (void)tabbar:(CYTabBar *)tabbar clickForCenterButton:(CYCenterButton *)centerButton{
    [PlusAnimate standardPublishAnimateWithView:centerButton];
}
//是否允许切换
- (BOOL)tabBar:(CYTabBar *)tabBar willSelectIndex:(NSInteger)index{
    NSLog(@"将要切换到---> %ld",index);
    return YES;
}
//通知切换的下标
- (void)tabBar:(CYTabBar *)tabBar didSelectIndex:(NSInteger)index{
    NSLog(@"切换到---> %ld",index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

