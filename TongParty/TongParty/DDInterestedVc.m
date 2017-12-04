//
//  DDInterestedVc.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/21.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDInterestedVc.h"
#import "DDCustomCommonEmptyView.h"
#import "DDDeskShowViewController.h"  //桌子页面
#import "DDInterestTableViewCell.h"

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
    [super loadData];
    [self showLoadingView];
    [DDTJHttpRequest getInterestedDeskWithToken:TOKEN lat:@"" lon:@"" block:^(NSDictionary *dict) {
        [self hideLoadingView];
        _dataArray = [DDTableModel mj_objectArrayWithKeyValuesArray:dict];
        if (_dataArray.count == 0) {
            [self.emptyView showInView:self.view];
        }else{
            [self.tableView reloadData];
        }
    } failure:^{
        //
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
    DDInterestTableViewCell *cell = [DDInterestTableViewCell cellWithTableView:self.tableView];
    [cell updateWithModel:_dataArray[indexPath.row]];
    return cell;
}

- (CGFloat)tj_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 145;
}
- (void)tj_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(DDBaseTableViewCell *)cell {
    DDDeskShowViewController *deskShowVC = [[DDDeskShowViewController alloc] init];
    [self.navigationController pushViewController:deskShowVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end







