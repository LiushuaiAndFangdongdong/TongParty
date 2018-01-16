
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

// 设置子视图
- (void)setUpViews {
    self.sepLineColor = kBgWhiteGrayColor;
    self.refreshType = DDBaseTableVcRefreshTypeOnlyCanRefresh;
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
//    DDMasterMessageVC *masterMsgVC = [[DDMasterMessageVC alloc] init];
//    [self.navigationController pushViewController:masterMsgVC animated:YES];
    
//    DDSystemMessageVC *sysMsgVC = [[DDSystemMessageVC alloc] init];
//    [self.navigationController pushViewController:sysMsgVC animated:YES];
    
    DDNoticeMessageVC *noticeMsgVC = [[DDNoticeMessageVC alloc] init];
    [self.navigationController pushViewController:noticeMsgVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end







