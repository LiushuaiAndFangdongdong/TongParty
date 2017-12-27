//
//  LSRecommendAddressVC.m
//  TongParty
//
//  Created by 刘帅 on 2017/10/29.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSRecommendAddressVC.h"
#import "LSRecommendAddressCell.h"
#import "DOPDropDownMenu.h"
#import "LSSortingView.h"
#import "DDShopDetailViewController.h"
#import "LSContenSortVC.h"
#import "LSRegionDumpsVC.h"
#import "LSTimeSortVC.h"
@interface LSRecommendAddressVC ()<UISearchBarDelegate>
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) LSSortingView *sortingView;
@property (nonatomic, strong)LSContenSortVC *contentsortVc;
@property (nonatomic, strong)LSRegionDumpsVC *regionDumpsVc;
@property (nonatomic, strong)LSTimeSortVC *timesortVc;
@end

@implementation LSRecommendAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavi];
    [self setUpViews];
}


- (void)tj_refresh {
    [self tj_endRefresh];
}

- (void)tj_loadMore {
    [self tj_endLoadMore];
}

// 设置子视图
- (void)setUpViews {
    self.sepLineColor = kSeperatorColor;
    self.refreshType = DDBaseTableVcRefreshTypeRefreshAndLoadMore;
}


- (void)setupNavi {
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DDFitWidth(240), DDFitHeight(30))];
    titleView.backgroundColor = [UIColor whiteColor];
    UIColor *color =  self.navigationController.navigationBar.barTintColor;
    [titleView setBackgroundColor:color];
    [titleView addSubview:self.searchBar];
    [self.navigationItem.titleView sizeToFit];
    self.navigationItem.titleView = titleView;
    self.navigationItem.leftBarButtonItem = [self backButtonForNavigationBarWithAction:@selector(pop)];
    self.view.backgroundColor = kBgWhiteGrayColor;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

#pragma  mark search view
- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
        _searchBar.delegate = self;
        _searchBar.frame = CGRectMake(0, 0, DDFitWidth(240), DDFitHeight(30));
        _searchBar.backgroundColor = kBgWhiteGrayColor;
        _searchBar.layer.cornerRadius = DDFitHeight(15);
        _searchBar.layer.masksToBounds = YES;
        [_searchBar.layer setBorderWidth:5];
        [_searchBar.layer setBorderColor:kBgWhiteGrayColor.CGColor];  //设置边框为白色
        _searchBar.backgroundImage = [UIImage new];
        //_searchBar.text = @"你看他在狼人杀";
        //[self.searchBar resignFirstResponder];
    }
    return _searchBar;
}

- (LSSortingView *)sortingView {
    WeakSelf(weakSelf);
    if (!_sortingView) {
        _sortingView = [[LSSortingView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        _sortingView.onTapBlcok = ^(NSInteger index) {
            switch (index) {
                case 0:{
                    weakSelf.regionDumpsVc.view.hidden = YES;
                    weakSelf.timesortVc.view.hidden = YES;
                    weakSelf.contentsortVc.view.hidden = !weakSelf.contentsortVc.view.isHidden;
                }break;
                case 1:{
                    weakSelf.contentsortVc.view.hidden = YES;
                    weakSelf.regionDumpsVc.view.hidden = YES;
                    weakSelf.timesortVc.view.hidden = !weakSelf.timesortVc.view.isHidden;;
                }break;
                case 2:{
                    weakSelf.contentsortVc.view.hidden = YES;
                    weakSelf.timesortVc.view.hidden = YES;
                    weakSelf.regionDumpsVc.view.hidden = !weakSelf.regionDumpsVc.view.isHidden;;
                }break;
                default:
                    break;
            }
        };
    }
    return _sortingView;
}

- (LSContenSortVC *)contentsortVc {
    if (!_contentsortVc) {
        _contentsortVc = [[LSContenSortVC alloc] init];
        [self addChildVc:_contentsortVc];
        _contentsortVc.view.frame = CGRectMake(0, self.sortingView.bottom, self.view.frame.size.width, kScreenHeight);
        [self.view addSubview:_contentsortVc.view];
        _contentsortVc.view.hidden = YES;
    }
    return _contentsortVc;
}

- (LSRegionDumpsVC *)regionDumpsVc {
    if (!_regionDumpsVc) {
        _regionDumpsVc = [[LSRegionDumpsVC alloc] init];
        [self addChildVc:_regionDumpsVc];
        _regionDumpsVc.view.frame = CGRectMake(0, self.sortingView.bottom, self.view.frame.size.width, kScreenHeight);
        [self.view addSubview:_contentsortVc.view];
        _regionDumpsVc.view.hidden = YES;
    }
    return _regionDumpsVc;
}

- (LSTimeSortVC *)timesortVc {
    if (!_timesortVc) {
        _timesortVc = [[LSTimeSortVC alloc] init];
        [self addChildVc:_timesortVc];
        _timesortVc.view.frame = CGRectMake(0, self.sortingView.bottom, self.view.frame.size.width, 40.f);
        [self.view addSubview:_timesortVc.view];
        _timesortVc.view.hidden = YES;
    }
    return _timesortVc;
}

#pragma mark - UITableViewDelegate
- (NSInteger)tj_numberOfSections {
    return 1;
}

- (NSInteger)tj_numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (DDBaseTableViewCell *)tj_cellAtIndexPath:(NSIndexPath *)indexPath {
    LSRecommendAddressCell *cell = [LSRecommendAddressCell cellWithTableView:self.tableView];
    
    return cell;
}

- (CGFloat)tj_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return DDFitHeight(85.f);
}

- (CGFloat)tj_sectionHeaderHeightAtSection:(NSInteger)section {
    return DDFitWidth(40.f);
}

- (void)tj_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(DDBaseTableViewCell *)cell {
//    if (_selectedAddressResult) {
//        _selectedAddressResult(@"阜北社区8号楼41单元9号");
//    }
//    [self pop];
    DDShopDetailViewController *shopVC = [[DDShopDetailViewController alloc] init];
    [self.navigationController pushViewController:shopVC animated:YES];
}

- (UIView *)tj_headerAtSection:(NSInteger)section {
    
    return self.sortingView;
}


















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end

