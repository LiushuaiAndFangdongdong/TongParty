//
//  AppDelegate+AppRootVC.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/13.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "AppDelegate+AppRootVC.h"

@interface AppDelegate ()<UIScrollViewDelegate>
@end

@implementation AppDelegate (AppRootVC)

#pragma mark - 判断App是否首次打开 -
-(void)isAppFirstOpen{
    
//        if ([LSUserDefault objectForKey:@"isFirstLogin"])
//        {//不是第一次安装
//            [self checkBlack];
//            [self setRoot];
//            //   self.window.rootViewController = self.viewController;
//
//        }
//        else
//        {
        UIViewController *emptyView = [[ UIViewController alloc ]init ];
        self. window .rootViewController = emptyView;
        [self createLoadingScrollView];
    
}


-(void)setTabbarController{
    

}




#pragma mark -============== 引导页   ====================
- (void)createLoadingScrollView
{//引导页
    UIScrollView *sc = [[UIScrollView alloc]initWithFrame:self.window.bounds];
    sc.pagingEnabled = YES;
    sc.delegate = self;
    sc.showsHorizontalScrollIndicator = NO;
    sc.showsVerticalScrollIndicator = NO;
    [self.window.rootViewController.view addSubview:sc];
    
    NSArray *arr = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg"];
    for (NSInteger i = 0; i<arr.count; i++)
    {
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth*i, 0, kScreenWidth, self.window.frame.size.height)];
        img.image = [UIImage imageNamed:arr[i]];
        [sc addSubview:img];
        img.userInteractionEnabled = YES;
        if (i == arr.count - 1)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn.frame = CGRectMake((self.window.frame.size.width/2)-50, kScreenHeight-110, 100, 40);
            btn.backgroundColor = kRedColor;
            [btn setTitle:@"开始体验" forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(goToMain) forControlEvents:UIControlEventTouchUpInside];
            [img addSubview:btn];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = kRedColor.CGColor;
        }
    }
    sc.contentSize = CGSizeMake(kScreenWidth*arr.count, self.window.frame.size.height);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x>kScreenWidth *4+30)
    {
        [self goToMain];
    }
}

- (void)goToMain
{
    [DDUserDefault setObject:@"isFirstLogin" forKey:@"isFirstLogin"];
    [DDUserDefault synchronize];
    [self setRootVC];
    
}

-(void)setRootVC{
    
    CATransition *anim = [[CATransition alloc] init];
    anim.type = @"rippleEffect";
    anim.duration = 1.0;
    [self.window.layer addAnimation:anim forKey:nil];
    self.window.rootViewController = self.tabbar;
}

@end
