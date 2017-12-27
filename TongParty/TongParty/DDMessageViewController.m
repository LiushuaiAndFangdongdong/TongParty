
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
        _masterMsgArray = [DDMessageModel mj_objectArrayWithKeyValuesArray:dict[@"ct"]];
        _joinMsgArray = [DDMessageModel mj_objectArrayWithKeyValuesArray:dict[@"jt"]];
        _otherMsgArray = [DDMessageModel mj_objectArrayWithKeyValuesArray:dict[@"other"]];
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
    int a1 = (int)_masterMsgArray.count;
    int a2 = (int)_joinMsgArray.count;
    int a3 = (int)_otherMsgArray.count;
    if (a1 == 0 && a2 == 0 && a3 == 0) {
        return 0;
    }else if ((a1 == 0 && a2 >0 && a3 > 0) || (a1 > 0 && a2 ==0 && a3 > 0) || (a1 > 0 && a2 >0 && a3 == 0)){
        return 2;
    }else if ((a1 == 0 && a2 ==0 && a3 > 0) || (a1 == 0 && a2 >0 && a3 == 0) || (a1 > 0 && a2 ==0 && a3 == 0)){
        return 1;
    }else if (a1 > 0 && a2 > 0 && a3 > 0){
        return 3;
    }
    else{
        return 0;
    }
}

- (NSInteger)tj_numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _masterMsgArray.count;
    }else if (section == 1){
        return _joinMsgArray.count;
    }else if (section == 2){
        return _otherMsgArray.count;
    }else{return 0;}
}

- (DDBaseTableViewCell *)tj_cellAtIndexPath:(NSIndexPath *)indexPath {
    DDJoinDeskMessageCell *cell = [DDJoinDeskMessageCell cellWithTableView:self.tableView];
    if (indexPath.section == 0) {
        [cell updateMessageCellWithModel:_masterMsgArray[indexPath.row]];
    }
   else if (indexPath.section == 1) {
        [cell updateMessageCellWithModel:_joinMsgArray[indexPath.row]];
    }
   else if (indexPath.section == 2) {
        [cell updateMessageCellWithModel:_otherMsgArray[indexPath.row]];
   }else{}
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







