//
//  DDPersonInfoVc.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/26.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDPersonInfoVc.h"
#import "DDPersonInfoTableViewCell.h"//cell
#import "DDEditInfoVC.h"   //编辑资料
#import "DDPersonLabelVc.h"//个人标签
#import "DDPickerSingle.h"
#import "DDPickerDate.h"
#import "DDPickerArea.h"
#import "DDUserInfoModel.h"

@interface DDPersonInfoVc ()<DDPickerSingleDelegate,DDPickerAreaDelegate,DDPickerDateDelegate,LSUpLoadImageManagerDelegate>
@property (nonatomic, strong) DDUserInfoModel *model;
@property (nonatomic, strong) DDUserInfoModel *uploadModel;
@end
static NSInteger seletePickerType = 0;
@implementation DDPersonInfoVc


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [kNotificationCenter postNotificationName:kUpdateUserInfoNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _uploadModel = [DDUserInfoModel new];
    [self navigationWithTitle:@"个人资料"];
    [kNotificationCenter addObserver:self selector:@selector(reloadLabel:) name:@"updateLabels" object:nil];
    [self setUpViews];
    if ([DDUserDefault objectForKey:@"token"]){
        [self getUserdetailInfo];
    }
}

- (void)getUserdetailInfo{
    //开启异步并行线程请求用户详情数据
    dispatch_queue_t queue= dispatch_queue_create("userDetailinfo", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        [DDTJHttpRequest getUserDetailInfoWithToken:[DDUserSingleton shareInstance].token block:^(NSDictionary *dict) {
            _model = [DDUserInfoModel mj_objectWithKeyValues:dict];
            [self tj_reloadData];
        } failure:^{
            //
        }];
    });
}

// 设置子视图
- (void)setUpViews {
    self.sepLineColor = kSeperatorColor;
    self.tableView.bounces = NO;
    self.refreshType = DDBaseTableVcRefreshTypeNone;
    self.navLeftItem = [self backButtonForNavigationBarWithAction:@selector(pop)];
    self.navRightItem = [self customTitleButtonForNavigationWithAction:@selector(confirmToEdit:) title:@"修改" CGSize:CGSizeMake(DDFitWidth(50.f), DDFitHeight(40.f))];
}
#pragma mark
-(NSInteger)tj_numberOfSections{
    return 3;
}
-(NSInteger)tj_numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {return 5;}else if (section == 1){return 4;}else{return 1;}
}
-(CGFloat)tj_sectionHeaderHeightAtSection:(NSInteger)section{
    if (section == 2) {
        return 30;
    }else{
        return 10;
    }
}
-(CGFloat)tj_cellheightAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 60;
        }else{
            return 50;
        }
    }else{
        return 50;
    }
}
-(UIView *)tj_headerAtSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = kBgWhiteGrayColor;
    if (section == 2) {
        UILabel *privateLabel = [[UILabel alloc] init];
        [headerView addSubview:privateLabel];
        [privateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(headerView);
            make.left.mas_equalTo(10);
        }];
        privateLabel.text = @"我的标签";
        privateLabel.font = kFont(13);
        privateLabel.textAlignment = NSTextAlignmentLeft;
        privateLabel.textColor = kGrayColor;
    }
    return headerView;
}
-(DDBaseTableViewCell *)tj_cellAtIndexPath:(NSIndexPath *)indexPath{
    DDPersonInfoTableViewCell *cell = [DDPersonInfoTableViewCell cellWithTableView:self.tableView];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.style = DDPersonInfoCellStyleAvatar;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.imageUrl = _model.image;
        }else{
            cell.style = DDPersonInfoCellStyleNormal;
            if (indexPath.row == 1) {
                cell.namestring = @"昵称";
                cell.valuestring = _model.name;
            }
            if (indexPath.row == 2) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.namestring = @"性别";
                if (_model.sex.integerValue == 0) {
                    cell.valuestring = @"保密";
                }
                if (_model.sex.integerValue == 1) {
                    cell.valuestring = @"男";
                }
                if (_model.sex.integerValue == 2) {
                    cell.valuestring = @"女";
                }
                
            }
            if (indexPath.row == 3) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.namestring = @"生日";
                cell.valuestring = _model.birthday;
            }
            if (indexPath.row == 4) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.namestring = @"星座";
                cell.valuestring = _model.constellation;
            }
        }
    }
    else if (indexPath.section == 1){
        cell.style = DDPersonInfoCellStyleNormal;
        if (indexPath.row == 0) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.namestring = @"城市";
            cell.valuestring = _model.city;
        }
        if (indexPath.row == 1) {
            cell.namestring = @"社区";
            cell.valuestring = _model.district;
        }
        if (indexPath.row == 2) {
            cell.namestring = @"学校";
            cell.valuestring = _model.school;
        }
        if (indexPath.row == 3) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.namestring = @"职业";
            cell.valuestring = _model.occupation;
        }
    }
    else if (indexPath.section == 2){
        cell.style = DDPersonInfoCellStyleNormal;
        cell.namestring = @"名称";
        cell.valuestring = _model.label;
    }
    return cell;
}

