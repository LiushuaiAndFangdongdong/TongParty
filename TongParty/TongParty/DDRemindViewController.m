//
//  DDRemindViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/29.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDRemindViewController.h"
#import "DDSettingTableViewCell.h"

@interface DDRemindViewController ()

@end

@implementation DDRemindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationWithTitle:@"提醒设置"];
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
    return 2;
}

- (NSInteger)tj_numberOfRowsInSection:(NSInteger)section {
    return 1;
}
//-(UIView *)tj_headerAtSection:(NSInteger)section{
//    UIView *headerView = [[UIView alloc] init];
//    return headerView;
//}
- (DDBaseTableViewCell *)tj_cellAtIndexPath:(NSIndexPath *)indexPath {
    DDSettingTableViewCell *cell = [DDSettingTableViewCell cellWithTableView:self.tableView];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.style = DDSettingCellStyleSwitch;
    if (indexPath.section == 0) {
        cell.namestring  = @"声音";
    }else if (indexPath.section == 1){
        cell.namestring  = @"振动";
    }else{
    }
    return cell;
}

- (CGFloat)tj_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
-(CGFloat)tj_sectionHeaderHeightAtSection:(NSInteger)section{
    return 10;
}
- (void)tj_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(DDBaseTableViewCell *)cell {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end







