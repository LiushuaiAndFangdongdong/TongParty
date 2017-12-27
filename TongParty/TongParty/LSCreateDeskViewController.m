//
//  LSCreateDeskViewController.m
//  TongParty
//
//  Created by 刘帅 on 2017/12/23.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSCreateDeskViewController.h"
#import "LSCreateDeskCommonCell.h"
#import "LSCreateDeskAddrLabelCell.h"
#import "LSCreatDeskEntity.h"
#import "LSCreateDeskJoinCell.h"
#import "LSCreateDeskAddPicCell.h"
#import "LSManageAddressVC.h"
#import "LSRecommendAddressVC.h"
#import "DDPrefectDataVC.h"

@interface LSCreateDeskViewController ()<UITableViewDelegate,UITableViewDataSource,LSUpLoadImageManagerDelegate,UIScrollViewDelegate>
@property (nonatomic, strong)UITableView    *tableview;
@property (nonatomic, strong)UIButton       *btn_createDesk;
@property (nonatomic, strong)LSCreatDeskEntity  *requestEntity;
@property (nonatomic, strong)LSManageAddressVC    *manageAddressVC;
@property (nonatomic, strong)LSRecommendAddressVC *recommandVC;
@property (nonatomic, strong)NSMutableDictionary  *labelDict;
@end

@implementation LSCreateDeskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _requestEntity = [LSCreatDeskEntity new];
    _labelDict = [NSMutableDictionary dictionary];
    [self loadData];
    [self setupViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


// 加载数据
- (void)loadData {
    [super loadData];
    
    NSArray *labelArr = @[@"KTV",@"咖啡厅",@"家",@"公司",@"酒吧",@"球场",@"夜店",@"餐厅",@"夜总会",@"公园",@"水吧",@"俱乐部",@"茶馆"];
    [_labelDict setObject:labelArr forKey:@"array"];
    [_labelDict setObject:@"1" forKey:@"isexpand"];
    [self.tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:1]] withRowAnimation:UITableViewRowAnimationFade];
    // 获取标签
    [DDTJHttpRequest getAddrLabelsblock:^(NSDictionary *dict) {
        
    } failure:^{
        
    }];
}

- (void)setupViews {
    
    [self navigationWithTitle:@"创桌"];
    self.navigationItem.leftBarButtonItem = [self backButtonForNavigationBarWithAction:@selector(dismiss)];
    self.view.backgroundColor = kBgWhiteGrayColor;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    WeakSelf(weakSelf);
    
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.btn_createDesk];
    [_btn_createDesk mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.right.left.equalTo(weakSelf.view);
        make.height.mas_equalTo(kTabBarHeight);
    }];
}
static NSString *cellId = @"cellId";
static NSString *addrcellId = @"addrcellId";
static NSString *joinCell = @"joinCell";
static NSString *addPicCell = @"addPicCell";
#pragma mark -  懒加载
- (UITableView *)tableview{
    if (!_tableview) {
        self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - DDFitHeight(110.f)) style:UITableViewStyleGrouped];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.estimatedRowHeight = 45;
        _tableview.estimatedSectionHeaderHeight = 0;
        _tableview.estimatedSectionFooterHeight = 0;
        _tableview.showsVerticalScrollIndicator = NO;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableview registerNib:[UINib nibWithNibName:@"LSCreateDeskAddrLabelCell" bundle:nil]
         forCellReuseIdentifier:addrcellId];
        [_tableview registerClass:[LSCreateDeskJoinCell class] forCellReuseIdentifier:joinCell];
        [_tableview registerNib:[UINib nibWithNibName:@"LSCreateDeskAddPicCell" bundle:nil]
         forCellReuseIdentifier:addPicCell];
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

- (LSManageAddressVC *)manageAddressVC {
    
    if (!_manageAddressVC) {
        _manageAddressVC = [[LSManageAddressVC alloc] init];
    }
    return _manageAddressVC;
}