-(void)tj_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(DDBaseTableViewCell *)cell{
    WeakSelf(weakSelf);
    DDPersonInfoTableViewCell *celll = (DDPersonInfoTableViewCell *)cell;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //点击头像
            [LSUPLOAD_IMAGE showActionSheetInFatherViewController:self delegate:self];
        }
        if (indexPath.row == 1) {
            //点击昵称
            [self pushEditVCWithTitle:@"修改昵称" cell:celll];
        }
        if (indexPath.row == 2) {
            //点击性别
            NSArray *arr = @[@"男",@"女",@"保密"];
            [self popsinglePickerSelectVCWithTitle:@"请选择性别" dataArr:arr];
            seletePickerType = 1;
        }
        if (indexPath.row == 3) {
            //点击生日
            [self popDatePickerSelectVCWithTitle:@"请选择生日日期"];
        }
        if (indexPath.row == 4) {
            //点击星座
            NSArray *arr = @[@"白羊座",
                             @"金牛座",
                             @"双子座",
                             @"巨蟹座",
                             @"狮子座",
                             @"处女座",
                             @"天秤座",
                             @"天蝎座",
                             @"射手座",
                             @"摩羯座",
                             @"水瓶座",
                             @"双鱼座"];
            [self popsinglePickerSelectVCWithTitle:@"请选择星座" dataArr:arr];
            seletePickerType = 2;
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            //点击城市
            [self popCityPickerSelectVCWithTitle:@"请选择城市"];
        }
        if (indexPath.row == 1) {
            //点击社区
            [self pushEditVCWithTitle:@"修改社区" cell:celll];
        }
        if (indexPath.row == 2) {
            //点击学校
            [self pushEditVCWithTitle:@"修改学校" cell:celll];
        }
        if (indexPath.row == 3) {
            //点击职业
            NSArray *arr = @[@"计算机/互联网/通信",
                             @"生产/工艺/制造",
                             @"医疗/护理/制药",
                             @"金融/银行/投资/保险",
                             @"商业/服务业/个体经营",
                             @"文化/广告/传媒",
                             @"娱乐/艺术/表演",
                             @"律师/法务",
                             @"教育/培新",
                             @"公务员/行政/事业单位",
                             @"模特",
                             @"空姐",
                             @"学生",
                             @"其他职业"];
            [self popsinglePickerSelectVCWithTitle:@"请选择职业" dataArr:arr];
            seletePickerType = 3;
        }
    }if (indexPath.section == 2){
        //修改标签
        DDPersonLabelVc *perLabelVc = [[DDPersonLabelVc alloc] init];
        NSMutableArray *btn_labelArr = [NSMutableArray new];
        NSArray *labelArr = [_model.label componentsSeparatedByString:@","];
        for (int j =0; j < labelArr.count; j++) {
            UIButton *btn_label = [UIButton new];
            [btn_label setTitle:labelArr[j] forState:UIControlStateNormal];
            [btn_label setTitleColor:kDDRandColor forState:UIControlStateNormal];
            btn_label.titleLabel.font = kFont(13);
            btn_label.layerCornerRadius = 15.f;
            btn_label.layerBorderWidth = 1;
            btn_label.layerBorderColor = kDDRandColor;
            [btn_labelArr addObject:btn_label];
        }
        perLabelVc.selectedArray = btn_labelArr;
        perLabelVc.chosseLabelResult = ^(NSString *result) {
            DDPersonInfoTableViewCell *labelCell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
            labelCell.valuestring = result;
        };
        
        [self.navigationController pushViewController:perLabelVc animated:YES];
    }else{
    }
}

- (void)reloadLabel:(NSNotification *)nf {
    [DDTJHttpRequest getUserLabelsblock:^(NSDictionary *dict) {
        _model.label = dict[@"label"];
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:2]] withRowAnimation:UITableViewRowAnimationFade];
    } failure:^{
        
    }];
}

