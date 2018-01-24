
//
//  DDReplyMessageVC.m
//  TongParty
//
//  Created by 方冬冬 on 2017/12/18.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDReplyMessageVC.h"
#import "DDReplyMessageCell.h"
#import "LSPersonEntity.h"
@interface DDReplyMessageVC ()
@property (nonatomic, weak) DDCustomCommonEmptyView *emptyView;
@end

@implementation DDReplyMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpViews];
}
// 设置子视图
- (void)setUpViews {
    self.sepLineColor = kSeperatorColor;
    self.refreshType = DDBaseTableVcRefreshTypeOnlyCanRefresh;
}

#pragma mark  -  请求数据
- (void)loadData {
    [super loadData];
    [DDTJHttpRequest deskApplyUserListWithToken:TOKEN tid:_messageModel.tid lon:[DDUserSingleton shareInstance].longitude lat:[DDUserSingleton shareInstance].latitude block:^(NSDictionary *dict) {
        _dataArray = [LSPersonEntity mj_objectArrayWithKeyValuesArray:dict];
        if (_dataArray.count == 0) {
            [self.emptyView showInView:self.view];
        }else{
            [self.emptyView removeFromSuperview];
            if (_members) {
                _members([NSString stringWithFormat:@"%ld人",_dataArray.count]);
            }
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
///tongju/api/examine_join_table.php
- (DDBaseTableViewCell *)tj_cellAtIndexPath:(NSIndexPath *)indexPath {
    WeakSelf(weakSelf);
    DDReplyMessageCell *cell = [DDReplyMessageCell cellWithTableView:self.tableView];
    cell.agree = ^(NSString *sid) {
        [weakSelf agree:sid];
    };
    cell.disagree = ^(NSString *sid) {
        [weakSelf disagree:sid];
    };
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
}

- (void)tj_refresh {
    [DDTJHttpRequest deskApplyUserListWithToken:TOKEN tid:_messageModel.tid lon:[DDUserSingleton shareInstance].longitude lat:[DDUserSingleton shareInstance].latitude block:^(NSDictionary *dict) {
        [self tj_endRefresh];
        _dataArray = [LSPersonEntity mj_objectArrayWithKeyValuesArray:dict];
        if (_dataArray.count == 0) {
            [self.emptyView showInView:self.view];
        }else{
            [self.emptyView removeFromSuperview];
        }
        if (_members) {
            if (_dataArray.count == 0) {
                _members(nil);
            } else {
                _members([NSString stringWithFormat:@"%ld人",_dataArray.count]);
            }
        }
        [self.tableView reloadData];
    } failure:^{
        [self.emptyView showInView:self.view];
    }];
}


- (void)setMessageModel:(DDMessageModel *)messageModel {
    _messageModel = messageModel;
    [self showLoadingAnimation];
    [DDTJHttpRequest deskApplyUserListWithToken:TOKEN tid:_messageModel.tid lon:[DDUserSingleton shareInstance].longitude lat:[DDUserSingleton shareInstance].latitude block:^(NSDictionary *dict) {
        [self hideLoadingAnimation];
        _dataArray = [LSPersonEntity mj_objectArrayWithKeyValuesArray:dict];
        if (_dataArray.count == 0) {
            [self.emptyView showInView:self.view];
        }else{
            [self.emptyView removeFromSuperview];
        }
        if (_members) {
            if (_dataArray.count == 0) {
                _members(nil);
            } else {
                _members([NSString stringWithFormat:@"%ld人",_dataArray.count]);
            }
        }
        [self.tableView reloadData];
    } failure:^{
        [self.emptyView showInView:self.view];
    }];
}

// 同意
- (void)agree:(NSString *)sid {
    [DDTJHttpRequest masterCheckApplicantWithToken:TOKEN tid:_messageModel.tid sid:sid m:@"1" block:^(NSDictionary *dict) {
        [self loadData];
    } failure:^{
        
    }];
}

// 不同意
- (void)disagree:(NSString *)sid {
    [DDTJHttpRequest masterCheckApplicantWithToken:TOKEN tid:_messageModel.tid sid:sid m:@"2" block:^(NSDictionary *dict) {
        [self loadData];
    } failure:^{
        
    }];
}

@end




