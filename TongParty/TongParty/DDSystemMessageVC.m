//
//  DDSystemMessageVC.m
//  TongParty
//
//  Created by 方冬冬 on 2017/12/18.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDSystemMessageVC.h"
#import "DDSysMsgTableViewCell.h"

@interface DDSystemMessageVC ()
@property (nonatomic, weak) DDCustomCommonEmptyView *emptyView;
@end

@implementation DDSystemMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationWithTitle:@"系统消息"];
}
// 设置子视图
- (void)setUpViews {
//    self.sepLineColor = kSeperatorColor;
    self.refreshType = DDBaseTableVcRefreshTypeOnlyCanRefresh;
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
    //    return self.dataArray.count;
    return 10;
}

- (DDBaseTableViewCell *)tj_cellAtIndexPath:(NSIndexPath *)indexPath {
    DDSysMsgTableViewCell *cell = [DDSysMsgTableViewCell cellWithTableView:self.tableView];
    //    [cell updateWithModel:_dataArray[indexPath.row]];
    return cell;
}

- (CGFloat)tj_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 300;
}
- (void)tj_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(DDBaseTableViewCell *)cell {
    //    DDTableModel *model = _dataArray[indexPath.row];
    //    DDDeskShowViewController *deskShowVC = [[DDDeskShowViewController alloc] init];
    //    deskShowVC.tmpModel   = model;
    //    [self.navigationController pushViewController:deskShowVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end




