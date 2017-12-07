
//
//  DDInviteFriedsViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/12/7.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDInviteFriedsViewController.h"
#import "DDInviteFriendCell.h"
#import "DDCustomCommonEmptyView.h"
#import "DDInviteFriendModel.h"
#import "LSCouponView.h"                //弹窗加入券和申请券

@interface DDInviteFriedsViewController ()
@property (nonatomic, weak) DDCustomCommonEmptyView *emptyView;
@property (nonatomic, strong) NSMutableArray *friedsArr;
@property (nonatomic, strong) NSMutableArray *caredArr;
@end

@implementation DDInviteFriedsViewController
@synthesize tid;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationWithTitle:@"邀请好友"];
    [self setUpViews];
    [self loadData];
}

// 设置子视图
- (void)setUpViews {
    self.sepLineColor = kSeperatorColor;
    self.refreshType = DDBaseTableVcRefreshTypeNone;
}

#pragma mark  -  请求数据
- (void)loadData {
    [super loadData];
    [self showLoadingAnimation];
    [DDTJHttpRequest inviteFriendsListsWithToken:TOKEN block:^(NSDictionary *dict) {
        [self hideLoadingAnimation];
        _friedsArr = [DDInviteFriendModel mj_objectArrayWithKeyValuesArray:dict[@"friends"]];
        _caredArr = [DDInviteFriendModel mj_objectArrayWithKeyValuesArray:dict[@"likes"]];
        if (_friedsArr.count == 0 && _caredArr.count == 0) {
            [self.emptyView showInView:self.view];
        }else{
            [self.tableView reloadData];
        }
    } failure:^{
        [self.emptyView showInView:self.view];
    }];
}
- (DDCustomCommonEmptyView *)emptyView {
    if (!_emptyView) {
        DDCustomCommonEmptyView *empty = [[DDCustomCommonEmptyView alloc] initWithTitle:@"暂无数据" secondTitle:@"不好意思，网络跟您开了一个玩笑了" iconname:@"nocontent"];
        [self.view addSubview:empty];
        _emptyView = empty;
    }
    return _emptyView;
}
#pragma mark - UITableViewDelegate
- (NSInteger)tj_numberOfSections {
    return 2;
}

- (NSInteger)tj_numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return _friedsArr.count;
    }else if (section == 1){
        return _caredArr.count;
    }else{
        return 0;
    }
}

- (CGFloat)tj_sectionHeaderHeightAtSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else if (section == 1){
        return 40;
    }else{
        return 0;
    }
}

- (UIView *)tj_headerAtSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc] init];
    if (section==0) {
    }else if (section == 1){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
        label.text = @"我的关注";
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = kGrayColor;
        label.font = kFont(13);
        [bgView addSubview:label];
    }
    return bgView;
}

- (DDBaseTableViewCell *)tj_cellAtIndexPath:(NSIndexPath *)indexPath {
    DDInviteFriendCell *cell = [DDInviteFriendCell cellWithTableView:self.tableView];
    if (indexPath.section == 0) {
        DDInviteFriendModel *m = _friedsArr[indexPath.row];
        [cell updateDataWithModel:m];
        cell.inviteClickBlcok = ^{
            [self inviteFriendsWithFid:m.friend_id];
        };
    }else if (indexPath.section == 1){
        DDInviteFriendModel *m = _caredArr[indexPath.row];
        [cell updateDataWithModel:m];
        cell.inviteClickBlcok = ^{
            [self inviteFriendsWithFid:m.friend_id];
        };
    }else{}
    return cell;
}

//邀请好友
- (void)inviteFriendsWithFid:(NSString *)fid{
    
    // 1邀请  0加入 // 控件中信息被打包成dict 返回。。
    [[LSCouponView shareInstance] showCouponViewOnWindowWithType:1 doneBlock:^(NSDictionary *dict) {
        [DDTJHttpRequest inviteFriendJoinDeskWithToken:TOKEN tid:tid fid:fid block:^(NSDictionary *dict) {
            NSLog(@"邀请好友%@",dict);
        } failure:^{
            //
        }];
    }];
}

- (CGFloat)tj_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}
- (void)tj_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(DDBaseTableViewCell *)cell {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end









