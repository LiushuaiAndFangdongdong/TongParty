//
//  DDHomeListViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/15.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDHomeListViewController.h"
#import "DDBannerView.h"       //banner
#import "DDHomeListRequest.h"  //request
#import "DDInterestTableViewCell.h"
#import "DDTableModel.h"
#import "DDBannerModel.h"
#import "DOPDropDownMenu.h"    //下拉筛选菜单
#import "DDCustomCommonEmptyView.h"

@interface DDHomeListViewController ()<DOPDropDownMenuDataSource,DOPDropDownMenuDelegate>
/** 轮播图数据数组*/
@property (nonatomic, strong) NSMutableArray *bannerImgArray;
/** 头部视图*/
@property (nonatomic, strong) DDBannerView *headerView;

//----------------------------------------------------
@property (nonatomic, strong) NSArray *classifys;
@property (nonatomic, strong) NSArray *cates;
@property (nonatomic, strong) NSArray *movices;
@property (nonatomic, strong) NSArray *hostels;
@property (nonatomic, strong) NSArray *areas;
@property (nonatomic, strong) NSArray *sorts;
@property (nonatomic, weak) DOPDropDownMenu *menu;
@property (nonatomic, weak) DOPDropDownMenu *menuB;
//----------------------------------------------------

@property (nonatomic, weak) DDCustomCommonEmptyView *emptyView;
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
        _headerView = [[DDBannerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 180)];
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
    // 请求数据
    [self loadData];
}

#pragma mark - 出现
- (void)viewDidLoad {
    [super viewDidLoad];

    [self initSelectData];
    // 设置子视图
    [self setUpViews];
}

-(void)initSelectData{
  
    // 数据
    self.classifys = @[@"美食",@"今日新单",@"电影",@"酒店"];
    self.cates = @[@"内容",@"快餐",@"火锅",@"日韩料理",@"西餐",@"烧烤小吃"];
    self.movices = @[@"内地剧",@"港台剧",@"英美剧"];
    self.hostels = @[@"经济酒店",@"商务酒店",@"连锁酒店",@"度假酒店",@"公寓酒店"];
    self.areas = @[@"时间",@"芙蓉区",@"雨花区",@"天心区",@"开福区",@"岳麓区"];
    self.sorts = @[@"位置",@"离我最近",@"好评优先",@"人气优先",@"最新发布"];
}
// 设置子视图
- (void)setUpViews {
    self.sepLineColor = kSeperatorColor;
    self.refreshType = DDBaseTableVcRefreshTypeRefreshAndLoadMore;
}

