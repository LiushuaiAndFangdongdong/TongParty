
//
//  DDBlackListViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/29.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDBlackListViewController.h"
#import "DDFriendsTableViewCell.h"

@interface DDBlackListViewController ()

@end

@implementation DDBlackListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navItemTitle = @"黑名单";
    [self setUpViews];
}
// 设置子视图
- (void)setUpViews {
    self.sepLineColor = kSeperatorColor;
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
    DDFriendsTableViewCell *cell = [DDFriendsTableViewCell cellWithTableView:self.tableView];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.style = DDFriendsCellStyleBlackList;
    return cell;
}

- (CGFloat)tj_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tj_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(DDBaseTableViewCell *)cell {
}
-(void)tj_commitEditForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"删除");
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除吗？" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"删除"style:UIAlertActionStyleDestructive handler:^(UIAlertAction*action) {
//        NSLog(@"删除");
//    }];
//    [alertController addAction:cancelAction];
//    [alertController addAction:otherAction];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end









