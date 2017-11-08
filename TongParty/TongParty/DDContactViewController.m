
//
//  DDContactViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/29.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDContactViewController.h"
#import "DDSettingTableViewCell.h"

@interface DDContactViewController ()

@end

@implementation DDContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navItemTitle = @"联系方式";
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
    if (section == 0) {
        return 3;
    }else if (section == 1){
        return 2;
    }else{
        return 0;
    }
}
- (DDBaseTableViewCell *)tj_cellAtIndexPath:(NSIndexPath *)indexPath {
    DDSettingTableViewCell *cell = [DDSettingTableViewCell cellWithTableView:self.tableView];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.style = DDSettingCellStyleNormal;
    cell.valueColor = kGreenColor;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.namestring = @"微信服务号";
            cell.valuestring = @"hello_tongju";
        }
        if (indexPath.row == 1) {
            cell.namestring = @"客服电话";
            cell.valuestring = @"010-897-8767";
        }
        if (indexPath.row == 2) {
            cell.namestring = @"客服邮箱";
            cell.valuestring = @"kf@tongju.com";
        }else{
        }
    }else if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            cell.namestring  =@"商务合作";
            cell.valuestring = @"market@tongju.com";
        }
        if (indexPath.row == 1) {
            cell.namestring  = @"加入我们";
            cell.valuestring = @"HR@tongju.com";
        }else{
        }
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






