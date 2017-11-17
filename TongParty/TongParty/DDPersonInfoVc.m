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

@interface DDPersonInfoVc ()<DDPickerSingleDelegate,DDPickerAreaDelegate,DDPickerDateDelegate>

@end

@implementation DDPersonInfoVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navItemTitle = @"个人资料";
    [self setUpViews];
}
// 设置子视图
- (void)setUpViews {
    self.sepLineColor = kSeperatorColor;
    self.refreshType = DDBaseTableVcRefreshTypeNone;
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
        }else{
            cell.style = DDPersonInfoCellStyleNormal;
            if (indexPath.row == 1) {
                cell.namestring = @"昵称";
                cell.valuestring = @"fangdese";
            }
            if (indexPath.row == 2) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.namestring = @"性别";
                cell.valuestring = @"男";
            }
            if (indexPath.row == 3) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.namestring = @"生日";
                cell.valuestring = @"1992-11-01";
            }
            if (indexPath.row == 4) {
                cell.namestring = @"星座";
                cell.valuestring = @"天蝎座";
            }
        }
    }
    else if (indexPath.section == 1){
        cell.style = DDPersonInfoCellStyleNormal;
        if (indexPath.row == 0) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.namestring = @"城市";
            cell.valuestring = @"北京朝阳区酒仙桥路";
        }
        if (indexPath.row == 1) {
            cell.namestring = @"社区";
            cell.valuestring = @"亚洲壹号";
        }
        if (indexPath.row == 2) {
            cell.namestring = @"学校";
            cell.valuestring = @"北京市朝阳一中";
        }
        if (indexPath.row == 3) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.namestring = @"职业";
            cell.valuestring = @"软件工程师";
        }
    }
    else if (indexPath.section == 2){
        cell.style = DDPersonInfoCellStyleNormal;
        cell.namestring = @"名称";
        cell.valuestring = @"桐聚";
    }
    return cell;
}

-(void)tj_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(DDBaseTableViewCell *)cell{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //点击头像
        }
        if (indexPath.row == 1) {
            //点击昵称
            [self pushEditVC];
        }
        if (indexPath.row == 2) {
            //点击性别
            NSArray *arr = @[@"男",@"女",@"保密"];
            [self popsinglePickerSelectVCWithTitle:@"请选择性别" dataArr:arr];
        }
        if (indexPath.row == 3) {
            //点击生日
//            [self popDatePickerSelectVCWithTitle:@"请选择生日日期"];
        }
        if (indexPath.row == 4) {
            //点击星座
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            //点击城市
//            [self popCityPickerSelectVCWithTitle:@"请选择城市"];
        }
        if (indexPath.row == 1) {
            //点击社区
             [self pushEditVC];
        }
        if (indexPath.row == 2) {
            //点击学校
             [self pushEditVC];
        }
        if (indexPath.row == 3) {
            //点击职业
             NSArray *arr = @[@"开发工程师",@"测试工程师",@"产品经理"];
            [self popsinglePickerSelectVCWithTitle:@"请选择职业" dataArr:arr];
        }
    }if (indexPath.section == 2){
        //修改标签
        DDPersonLabelVc *perLabelVc = [[DDPersonLabelVc alloc] init];
       [self.navigationController pushViewController:perLabelVc animated:YES];
    }else{
    }
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
#pragma mark - DDPickerSingleDelegate
- (void)pickerSingle:(DDPickerSingle *)pickerSingle selectedTitle:(NSString *)selectedTitle;
{
//    if (self.index.row == 1) {
//        self.sexStr =selectedTitle.name;
//    }
//    if (self.index.row== 3) {
//        self.eduStr =selectedTitle.name;
//    }
//    if (self.index.row== 7) {
//        self.experienceStr =selectedTitle.name;
//    }
//    if (self.index.row == 12) {
//        self.workTypeStr =selectedTitle.name;
//    }
//    if (self.index.row == 13) {
//        self.salaryStr =selectedTitle.name;
//    }
//    [self reloadRowsAtIndexPaths:@[self.index] withRowAnimation:UITableViewRowAnimationFade];
}
#pragma mark - DDPickerDateDelegate
-(void)pickerDate:(DDPickerDate *)pickerDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day{
//    self.birthStr = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)year,(long)month,(long)day];
//    [self reloadRowsAtIndexPaths:@[self.index] withRowAnimation:UITableViewRowAnimationFade];
}
#pragma mark - DDPickerArea delegate
- (void)pickerArea:(DDPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area
{
//    NSString *text = [NSString stringWithFormat:@"%@ %@ %@", province, city, area];
//    self.areaStr = text;
//    [self reloadRowsAtIndexPaths:@[self.index] withRowAnimation:UITableViewRowAnimationFade];
}
#pragma mark  -push
-(void)pushEditVC{
    DDEditInfoVC *editVC = [[DDEditInfoVC alloc] init];
    [self.navigationController pushViewController:editVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end








