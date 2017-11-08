//
//  DDHomeMainVC.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/19.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDHomeMainVC.h"
#import "PYSearch.h"
#import "DDHomeListViewController.h"  //列表vc
#import "DDHomeMapViewController.h"   //地图vc
#import "PlusAnimate.h"
#import "CYTabBarController.h"

@interface DDHomeMainVC ()<UISearchBarDelegate,PYSearchViewControllerDelegate,CYTabBarDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView   *view_title;
@property (nonatomic, strong) UILabel  *lbl_line;
@property (nonatomic, strong) DDHomeListViewController *listVc;
@property (nonatomic, strong) DDHomeMapViewController *mapVc;

@end

@implementation DDHomeMainVC

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView  = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator  = NO;
        _scrollView.showsVerticalScrollIndicator    = NO;
        _scrollView.contentSize     = CGSizeMake(kScreenWidth * 2, kScreenHeight);
        _scrollView.pagingEnabled   = YES;
        _scrollView.bounces         = NO;
        _scrollView.scrollEnabled   = NO;
    }
    return _scrollView;
}

- (UIView *)view_title {
    if (!_view_title) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/3.f, 40)];
        UIButton *btn_map = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/6.f, 35)];
        btn_map.titleLabel.font = DDFitFont(16.f);
        [btn_map setTitle:@"地图" forState:UIControlStateNormal];
        [btn_map setTitleColor:kRGBColor(123.f, 198.f, 239.f) forState:UIControlStateNormal];
        btn_map.tag = 3607;
        [btn_map addTarget:self action:@selector(modelTransform:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn_map];
        UIButton *btn_list = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/6.f, 0, kScreenWidth/6.f, 35)];
        btn_list.titleLabel.font = DDFitFont(16.f);
        [btn_list setTitle:@"列表" forState:UIControlStateNormal];
        [btn_list setTitleColor:kCommonGrayTextColor forState:UIControlStateNormal];
        btn_list.tag = 3608;
        [btn_list addTarget:self action:@selector(modelTransform:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn_list];
        _lbl_line = [[UILabel alloc] initWithFrame:CGRectMake(0, 39, kScreenWidth/7.f, 3)];
        _lbl_line.centerX = btn_map.centerX;
        _lbl_line.backgroundColor = kRGBColor(123.f, 198.f, 239.f);
        [view addSubview:_lbl_line];
        _view_title = view;
    }
    
    return _view_title;
}
-(DDHomeMapViewController *)mapVc{
    if (!_mapVc) {
        _mapVc = [[DDHomeMapViewController alloc]init];
    }
    return _mapVc;
}
-(DDHomeListViewController *)listVc{
    if (!_listVc) {
        _listVc = [[DDHomeListViewController alloc]init];
    }
    return _listVc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNavi];
    [self initWithScrollView];
    CYTABBARCONTROLLER.tabbar.delegate = self;
    self.tabBarItem.badgeValue = @"remind";
}
-(void)initWithScrollView{
    [self.view addSubview:self.scrollView];
    [self addChildViewController:self.mapVc];
    [self addChildViewController:self.listVc];
    
    self.mapVc.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.listVc.view.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight);
    [self.scrollView addSubview:self.mapVc.view];
    [self.scrollView addSubview:self.listVc.view];
//    [self.view addSubview:self.contentView];
}

-(void)customNavi{
    
    // title 视图
    self.navigationItem.titleView = self.view_title;
    //左边消息按钮
    UIBarButtonItem *leftBtn = [self customButtonForNavigationBarWithAction:@selector(messagesAction) imageNamed:@"navi_nf" isRedPoint:YES pointValue:@"9" CGSizeMake:CGSizeMake(20, 15)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    //右边items
    self.navigationItem.rightBarButtonItems = [self customVariousButtonForNavigationBarWithFirstAction:@selector(scanAction) firstImage:@"navi_scan" firstIsRedPoint:NO firstPointValue:nil secondAction:@selector(searchAction) secondImage:@"navi_search" secondIsRedPoint:NO secondPointValue:nil];
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

#pragma mark - PYSearchViewControllerDelegate
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (searchText.length) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            for (int i = 0; i < arc4random_uniform(5) + 10; i++) {
                NSString *searchSuggestion = [NSString stringWithFormat:@"Search suggestion %d", i];
                [searchSuggestionsM addObject:searchSuggestion];
            }
            searchViewController.searchSuggestions = searchSuggestionsM;
        });
    }
}


#pragma mark - push

-(void)messagesAction{
    
}
-(void)scanAction{
  
}

- (void) searchAction {
    NSArray *hotSeaches = @[@"狼人杀", @"三国杀", @"万纸牌", @"麻将", @"斗地主", @"跑团", @"唱K", @"夜店", @"撸串儿", @"咖啡厅", @"JYClub", @"吃鸡", @"小龙虾", @"桌游"];
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder: @"搜索活动" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        searchViewController.searchHistoryStyle = PYHotSearchStyleDefault;
        [searchViewController dismissViewControllerAnimated:YES completion:nil];
    }];
    searchViewController.hotSearchStyle = PYHotSearchStyleColorfulTag;
    searchViewController.delegate = self;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav animated:YES completion:nil];
}

//地图和列表模式切换
-(void)modelTransform:(UIButton *)sender {

    for (id obj in [_view_title subviews]) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)obj;
            if (btn.tag != sender.tag) {
                [btn setTitleColor:kCommonGrayTextColor forState:UIControlStateNormal];
            }
        }
    }
    [sender setTitleColor:kRGBColor(123.f, 198.f, 239.f) forState:UIControlStateNormal];
    if (sender.tag == 3608 ) {
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




