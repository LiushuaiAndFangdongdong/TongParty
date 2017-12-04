//
//  DDDeskViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/21.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDDeskViewController.h"
#import "DDJoinedVc.h"
#import "DDInterestedVc.h"
#import "LLSegmentBarVC.h"

@interface DDDeskViewController ()
@property (nonatomic, strong) DDJoinedVc  *joinedVc;
@property (nonatomic, strong) DDInterestedVc *interestedVc;
@property (nonatomic, weak) LLSegmentBarVC * segmentVC;
@end

@implementation DDDeskViewController

- (LLSegmentBarVC *)segmentVC{
    if (!_segmentVC) {
        LLSegmentBarVC *vc = [[LLSegmentBarVC alloc]init];
        // 添加到到控制器
        [self addChildViewController:vc];
        _segmentVC = vc;
    }
    return _segmentVC;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setupNavi];
    // 1 设置segmentBar的frame
    self.segmentVC.segmentBar.frame = CGRectMake(0, 0, kScreenWidth, 35);
    self.navigationItem.titleView = self.segmentVC.segmentBar;
    
    // 2 添加控制器的View
    self.segmentVC.view.frame = self.view.bounds;
    [self.view addSubview:self.segmentVC.view];
    
    NSArray *items = @[@"参加", @"感兴趣"];
    DDJoinedVc *vc1 = [DDJoinedVc new];
    DDInterestedVc *vc2 = [DDInterestedVc new];
    
    // 3 添加标题数组和控住器数组
    [self.segmentVC setUpWithItems:items childVCs:@[vc1,vc2]];
    
    // 4  配置基本设置  可采用链式编程模式进行设置
    [self.segmentVC.segmentBar updateWithConfig:^(LLSegmentBarConfig *config) {
        config.itemNormalColor([UIColor blackColor]).itemSelectColor(kBgGreenColor).indicatorColor(kBgGreenColor);
    }];
}

- (DDJoinedVc *)joinedVc {
    if (!_joinedVc) {
        DDJoinedVc *joinVC = [[DDJoinedVc alloc] init];
        [joinVC willMoveToParentViewController:self];
        [self addChildViewController:joinVC];
        [self.view addSubview:joinVC.view];
        joinVC.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTabBarHeight);
        _joinedVc = joinVC;
    }
    return _joinedVc;
}

- (DDInterestedVc *)interestedVc {
    if (!_interestedVc) {
        DDInterestedVc *intertedVC = [[DDInterestedVc alloc] init];
        [intertedVC willMoveToParentViewController:self];
        [self addChildViewController:intertedVC];
        [self.view addSubview:intertedVC.view];
        intertedVC.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTabBarHeight);
        _interestedVc = intertedVC;
    }
    return _interestedVc;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end








