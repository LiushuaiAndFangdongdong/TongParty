//
//  DDPermissonViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/29.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDPermissonViewController.h"
#import "DDSettingTableViewCell.h"

@interface DDPermissonViewController ()

@end

@implementation DDPermissonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navItemTitle = @"设置隐私";
    [self setUpViews];
}
// 设置子视图
- (void)setUpViews {
    self.sepLineColor = kSeperatorColor;
    self.refreshType = DDBaseTableVcRefreshTypeNone;
}
#pragma mark - UITableViewDelegate
- (NSInteger)tj_numberOfSections {
    return 1;
}

- (NSInteger)tj_numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (DDBaseTableViewCell *)tj_cellAtIndexPath:(NSIndexPath *)indexPath {
    DDSettingTableViewCell *cell = [DDSettingTableViewCell cellWithTableView:self.tableView];
    cell.accessoryType = UITableViewCellAccessoryNone;
    if (indexPath.row == 0) {
        cell.namestring = @"公开所有人";
    }
    if (indexPath.row == 1) {
        cell.namestring = @"仅好友可见";
    }
    if (indexPath.row == 2) {
        cell.namestring = @"所有人都不可见";
    }else{
    }
    return cell;
}

- (CGFloat)tj_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tj_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(DDBaseTableViewCell *)cell {
  
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end









