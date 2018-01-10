//
//  DDDiscoverViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/21.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDDiscoverViewController.h"
#import "DDRecomCardViewController.h"
#import "FXDCircleView.h"
#import "DDNearUserModel.h"
#import "DDNearTableModel.h"

#define kBannerHeight 170
#define kCircleWidth  kScreenWidth/3 * 2
//#define kCircleWidth  (kContentHeight - kBannerHeight)/2

@interface DDDiscoverViewController ()
@property (nonatomic, strong) UIImageView *bannerView;   //banner
@property (nonatomic, strong) UIImageView *recommedView; //推荐卡片
@property (nonatomic, strong) FXDCircleView *deskCircle; //桌子转盘
@property (nonatomic, strong) FXDCircleView *userCircle; //用户转盘
@property (nonatomic, strong) UIImageView *deskPillar;   //桌子柱子
@property (nonatomic, strong) UIImageView *userPillar;   //用户柱子
@end

@implementation DDDiscoverViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addViews];
    self.view.backgroundColor = [UIColor whiteColor];
    [DDTJHttpRequest getNearByDiscoverWithLat:@"" lon:@"" block:^(NSDictionary *dict) {
        NSLog(@"附近有：%@",dict);
        NSArray *userArray = [DDNearUserModel mj_objectArrayWithKeyValuesArray:dict[@"f_user"]];
        NSArray *tableArray = [DDNearTableModel mj_objectArrayWithKeyValuesArray:dict[@"f_table"]];
        [self.userCircle updateNearUserWithArray:userArray];
        [self.deskCircle updateNearTableWithArray:tableArray];
    } failure:^{
        //
    }];
}

- (void)addViews
{
    [self.view addSubview:self.bannerView];
    [self.view addSubview:self.recommedView];
    [self.view addSubview:self.deskPillar];
    [self.view addSubview:self.deskCircle];
    [self.view addSubview:self.userPillar];
    [self.view addSubview:self.userCircle];
}


#pragma ----getter
- (UIImageView *)bannerView{
    if (!_bannerView) {
        _bannerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, kScreenWidth, kBannerHeight)];
        _bannerView.image = [UIImage imageNamed:@"banner_image"];
    }
    return _bannerView;
}

- (UIImageView *)recommedView{
    if (!_recommedView) {
        _recommedView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 50, _bannerView.y + _bannerView.height + 20, 30, 30)];
        _recommedView.userInteractionEnabled = YES;
        _recommedView.image = kImage(@"discover_recommend");
        [_recommedView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(enterRecommendCard)]];
    }
    return _recommedView;
}

- (UIImageView *)deskPillar{
    if (!_deskPillar) {
        _deskPillar = [[UIImageView alloc] initWithFrame:CGRectMake(kCircleWidth/2 - 50 -30/2, _bannerView.y + _bannerView.height + 10 + kCircleWidth/2 + 25, 30, 200)];
        _deskPillar.image = [UIImage imageNamed:@"柱子"];
    }
    return _deskPillar;
}

- (FXDCircleView *)deskCircle{
    if (!_deskCircle) {
        _deskCircle = [[FXDCircleView alloc] initWithFrame:CGRectMake(-50, _bannerView.y + _bannerView.height + 10, kCircleWidth, kCircleWidth)];
    }
    return _deskCircle;
}

- (UIImageView *)userPillar{
    if (!_userPillar) {
        _userPillar = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - (kCircleWidth/2 - 50 -30/2) - 30, (_deskCircle.y + _deskCircle.height - 80) + kCircleWidth/2 + 25, 30, 200)];
        _userPillar.image = [UIImage imageNamed:@"柱子"];
    }
    return _userPillar;
}

- (FXDCircleView *)userCircle{
    if (!_userCircle) {
        _userCircle = [[FXDCircleView alloc] initWithFrame:CGRectMake(kScreenWidth-(kCircleWidth-50), (_deskCircle.y + _deskCircle.height - 80), kCircleWidth, kCircleWidth)];
    }
    return _userCircle;
}


-(void)enterRecommendCard{
    DDRecomCardViewController *cardVC = [[DDRecomCardViewController alloc] init];
    [self.navigationController pushViewController:cardVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end







