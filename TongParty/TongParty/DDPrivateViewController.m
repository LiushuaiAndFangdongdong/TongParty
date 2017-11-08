
//
//  DDPrivateViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/29.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDPrivateViewController.h"
#import "DDSettingTableViewCell.h"
#import "DDBlackListViewController.h"
#import "DDPermissonViewController.h"

@interface DDPrivateViewController ()

@end

@implementation DDPrivateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navItemTitle = @"隐私";
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
        return 1;
    }else if (section == 1){
        return 4;
    }else{
        return 0;
    }
}
-(UIView *)tj_headerAtSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] init];
//    headerView.backgroundColor = kLightGrayColor;
    if (section == 1) {
        UILabel *privateLabel = [[UILabel alloc] init];
        [headerView addSubview:privateLabel];
        [privateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(headerView);
            make.left.mas_equalTo(10);
        }];
        privateLabel.text = @"个人隐私";
        privateLabel.font = kFont(13);
        privateLabel.textAlignment = NSTextAlignmentLeft;
        privateLabel.textColor = kGrayColor;
    }
    return headerView;
}
- (DDBaseTableViewCell *)tj_cellAtIndexPath:(NSIndexPath *)indexPath {
    DDSettingTableViewCell *cell = [DDSettingTableViewCell cellWithTableView:self.tableView];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        cell.style = DDSettingCellStyleNormal;
        cell.namestring = @"黑名单";
    }else if (indexPath.section == 1){
        cell.style = DDSettingCellStyleNormal;
        if (indexPath.row ==0) {
            cell.namestring = @"电话";
        }
        if (indexPath.row ==1) {
            cell.namestring = @"地址";
        }
        if (indexPath.row ==2) {
            cell.namestring = @"历史桌子";
        }
        if (indexPath.row ==3) {
            cell.namestring = @"相册";
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
    if (section == 0) {
        return 10;
    }else if (section == 1){
        return 30;
    }else{
        return 0;
    }
}
- (void)tj_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(DDBaseTableViewCell *)cell {
    if (indexPath.section == 0) {
        //黑名单
        [self pushBlackListVC];
    }else if (indexPath.section == 1){
        
        
        [self pushPermissonVC];
        if (indexPath.row == 0) {
            
        }
        if (indexPath.row == 1) {
            
        }
        if (indexPath.row == 2) {
            
        }
        if (indexPath.row == 3) {
            
        }else{
        }
        
    }else{
    }
}
-(void)pushBlackListVC {
    DDBlackListViewController *blist = [[DDBlackListViewController alloc] init];
    [self.navigationController pushViewController:blist animated:YES];
}
-(void)pushPermissonVC{
    DDPermissonViewController *permissonVC =[[DDPermissonViewController alloc] init];
    [self.navigationController pushViewController:permissonVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end







