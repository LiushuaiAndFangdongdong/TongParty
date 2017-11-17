//
//  LSCreateDeskVC.m
//  TongParty
//
//  Created by 刘帅 on 2017/10/28.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSCreateDeskVC.h"
#import "LSCreateDeskTableViewCell.h"
#import "LSManageAddressVC.h"
#import "LSRecommendAddressVC.h"

@interface LSCreateDeskVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView  *tableview;
@property (nonatomic, strong)UIButton     *btn_createDesk;

@end

@implementation LSCreateDeskVC

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
    
    [self navigationWithTitle:@"创桌"];
    self.navigationItem.leftBarButtonItem = [self backButtonForNavigationBarWithAction:@selector(dismiss)];
    self.view.backgroundColor = kBgWhiteGrayColor;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)setupViews {
    WeakSelf(weakSelf);

    [self.view addSubview:self.tableview];
    [self.view addSubview:self.btn_createDesk];
    [_btn_createDesk mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.right.left.equalTo(weakSelf.view);
        make.height.mas_equalTo(DDFitHeight(45.f));
    }];
}


#pragma mark - getter

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

- (UIButton *)btn_createDesk {
    
    if (!_btn_createDesk) {
        _btn_createDesk = [[UIButton alloc] init];
        [_btn_createDesk addTarget:self action:@selector(didSelectedToCreateDesk:) forControlEvents:UIControlEventTouchUpInside];
        [_btn_createDesk setTitle:@"创建桌子" forState:UIControlStateNormal];
        [_btn_createDesk setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _btn_createDesk.backgroundColor = kRGBColor(118.f, 213.f, 113.f);
        _btn_createDesk.titleLabel.font = DDFitFont(16.f);
    }
    return _btn_createDesk;
}

// 创建桌子
- (void)didSelectedToCreateDesk:(UIButton *)sender {
    
}


#pragma mark - tableview data source + delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:{
            return DDFitHeight(140.f);
        } break;
        case 1:{
            return DDFitHeight(330.f);
        } break;
        case 2:{
            return DDFitHeight(210.f);
        } break;
        case 3:{
            return DDFitHeight(190.f);
        } break;
        case 4:{
            return DDFitHeight(70.f);
        } break;
        default:
            break;
    }
    return 0.1f;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section== 0 || section == 1 || section == 2 || section == 3 || section == 4) {
        return DDFitHeight(10.f);
    }
    return 0.000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == 4) {
        return DDFitHeight(10.f);
    }
    return 0.000001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    LSCreateDeskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[LSCreateDeskTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.onClickBlcok = ^(NSInteger index) {
        switch (index) {
            case 0:{
                NSLog(@"推荐地点");
                [self.navigationController pushViewController:[[LSRecommendAddressVC alloc] init] animated:YES];
            }break;
            case 1:{
                NSLog(@"管理地点");
                [self.navigationController pushViewController:[[LSManageAddressVC alloc] init] animated:YES];
            }break;
            default:
                break;
        }
    };
    switch (indexPath.section) {
        case 0:{
            cell.style = LSCreateCellSytleActionAndTheme;
        } break;
        case 1:{
            cell.style = LSCreateCellSytleTimeAndAddress;
            // 造标签数据
            NSArray *labelArr = @[@"KTV",@"咖啡厅",@"家",@"公司",@"酒吧",@"球场",@"夜店",@"餐厅",@"夜总会",@"公园",@"水吧",@"俱乐部",@"茶馆"];
            [cell updateWithObj:labelArr];
        } break;
        case 2:{
            cell.style = LSCreateCellSytleMembersEstimatePerCapita;
        } break;
        case 3:{
            cell.style = LSCreateCellSytleDescription;
        } break;
        case 4:{
            cell.style = LSCreateCellSytleIsJoinDesk;
        } break;
        default:
            break;
    }
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
