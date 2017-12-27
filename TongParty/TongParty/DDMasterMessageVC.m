
//
//  DDMasterMessageVC.m
//  TongParty
//
//  Created by 方冬冬 on 2017/12/18.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDMasterMessageVC.h"
#import "LLSegmentBarVC.h"
#import "DDReplyMessageVC.h"
#import "DDInterestMessageVC.h"

@interface DDMasterMessageVC ()
@property (nonatomic, strong) DDLoginManager *loginManager;
@property (nonatomic, strong) DDReplyMessageVC  *replyMsgVc;
@property (nonatomic, strong) DDInterestMessageVC *interestMsgVc;
@property (nonatomic, weak) LLSegmentBarVC * segmentVC;
@end

@implementation DDMasterMessageVC

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
    self.navigationItem.leftBarButtonItem = [self backButtonForNavigationBarWithAction:@selector(back)];
    [self.loginManager pushCheckedLoginWithPopToRoot:NO block:^{
        [self configSegement];
    }];
}
-(void)back{
    [self popViewController];
}

- (void)configSegement{
    // 1 设置segmentBar的frame
    self.segmentVC.segmentBar.frame = CGRectMake(0, 0, kScreenWidth, 35);
    self.navigationItem.titleView = self.segmentVC.segmentBar;
    
    // 2 添加控制器的View
    self.segmentVC.view.frame = self.view.bounds;
    [self.view addSubview:self.segmentVC.view];
    
    NSArray *items = @[@"等待回复的人", @"感兴趣的人"];
    DDReplyMessageVC *vc1 = [DDReplyMessageVC new];
    DDInterestMessageVC *vc2 = [DDInterestMessageVC new];
    
    // 3 添加标题数组和控住器数组
    [self.segmentVC setUpWithItems:items childVCs:@[vc1,vc2]];
    
    // 4  配置基本设置  可采用链式编程模式进行设置
    [self.segmentVC.segmentBar updateWithConfig:^(LLSegmentBarConfig *config) {
        config.itemNormalColor([UIColor blackColor]).itemSelectColor(kBgGreenColor).indicatorColor(kBgGreenColor);
    }];
}


-(DDLoginManager *)loginManager
{
    if(!_loginManager) {
        _loginManager = [[DDLoginManager alloc]initWithController:self];
    }
    return _loginManager;
}


- (DDReplyMessageVC *)replyMsgVc {
    if (!_replyMsgVc) {
        DDReplyMessageVC *rmVC = [[DDReplyMessageVC alloc] init];
        [rmVC willMoveToParentViewController:self];
        [self addChildViewController:rmVC];
        [self.view addSubview:rmVC.view];
        rmVC.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTabBarHeight);
        _replyMsgVc = rmVC;
    }
    return _replyMsgVc;
}

- (DDInterestMessageVC *)interestMsgVc {
    if (!_interestMsgVc) {
        DDInterestMessageVC *intertedVC = [[DDInterestMessageVC alloc] init];
        [intertedVC willMoveToParentViewController:self];
        [self addChildViewController:intertedVC];
        [self.view addSubview:intertedVC.view];
        intertedVC.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTabBarHeight);
        _interestMsgVc = intertedVC;
    }
    return _interestMsgVc;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end







