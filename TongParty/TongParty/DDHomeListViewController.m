//
//  DDHomeListViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/15.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDHomeListViewController.h"
#import "DDBannerView.h"       //banner
#import "DDInterestTableViewCell.h"
#import "DDTableModel.h"
#import "DDBannerModel.h"
#import "DDCustomCommonEmptyView.h"
#import "LSSortingView.h"
#import "LSContenSortVC.h"
#import "LSRegionDumpsVC.h"
#import "LSHomwTimeSortVC.h"
#import "LSActivityEntity.h"
#import "DDDeskShowViewController.h"


@interface DDHomeListViewController ()
/** 轮播图数据数组*/
@property (nonatomic, strong) NSMutableArray *bannerImgArray;
/** 头部视图*/
@property (nonatomic, strong) DDBannerView *headerView;
@property (nonatomic, strong) LSSortingView *sortingView;
@property (nonatomic, strong) UIView *sortsView;
@property (nonatomic, strong) LSContenSortVC *contentsortVc;
@property (nonatomic, strong) LSRegionDumpsVC *regionDumpsVc;
@property (nonatomic, strong) LSHomwTimeSortVC *timesortVc;
@property (nonatomic, strong) UIView *view_average;
@property (nonatomic, strong) UILabel *sortLabel;
@property (nonatomic, strong) NSMutableArray   *btns;
@property (nonatomic, weak) DDCustomCommonEmptyView *emptyView;

// 搜索记录
@property (nonatomic, copy)NSString *old_lat;
@property (nonatomic, copy)NSString *old_lon;
@property (nonatomic, strong)NSArray *old_activities;
@property (nonatomic, copy)NSString *old_text;
@property (nonatomic, copy)NSString *old_range;
@property (nonatomic, copy)NSString *old_begin;
@property (nonatomic, copy)NSString *old_end;
@property (nonatomic, copy)NSString *order1;
@property (nonatomic, copy)NSString *order2;
@end

@implementation DDHomeListViewController

#pragma mark - 懒
- (NSMutableArray *)bannerImgArray {
    if (!_bannerImgArray) {
        _bannerImgArray = [NSMutableArray new];
    }
    return _bannerImgArray;
}

- (DDBannerView *)headerView {
    if (!_headerView) {
        _headerView = [[DDBannerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, DDFitHeight(180.f))];
        self.tableView.tableHeaderView = _headerView;
    }
    return _headerView;
}

- (DDCustomCommonEmptyView *)emptyView {
    if (!_emptyView) {
        DDCustomCommonEmptyView *empty = [[DDCustomCommonEmptyView alloc] initWithTitle:@"暂无数据" secondTitle:@"不好意思，网络跟您开了一个玩笑了" iconname:@"nocontent"];
        [self.view addSubview:empty];
        _emptyView = empty;
    }
    return _emptyView;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

#pragma mark - 出现
- (void)viewDidLoad {
    [super viewDidLoad];
    // 请求数据
    [self loadData];
    // 设置子视图
    [self setUpViews];
}

// 设置子视图
- (void)setUpViews {
    self.btns = [NSMutableArray array];
    self.sepLineColor = kSeperatorColor;
    self.refreshType = DDBaseTableVcRefreshTypeRefreshAndLoadMore;
}

#pragma mark - UITableViewDelegate
- (NSInteger)tj_numberOfSections {
    return 1;
}

- (NSInteger)tj_numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (DDBaseTableViewCell *)tj_cellAtIndexPath:(NSIndexPath *)indexPath {
    DDInterestTableViewCell *cell = [DDInterestTableViewCell cellWithTableView:self.tableView];
    [cell updateWithModel:_dataArray[indexPath.row]];
    return cell;
}

- (CGFloat)tj_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 145;
}
- (CGFloat)tj_sectionHeaderHeightAtSection:(NSInteger)section {
    return 80;
}

- (void)tj_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(DDBaseTableViewCell *)cell {
    DDDeskShowViewController *deskVC = [[DDDeskShowViewController alloc] init];
    deskVC.tmpModel = _dataArray[indexPath.row];
    [self.navigationController pushViewController:deskVC animated:YES];
}

