//
//  DDAboutViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/29.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDAboutViewController.h"
#import "DDSettingTableViewCell.h"

@interface DDAboutViewController ()

@end

@implementation DDAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationWithTitle:@"关于桐聚"];
    self.navigationItem.leftBarButtonItem = [self backButtonForNavigationBarWithAction:@selector(pop)];
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
    return 2;
}
- (DDBaseTableViewCell *)tj_cellAtIndexPath:(NSIndexPath *)indexPath {
    DDSettingTableViewCell *cell = [DDSettingTableViewCell cellWithTableView:self.tableView];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.style = DDSettingCellStyleNormal;
    if (indexPath.row == 0) {
        cell.namestring = @"去评分";
    }else{
        cell.namestring = @"功能介绍";
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
    // Dispose of any resources that can be recreated.
}


@end





