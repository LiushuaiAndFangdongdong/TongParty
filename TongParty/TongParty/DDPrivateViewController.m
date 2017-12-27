
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
#import "LSPrivateEntity.h"
@interface DDPrivateViewController ()
@end

@implementation DDPrivateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationWithTitle:@"隐私"];
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
        if (indexPath.row == 0) {
            [self pushPermissonVCWith:@"phone"];
        }
        if (indexPath.row == 1) {
            [self pushPermissonVCWith:@"addr"];
        }
        if (indexPath.row == 2) {
            [self pushPermissonVCWith:@"desk"];
        }
        if (indexPath.row == 3) {
            [self pushPermissonVCWith:@"photo"];
        }
        
    }else{
    }
}
-(void)pushBlackListVC {
    DDBlackListViewController *blist = [[DDBlackListViewController alloc] init];
    [self.navigationController pushViewController:blist animated:YES];
}
-(void)pushPermissonVCWith:(NSString *)name{
    [DDTJHttpRequest getPrivacyblock:^(NSDictionary *dict) {
        NSString *status = dict[name];
        DDPermissonViewController *permissonVC =[[DDPermissonViewController alloc] init];
        permissonVC.name = name;
        permissonVC.statu = status;
        [self.navigationController pushViewController:permissonVC animated:YES];
    } failure:^{
        
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end







