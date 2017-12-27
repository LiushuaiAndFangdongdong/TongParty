
//
//  DDBlackListViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/29.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDBlackListViewController.h"
#import "DDFriendsTableViewCell.h"
#import "LSBlacklistEntity.h"
@interface DDBlackListViewController ()

@end

@implementation DDBlackListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self setUpViews];
}

- (void)loadData {
    [super loadData];
    [DDTJHttpRequest getblacklistblock:^(NSDictionary *dict) {
        self.dataArray = [LSBlacklistEntity mj_objectArrayWithKeyValuesArray:dict];
        [self tj_reloadData];
    } failure:^{
        
    }];
}

-(void)tj_refresh {
    [self tj_endRefresh];
    [self loadData];
}

// 设置子视图
- (void)setUpViews {
    [self navigationWithTitle:@"黑名单"];
    self.sepLineColor = kSeperatorColor;
    self.refreshType = DDBaseTableVcRefreshTypeRefreshAndLoadMore;
    self.navLeftItem = [self backButtonForNavigationBarWithAction:@selector(pop)];
}
#pragma mark - UITableViewDelegate
- (NSInteger)tj_numberOfSections {
    return 1;
}

- (NSInteger)tj_numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (DDBaseTableViewCell *)tj_cellAtIndexPath:(NSIndexPath *)indexPath {
    DDFriendsTableViewCell *cell = [DDFriendsTableViewCell cellWithTableView:self.tableView];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.style = DDFriendsCellStyleBlackList;
    [cell updateWithEntity:self.dataArray[indexPath.row]];
    
    return cell;
}

- (CGFloat)tj_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return DDFitHeight(70.f);
}

- (void)tj_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(DDBaseTableViewCell *)cell {
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"移出黑名单";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    LSBlacklistEntity *entity = self.dataArray[indexPath.row];
    if (entity) {
        [DDTJHttpRequest deleteBlacklistByfid:entity.id block:^(NSDictionary *dict) {
            [self loadData];
        } failure:^{
            
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end