- (UIView *)tj_headerAtSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80.f)];
    view.backgroundColor = kWhiteColor;
    [view addSubview:self.sortingView];
    [view addSubview:self.sortsView];
    return view;
}
static NSInteger bastTag = 111111;
- (UIView *)sortsView {
    
    if ((!_sortsView)) {
        _sortsView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth, 40)];
        NSArray *titles = @[@"时间优先",@"距离优先",@"人均消费",@"其他排序"];
        for (int i = 0; i < titles.count; i++) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth/4) * i, 2.5f, kScreenWidth/4, 35.f)];
            [btn setTitle:titles[i] forState:UIControlStateNormal];
            [btn setTitleColor:kCommonGrayTextColor forState:UIControlStateNormal];
            btn.titleLabel.font = DDFitFont(14.f);
            btn.tag = bastTag + i;
            [self.btns addObject:btn];
            [btn addTarget:self action:@selector(sortsList:) forControlEvents:UIControlEventTouchUpInside];
            [_sortsView addSubview:btn];
            if (i == 2) {
                _sortLabel = [UILabel new];
                [btn addSubview:_sortLabel];
                [_sortLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.top.bottom.equalTo(btn);
                     make.right.equalTo(btn).offset(-3.f);
                    make.width.mas_equalTo(DDFitWidth(10.f));
                }];
                _sortLabel.text = @"▲\n▼";
                _sortLabel.numberOfLines = 2;
                _sortLabel.textAlignment = NSTextAlignmentCenter;
                _sortLabel.textColor = kCommonGrayTextColor;
                _sortLabel.font = DDFitFont(8.f);
            }
        }
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5f)];
        line.backgroundColor = kBgWhiteGrayColor;
        [_sortsView addSubview:line];
    }
    return _sortsView;
}

- (void)sortsList:(UIButton *)sender {
    for (UIButton *btn in self.btns) {
        [btn setTitleColor:kCommonGrayTextColor forState:UIControlStateNormal];
    }
    [sender setTitleColor:kBlackColor forState:UIControlStateNormal];
    self.view_average.hidden = YES;
    [self.tableView setContentOffset:CGPointMake(0,0) animated:YES];
    _sortLabel.text = @"▲\n▼";
    _sortLabel.textColor = kCommonGrayTextColor;
    self.tableView.scrollEnabled = YES;
    switch (sender.tag - bastTag) {
        case 0:{
            [self loadConditionsDataWithOrder1:@"1" order2:@"1"];
            }break;
        case 1:{
            [self loadConditionsDataWithOrder1:@"2" order2:@"1"];
        }break;
        case 2:{
            self.tableView.scrollEnabled = NO;
            self.view_average.hidden = !self.view_average.isHidden;
        }break;
        case 3:{
            [self loadConditionsDataWithOrder1:@"4" order2:@"1"];
        }break;
        default:
            break;
    }
}

- (UIView *)view_average {
    if (!_view_average) {
        _view_average = [[UIView alloc] initWithFrame:CGRectMake(0, DDFitHeight(260.f), kScreenWidth, 80.f)];
        [self.tableView addSubview:self.view_average];
        UILabel *label_rise = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth/2, 40)];
        label_rise.text = @"人均从低到高";
        label_rise.font = DDFitFont(13.f);
        label_rise.textAlignment = NSTextAlignmentLeft;
        label_rise.textColor = kBlackColor;
        label_rise.userInteractionEnabled = YES;
        label_rise.tag = 3838;
        [label_rise addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sortAverage:)]];
        [_view_average addSubview:label_rise];
        UILabel *label_down = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, kScreenWidth/2, 40)];
        label_down.text = @"人均从高到低";
        label_down.font = DDFitFont(13.f);
        label_down.textAlignment = NSTextAlignmentLeft;
        label_down.textColor = kBlackColor;
        label_down.userInteractionEnabled = YES;
        label_down.tag = 3839;
        [label_down addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sortAverage:)]];
        [_view_average addSubview:label_down];
        _view_average.hidden = YES;
        _view_average.backgroundColor = kBgWhiteGrayColor;
    }
    return _view_average;
}

