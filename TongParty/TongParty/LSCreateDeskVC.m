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
//#import "DDEditAddrViewController.h"
#import "LSCreatDeskEntity.h"

@interface LSCreateDeskVC ()<UITableViewDelegate,UITableViewDataSource,LSUpLoadImageManagerDelegate>{
    BOOL isExpandPhotoCell;
}
@property (nonatomic, strong)UITableView    *tableview;
@property (nonatomic, strong)UIButton       *btn_createDesk;
@property (nonatomic, strong)NSMutableArray *label_array;
@property (nonatomic, strong)LSRecommendAddressVC *recommendVC;
@property (nonatomic, strong)LSManageAddressVC    *manageAddressVC;
@property (nonatomic, strong)NSMutableArray *photosArray;
@property (nonatomic, strong)LSCreatDeskEntity  *requestEntity;
@end
static NSString *cellId = @"cellId";
@implementation LSCreateDeskVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self setupNavi];
    [self setupViews];
}

- (void)loadData {
    _photosArray = [NSMutableArray array];
    
    //创建数据
    _requestEntity = [[LSCreatDeskEntity alloc] init];
    NSArray *labelArr = @[@"KTV",@"咖啡厅",@"家",@"公司",@"酒吧",@"球场",@"夜店",@"餐厅",@"夜总会",@"公园",@"水吧",@"俱乐部",@"茶馆"];
    _requestEntity.labels = labelArr;
    [self.tableview reloadData];
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
        make.height.mas_equalTo(kTabBarHeight);
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
        [_tableview registerClass:[LSCreateDeskTableViewCell class] forCellReuseIdentifier:cellId];
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

- (LSRecommendAddressVC *)recommendVC {
    
    if (!_recommendVC) {
        _recommendVC = [[LSRecommendAddressVC alloc] init];
    }
    return _recommendVC;
}

- (LSManageAddressVC *)manageAddressVC {
    
    if (!_manageAddressVC) {
        _manageAddressVC = [[LSManageAddressVC alloc] init];
    }
    return _manageAddressVC;
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
            if (testHeight || testHeight != 0) {
                return testHeight;
            }
            if (_requestEntity.labels.count <= 4) {
                return DDFitHeight(210.f);
            }
            if (_requestEntity.labels.count > 4) {
                return DDFitHeight(270.f);
            }
            
        } break;
        case 2:{
            return DDFitHeight(210.f);
        } break;
        case 3:{
            
            if (_requestEntity.Images.count < 4) {
                return DDFitHeight(190.f);
            }
            else {
                return DDFitHeight(275.f);
            }
            
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
static CGFloat testHeight;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LSCreateDeskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[LSCreateDeskTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    switch (indexPath.section) {
        case 0:{
            cell.style = LSCreateCellSytleActionAndTheme;
        } break;
        case 1:{
            cell.style = LSCreateCellSytleTimeAndAddress;
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
    
    [cell updateWithObj:_requestEntity];
    
    __block LSCreateDeskTableViewCell *blockCell = cell;
    cell.onClickBlcok = ^(NSInteger index) {
        switch (index) {
            case 0:{
                NSLog(@"推荐地点");
                self.recommendVC.selectedAddressResult = ^(NSString *addressString) {
                    [blockCell putStringToChildView:addressString];
                };
                [self.navigationController pushViewController:self.recommendVC animated:YES];
            }break;
            case 1:{
                NSLog(@"管理地点");
                [self.navigationController pushViewController:self.manageAddressVC animated:YES];
            }break;
            default:
                break;
        }
    };
    
    cell.expandMoreBlcok = ^(CGFloat final_height) {
        // 根据 final_height 展开全部标签
        testHeight = final_height;
        [self.tableview reloadSections:[[NSIndexSet alloc] initWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
    };

    cell.selectPhotos = ^(LSCDPhotoIV *iv_photo) {
        [LSUPLOAD_IMAGE showActionSheetInFatherViewController:self delegate:self];
    };
    cell.deleteUpdate = ^(NSInteger index) {
        [_requestEntity.Images removeObjectAtIndex:index];
        [self.tableview reloadSections:[[NSIndexSet alloc] initWithIndex:3] withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView endEditing:YES];
}


#pragma mark - LSUpLoadImageManagerDelegate
- (void)uploadImageToServerWithImage:(UIImage *)image {
    [_requestEntity.Images addObject:image];
    [self.tableview reloadSections:[[NSIndexSet alloc] initWithIndex:3] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end

