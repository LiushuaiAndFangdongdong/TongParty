
//
//  DDMessageViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/11/27.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDMessageViewController.h"
#import "DDJoinDeskMessageCell.h"
#import "DDNoticeMessageCell.h"

@interface DDMessageViewController ()

@end

@implementation DDMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationWithTitle:@"消息通知"];
    
    [DDTJHttpRequest getMessageNumWithToken:TOKEN block:^(NSDictionary *dict) {
        NSLog(@"未读消息数量%@",dict);
    } failure:^{
        //
    }];
    
    [DDTJHttpRequest getMessageListsWithToken:TOKEN block:^(NSDictionary *dict) {
        NSLog(@"消息列表%@",dict);
    } failure:^{
        //
    }];
    
//    [DDTJHttpRequest getUserLabelListsWithToken:TOKEN block:^(NSDictionary *dict) {
//        NSLog(@"用户列表");
//    } failure:^{
//        //
//    }];
    
//    [DDTJHttpRequest getUserRechargeInfoWithToken:TOKEN block:^(NSDictionary *dict) {
//        NSLog(@"用户充值信息");
//    } failure:^{
//        //
//    }];
    
//    [DDTJHttpRequest getRewardRecordWithToken:TOKEN block:^(NSDictionary *dict) {
//        NSLog(@"获取打赏记录");
//    } failure:^{
//        //
//    }];
    
//    [DDTJHttpRequest getOthersRewardRecordWithToken:TOKEN fid:@"1" block:^(NSDictionary *dict) {
//        NSLog(@"获取他人打赏记录");
//    } failure:^{
//        //
//    }];
    
    [self setUpViews];
}

// 设置子视图
- (void)setUpViews {
    self.sepLineColor = kBgWhiteGrayColor;
    self.refreshType = DDBaseTableVcRefreshTypeRefreshAndLoadMore;
}
#pragma mark - UITableViewDelegate
- (NSInteger)tj_numberOfSections {
    return 1;
}

- (NSInteger)tj_numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (DDBaseTableViewCell *)tj_cellAtIndexPath:(NSIndexPath *)indexPath {
    DDNoticeMessageCell *cell = [DDNoticeMessageCell cellWithTableView:self.tableView];
//    cell.elementModel = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tj_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tj_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(DDBaseTableViewCell *)cell {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end







