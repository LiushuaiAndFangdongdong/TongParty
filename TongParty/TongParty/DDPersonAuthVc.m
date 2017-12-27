//
//  DDPersonAuthVc.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/28.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDPersonAuthVc.h"
#import "DDPersonAuthTableViewCell.h"
#import "DDSesameAuthVc.h"
#import "DDRealNameAuthVc.h"

@interface DDPersonAuthVc ()

@end

@implementation DDPersonAuthVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationWithTitle:@"个人认证"];
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
    DDPersonAuthTableViewCell *cell = [DDPersonAuthTableViewCell cellWithTableView:self.tableView];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0) {
        cell.iconstring = @"personAuth_real_alipay";
        cell.namestring = @"芝麻认证";
    }
    if (indexPath.row == 1) {
        cell.iconstring = @"personAuth_real_avatar";
        cell.namestring = @"实名认证";
        if (_currentModel.is_valid.integerValue == 1) {
            cell.statustring = @"已认证";
        }
    }else{
    }
    return cell;
}

- (CGFloat)tj_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (void)tj_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(DDBaseTableViewCell *)cell {
    if (indexPath.row == 0) {
        //芝麻认证
        [self pushSesameAuthVC];
    }
    if (indexPath.row == 1) {
        if (_currentModel.is_valid.integerValue == 1) {
            return;
        }
        //实名认证
        [self pushRealNameAuthVC];
    }
}

#pragma mark - push
-(void)pushSesameAuthVC{
    DDSesameAuthVc *sesameVc = [[DDSesameAuthVc alloc] init];
    [self pushtoVC:sesameVc];
}

-(void)pushRealNameAuthVC{
    DDRealNameAuthVc *realVC = [[DDRealNameAuthVc alloc ] init];
    [self pushtoVC:realVC];
}
-(void)pushtoVC:(UIViewController *)controller{
    [self.navigationController pushViewController:controller animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end












