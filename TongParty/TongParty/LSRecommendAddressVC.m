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
#import "LSShopEntity.h"
#import "DDCustomCommonEmptyView.h"
#import "LSActivityEntity.h"
@interface LSRecommendAddressVC ()<UISearchBarDelegate>
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) LSSortingView *sortingView;
@property (nonatomic, strong)LSContenSortVC *contentsortVc;
@property (nonatomic, strong)LSRegionDumpsVC *regionDumpsVc;
@property (nonatomic, strong)LSTimeSortVC *timesortVc;
@property (nonatomic, weak) DDCustomCommonEmptyView *emptyView;
@end

@implementation LSRecommendAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self setupNavi];
    [self setUpViews];
}

- (void)loadData {
    [super loadData];
    [DDTJHttpRequest getShopListsWithContent:nil price_star:@"" price_end:@"" position_lat:@"" position_lon:@"" star_time:@"" end_time:@"" range:nil block:^(NSDictionary *dict) {
        self.dataArray = [LSShopEntity mj_objectArrayWithKeyValuesArray:dict];
        [self.tableView reloadData];
    } failure:^{
        
    }];
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
    WeakSelf(weakSelf);
    if (!_contentsortVc) {
        _contentsortVc = [[LSContenSortVC alloc] init];
        _contentsortVc.confirmSort = ^(NSArray *selectedArray) {
            NSMutableArray *idArr = [NSMutableArray array];
            for (LSActivityEntity *at in selectedArray) {
                [idArr addObject:at.id];
            }
            [DDTJHttpRequest getShopListsWithContent:idArr price_star:nil price_end:nil position_lat:nil position_lon:nil star_time:nil end_time:nil range:nil block:^(NSDictionary *dict) {
                weakSelf.dataArray = [LSShopEntity mj_objectArrayWithKeyValuesArray:dict];
                if (weakSelf.dataArray.count == 0) {
                    [weakSelf.emptyView showInView:weakSelf.view];
                } else {
                    [weakSelf.emptyView removeFromSuperview];
                }
                weakSelf.contentsortVc.view.hidden = YES;
                [weakSelf.sortingView clean];
                [weakSelf.tableView reloadData];
            } failure:^{
                [weakSelf.emptyView showInView:weakSelf.view];
            }];
        };
        [self addChildVc:_contentsortVc];
        _contentsortVc.view.frame = CGRectMake(0, self.sortingView.bottom, self.view.frame.size.width, kScreenHeight);
        [self.view addSubview:_contentsortVc.view];
        _contentsortVc.view.hidden = YES;
    }
    return _contentsortVc;
}

- (LSRegionDumpsVC *)regionDumpsVc {
    WeakSelf(weakSelf);
    if (!_regionDumpsVc) {
        _regionDumpsVc = [[LSRegionDumpsVC alloc] init];
        _regionDumpsVc.confirmSort = ^(NSString *lon, NSString *lat) {
            [DDTJHttpRequest getShopListsWithContent:nil price_star:nil price_end:nil position_lat:lat position_lon:lon star_time:nil end_time:nil range:nil block:^(NSDictionary *dict) {
                weakSelf.dataArray = [LSShopEntity mj_objectArrayWithKeyValuesArray:dict];
                if (weakSelf.dataArray.count == 0) {
                    [weakSelf.emptyView showInView:weakSelf.view];
                } else {
                    [weakSelf.emptyView removeFromSuperview];
                }
                weakSelf.contentsortVc.view.hidden = YES;
                [weakSelf.tableView reloadData];
            } failure:^{
                [weakSelf.emptyView showInView:weakSelf.view];
            }];
            weakSelf.regionDumpsVc.view.hidden = YES;
            [weakSelf.sortingView clean];
        };
        
        _regionDumpsVc.selectRangeSort = ^(NSString *range) {
            [DDTJHttpRequest getShopListsWithContent:nil price_star:nil price_end:nil position_lat:nil position_lon:nil star_time:nil end_time:nil range:range block:^(NSDictionary *dict) {
                weakSelf.dataArray = [LSShopEntity mj_objectArrayWithKeyValuesArray:dict];
                if (weakSelf.dataArray.count == 0) {
                    [weakSelf.emptyView showInView:weakSelf.view];
                } else {
                    [weakSelf.emptyView removeFromSuperview];
                }
                weakSelf.contentsortVc.view.hidden = YES;
                [weakSelf.tableView reloadData];
            } failure:^{
                [weakSelf.emptyView showInView:weakSelf.view];
            }];
            weakSelf.regionDumpsVc.view.hidden = YES;
            [weakSelf.sortingView clean];
        };
        [self addChildVc:_regionDumpsVc];
        _regionDumpsVc.view.frame = CGRectMake(0, self.sortingView.bottom, self.view.frame.size.width, kScreenHeight);
        [self.view addSubview:_contentsortVc.view];
        _regionDumpsVc.view.hidden = YES;
    }
    return _regionDumpsVc;
}