- (void)sortAverage:(UITapGestureRecognizer *)tap {
    UILabel *lbl = (UILabel *)[tap view];
    _view_average.hidden = YES;
    self.tableView.scrollEnabled = YES;
    switch (lbl.tag) {
        case 3838:{
            for (UIButton *btn in self.btns) {
                [btn setTitleColor:kCommonGrayTextColor forState:UIControlStateNormal];
                if (btn.tag - bastTag == 2 ) {
                    [btn setTitleColor:kBlackColor forState:UIControlStateNormal];
                    _sortLabel.text = @"▲";
                    _sortLabel.textColor = kBlackColor;
                }
            }
            [self loadConditionsDataWithOrder1:@"3" order2:@"1"];
            }break;
        case 3839:{
            for (UIButton *btn in self.btns) {
                [btn setTitleColor:kCommonGrayTextColor forState:UIControlStateNormal];
                if (btn.tag - bastTag == 2 ) {
                    [btn setTitleColor:kBlackColor forState:UIControlStateNormal];
                    _sortLabel.text = @"▼";
                    _sortLabel.textColor = kBlackColor;
                }
            }
            [self loadConditionsDataWithOrder1:@"3" order2:@"2"];
            }break;
        default:
            break;
    }
}

- (LSSortingView *)sortingView {
    WeakSelf(weakSelf);
    if (!_sortingView) {
        _sortingView = [[LSSortingView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        _sortingView.onTapBlcok = ^(NSInteger index) {
            weakSelf.view_average.hidden = YES;
            for (UIButton *btn in weakSelf.btns) {
                [btn setTitleColor:kCommonGrayTextColor forState:UIControlStateNormal];
            }
            weakSelf.sortLabel.text = @"▲\n▼";
            weakSelf.sortLabel.textColor = kCommonGrayTextColor;
            [weakSelf.tableView setContentOffset:CGPointMake(0,DDFitHeight(180.f)) animated:YES];
            switch (index) {
                case 0:{
                    weakSelf.regionDumpsVc.view.hidden = YES;
                    weakSelf.timesortVc.view.hidden = YES;
                    [weakSelf.tableView bringSubviewToFront:weakSelf.contentsortVc.view];
                    weakSelf.contentsortVc.view.hidden = !weakSelf.contentsortVc.view.isHidden;
                }break;
                case 1:{
                    weakSelf.contentsortVc.view.hidden = YES;
                    weakSelf.regionDumpsVc.view.hidden = YES;
                    [weakSelf.tableView bringSubviewToFront:weakSelf.timesortVc.view];
                    weakSelf.timesortVc.view.hidden = !weakSelf.timesortVc.view.isHidden;;
                }break;
                case 2:{
                    weakSelf.contentsortVc.view.hidden = YES;
                    weakSelf.timesortVc.view.hidden = YES;
                    [weakSelf.tableView bringSubviewToFront:weakSelf.regionDumpsVc.view];
                    weakSelf.regionDumpsVc.view.hidden = !weakSelf.regionDumpsVc.view.isHidden;;
                }break;
                default:
                    break;
            }
            if (weakSelf.regionDumpsVc.view.isHidden == YES &&
                weakSelf.timesortVc.view.isHidden == YES &&
                weakSelf.contentsortVc.view.isHidden == YES) {
                weakSelf.tableView.scrollEnabled = YES;
                [weakSelf.tableView setContentOffset:CGPointMake(0,0) animated:YES];
                [weakSelf.sortingView clean];
            } else {
                weakSelf.tableView.scrollEnabled = NO;
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
            if (idArr.count == 0) {
            } else {
                [weakSelf loadDataWithActivities:idArr];
                weakSelf.tableView.scrollEnabled = YES;
                weakSelf.contentsortVc.view.hidden = YES;
                [weakSelf.sortingView clean];
            };
        };
        [self addChildVc:_contentsortVc];
        _contentsortVc.view.frame = CGRectMake(0, DDFitHeight(220.f), self.view.frame.size.width, kScreenHeight);
        [self.tableView addSubview:_contentsortVc.view];
        _contentsortVc.view.hidden = YES;
    }
    return _contentsortVc;
}


- (LSRegionDumpsVC *)regionDumpsVc {
    WeakSelf(weakSelf);
    if (!_regionDumpsVc) {
        _regionDumpsVc = [[LSRegionDumpsVC alloc] init];
        _regionDumpsVc.confirmSort = ^(NSString *lon, NSString *lat) {
            [weakSelf loadDataWithPosition_lat:lat position_lon:lon];
            weakSelf.tableView.scrollEnabled = YES;
            weakSelf.regionDumpsVc.view.hidden = YES;
            [weakSelf.sortingView clean];
        };
        _regionDumpsVc.selectRangeSort = ^(NSString *range) {
            [weakSelf loadDataWithRange:range];
            weakSelf.tableView.scrollEnabled = YES;
            weakSelf.regionDumpsVc.view.hidden = YES;
            [weakSelf.sortingView clean];
        };
        [self addChildVc:_regionDumpsVc];
        _regionDumpsVc.view.frame = CGRectMake(0, DDFitHeight(220.f), self.view.frame.size.width, kScreenHeight);
        [self.tableView addSubview:_regionDumpsVc.view];
        _regionDumpsVc.view.hidden = YES;
    }
    return _regionDumpsVc;
}

- (LSHomwTimeSortVC *)timesortVc {
    WeakSelf(weakSelf);
    if (!_timesortVc) {
        _timesortVc = [[LSHomwTimeSortVC alloc] init];
        _timesortVc.confirmSort = ^(NSString *begin_time, NSString *end_time) {
            [weakSelf loadDataWithBegin_time:begin_time end_time:end_time];
            weakSelf.tableView.scrollEnabled = YES;
            weakSelf.timesortVc.view.hidden = YES;
            [weakSelf.sortingView clean];
        };
        [self addChildVc:_timesortVc];
        _timesortVc.view.frame = CGRectMake(0, DDFitHeight(220.f), self.view.frame.size.width, kScreenHeight - kNavigationBarHeight);
        [self.tableView addSubview:_timesortVc.view];
        _timesortVc.view.hidden = YES;
    }
    return _timesortVc;
}

#pragma mark  -  请求数据
- (void)loadData {
    page = 1;
    [super loadData];
    self.old_end = nil;
    self.old_begin = nil;
    self.old_lat = nil;
    self.old_lon = nil;
    self.old_text = nil;
    self.old_range = nil;
    self.old_activities = nil;
    [MBProgressHUD showLoading:self.view];
    [DDTJHttpRequest getDeskListsWithToken:[DDUserDefault objectForKey:@"token"] activity:nil page:page lat:[DDUserSingleton shareInstance].latitude lon:[DDUserSingleton shareInstance].longitude position_lat:nil position_lon:nil begin_time:nil end_time:nil range:nil text:nil order1:nil order2:nil block:^(NSDictionary *dict) {
        [MBProgressHUD hideAllHUDsInView:self.view];
        _dataArray = [DDTableModel mj_objectArrayWithKeyValuesArray:dict[@"table"]];
        [self dealToData];
    } failure:^{
        [self.emptyView showInView:self.view];
    }];
    
    [DDTJHttpRequest headerBannerWithToken:[DDUserDefault objectForKey:@"token"] block:^(NSDictionary *dict) {
        self.bannerImgArray = [DDBannerModel mj_objectArrayWithKeyValuesArray:dict];
        if (self.bannerImgArray.count) {
            self.headerView.modelArray = self.bannerImgArray;
            WeakSelf(weakSelf);
            weakSelf.headerView.bannerViewGoToPageHandle = ^(DDBannerViewCell *cell, DDBannerModel *bannerUrlModel) {
                NSLog(@"您点击了%@",bannerUrlModel.title);
            };
            [self.tableView reloadData];
        }
    } failure:^{
        //
    }];
}

- (void)tj_refresh {
    page = 1;
    self.old_end = nil;
    self.old_begin = nil;
    self.old_lat = nil;
    self.old_lon = nil;
    self.old_text = nil;
    self.old_range = nil;
    self.old_activities = nil;
    if (self.btns.count > 0 && self.btns) {
        for (UIButton *btn in self.btns) {
            [btn setTitleColor:kCommonGrayTextColor forState:UIControlStateNormal];
        }
        self.sortLabel.text = @"▲\n▼";
        self.sortLabel.textColor = kCommonGrayTextColor;
    }
    [DDTJHttpRequest getDeskListsWithToken:TOKEN activity:nil page:page lat:[DDUserSingleton shareInstance].latitude lon:[DDUserSingleton shareInstance].longitude position_lat:nil position_lon:nil begin_time:nil end_time:nil range:nil text:nil order1:nil order2:nil block:^(NSDictionary *dict) {
        [self tj_endRefresh];
        _dataArray = [DDTableModel mj_objectArrayWithKeyValuesArray:dict[@"table"]];
        [self dealToData];
    } failure:^{
        [self.emptyView showInView:self.view];
    }];
}
static NSInteger page = 1;

- (void)tj_loadMore {
    page ++;
    [DDTJHttpRequest getDeskListsWithToken:TOKEN activity:self.old_activities page:page lat:[DDUserSingleton shareInstance].latitude lon:[DDUserSingleton shareInstance].longitude position_lat:self.old_lat position_lon:self.old_lon begin_time:self.old_begin end_time:self.old_end range:self.old_range text:self.old_text order1:self.order2  order2:self.order2  block:^(NSDictionary *dict) {
        [_dataArray addObjectsFromArray:[DDTableModel mj_objectArrayWithKeyValuesArray:dict[@"table"]]];;
        [self dealToData];
    } failure:^{
        [self.emptyView showInView:self.view];
    }];
}

- (void)loadDataWithRange:(NSString *)range{
    self.old_end = nil;
    self.old_begin = nil;
    self.old_lat = nil;
    self.old_lon = nil;
    self.old_text = nil;
    self.old_range = range;
    self.old_activities = nil;
    [self loadConditionsDataWithOrder1:nil order2:nil];
}

- (void)loadDataWithBegin_time:(NSString *)begin_time end_time:(NSString *)end_time {
    self.old_end = end_time;
    self.old_begin = begin_time;
    self.old_lat = nil;
    self.old_lon = nil;
    self.old_text = nil;
    self.old_range = nil;
    self.old_activities = nil;
    [self loadConditionsDataWithOrder1:nil order2:nil];
}

- (void)loadDataWithActivities:(NSArray *)activities {
    self.old_end = nil;
    self.old_begin = nil;
    self.old_lat = nil;
    self.old_lon = nil;
    self.old_text = nil;
    self.old_range = nil;
    self.old_activities = activities;
    [self loadConditionsDataWithOrder1:nil order2:nil];
}

- (void)loadDataWithPosition_lat:(NSString *)lat position_lon:(NSString *)lon {
    self.old_end = nil;
    self.old_begin = nil;
    self.old_lat = lat;
    self.old_lon = lon;
    self.old_text = nil;
    self.old_range = nil;
    self.old_activities = nil;
    [self loadConditionsDataWithOrder1:nil order2:nil];
}

- (void)loadConditionsDataWithOrder1:(NSString *)order1 order2:(NSString *)order2{
    self.order1 = order1;
    self.order2 = order2;
    [DDTJHttpRequest getDeskListsWithToken:TOKEN activity:self.old_activities page:page lat:[DDUserSingleton shareInstance].latitude lon:[DDUserSingleton shareInstance].longitude position_lat:self.old_lat position_lon:self.old_lon begin_time:self.old_begin end_time:self.old_end range:self.old_range text:self.old_text order1:self.order1 order2:self.order2  block:^(NSDictionary *dict) {
        _dataArray = [DDTableModel mj_objectArrayWithKeyValuesArray:dict[@"table"]];
        [self dealToData];
    } failure:^{
        [self.emptyView showInView:self.view];
    }];
}

- (void)searchActivitiesByText:(NSString *)text {
    self.old_end = nil;
    self.old_begin = nil;
    self.old_lat = nil;
    self.old_lon = nil;
    self.old_text = text;
    self.old_range = nil;
    self.old_activities = nil;
    [self loadConditionsDataWithOrder1:nil order2:nil];
}

- (void)dealToData {
    if (_dataArray.count == 0) {
        [self.emptyView showInView:self.view];
    }else{
        [self.emptyView removeFromSuperview];
    }
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end









