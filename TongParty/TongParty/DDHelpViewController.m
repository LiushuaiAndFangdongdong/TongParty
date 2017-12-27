
//
//  DDHelpViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/29.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDHelpViewController.h"
#import "DDSettingTableViewCell.h"
#import "DDContactViewController.h"

@interface DDHelpViewController ()

@end

@implementation DDHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationWithTitle:@"帮助"];
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
    if (section == 0) {
        return 2;
    }else if (section == 1){
        return 1;
    }else{
        return 0;
    }
}
- (DDBaseTableViewCell *)tj_cellAtIndexPath:(NSIndexPath *)indexPath {
    DDSettingTableViewCell *cell = [DDSettingTableViewCell cellWithTableView:self.tableView];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.style = DDSettingCellStyleNormal;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.namestring = @"用户条款";
        }else{
            cell.namestring = @"行为规范";
        }
    }else if (indexPath.section == 1)
    {
        cell.namestring = @"联系方式";
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
    if (indexPath.section == 0) {
        //
    }
    if (indexPath.section == 1) {
        [self pushContactVC];
    }else{
    }
}

-(void)pushContactVC {
    DDContactViewController *contactVC = [[DDContactViewController alloc] init];
    [self.navigationController pushViewController:contactVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end