- (LSTimeSortVC *)timesortVc {
    WeakSelf(weakSelf);
    if (!_timesortVc) {
        _timesortVc = [[LSTimeSortVC alloc] init];
        _timesortVc.onTimeClickBlcok = ^(NSString *begin, NSString *end) {
            [DDTJHttpRequest getShopListsWithContent:nil price_star:nil price_end:nil position_lat:nil position_lon:nil star_time:begin end_time:end range:nil block:^(NSDictionary *dict) {
                weakSelf.dataArray = [LSShopEntity mj_objectArrayWithKeyValuesArray:dict];
                if (weakSelf.dataArray.count == 0) {
                    [weakSelf.emptyView showInView:weakSelf.view];
                } else {
                    [weakSelf.emptyView removeFromSuperview];
                }
                weakSelf.contentsortVc.view.hidden = YES;
                [weakSelf.tableView reloadData];
            } failure:^{
                [weakSelf.emptyView showInView:weakSelf.view];
            }];
            weakSelf.timesortVc.view.hidden = YES;
            [weakSelf.sortingView clean];
        };
        [self addChildVc:_timesortVc];
        _timesortVc.view.frame = CGRectMake(0, self.sortingView.bottom, self.view.frame.size.width, 40.f);
        [self.view addSubview:_timesortVc.view];
        _timesortVc.view.hidden = YES;
    }
    return _timesortVc;
}

- (DDCustomCommonEmptyView *)emptyView {
    if (!_emptyView) {
        DDCustomCommonEmptyView *empty = [[DDCustomCommonEmptyView alloc] initWithTitle:@"暂无数据" secondTitle:@"不好意思，网络跟您开了一个玩笑了" iconname:@"nocontent"];
        [self.view addSubview:empty];
        _emptyView = empty;
    }
    return _emptyView;
}

#pragma mark - UITableViewDelegate
- (NSInteger)tj_numberOfSections {
    return 1;
}

- (NSInteger)tj_numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (DDBaseTableViewCell *)tj_cellAtIndexPath:(NSIndexPath *)indexPath {
    LSRecommendAddressCell *cell = [LSRecommendAddressCell cellWithTableView:self.tableView];
    [cell updateValueWith:self.dataArray[indexPath.row]];
    return cell;
}

- (CGFloat)tj_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return DDFitHeight(85.f);
}

- (CGFloat)tj_sectionHeaderHeightAtSection:(NSInteger)section {
    return DDFitWidth(40.f);
}

- (void)tj_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(DDBaseTableViewCell *)cell {
    DDShopDetailViewController *shopVC = [[DDShopDetailViewController alloc] init];
    shopVC.selectedAddressResult = ^(LSShopDetailEntity *shop) {
        if (_selectedAddressResult) {
            _selectedAddressResult(shop);
        }
    };
    shopVC.shop_entity = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:shopVC animated:YES];
}

- (UIView *)tj_headerAtSection:(NSInteger)section {
    
    return self.sortingView;
}

#pragma mark - 搜索

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([searchText isEqualToString:@""]) {
        [self loadData];
    } else {
        [DDTJHttpRequest searchShopWithText:searchText block:^(NSDictionary *dict) {
            self.dataArray = [LSShopEntity mj_objectArrayWithKeyValuesArray:dict];
            [self.tableView reloadData];
        } failure:^{
            
        }];
    }
}
















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end

