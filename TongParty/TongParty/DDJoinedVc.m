//
//  DDJoinedVc.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/21.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDJoinedVc.h"
#import "DDHomeListRequest.h"  //request
#import "DDHomeListTableCell.h"//cell
#import "NHDiscoverModel.h"    //model
#import "DDCustomCommonEmptyView.h"

@interface DDJoinedVc ()
@property (nonatomic, weak) DDCustomCommonEmptyView *emptyView;
@end

@implementation DDJoinedVc

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
// [self showLoadingAnimation];
    [super loadData];
//    DDHomeListRequest *request = [DDHomeListRequest tj_request];
//    request.tj_url = kNHDiscoverHotListAPI;
//    [request tj_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
//        [self hideLoadingAnimation];
//        if (success) {
//            NHDiscoverModel *discoverModel = [NHDiscoverModel modelWithDictionary:response];
//            self.dataArray = discoverModel.categories.category_list;
//            [self.tableView reloadData];
//        }else{
            [self.emptyView showInView:self.view];
//        }
//    }];
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
    DDHomeListTableCell *cell = [DDHomeListTableCell cellWithTableView:self.tableView];
    cell.elementModel = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tj_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}
- (void)tj_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(DDBaseTableViewCell *)cell {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end








