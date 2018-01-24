
//
//  DDNoticeMessageVC.m
//  TongParty
//
//  Created by 方冬冬 on 2017/12/19.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDNoticeMessageVC.h"
#import "DDNoticeMsgTableViewCell.h"
#import "LSNoticeMessageEntity.h"
@interface DDNoticeMessageVC ()
@property (nonatomic, weak) DDCustomCommonEmptyView *emptyView;
@end

@implementation DDNoticeMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self navigationWithTitle:@"消息通知"];
}
// 设置子视图
- (void)setUpViews {
    self.sepLineColor = kSeperatorColor;
    self.refreshType = DDBaseTableVcRefreshTypeOnlyCanRefresh;
}

#pragma mark  -  请求数据
- (void)loadData {
    [super loadData];
    [self showLoadingAnimation];
    [DDTJHttpRequest getMessageContentWithToken:TOKEN mid:_messageModel.mid tid:_messageModel.tid block:^(NSDictionary *dict) {
        [self hideLoadingAnimation];
        _dataArray = [LSNoticeMessageEntity mj_objectArrayWithKeyValuesArray:dict];
        if (_dataArray.count == 0) {
            [self.emptyView showInView:self.view];
        }else{
            [self.emptyView removeFromSuperview];
        }
        [self.tableView reloadData];
    } failure:^{
        [self.emptyView showInView:self.view];
    }];
}

- (void)tj_refresh {
    [DDTJHttpRequest getMessageContentWithToken:TOKEN mid:_messageModel.mid tid:_messageModel.tid block:^(NSDictionary *dict) {
        [self tj_endRefresh];
        _dataArray = [LSNoticeMessageEntity mj_objectArrayWithKeyValuesArray:dict];
        if (_dataArray.count == 0) {
            [self.emptyView showInView:self.view];
        }else{
            [self.emptyView removeFromSuperview];
        }
        [self.tableView reloadData];
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
#pragma mark - UITableViewDelegate
- (NSInteger)tj_numberOfSections {
    return 1;
}

- (NSInteger)tj_numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (DDBaseTableViewCell *)tj_cellAtIndexPath:(NSIndexPath *)indexPath {
    DDNoticeMsgTableViewCell *cell = [DDNoticeMsgTableViewCell cellWithTableView:self.tableView];
    [cell updateWithModel:_dataArray[indexPath.row]];
    return cell;
}

- (CGFloat)tj_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
- (void)tj_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(DDBaseTableViewCell *)cell {
    //    DDTableModel *model = _dataArray[indexPath.row];
    //    DDDeskShowViewController *deskShowVC = [[DDDeskShowViewController alloc] init];
    //    deskShowVC.tmpModel   = model;
    //    [self.navigationController pushViewController:deskShowVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end