#pragma mark  -  请求数据
- (void)loadData {
    [super loadData];
    [MBProgressHUD showLoading:self.view];
    [DDTJHttpRequest getDeskListsWithToken:[DDUserDefault objectForKey:@"token"] activity:@"0" page:1 lat:@"" lon:@"" position_lat:@"" position_lon:@"" begin_time:@"" block:^(NSDictionary *dict) {
        [MBProgressHUD hideAllHUDsInView:self.view];
        _dataArray = [DDTableModel mj_objectArrayWithKeyValuesArray:dict[@"table"]];
        if (_dataArray.count == 0) {
            [self.emptyView showInView:self.view];
        }else{
            [self.tableView reloadData];
        }
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

#pragma mark - UITableViewDelegate
- (NSInteger)tj_numberOfSections {
    return 1;
}

- (NSInteger)tj_numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (DDBaseTableViewCell *)tj_cellAtIndexPath:(NSIndexPath *)indexPath {
    DDInterestTableViewCell *cell = [DDInterestTableViewCell cellWithTableView:self.tableView];
//    cell.elementModel = self.dataArray[indexPath.row];
    [cell updateWithModel:_dataArray[indexPath.row]];
    return cell;
}

- (CGFloat)tj_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 145;
}
- (CGFloat)tj_sectionHeaderHeightAtSection:(NSInteger)section {
    return 44;
}

- (void)tj_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(DDBaseTableViewCell *)cell {
//    NHDiscoverCategoryElement *elementModel = self.dataArray[indexPath.row];
//    NHDiscoverTopicViewController *topic = [[NHDiscoverTopicViewController alloc] initWithCategoryElement:elementModel];
//    //    [[NHDiscoverTopicViewController alloc] initWithCatogoryId:elementModel.ID];
//    [self pushVc:topic];
}

- (UIView *)tj_headerAtSection:(NSInteger)section {

    // 添加下拉菜单
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:44];
    menu.delegate = self;
    menu.dataSource = self;
    menu.layer.borderWidth = 0.24;
    menu.layer.borderColor = [UIColor grayColor].CGColor;
//    [self.view addSubview:menu];
    _menu = menu;
    //当下拉菜单收回时的回调，用于网络请求新的数据
    _menu.finishedBlock=^(DOPIndexPath *indexPath){
        if (indexPath.item >= 0) {
            NSLog(@"收起:点击了 %ld - %ld - %ld 项目",(long)indexPath.column,(long)indexPath.row,indexPath.item);
        }else {
            NSLog(@"收起:点击了 %ld - %ld 项目",(long)indexPath.column,(long)indexPath.row);
        }
    };
    //     创建menu 第一次显示 不会调用点击代理，可以用这个手动调用
    //    [menu selectDefalutIndexPath];
    [menu selectIndexPath:[DOPIndexPath indexPathWithCol:0 row:0 item:0]];
    
    
    return menu;
}
//- (void)menuReloadData
//{
//    self.classifys = @[@"美食",@"今日新单",@"电影"];
//    [_menu reloadData];
//}

#pragma mark  -DOPDropDownMenuDataSource \DOPDropDownMenuDelegate

- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu
{
    return 3;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column
{
    if (column == 0) {
        return self.classifys.count;
    }else if (column == 1){
        return self.areas.count;
    }else {
        return self.sorts.count;
    }
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        return self.classifys[indexPath.row];
    } else if (indexPath.column == 1){
        return self.areas[indexPath.row];
    } else {
        return self.sorts[indexPath.row];
    }
}

// new datasource
- (NSString *)menu:(DOPDropDownMenu *)menu imageNameForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0 || indexPath.column == 1) {
        return [NSString stringWithFormat:@"ic_filter_category_%ld",(long)indexPath.row];
    }
    return nil;
}

- (NSString *)menu:(DOPDropDownMenu *)menu imageNameForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0 && indexPath.item >= 0) {
        return [NSString stringWithFormat:@"ic_filter_category_%ld",(long)indexPath.item];
    }
    return nil;
}

// new datasource

- (NSString *)menu:(DOPDropDownMenu *)menu detailTextForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column < 2) {
        return [@(arc4random()%1000) stringValue];
    }
    return nil;
}

- (NSString *)menu:(DOPDropDownMenu *)menu detailTextForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
{
    return [@(arc4random()%1000) stringValue];
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfItemsInRow:(NSInteger)row column:(NSInteger)column
{
    if (column == 0) {
        if (row == 0) {
            return self.cates.count;
        } else if (row == 2){
            return self.movices.count;
        } else if (row == 3){
            return self.hostels.count;
        }
    }
    return 0;
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        if (indexPath.row == 0) {
            return self.cates[indexPath.item];
        } else if (indexPath.row == 2){
            return self.movices[indexPath.item];
        } else if (indexPath.row == 3){
            return self.hostels[indexPath.item];
        }
    }
    return nil;
}

- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.item >= 0) {
        NSLog(@"点击了 %ld - %ld - (long)%ld 项目",(long)indexPath.column,indexPath.row,indexPath.item);
    }else {
        NSLog(@"点击了 %ld - (long)%ld 项目",(long)indexPath.column,indexPath.row);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end









