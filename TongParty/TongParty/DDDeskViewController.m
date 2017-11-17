//
//  DDDeskViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/21.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDDeskViewController.h"
#import "DDCustomSegmentView.h"
#import "DDJoinedVc.h"
#import "DDInterestedVc.h"

@interface DDDeskViewController ()
@property (nonatomic, strong) DDJoinedVc  *joinedVc;
@property (nonatomic, strong) DDInterestedVc *interestedVc;
@end

@implementation DDDeskViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavi];
}

-(void)setupNavi{
    WeakSelf(weakSelf);
    // 精选关注
    DDCustomSegmentView *segment = [[DDCustomSegmentView alloc] initWithItemTitles:@[@"参加", @"感兴趣"]];
    self.navigationItem.titleView = segment;
    segment.frame = CGRectMake(0, 0, 130, 35);
    [segment clickDefault];
    segment.DDCustomSegmentViewBtnClickHandle = ^(DDCustomSegmentView *segment, NSString *title, NSInteger currentIndex) {
        BOOL isFeatured = (currentIndex == 0);
        weakSelf.joinedVc.view.hidden = !isFeatured;
        weakSelf.interestedVc.view.hidden =  isFeatured;
    };
}
- (DDJoinedVc *)joinedVc {
    if (!_joinedVc) {
        DDJoinedVc *joinVC = [[DDJoinedVc alloc] init];
        [joinVC willMoveToParentViewController:self];
        [self addChildViewController:joinVC];
        [self.view addSubview:joinVC.view];
        joinVC.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight);
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
        intertedVC.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight);
        _interestedVc = intertedVC;
    }
    return _interestedVc;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end








