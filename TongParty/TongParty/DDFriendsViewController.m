//
//  DDFriendsViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/27.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDFriendsViewController.h"
#import "DDFriendsTableViewCell.h"
#import "LSPlayRewardEntity.h"
#import "LSAddFriendVC.h"
#import "LSFriendEntity.h"
#import "DDHisHerViewController.h"
#import "LSCareEntity.h"
@interface DDFriendsViewController ()
@property (nonatomic, strong)LSAddFriendVC  *addFriendVC;
@end

@implementation DDFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self setUpViews];
}
#pragma mark  -  请求数据
- (void)loadData {
    //[self showLoadingAnimation];
    [super loadData];
    switch (_style) {
        case DDFriendsStyleNormal: {
            if (_type == DDFriendCurrentUserStyle) {
                [DDTJHttpRequest getFriendsListWithToken:[DDUserSingleton shareInstance].token block:^(NSDictionary *dict) {
                    [self hideLoadingAnimation];
                    self.dataArray = [LSFriendEntity mj_objectArrayWithKeyValuesArray:dict];
                    [self tj_reloadData];
                } failure:^{
                    
                }];
            } else {
                // 他人朋友列表
            }
            
        }break;
        case DDFriendsStyleCare:{
            if (_type == DDFriendCurrentUserStyle) {
                [DDTJHttpRequest getCareListblock:^(NSDictionary *dict) {
                    self.dataArray = [LSCareEntity mj_objectArrayWithKeyValuesArray:dict];
                    [self tj_reloadData];
                } failure:^{
                    
                }];
            } else {
                // 他人关注列表
            }
            
        }break;
        case DDFriendsStyleCared: {
            if (_type == DDFriendCurrentUserStyle) {
                [DDTJHttpRequest getCaredListblock:^(NSDictionary *dict) {
                    self.dataArray = [LSCareEntity mj_objectArrayWithKeyValuesArray:dict];
                    [self tj_reloadData];
                } failure:^{
                    
                }];
            } else {
                // 他人被关注列表
                [DDTJHttpRequest getOhterCaredListByFid:_fid block:^(NSDictionary *dict) {
                    self.dataArray = [LSCareEntity mj_objectArrayWithKeyValuesArray:dict];
                    [self tj_reloadData];
                } failure:^{
                    
                }];
            }
            
        }
            break;
        case DDFriendsStyleReward: {
            // 打赏明细
            [DDTJHttpRequest getRewardRecordWithToken:[DDUserSingleton shareInstance].token block:^(NSDictionary *dict) {
                self.dataArray = [LSPlayRewardEntity mj_objectArrayWithKeyValuesArray:dict];
                [self tj_reloadData];
            } failure:^{
                
            }];
        }
            break;
        case DDFriendsStyleBlackList: {
        }
            break;
        default:
            break;
    }
}

// 下拉
- (void)tj_refresh {
    [self loadData];
    [self tj_endRefresh];
}

// 上拉
- (void)tj_loadMore {
    [self tj_endLoadMore];
}

// 设置子视图
- (void)setUpViews {
    self.sepLineColor = kSeperatorColor;
    self.refreshType = DDBaseTableVcRefreshTypeRefreshAndLoadMore;
    self.navigationItem.leftBarButtonItem = [self backButtonForNavigationBarWithAction:@selector(pop)];
    switch (_style) {
        case DDFriendsStyleNormal: {
            [self navigationWithTitle:@"好友"];
            self.navigationItem.rightBarButtonItem = [self customButtonForNavigationBarWithAction:@selector(addFriendToList:) imageNamed:@"friend_add" isRedPoint:NO pointValue:nil CGSizeMake:CGSizeMake(DDFitWidth(20.f), DDFitWidth(20.f))];
        }
            break;
        case DDFriendsStyleCare: {
            [self navigationWithTitle:@"关注"];
        }
            break;
        case DDFriendsStyleCared: {
            [self navigationWithTitle:@"被关注"];
        }
            break;
        case DDFriendsStyleReward: {
            [self navigationWithTitle:@"打赏明细"];
        }
            break;
        case DDFriendsStyleBlackList: {
            [self navigationWithTitle:@"黑名单"];
        }
            break;
        default:
            break;
    }
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
    //    cell.elementModel = self.dataArray[indexPath.row];
    if (_style == DDFriendsStyleNormal) {
        cell.style = DDFriendsCellStyleNormal;
        [cell updateWithEntity:self.dataArray[indexPath.row]];
    }
    if (_style == DDFriendsStyleCare) {
        cell.style = DDFriendsCellStyleCare;
        [cell updateWithEntity:self.dataArray[indexPath.row]];
    }
    if (_style == DDFriendsStyleCared) {
        cell.style = DDFriendsCellStyleCared;
        [cell updateWithEntity:self.dataArray[indexPath.row]];
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
    if (_style == DDFriendsStyleNormal) {
        LSFriendEntity *entity = self.dataArray[indexPath.row];
        DDHisHerViewController *hisVC = [[DDHisHerViewController alloc] init];
        hisVC.fid = entity.friend_id;
        [self.navigationController pushViewController:hisVC animated:YES];
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_style == DDFriendsStyleNormal) {
        return YES;
    }
    return NO;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除好友";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete){
        LSFriendEntity *entity = self.dataArray[indexPath.row];
        [DDTJHttpRequest deleteFriendWithToken:[DDUserSingleton shareInstance].token fid:entity.friend_id block:^(NSDictionary *dict) {
            [self loadData];
        } failure:^{
            
        }];
    }
}


#pragma mark - 添加好友
- (void)addFriendToList:(UIBarButtonItem *)sender {
    [self.navigationController pushViewController:self.addFriendVC animated:YES];
}

- (LSAddFriendVC *)addFriendVC {
    if (!_addFriendVC) {
        _addFriendVC = [[LSAddFriendVC alloc] init];
    }
    return _addFriendVC;
}


- (UIBarButtonItem *)backButtonForNavigationBarWithAction:(SEL)action {
    UIImage *image = [[UIImage imageNamed:@"back_tj"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *btnBar = [[UIBarButtonItem alloc] initWithImage:image
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:action];
    return btnBar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end










