//
//  DDFriendsViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/27.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDFriendsViewController.h"
#import "DDFriendsTableViewCell.h"

@interface DDFriendsViewController ()

@end

@implementation DDFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self loadData];
    [self setUpViews];
    switch (_style) {
        case DDFriendsStyleNormal:
        {
            self.navItemTitle = @"好友";
        }
            break;
        case DDFriendsStyleCare:
        {
            self.navItemTitle = @"关注";
        }
            break;
        case DDFriendsStyleCared:
        {
            self.navItemTitle = @"被关注";
        }
            break;
        case DDFriendsStyleReward:
        {
            self.navItemTitle = @"打赏明细";
        }
            break;
        case DDFriendsStyleBlackList:
        {
            self.navItemTitle = @"黑名单";
        }
            break;
        default:
            break;
    }
}
#pragma mark  -  请求数据
//- (void)loadData {
//    [self showLoadingAnimation];
//    [super loadData];
//    DDHomeListRequest *request = [DDHomeListRequest tj_request];
//    request.tj_url = kNHDiscoverHotListAPI;
//    [request tj_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
//        [self hideLoadingAnimation];
//        if (success) {
//            NHDiscoverModel *discoverModel = [NHDiscoverModel modelWithDictionary:response];
//            self.dataArray = discoverModel.categories.category_list;
//            [self.tableView reloadData];
//        }else{
//            [self.emptyView showInView:self.view];
//        }
//    }];
//}
// 设置子视图
- (void)setUpViews {
    self.sepLineColor = kSeperatorColor;
    self.refreshType = DDBaseTableVcRefreshTypeRefreshAndLoadMore;
}
#pragma mark - UITableViewDelegate
- (NSInteger)tj_numberOfSections {
    return 1;
}

- (NSInteger)tj_numberOfRowsInSection:(NSInteger)section {
//    return self.dataArray.count;
    return 10;
}

- (DDBaseTableViewCell *)tj_cellAtIndexPath:(NSIndexPath *)indexPath {
    DDFriendsTableViewCell *cell = [DDFriendsTableViewCell cellWithTableView:self.tableView];
//    cell.elementModel = self.dataArray[indexPath.row];
    if (_style == DDFriendsStyleNormal) {
        cell.style = DDFriendsCellStyleNormal;
    }
    if (_style == DDFriendsStyleCare) {
        cell.style = DDFriendsCellStyleCare;
    }
    if (_style == DDFriendsStyleCared) {
        cell.style = DDFriendsCellStyleCared;
    }
    if (_style == DDFriendsStyleReward) {
        cell.style = DDFriendsCellStyleReward;
    }
   else if (_style == DDFriendsStyleBlackList) {
        cell.style = DDFriendsCellStyleBlackList;
    }
    return cell;
}

- (CGFloat)tj_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}
- (void)tj_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(DDBaseTableViewCell *)cell {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end










