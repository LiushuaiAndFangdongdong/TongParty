

//
//  DDDeskShowViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/10/10.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDDeskShowViewController.h"
#import <UShareUI/UShareUI.h>           //友盟分享ui
#import "DDTJShareManager.h"            //封装分享
#import "DDCustomActionSheet.h"         //弹窗
#import "DDBottomView.h"                //底部视图
#import "DDBigDeskView.h"               //桌子视图
#import "DDTableInfoModel.h"            //桌子信息model
#import "DDParticipantModel.h"          //参与者model
#import "DDNoticeModel.h"               //公告model
#import "DDSignQRcodeViewController.h"  //二维码签到页面
#import "DDInviteFriedsViewController.h"//邀请好友页面
#import "LSCouponView.h"                //弹窗加入券和申请券

@interface DDDeskShowViewController ()
@property (nonatomic, strong) DDTableInfoModel *tModel;         //桌子信息model
@property (nonatomic, strong) DDBottomView *bottomView;         //底部视图
@property (nonatomic, strong) DDBigDeskView *deskShowView;      //桌子view
@property (nonatomic, strong) DDParticipantModel *vistorModel;  //游客
@property (nonatomic, strong) NSArray *noticeArr;               //公告数组
@end

@implementation DDDeskShowViewController
@synthesize tmpModel;

//桌主98.5/749  桌主的高宽比815/443
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

- (DDBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[DDBottomView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 60, kScreenWidth, 60)];
        WeakSelf(weakSelf);
        _bottomView.bottomFunctionClickBlcok = ^(NSInteger index) {
            if (index == 0) {
                //分享
                [weakSelf share];
            }
            if (index == 1) {
                if ([_tModel.type intValue] == 1) {
                    //桌主----公告
                    [weakSelf popNotice];
                }else if ([_tModel.type intValue] == 2){
                    //参加者----联系桌主
                    [weakSelf callMaster];
                }else if ([_tModel.type intValue] == 3){
                    //未参加者----申请加入
                    [weakSelf vistorApplyForJoinDesk];
                }else{}
            }
            if (index == 2) {
                if ([_tModel.type intValue] == 1) {
                    //桌主----签到
                    [weakSelf masterSign];
                }else if ([_tModel.type intValue] == 2){
                    //参加者----签到
                    [weakSelf partintSign];
                }else if ([_tModel.type intValue] == 3){
                    //未参加者----感兴趣
                    [weakSelf vistorCareDesk];
                }else{}
            }
            if (index == 3) {
                //邀请
                [weakSelf pushInviteFriedsVC];
            }
        };
    }
    return _bottomView;
}

- (DDBigDeskView *)deskShowView{
    if (!_deskShowView) {
        _deskShowView = [[DDBigDeskView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 60)];
        _deskShowView.type = DDDeskShowTypeNormal;
    }
    return _deskShowView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNavi];
    self.view.backgroundColor = kWhiteColor;
    [self.view addSubview:self.deskShowView];
    [self.view addSubview:self.bottomView];
    [self loadData];
}

- (void)customNavi{
    
    //返回
    self.navigationItem.leftBarButtonItem = [self backButtonForNavigationBarWithAction:@selector(backAction)];
    
    //刷新
    UIBarButtonItem *rightBtn = [self customButtonForNavigationBarWithAction:@selector(refreshAction) imageNamed:@"desk_refresh" isRedPoint:NO pointValue:nil CGSizeMake:CGSizeMake(60, 30)];
    self.navigationItem.rightBarButtonItem = rightBtn;
}

- (void)backAction{
    [self popViewController];
}

- (void)refreshAction{
    NSLog(@"刷新");
    [self loadData];
}

- (void)loadData{
    [super loadData];
    [self showLoadingView];
    [DDTJHttpRequest getDeskDetailInfoWithToken:TOKEN tid:tmpModel.id  block:^(NSDictionary *dict) {
        [self hideLoadingView];
        NSLog(@"桌子信息----->%@",dict);
        _tModel = [DDTableInfoModel mj_objectWithKeyValues:dict[@"info"]];
        self.noticeArr = [DDNoticeModel mj_objectArrayWithKeyValuesArray:dict[@"info"][@"notice"]];
        NSArray *partsArr = [DDParticipantModel mj_objectArrayWithKeyValuesArray:dict[@"users"]];
        [self.deskShowView updateDeskInfoModel:_tModel];
        [self.deskShowView updateNoticeWith:_tModel.text];
        [self.deskShowView updatePartsWithArray:partsArr];
        [_bottomView updateBtnImageWithType:_tModel.type];
        
    } failure:^{
        //
    }];
}


