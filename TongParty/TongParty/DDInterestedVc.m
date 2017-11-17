//
//  DDInterestedVc.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/21.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDInterestedVc.h"
#import "DDHomeListRequest.h"  //request
#import "DDHomeListTableCell.h"//cell
#import "NHDiscoverModel.h"    //model
#import "UIViewController+Loading.h"
#import "DDCustomCommonEmptyView.h"
#import "DDDeskShowViewController.h"  //桌子页面

@interface DDInterestedVc ()
@property (nonatomic, weak) DDCustomCommonEmptyView *emptyView;
@end

@implementation DDInterestedVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpViews];
    [self loadData];
}
// 设置子视图
- (void)setUpViews {
    self.sepLineColor = kSeperatorColor;
    self.refreshType = DDBaseTableVcRefreshTypeRefreshAndLoadMore;
}

#pragma mark  -  请求数据
- (void)loadData {
    [self showLoadingView];
    [super loadData];
    DDHomeListRequest *request = [DDHomeListRequest tj_request];
    request.tj_url = kNHDiscoverHotListAPI;
    [request tj_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
        [self hideLoadingView];
        if (success) {
            NHDiscoverModel *discoverModel = [NHDiscoverModel modelWithDictionary:response];
            self.dataArray = discoverModel.categories.category_list;
            [self.tableView reloadData];
        }else{
            [self.emptyView showInView:self.view];
        }
    }];
}
- (DDCustomCommonEmptyView *)emptyView {
    if (!_emptyView) {
        DDCustomCommonEmptyView *empty = [[DDCustomCommonEmptyView alloc] initWithTitle:@"" secondTitle:@"" iconname:@"nocontent"];
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
    DDHomeListTableCell *cell = [DDHomeListTableCell cellWithTableView:self.tableView];
    cell.elementModel = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tj_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}
- (void)tj_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(DDBaseTableViewCell *)cell {
    DDDeskShowViewController *deskShowVC = [[DDDeskShowViewController alloc] init];
    [self.navigationController pushViewController:deskShowVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