-(void)popCityPickerSelectVCWithTitle:(NSString *)title{
    DDPickerArea *pickerArea = [[DDPickerArea alloc]init];
    [pickerArea setDelegate:self];
    [pickerArea setContentMode:DDPickerContentModeBottom];
    [pickerArea show];
}

-(void)popDatePickerSelectVCWithTitle:(NSString *)title{
    DDPickerDate *pickerDate = [[DDPickerDate alloc ] init];
    [pickerDate setDelegate:self];
    [pickerDate setContentMode:DDPickerContentModeBottom];
    [pickerDate show];
}

-(void)popsinglePickerSelectVCWithTitle:(NSString *)title dataArr:(NSArray *)arr{
    NSMutableArray *selectArr = [NSMutableArray arrayWithArray:arr];
    DDPickerSingle* _pickerSingle = [[DDPickerSingle alloc]init];
    [_pickerSingle setArrayData:selectArr];
    [_pickerSingle setTitle:title];
    [_pickerSingle setContentMode:DDPickerContentModeBottom];
    [_pickerSingle setDelegate:self];
    [_pickerSingle  show];
}

- (void)confirmToEdit:(UIBarButtonItem *)sender {
    DDPersonInfoTableViewCell *nameCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    _uploadModel.name = nameCell.valueLbl.text;
    DDPersonInfoTableViewCell *sexCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    if ([sexCell.valueLbl.text isEqualToString:@"保密"]) {
        _uploadModel.sex = @"0";
    }
    if ([sexCell.valueLbl.text isEqualToString:@"男"]) {
        _uploadModel.sex = @"1";
    }
    if ([sexCell.valueLbl.text isEqualToString:@"女"]) {
        _uploadModel.sex = @"2";
    }
    
    DDPersonInfoTableViewCell *birthdayCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    _uploadModel.birthday = birthdayCell.valueLbl.text;
    DDPersonInfoTableViewCell *constellationCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    _uploadModel.constellation = constellationCell.valueLbl.text;
    DDPersonInfoTableViewCell *cityCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    _uploadModel.city = cityCell.valueLbl.text;
    DDPersonInfoTableViewCell *districtCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    _uploadModel.district = districtCell.valueLbl.text;
    DDPersonInfoTableViewCell *schoolCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
    _uploadModel.school = schoolCell.valueLbl.text;
    DDPersonInfoTableViewCell *occupationCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:1]];
    _uploadModel.occupation = occupationCell.valueLbl.text;
    DDPersonInfoTableViewCell *labelCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    _uploadModel.label = labelCell.valueLbl.text;
    
    [DDTJHttpRequest upUserInfoWith:_uploadModel block:^(NSDictionary *dict) {
        [self pop];
    } failure:^{
        
    }];
    
}

#pragma mark - LSUpLoadImageManagerDelegate
- (void)uploadImageToServerWithImage:(UIImage *)image {
    [DDTJHttpRequest upUserHeaderImage:image block:^(NSDictionary *dict) {
        _model.image = dict[@"image"];
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    } failure:^{
        
    }];
}
#pragma mark - DDPickerSingleDelegate
- (void)pickerSingle:(DDPickerSingle *)pickerSingle selectedTitle:(NSString *)selectedTitle {
    switch (seletePickerType) {
        case 1:{
            DDPersonInfoTableViewCell *sexCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
            sexCell.valuestring = selectedTitle;
        }break;
        case 2:{
            DDPersonInfoTableViewCell *constellationCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
            constellationCell.valuestring = selectedTitle;
        }break;
        case 3:{
            DDPersonInfoTableViewCell *occupationCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:1]];
            occupationCell.valuestring = selectedTitle;
        }break;
        default:
            break;
    }
}
#pragma mark - DDPickerDateDelegate
-(void)pickerDate:(DDPickerDate *)pickerDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day{
    DDPersonInfoTableViewCell *birthdayCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    birthdayCell.valuestring = [NSString stringWithFormat:@"%ld-%02ld-%02ld",year,month,day];
}
#pragma mark - DDPickerArea delegate
- (void)pickerArea:(DDPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area {
    NSString *text = [NSString stringWithFormat:@"%@ %@ %@", province, city, area];
    DDPersonInfoTableViewCell *cityCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    cityCell.valuestring = text;
}
#pragma mark  -push
-(void)pushEditVCWithTitle:(NSString *)title cell:(DDPersonInfoTableViewCell *)cell {
    DDEditInfoVC *editVC = [[DDEditInfoVC alloc] init];
    editVC.title = title;
    editVC.editResult = ^(NSString *result) {
        cell.valuestring = result;
    };
    [self.navigationController pushViewController:editVC animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end