//桌主签到
-(void)masterSign{
    [MBProgressHUD showLoading:@"签到中..." toView:self.view];
    [DDTJHttpRequest hosterSigninDeskWithToken:TOKEN tid:tmpModel.id lat:@"" lon:@"" block:^(NSDictionary *dict) {
        [MBProgressHUD hideAllHUDsInView:self.view];
        NSLog(@"桌主签到  %@",dict);
    } failure:^{
        //
    }];
}

//参与者到签到页面
-(void)partintSign{
    DDSignQRcodeViewController *showSignVc = [[DDSignQRcodeViewController alloc] init];
    showSignVc.hosterAvatar = _tModel.image;
    [self.navigationController pushViewController:showSignVc animated:YES];
}

//邀请好友页面
- (void)pushInviteFriedsVC{
    DDInviteFriedsViewController *inviteVC = [[DDInviteFriedsViewController alloc] init];
    inviteVC.tid = tmpModel.id;
    [self.navigationController pushViewController:inviteVC animated:YES];
}

//游客关注桌子
-(void)vistorCareDesk{
    [MBProgressHUD showLoading:@"关注中..." toView:self.view];
    [DDTJHttpRequest vistorCaredDeskWithToken:TOKEN tid:tmpModel.id block:^(NSDictionary *dict) {
        [MBProgressHUD hideAllHUDsInView:self.view];
        NSLog(@"关注桌子  %@",dict);
    } failure:^{
        //
    }];
}
//游客申请加入桌子
- (void)vistorApplyForJoinDesk{
    
    // 1邀请  0加入 // 控件中信息被打包成dict 返回。。
    [[LSCouponView shareInstance] showCouponViewOnWindowWithType:0 doneBlock:^(NSDictionary *dict) {
        [MBProgressHUD showLoading:@"申请中..." toView:self.view];
        [DDTJHttpRequest applyJoinDeskWithToken:TOKEN tid:tmpModel.id t_uid:_tModel.uid block:^(NSDictionary *dict) {
            [MBProgressHUD hideAllHUDsInView:self.view];
            NSLog(@"申请加桌  %@",dict);
        } failure:^{
            //
        }];
        
    }];
    

}
//联系桌主
-(void)callMaster{
    if (_tModel.mobile == nil || _tModel.mobile == NULL) {
        [MBProgressHUD showError:@"桌主的联系方式为空" toView:self.view];
    }else{
        NSString *mobilestr=[[NSMutableString alloc] initWithFormat:@"tel:%@",_tModel.mobile];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mobilestr]];
    }
}

//发布公告
-(void)popNotice{
    
    DDCustomActionSheet *actionSheet = [DDCustomActionSheet actionSheetWithCancelTitle:@"取消" alertTitle:nil SubTitles:self.noticeArr, nil];
    [actionSheet show];
    [actionSheet setCustomActionSheetItemClickHandle:^(DDCustomActionSheet *actionSheet, NSInteger currentIndex, NSString *title) {
        //发送公告
        DDNoticeModel *nmodel = self.noticeArr[currentIndex];
        [MBProgressHUD showLoading:@"发布公告中..." toView:self.view];
        [DDTJHttpRequest masterSendNoticeWithToken:TOKEN tid:tmpModel.id nid:nmodel.nid block:^(NSDictionary *dict) {
            [MBProgressHUD hideAllHUDsInView:self.view];
            [self.deskShowView updateNoticeWith:title];
        } failure:^{
            //
        }];
    }];
}
#pragma mark - 分享
-(void)share{
    
    NSString *shareDesc = [NSString stringWithFormat:@"%@%@附近%@人的%@,人均消费只要%@，赶快加入吧>>>>>>>>>>>",_tModel.begin_time,_tModel.place,_tModel.person_num,_tModel.title,_tModel.average_price];
    
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        WeakSelf(weakSelf);
        [[DDTJShareManager sharedManager] manageShareWithSharedType:platformType title:_tModel.title desc:shareDesc image:@"AppIcon" shareUrl:@"http://www.itexamprep.com/cn/microsoft/exam/" controller:weakSelf];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

















