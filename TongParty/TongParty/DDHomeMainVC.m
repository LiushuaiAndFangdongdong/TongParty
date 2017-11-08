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

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) DDHomeListViewController *listVc;
@property (nonatomic, strong) DDHomeMapViewController *mapVc;

@end

@implementation DDHomeMainVC

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        UIColor *color =  self.navigationController.navigationBar.barTintColor;
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
        _searchBar.delegate = self;
        _searchBar.frame = CGRectMake(0, 0, DDFitWidth(240), DDFitHeight(30));
        _searchBar.backgroundColor = color;
        _searchBar.layer.cornerRadius = DDFitHeight(15);
        _searchBar.layer.masksToBounds = YES;
        [_searchBar.layer setBorderWidth:5];
        [_searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];  //设置边框为白色
        _searchBar.backgroundImage = [NSBundle py_imageNamed:@"clearImage"];
        _searchBar.text = @"你看他在狼人杀";
        //[self.searchBar resignFirstResponder];
    }
    return _searchBar;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView  = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator  = NO;
        _scrollView.showsVerticalScrollIndicator    = NO;
        _scrollView.contentSize     = CGSizeMake(kScreenWidth * 2, kScreenHeight);
        _scrollView.pagingEnabled   = YES;
        _scrollView.bounces         = NO;
    }
    return _scrollView;
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
    
    //搜索栏
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DDFitWidth(240), DDFitHeight(30))];
    titleView.backgroundColor = [UIColor whiteColor];
    UIColor *color =  self.navigationController.navigationBar.barTintColor;
    [titleView setBackgroundColor:color];
    [titleView addSubview:self.searchBar];
    [self.navigationItem.titleView sizeToFit];
    self.navigationItem.titleView = titleView;
    
    //左边消息按钮
    UIBarButtonItem *leftBtn = [self customButtonForNavigationBarWithAction:@selector(messagesAction) imageNamed:@"navi_message" isRedPoint:YES pointValue:@"99" CGSizeMake:CGSizeMake(20, 15)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    //右边items
    self.navigationItem.rightBarButtonItems = [self customVariousButtonForNavigationBarWithFirstAction:@selector(modelTransform) firstImage:@"navi_list" firstIsRedPoint:NO firstPointValue:nil secondAction:@selector(scanAction) secondImage:@"navi_scan" secondIsRedPoint:NO secondPointValue:nil];
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

#pragma mark - search bar delegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    // 1. Create an Array of popular search
    NSArray *hotSeaches = @[@"狼人杀", @"三国杀", @"万纸牌", @"麻将", @"斗地主", @"跑团", @"唱K", @"夜店", @"撸串儿", @"咖啡厅", @"JYClub", @"吃鸡", @"小龙虾", @"桌游"];
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder: @"搜索活动" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // Called when search begain.
        // eg：Push to a temp view controller
        
        searchViewController.searchHistoryStyle = PYHotSearchStyleDefault;
        
        self.searchBar.text = searchText;
        [searchViewController dismissViewControllerAnimated:YES completion:nil];
        
    }];
    searchViewController.hotSearchStyle = PYHotSearchStyleColorfulTag;
    
    // 4. Set delegate
    searchViewController.delegate = self;
    // 5. Present a navigation controller
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - PYSearchViewControllerDelegate
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (searchText.length) {
        // Simulate a send request to get a search suggestions
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            for (int i = 0; i < arc4random_uniform(5) + 10; i++) {
                NSString *searchSuggestion = [NSString stringWithFormat:@"Search suggestion %d", i];
                [searchSuggestionsM addObject:searchSuggestion];
            }
            // Refresh and display the search suggustions
            searchViewController.searchSuggestions = searchSuggestionsM;
        });
    }
}


#pragma mark - push

-(void)messagesAction{
    
}
-(void)scanAction{

  
}
//地图和列表模式切换
-(void)modelTransform{
    [UIView animateWithDuration:0.5f animations:^{
        self.scrollView.contentOffset = CGPointMake(kScreenWidth, 0);
    } completion:^(BOOL finished) {
        //
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end




