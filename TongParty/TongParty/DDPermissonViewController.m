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
    [self navigationWithTitle:@"设置隐私"];
    self.navLeftItem = [self backButtonForNavigationBarWithAction:@selector(pop)];
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
    cell.style = DDSingleSelectStyleSelectImg;
    if (indexPath.row == 0) {
        if (_statu.integerValue == 0) {
            cell.ra_btn.checked = YES;
        }
        cell.namestring = @"公开所有人";
    }
    if (indexPath.row == 1) {
        if (_statu.integerValue == 1) {
            cell.ra_btn.checked = YES;
        }
        cell.namestring = @"仅好友可见";
    }
    if (indexPath.row == 2) {
        if (_statu.integerValue == 2) {
            cell.ra_btn.checked = YES;
        }
        cell.namestring = @"所有人都不可见";
    }
    cell.setPrivacy = ^(NSString *statu) {
        
        [DDTJHttpRequest editUserPrivacyName:_name status:statu block:^(NSDictionary *dict) {
            
        } failure:^{
            
        }];
    };
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









