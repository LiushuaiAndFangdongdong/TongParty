//
//  DDJoinedVc.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/21.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDJoinedVc.h"
#import "DDInterestTableViewCell.h"
#import "DDTableModel.h"
//#import "DDCustomCommonEmptyView.h"
#import "DDDeskShowViewController.h"  //桌子页面

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
    [super loadData];
     [self showLoadingAnimation];
    [DDTJHttpRequest getJoinedDeskWithToken:TOKEN lat:@"" lon:@"" block:^(NSDictionary *dict) {
        [self hideLoadingAnimation];
        _dataArray = [DDTableModel mj_objectArrayWithKeyValuesArray:dict];
        if (_dataArray.count == 0) {
            [self.emptyView showInView:self.view];
        }else{
            [self.tableView reloadData];
        }
    } failure:^{
        [self.emptyView showInView:self.view];
    }];
}
- (DDCustomCommonEmptyView *)emptyView {
    if (!_emptyView) {
        DDCustomCommonEmptyView *empty = [[DDCustomCommonEmptyView alloc] initWithTitle:@"暂无数据" secondTitle:@"不好意思，网络跟您开了一个玩笑了" iconname:@"nocontent"];
        [self.view addSubview:empty];
        _emptyView = empty;
    }
    return _emptyView;
}

- (void)tj_refresh {
    [DDTJHttpRequest getJoinedDeskWithToken:TOKEN lat:@"" lon:@"" block:^(NSDictionary *dict) {
        _dataArray = [DDTableModel mj_objectArrayWithKeyValuesArray:dict];
        [self tj_endRefresh];
        if (_dataArray.count == 0) {
            [self.emptyView showInView:self.view];
        }else{
            [self.tableView reloadData];
        }
    } failure:^{
        [self.emptyView showInView:self.view];
    }];
}

- (void)tj_loadMore {
    [DDTJHttpRequest getJoinedDeskWithToken:TOKEN lat:@"" lon:@"" block:^(NSDictionary *dict) {
        _dataArray = [DDTableModel mj_objectArrayWithKeyValuesArray:dict];
        [self tj_endLoadMore];
        if (_dataArray.count == 0) {
            [self.emptyView showInView:self.view];
        }else{
            [self.tableView reloadData];
        }
    } failure:^{
        [self.emptyView showInView:self.view];
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
    [cell updateWithModel:_dataArray[indexPath.row]];
    return cell;
}

- (CGFloat)tj_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 145;
}
- (void)tj_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(DDBaseTableViewCell *)cell {
    DDTableModel *model = _dataArray[indexPath.row];
    DDDeskShowViewController *deskShowVC = [[DDDeskShowViewController alloc] init];
    deskShowVC.tmpModel   = model;
    [self.navigationController pushViewController:deskShowVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end








