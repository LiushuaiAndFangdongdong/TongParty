//
//  DDSettingVc.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/26.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDSettingVc.h"
#import "DDSettingTableViewCell.h"  //cell
#import "DDPersonInfoVc.h"          //个人资料
#import "DDPersonAuthVc.h"          //认证
#import "DDPsdSettingVc.h"          //设置
#import "DDRemindViewController.h"  //提醒
#import "DDPrivateViewController.h" //隐私
#import "DDHelpViewController.h"    //帮助
#import "DDAboutViewController.h"   //关于
#import "DDShowBlindViewController.h" //绑定
#import "LXAlertView.h"
#import "DDLoginViewController.h"

@interface DDSettingVc ()
@end

@implementation DDSettingVc

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navItemTitle = @"设置";
    [self navigationWithTitle:@"设置"];
    [self setUpViews];
}
// 设置子视图
- (void)setUpViews {
    self.sepLineColor = kSeperatorColor;
    self.refreshType = DDBaseTableVcRefreshTypeNone;
}
#pragma mark - UITableViewDelegate
- (NSInteger)tj_numberOfSections {
    return 6;
}
- (NSInteger)tj_numberOfRowsInSection:(NSInteger)section
{
    NSInteger numRows = 0;
    switch (section) {
        case 0:
        {
            numRows = 1;
        }break;
        case 1:
        {
            numRows = 4;
        }break;
        case 2:
        {
            numRows = 2;
        }
            break;
        case 3:
        {
             numRows = 2;
        }break;
        case 4:
        {
             numRows = 4;
        }break;
        case 5:
        {
            numRows = 1;
        }break;
        default:
            break;
    }
    return numRows;
}
-(UIView *)tj_headerAtSection:(NSInteger)section{
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = kBgWhiteGrayColor;
    return headView;
}
- (DDBaseTableViewCell *)tj_cellAtIndexPath:(NSIndexPath *)indexPath {
    DDSettingTableViewCell *cell = [DDSettingTableViewCell cellWithTableView:self.tableView];

    if (indexPath.section == 5) {
        cell.style = DDSettingCellStyleCentertext;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.centerText = @"退出登录";
    }else{
        cell.style = DDSettingCellStyleNormal;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        NSArray *authArr = @[@"手机认证",@"绑定微信",@"绑定QQ",@"绑定微博"];
        NSArray *authValueArr = @[@"15205145990",@"fxd1101",@"755788561",@"方嘚瑟"];
        NSArray *psdArr= @[@"个人认证",@"密码设置"];
        NSArray *psdValueArr =@[@"方冬冬",@""];
        NSArray *mindArr= @[@"提醒设置",@"隐私"];
        NSArray *mindValueArr =@[@"",@""];
        NSArray *aboutArr= @[@"清除缓存",@"帮助",@"关于桐聚",@"分享桐聚"];
        NSArray *aboutValueArr =@[@"12.21M",@"",@"",@""];
        NSString *name;
        NSString *value;
        if (indexPath.section == 0) {
            name = @"修改个人资料";
        }else if (indexPath.section == 1){
            name = authArr[indexPath.row];
            value = authValueArr[indexPath.row];
        }else if (indexPath.section == 2)
        {
            name = psdArr[indexPath.row];
            value = psdValueArr[indexPath.row];
        }else if (indexPath.section == 3)
        {
            name = mindArr[indexPath.row];
            value = mindValueArr[indexPath.row];

        }else if(indexPath.section == 4)
        {
            name = aboutArr[indexPath.row];
            value = aboutValueArr[indexPath.row];
        }else{
        }
        cell.namestring = name;
        cell.valuestring   = value;
    }
  
    
    return cell;
}