- (LSRecommendAddressVC *)recommandVC {
    
    if (!_recommandVC) {
        _recommandVC = [[LSRecommendAddressVC alloc] init];
    }
    return _recommandVC;
}

#pragma mark - tableview data source + delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    if (section == 1 || section == 2) {
        return 3;
    }
    if (section == 3) {
        return 2;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 2) {
        return UITableViewAutomaticDimension;
    }
    if (indexPath.section == 3 && indexPath.row == 1) {
        return UITableViewAutomaticDimension;
    }
    return 70.f;
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
    WeakSelf(weakSelf);
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", [indexPath section], [indexPath row]];
    [_tableview registerNib:[UINib nibWithNibName:@"LSCreateDeskCommonCell" bundle:nil]
     forCellReuseIdentifier:CellIdentifier];
    LSCreateDeskCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[LSCreateDeskCommonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:{// 活动
                cell.iv_action.image = kImage(@"desk_activity");
                cell.tf_action_content.placeholder = @"请选择创建桌子内容";
                cell.lbl_action_name.text = @"活动：";
                cell.didEndEdit = ^(NSString *content) {
                    _requestEntity.activity = content;
                };
            } break;
            case 1:{
                cell.iv_action.image = kImage(@"desk_subject");
                cell.tf_action_content.placeholder = @"比如：狼人杀";
                cell.lbl_action_name.text = @"主题：";
                cell.didEndEdit = ^(NSString *content) {
                    _requestEntity.title = content;
                };
            }break;
            default:
                break;
        }
    }
    
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:{// 开始时间
                cell.iv_action.image = kImage(@"desk_starttime");
                cell.tf_action_content.placeholder = @"2017年12月24日 星期二 13:00";
                cell.lbl_action_name.text = @"开始时间：";
                cell.didEndEdit = ^(NSString *content) {
                    _requestEntity.begin_time = content;
                };
            } break;
            case 1:{// 所在地点
                cell.iv_action.image = kImage(@"desk_address");
                cell.tf_action_content.placeholder = @"请选择活动地址";
                cell.lbl_action_name.text = @"所在地点：";
                cell.didEndEdit = ^(NSString *content) {
                    _requestEntity.place = content;
                };
                cell.btn_recomand.hidden = NO;
                __block LSCreateDeskCommonCell *blockCell = cell;
                cell.recommandAddressBlcok = ^{
                    [self.navigationController pushViewController:self.recommandVC animated:YES];
                };
                self.recommandVC.selectedAddressResult = ^(NSString *addressString) {
                    weakSelf.requestEntity.place = addressString;
                    blockCell.tf_action_content.text = addressString;
                };
            }break;
            case 2:{
                // 地点标签
                LSCreateDeskAddrLabelCell *acell = [tableView dequeueReusableCellWithIdentifier:addrcellId];
                if (!acell) {
                    acell = [[LSCreateDeskAddrLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addrcellId];
                }
                acell.expandMoreBlcok = ^{
                    NSString *isexpand = [_labelDict objectForKey:@"isexpand"];
                    if (isexpand.integerValue == 1) {
                        [_labelDict setObject:@"0" forKey:@"isexpand"];
                    } else {
                        [_labelDict setObject:@"1" forKey:@"isexpand"];
                    }
                    
                    [self.tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:1]] withRowAnimation:UITableViewRowAnimationFade];
                };
                acell.managerAddressBlcok = ^{
                    [self.navigationController pushViewController:self.manageAddressVC animated:YES];
                };
                acell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                [acell updatePhotoWithArray:_labelDict];
                
                
                return acell;
            }break;
            default:
                break;
        }
    }
    
    if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0:{// 人数
                cell.iv_action.image = kImage(@"desk_person");
                cell.tf_action_content.placeholder = @"活动至少两人";
                cell.lbl_action_name.text = @"人数：";
                cell.didEndEdit = ^(NSString *content) {
                    _requestEntity.person_num = content;
                };
            } break;
            case 1:{// 预估时长
                cell.iv_action.image = kImage(@"desk_duration");
                cell.tf_action_content.placeholder = @"2天2夜";
                cell.lbl_action_name.text = @"预估时长：";
                cell.didEndEdit = ^(NSString *content) {
                    _requestEntity.time_range = content;
                };
            }break;
            case 2:{// 预估人均
                cell.iv_action.image = kImage(@"desk_average_price");
                cell.tf_action_content.placeholder = @"66元/人";
                cell.lbl_action_name.text = @"预估人均：";
                cell.didEndEdit = ^(NSString *content) {
                    _requestEntity.average_price = content;
                };
            }break;
            default:
                break;
        }
    }
    
    if (indexPath.section == 3) {
        switch (indexPath.row) {
            case 0:{// 描述 横线隐藏
                cell.iv_action.image = kImage(@"desk_descri");
                cell.tf_action_content.placeholder = @"关于桌子的描述...";
                cell.lbl_action_name.text = @"描述：";
                cell.didEndEdit = ^(NSString *content) {
                    _requestEntity.dEscription = content;
                };
                cell.lbl_line.hidden = YES;
            } break;
            case 1:{// 上传图片cell
                LSCreateDeskAddPicCell *apcell = [tableView dequeueReusableCellWithIdentifier:addPicCell];
                if (!apcell) {
                    apcell = [[LSCreateDeskAddPicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addPicCell];
                }
                [apcell updatePhotoWithArray:_requestEntity.Images];
                apcell.selectPhotos = ^(LSCDPhotoIV *iv_photo) {
                    [LSUPLOAD_IMAGE showActionSheetInFatherViewController:self delegate:self];
                };
                apcell.deleteClicked = ^(NSInteger indx) {
                    
                    [_requestEntity.Images enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                        [_requestEntity.Images removeObjectAtIndex:indx];
                        *stop = YES;
                    }];
                    
                    [self.tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:3]] withRowAnimation:UITableViewRowAnimationFade];
                };
                apcell.selectionStyle = UITableViewCellSelectionStyleNone;;
                return apcell;
            }break;
            default:
                break;
        }
    }
    
    if (indexPath.section == 4) {
        // 是否加入心跳桌
        LSCreateDeskJoinCell *jcell = [tableView dequeueReusableCellWithIdentifier:joinCell];
        if (!jcell) {
            jcell = [[LSCreateDeskJoinCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:joinCell];
        }
        jcell.selectIsHeart = ^(NSString *isheart) {
            _requestEntity.is_heart = isheart;
        };
        jcell.selectionStyle = UITableViewCellSelectionStyleNone;
        return jcell;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView endEditing:YES];
    
    
}

- (void)didSelectedToCreateDesk:(UIButton *)sender {
    
    //判断资料是否完善，如果没有完善则
    DDPrefectDataVC *dataVC = [[DDPrefectDataVC alloc] init];
    [self.navigationController pushViewController:dataVC animated:YES];
    
    //资料已经完善则判断创建桌子的活动时间人数人均等信息是否为空
    
    
    
    [DDTJHttpRequest createDeskWithToken:TOKEN activity:_requestEntity.activity custom:@"" title:_requestEntity.title place:_requestEntity.place begin_time:_requestEntity.begin_time person_num:_requestEntity.person_num time_range:_requestEntity.time_range average_price:_requestEntity.average_price description:_requestEntity.dEscription is_heart:_requestEntity.is_heart latitude:@"" longitude:@"" image:_requestEntity.Images block:^(NSDictionary *dict) {
        
    } failure:^{
        
    }];
}


#pragma mark - LSUpLoadImageManagerDelegate
- (void)uploadImageToServerWithImage:(UIImage *)image {
    [_requestEntity.Images addObject:image];
    [self.tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:3]] withRowAnimation:UITableViewRowAnimationFade];
}




@end
