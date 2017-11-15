//
//  DDNavViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/13.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDNavViewController.h"
#import "UIBarButtonItem+Addition.h"
#import "UIImage+Color.h"

@interface DDNavViewController ()<UIGestureRecognizerDelegate>

@end

@implementation DDNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置手势代理
    self.interactivePopGestureRecognizer.delegate = self;
    //设置NavigationBar
    [self setupNavigationBar];
}

//设置导航栏主题
- (void)setupNavigationBar
{
//    UINavigationBar *appearance = [UINavigationBar appearance];
//    //统一设置导航栏颜色，如果单个界面需要设置，可以在viewWillAppear里面设置，在viewWillDisappear设置回统一格式。
//    [appearance setBarTintColor:kWhiteColor];
//
//    //导航栏title格式
//    NSMutableDictionary *textAttribute = [NSMutableDictionary dictionary];
//    textAttribute[NSForegroundColorAttributeName] = kBlackColor;
//    textAttribute[NSFontAttributeName] = [UIFont systemFontOfSize:15];
//    [appearance setTitleTextAttributes:textAttribute];
//
    self.navigationController.navigationBar.barTintColor = kWhiteColor;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:kBlackColor,NSFontAttributeName:kFont(15)}];
}

//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    if (self.viewControllers.count > 0) {
//        viewController.hidesBottomBarWhenPushed = YES;
//        UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
//        [backButton setImage:[UIImage imageNamed:@"back_tj"] forState:UIControlStateNormal];
//        [backButton setImage:[UIImage imageNamed:@"back_tj"] forState:UIControlStateHighlighted];
//        [backButton setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
//        [backButton addTarget:self action:@selector(popView) forControlEvents:UIControlEventTouchUpInside];
//        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
//    }
//    [super pushViewController:viewController animated:NO];
//}

//- (void)popView
//{
//    [self popViewControllerAnimated:YES];
//}

////手势代理
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
//{
//    return self.childViewControllers.count > 1;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
