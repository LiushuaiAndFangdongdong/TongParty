//
//  LSManageAddressVC.m
//  TongParty
//
//  Created by 刘帅 on 2017/10/28.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSManageAddressVC.h"
#import "LSAddressTableViewCell.h"
#import "DDAddressModel.h"
#import "DDCustomCommonEmptyView.h"
#import "DDEditAddrViewController.h"

@interface LSManageAddressVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView  *tableview;
@property (nonatomic, strong)UIButton     *btn_addNewAddress;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, weak) DDCustomCommonEmptyView *emptyView;
@end

@implementation LSManageAddressVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavi];
    [self setupViews];
}

- (void)loadData{
    if (_emptyView) {
        [_emptyView removeFromSuperview];
    }
    [MBProgressHUD showLoading:self.view];
    [DDTJHttpRequest getCustomAddressListWithToken:TOKEN block:^(NSDictionary *dict) {
        [MBProgressHUD hideAllHUDsInView:self.view];
        _dataArray = [DDAddressModel mj_objectArrayWithKeyValuesArray:dict];
        if (_dataArray.count == 0) {
            [self.emptyView showInView:self.view];
        }else{
             [_tableview reloadData];
        }
    } failure:^{
        [self.emptyView showInView:self.view];
    }];
}

- (void)setupNavi {
    [self navigationWithTitle:@"选择活动地址"];
    self.navigationItem.leftBarButtonItem = [self backButtonForNavigationBarWithAction:@selector(pop)];
    self.view.backgroundColor = kBgWhiteGrayColor;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)setupViews {
    WeakSelf(weakSelf);
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.btn_addNewAddress];
    [_btn_addNewAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.left.equalTo(weakSelf.view);
        make.height.mas_equalTo(kTabBarHeight);
    }];
}

#pragma mark -  懒加载
- (UITableView *)tableview{
    if (!_tableview) {
        self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - DDFitHeight(110.f)) style:UITableViewStyleGrouped];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.estimatedRowHeight = 0;
        _tableview.estimatedSectionHeaderHeight = 0;
        _tableview.estimatedSectionFooterHeight = 0;
        _tableview.showsVerticalScrollIndicator = NO;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableview;
}

- (DDCustomCommonEmptyView *)emptyView {
    if (!_emptyView) {
        DDCustomCommonEmptyView *empty = [[DDCustomCommonEmptyView alloc] initWithTitle:@"暂无数据" secondTitle:@"不好意思，网络跟您开了一个玩笑了" iconname:@"nocontent"];
        [self.view addSubview:empty];
        _emptyView = empty;
    }
    return _emptyView;
}

- (UIButton *)btn_addNewAddress {
    
    if (!_btn_addNewAddress) {
        _btn_addNewAddress = [[UIButton alloc] init];
        [_btn_addNewAddress addTarget:self action:@selector(didSelectedToAddNewAddress:) forControlEvents:UIControlEventTouchUpInside];
        [_btn_addNewAddress setTitle:@"添加新地址" forState:UIControlStateNormal];
        [_btn_addNewAddress setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _btn_addNewAddress.backgroundColor = kRGBColor(118.f, 213.f, 113.f);
        _btn_addNewAddress.titleLabel.font = DDFitFont(16.f);
    }
    return _btn_addNewAddress;
}

// 添加新地址
- (void)didSelectedToAddNewAddress:(UIButton *)sender {
    [self pushEditVCWithTitle:@"新增地址" model:nil];
}

#pragma mark - tableview data source + delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return DDFitHeight(90.f);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return DDFitHeight(5.f);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.000001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    LSAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[LSAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [cell updateWithModel:_dataArray[indexPath.section]];
    cell.onClickBlcok = ^(NSInteger index) {
        switch (index) {
            case 0:{
                NSLog(@"编辑地点");
                [self pushEditVCWithTitle:@"编辑地址" model:_dataArray[indexPath.section]];
            }break;
            case 1:{
                NSLog(@"删除地点");
                [self deleteAddressWithIndexPath:indexPath];
            }break;
            default:
                break;
        }
    };
    cell.setDefaultBlcok = ^{
        [self setDefaultAddrWithIndexPath:indexPath];
    };
    return cell;
}

//设置默认
- (void)setDefaultAddrWithIndexPath:(NSIndexPath *)indexPath{
    DDAddressModel *model = _dataArray[indexPath.section];
    [MBProgressHUD showLoading:self.view];
    [DDTJHttpRequest setDefaultAddressWithToken:TOKEN aid:model.id block:^(NSDictionary *dict) {
        [MBProgressHUD hideAllHUDsInView:self.view];
    } failure:^{
        //
    }];
}

//删除
- (void)deleteAddressWithIndexPath:(NSIndexPath *)indexPath{
    DDAddressModel *model = _dataArray[indexPath.section];
    [MBProgressHUD showLoading:self.view];
    [DDTJHttpRequest deleteCustomAddressWithToken:TOKEN aid:model.id block:^(NSDictionary *dict) {
        [MBProgressHUD hideAllHUDsInView:self.view];
        [_dataArray removeObjectAtIndex:indexPath.section];
        [_tableview deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationMiddle];
        [_tableview reloadData];
        if (_dataArray.count == 0) {
            [self.emptyView showInView:self.view];
        }
    } failure:^{
        //
    }];
}

- (void)pushEditVCWithTitle:(NSString *)title model:(DDAddressModel *)model{

    DDEditAddrViewController *editVC = [[DDEditAddrViewController alloc] init];
    editVC.titleStr = title;
    editVC.tmpModel = model;
    [self.navigationController pushViewController:editVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
