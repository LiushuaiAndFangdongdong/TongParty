//
//  LSEditAddressVC.m
//  TongParty
//
//  Created by 刘帅 on 2017/10/29.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSEditAddressVC.h"
#import "LSEditAddressTableViewCell.h"

@interface LSEditAddressVC ()
<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView  *tableview;
@property (nonatomic, strong)UIButton     *btn_saveAddress;
@end

@implementation LSEditAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavi];
    [self setupViews];
}

- (void)setupNavi {
    [self navigationWithTitle:@"编辑地址"];
    self.navigationItem.leftBarButtonItem = [self backButtonForNavigationBarWithAction:@selector(pop)];
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, DDFitWidth(40.f), DDFitHeight(20.f))];
    [rightBtn setTitle:@"删除" forState:UIControlStateNormal];
    [rightBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
    rightBtn.titleLabel.font = DDFitFont(14.f);
    [rightBtn addTarget:self action:@selector(deleteAddress:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.view.backgroundColor = kBgWhiteGrayColor;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)setupViews {
    WeakSelf(weakSelf);
    
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.btn_saveAddress];
    [_btn_saveAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.left.equalTo(weakSelf.view);
        make.height.mas_equalTo(DDFitHeight(45.f));
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
        _tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableview;
}

- (UIButton *)btn_saveAddress {
    
    if (!_btn_saveAddress) {
        _btn_saveAddress = [[UIButton alloc] init];
        [_btn_saveAddress addTarget:self action:@selector(didSelectedToSaveNewAddress:) forControlEvents:UIControlEventTouchUpInside];
        [_btn_saveAddress setTitle:@"保存地址" forState:UIControlStateNormal];
        [_btn_saveAddress setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _btn_saveAddress.backgroundColor = kRGBColor(118.f, 213.f, 113.f);
        _btn_saveAddress.titleLabel.font = DDFitFont(16.f);
    }
    return _btn_saveAddress;
}


- (void)didSelectedToSaveNewAddress:(UIButton *)sender {
    // 保存地址
}

- (void)deleteAddress:(UIButton *)sender {
    // 删除地址
}

#pragma mark - tableview data source + delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 2) {
        return DDFitHeight(100.f);
    }
    return DDFitHeight(45.f);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return DDFitHeight(5.f);
    }
    return 0.000000000001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    LSEditAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[LSEditAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    if (indexPath.row == 0) {
        cell.style = LSCreateCellSytleAddressLable;
    }
    
    if (indexPath.row == 1) {
        cell.style = LSCreateCellSytleEditAddress;
    }
    
    if (indexPath.row == 2) {
        cell.style = LSCreateCellSytleLableManager;
    }
    
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
