//
//  DDBaseViewController.h
//  TongParty
//
//  Created by 方冬冬 on 2017/9/14.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Layer.h"

typedef void(^DDBaseViewControllerHandle)();

@interface DDBaseViewController : UIViewController

- (void)pop;

- (void)popToRootVc;

- (void)popToVc:(UIViewController *)vc;

- (void)dismiss;

- (void)dismissWithCompletion:(void(^)())completion;

- (void)presentVc:(UIViewController *)vc;

- (void)presentVc:(UIViewController *)vc completion:(void (^)(void))completion;

- (void)pushVc:(UIViewController *)vc;

- (void)removeChildVc:(UIViewController *)childVc;

- (void)addChildVc:(UIViewController *)childVc;

/** 加载中*/
- (void)showLoadingAnimation;

/** 停止加载*/
- (void)hideLoadingAnimation;

/** 请求数据，交给子类去实现*/
- (void)loadData;

@property (nonatomic, assign) BOOL isNetworkReachable;

//获取导航返回按钮
-(UIBarButtonItem *)backButtonForNavigationBarWithAction:(SEL)action;
//标题
- (void)navigationWithTitle:(NSString *)title;
//导航栏左右是标题
- (UIBarButtonItem *)customTitleButtonForNavigationWithAction:(SEL)action title:(NSString *)title CGSize:(CGSize)size;
//导航栏左右边的item
-(UIBarButtonItem *)customButtonForNavigationBarWithAction:(SEL)action imageNamed:(NSString *)imageNamed isRedPoint:(BOOL)isRedPoint pointValue:(NSString *)pointValue CGSizeMake:(CGSize)size;

//导航栏上左边或者右边多个items
-(NSArray *)customVariousButtonForNavigationBarWithFirstAction:(SEL)firstAction firstImage:(NSString *)firstImage firstIsRedPoint:(BOOL)firstIsRedPoint firstPointValue:(NSString *)firstPointValue secondAction:(SEL)secondAction secondImage:(NSString *)secondImage secondIsRedPoint:(BOOL)secondIsRedPoint secondPointValue:(NSString *)secondPointValue;

//控制器push时的模态效果
- (void)pushModalWithController:(UIViewController *)controller;

//控制器pop时的模态效果
- (void)popModalViewController;



@end








