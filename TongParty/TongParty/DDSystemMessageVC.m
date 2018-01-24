//
//  DDSystemMessageVC.m
//  TongParty
//
//  Created by 方冬冬 on 2017/12/18.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDSystemMessageVC.h"
#import "DDSysMsgTableViewCell.h"
#import "LSSystemMessageEntity.h"
#import "WKWebViewVC.h"
@interface DDSystemMessageVC ()
@property (nonatomic, weak) DDCustomCommonEmptyView *emptyView;
@end

@implementation DDSystemMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationWithTitle:@"系统消息"];
    [self loadData];
}
// 设置子视图
- (void)setUpViews {
    //    self.sepLineColor = kSeperatorColor;
    self.refreshType = DDBaseTableVcRefreshTypeOnlyCanRefresh;
}

- (void)loadData {
    [super loadData];
    [self showLoadingAnimation];
    [DDTJHttpRequest getMessageContentWithToken:TOKEN mid:@"1" tid:nil block:^(NSDictionary *dict) {
        [self hideLoadingAnimation];
        _dataArray = [LSSystemMessageEntity mj_objectArrayWithKeyValuesArray:dict];
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

-(void)tj_refresh {
    [DDTJHttpRequest getMessageContentWithToken:TOKEN mid:@"1" tid:nil block:^(NSDictionary *dict) {
        [self tj_endRefresh];
        _dataArray = [DDMessageModel mj_objectArrayWithKeyValuesArray:dict];
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
    DDSysMsgTableViewCell *cell = [DDSysMsgTableViewCell cellWithTableView:self.tableView];
    [cell updateWithModel:_dataArray[indexPath.row]];
    return cell;
}

- (CGFloat)tj_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return DDFitHeight(280.f);
}
- (void)tj_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(DDBaseTableViewCell *)cell {
    LSSystemMessageEntity *entity = _dataArray[indexPath.row];
    WKWebViewVC *vc = [[WKWebViewVC alloc] init];
    vc.requestUrl = entity.url;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end




