//
//  LSManageAddressVC.m
//  TongParty
//
//  Created by 刘帅 on 2017/10/28.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSManageAddressVC.h"
#import "LSAddressTableViewCell.h"
#import "LSEditAddressVC.h"

@interface LSManageAddressVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView  *tableview;
@property (nonatomic, strong)UIButton     *btn_addNewAddress;
@end

@implementation LSManageAddressVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavi];
    [self setupViews];
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
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableview;
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
    
}

#pragma mark - tableview data source + delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return DDFitHeight(100.f);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return DDFitHeight(10.f);
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
    cell.onClickBlcok = ^(NSInteger index) {
        switch (index) {
            case 0:{
                NSLog(@"编辑地点");
                 [self.navigationController pushViewController:[[LSEditAddressVC alloc] init] animated:YES];
            }break;
            case 1:{
                NSLog(@"删除地点");
            }break;
            default:
                break;
        }
    };
    return cell;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