- (CGFloat)tj_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
-(CGFloat)tj_sectionHeaderHeightAtSection:(NSInteger)section{
    return 10;
}
- (void)tj_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(DDBaseTableViewCell *)cell {
    switch (indexPath.section) {
        case 0:
        {//个人资料
            [self pushPersonInformationVC];
        }
            break;
        case 1:
        {
            //绑定的社交账号
            [self pushSocialBlindWithType:indexPath.row];
        }break;
        case 2:
        {
            if (indexPath.row == 0) {
                //个人认证
                [self pushPersonAuthVc];
            }
            if (indexPath.row == 1) {
                //密码设置
                [self pushPsdSettingVC];
            }else{
            }
        }break;
        case 3:
        {
            if (indexPath.row == 0) {
                //提醒设置
                [self pushRemindVC];
            }
            if (indexPath.row == 1) {
                //隐私设置
                [self pushPrivateVC];
            }else{
            }
        }break;
        case 4:
        {
            if (indexPath.row == 0) {
                //清除缓存
                [self clearAppAche];
            }
            if (indexPath.row == 1) {
                //帮助
                [self pushHelpVC];
            }
            if (indexPath.row == 2) {
                //关于桐聚
                [self pushAboutVC];
            }
            if (indexPath.row == 3) {
                //分享桐聚
            }else{
            }
        }break;
        case 5:
        {
            //退出登录
            [self logoutRequest];
            
        }break;
        default:
            break;
    }
}
//注销
- (void)logoutRequest
{
    LXAlertView *alert=[[LXAlertView alloc] initWithTitle:@"提示" message:@"确定要退出吗" cancelBtnTitle:@"取消" otherBtnTitle:@"确定" clickIndexBlock:^(NSInteger clickIndex) {
        NSLog(@"点击index====%ld",(long)clickIndex);
        
        if (clickIndex == 1) {
            [DDUserDefault removeObjectForKey:@"token"];
            [DDUserDefault removeObjectForKey:@"mobile"];
            [DDUserDefault removeObjectForKey:@"password"];
            [[DDUserSingleton shareInstance] clearUserInfo];
            [kNotificationCenter postNotificationName:kUpdateUserInfoNotification object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    alert.animationStyle=LXASAnimationDefault;
    [alert showLXAlertView];
}
//退出登录
- (void)pushLoginVC
{
    DDLoginViewController *vc = [[DDLoginViewController alloc]init];
    vc.isPopToRoot = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - push
-(void)pushPersonInformationVC{
    DDPersonInfoVc *pinfoVc = [[DDPersonInfoVc alloc] init];
    [self pushtoVC:pinfoVc];
}
-(void)pushPersonAuthVc{
    DDPersonAuthVc *authVC = [[DDPersonAuthVc alloc] init];
    [self pushtoVC:authVC];
}
-(void)pushPsdSettingVC{
    DDPsdSettingVc *psdSetting = [[DDPsdSettingVc alloc] init];
    [self pushtoVC:psdSetting];
}
-(void)pushRemindVC{
    DDRemindViewController *remindVC  =[[ DDRemindViewController  alloc] init];
    [self  pushtoVC:remindVC];
}
-(void)pushPrivateVC{
    DDPrivateViewController *privateVC = [[DDPrivateViewController alloc] init];
    [self pushtoVC:privateVC];
}
-(void)pushHelpVC {
    DDHelpViewController *helpVC = [[DDHelpViewController alloc] init];
    [self pushtoVC:helpVC];
}
-(void)pushAboutVC {
    DDAboutViewController *aboutVC =[[ DDAboutViewController alloc] init];
    [self pushtoVC:aboutVC];
}
-(void)pushSocialBlindWithType:(DDSocialBlindType)type{
    DDShowBlindViewController *showBlindVc = [[DDShowBlindViewController alloc] init];
    showBlindVc.type = type;
    [self pushtoVC:showBlindVc];
}
-(void)pushtoVC:(UIViewController *)controller{
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)clearAppAche{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"清除缓存13.14M？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"清除"style:UIAlertActionStyleDestructive handler:^(UIAlertAction*action) {
        NSLog(@"删除");
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end









