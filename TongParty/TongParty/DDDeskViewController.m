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

@interface DDDeskViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) DDLoginManager *loginManager;
@property (nonatomic, strong) DDJoinedVc  *joinedVc;
@property (nonatomic, strong) DDInterestedVc *interestedVc;
@property (nonatomic, weak) LLSegmentBarVC * segmentVC;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView   *view_title;
@property (nonatomic, strong) UILabel  *lbl_line;
@property (nonatomic, strong) UIButton *btn_map;
@property (nonatomic, strong) UIButton *btn_list;
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

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView  = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kNavigationBarHeight, kScreenWidth, kScreenHeight - kNavigationBarHeight )];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator  = NO;
        _scrollView.showsVerticalScrollIndicator    = NO;
        _scrollView.contentSize     = CGSizeMake(kScreenWidth * 2, kScreenHeight - kNavigationBarHeight);
        _scrollView.pagingEnabled   = YES;
        _scrollView.bounces         = NO;
        _scrollView.scrollEnabled   = NO;
    }
    return _scrollView;
}

- (UIView *)view_title {
    if (!_view_title) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/3.f, 40)];
        _btn_map = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/6.f, 35)];
        _btn_map.titleLabel.font = DDFitFont(15.f);
        [_btn_map setTitle:@"参加" forState:UIControlStateNormal];
        [_btn_map setTitleColor:kBgGreenColor forState:UIControlStateNormal];
        _btn_map.tag = 3607;
        [_btn_map addTarget:self action:@selector(modelTransform:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:_btn_map];
        _btn_list = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/6.f, 0, kScreenWidth/6.f, 35)];
        _btn_list.titleLabel.font = DDFitFont(15.f);
        [_btn_list setTitle:@"感兴趣" forState:UIControlStateNormal];
        [_btn_list setTitleColor:kCommonGrayTextColor forState:UIControlStateNormal];
        _btn_list.tag = 3608;
        [_btn_list addTarget:self action:@selector(modelTransform:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:_btn_list];
        _lbl_line = [[UILabel alloc] initWithFrame:CGRectMake(0, 39, kScreenWidth/7.f, 3)];
        _lbl_line.centerX = _btn_map.centerX;
        _lbl_line.backgroundColor = kBgGreenColor;
        [view addSubview:_lbl_line];
        _view_title = view;
    }
    
    return _view_title;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    if (![DDUserDefault objectForKey:@"token"]){
        [self refresh];
    }
}

- (void)refresh {
    [self.joinedVc userLoadData];
    [self.interestedVc userLoadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSegement];
    [kNotificationCenter addObserver:self selector:@selector(refresh) name:kUpdateUserInfoNotification object:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self modelTransform:self.btn_map];
    });
}

- (void)configSegement{

    self.navigationItem.titleView = self.view_title;
    [self.view addSubview:self.scrollView];
    [self addChildViewController:self.joinedVc];
    [self.scrollView addSubview:self.joinedVc.view];
    [self addChildViewController:self.interestedVc];
    [self.scrollView addSubview:self.interestedVc.view];
}


-(DDLoginManager *)loginManager
{
    if(!_loginManager) {
        _loginManager = [[DDLoginManager alloc]initWithController:self];
    }
    return _loginManager;
}


- (DDJoinedVc *)joinedVc {
    if (!_joinedVc) {
        DDJoinedVc *joinVC = [[DDJoinedVc alloc] init];
        [joinVC willMoveToParentViewController:self];
        joinVC.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight);
        _joinedVc = joinVC;
    }
    return _joinedVc;
}

- (DDInterestedVc *)interestedVc {
    if (!_interestedVc) {
        DDInterestedVc *intertedVC = [[DDInterestedVc alloc] init];
        [intertedVC willMoveToParentViewController:self];
        intertedVC.view.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight);
        _interestedVc = intertedVC;
    }
    return _interestedVc;
}

-(void)modelTransform:(UIButton *)sender {
    
    for (id obj in [_view_title subviews]) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)obj;
            if (btn.tag != sender.tag) {
                [btn setTitleColor:kCommonGrayTextColor forState:UIControlStateNormal];
            }
        }
    }
    
    [sender setTitleColor:kBgGreenColor forState:UIControlStateNormal];
    if (sender.tag == 3608) {
        [UIView animateWithDuration:0.5f animations:^{
            self.scrollView.contentOffset = CGPointMake(kScreenWidth, 0);
            _lbl_line.centerX = sender.centerX;
        } completion:^(BOOL finished) {
            //
        }];
    } else {
        [UIView animateWithDuration:0.5f animations:^{
            self.scrollView.contentOffset = CGPointMake(0, 0);
            _lbl_line.centerX = sender.centerX;
        } completion:^(BOOL finished) {
            //
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end








