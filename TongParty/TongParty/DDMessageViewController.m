
//
//  DDMessageViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/11/27.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDMessageViewController.h"
#import "DDJoinDeskMessageCell.h"//
#import "DDMessageModel.h"       //model
#import "DDMasterMessageVC.h"
#import "DDSystemMessageVC.h"
#import "DDNoticeMessageVC.h"

@interface DDMessageViewController ()
@property (nonatomic, strong) NSMutableArray *masterMsgArray; //桌主消息
@property (nonatomic, strong) NSMutableArray *joinMsgArray;   //参加桌子消息
@property (nonatomic, strong) NSMutableArray *otherMsgArray;  //其他消息
@end

@implementation DDMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationWithTitle:@"消息通知"];
    [self setUpViews];
    [self loadData];
}

-(void)loadData{
    [super loadData];
    [DDTJHttpRequest getMessageListsWithToken:TOKEN block:^(NSDictionary *dict) {
        
        NSLog(@"消息列表%@",dict);
        _dataArray = [NSMutableArray array];
        _masterMsgArray = [DDMessageModel mj_objectArrayWithKeyValuesArray:dict[@"ct"]];
        if (_masterMsgArray.count > 0) {
            [_dataArray addObject:_masterMsgArray];
        }
        _joinMsgArray = [DDMessageModel mj_objectArrayWithKeyValuesArray:dict[@"jt"]];
        if (_joinMsgArray.count > 0) {
            [_dataArray addObject:_joinMsgArray];
        }
        _otherMsgArray = [DDMessageModel mj_objectArrayWithKeyValuesArray:dict[@"other"]];
        if (_otherMsgArray.count > 0) {
            [_dataArray addObject:_otherMsgArray];
        }
        [self.tableView reloadData];
    } failure:^{
        //
    }];
}

- (void)tj_refresh {
    [DDTJHttpRequest getMessageListsWithToken:TOKEN block:^(NSDictionary *dict) {
        [self tj_endRefresh];
        [_dataArray removeAllObjects];
        _dataArray = [NSMutableArray array];
        _masterMsgArray = [DDMessageModel mj_objectArrayWithKeyValuesArray:dict[@"ct"]];
        if (_masterMsgArray.count > 0) {
            [_dataArray addObject:_masterMsgArray];
        }
        _joinMsgArray = [DDMessageModel mj_objectArrayWithKeyValuesArray:dict[@"jt"]];
        if (_joinMsgArray.count > 0) {
            [_dataArray addObject:_joinMsgArray];
        }
        _otherMsgArray = [DDMessageModel mj_objectArrayWithKeyValuesArray:dict[@"other"]];
        if (_otherMsgArray.count > 0) {
            [_dataArray addObject:_otherMsgArray];
        }
        [self.tableView reloadData];
    } failure:^{
        //
    }];
}

// 设置子视图
- (void)setUpViews {
    self.sepLineColor = kBgWhiteGrayColor;
    self.refreshType = DDBaseTableVcRefreshTypeRefreshAndLoadMore;
    //        self.tableView.backgroundColor = kRedColor;
}
#pragma mark - UITableViewDelegate
- (NSInteger)tj_numberOfSections {
    return _dataArray.count;
}

- (NSInteger)tj_numberOfRowsInSection:(NSInteger)section {
    return [_dataArray[section] count];
}

- (DDBaseTableViewCell *)tj_cellAtIndexPath:(NSIndexPath *)indexPath {
    DDJoinDeskMessageCell *cell = [DDJoinDeskMessageCell cellWithTableView:self.tableView];
    [cell updateMessageCellWithModel:_dataArray[indexPath.section][indexPath.row]];
    return cell;
}

- (CGFloat)tj_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tj_sectionHeaderHeightAtSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return 8;
    }
}

- (void)tj_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(DDBaseTableViewCell *)cell {
    DDMessageModel *model = self.dataArray[indexPath.section][indexPath.row];
    if ([_joinMsgArray containsObject:model]) {
        DDNoticeMessageVC *noticeMsgVC = [[DDNoticeMessageVC alloc] init];
        noticeMsgVC.messageModel = model;
        [self.navigationController pushViewController:noticeMsgVC animated:YES];
    }
    
    if ([_otherMsgArray containsObject:model]) {
        DDSystemMessageVC *sysMsgVC = [[DDSystemMessageVC alloc] init];
        sysMsgVC.messageModel = model;
        [self.navigationController pushViewController:sysMsgVC animated:YES];
    }
    
    if ([_masterMsgArray containsObject:model]) {
        DDMasterMessageVC *masterMsgVC = [[DDMasterMessageVC alloc] init];
        masterMsgVC.messageModel = model;
        [self.navigationController pushViewController:masterMsgVC animated:YES];
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除消息";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete){
        DDMessageModel *model = self.dataArray[indexPath.section][indexPath.row];
        
        [DDTJHttpRequest deleteMessageWithToken:TOKEN mid:model.mid block:^(NSDictionary *dict) {
            [self tj_refresh];
        } failure:^{ }];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [kNotificationCenter postNotificationName:@"loadMessageCount" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end







