

//
//  DDDeskShowViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/10/10.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDDeskShowViewController.h"
#import <UShareUI/UShareUI.h>           //分享
#import "DDTJShareManager.h"            //分享
#import "DDCustomActionSheet.h"         //弹窗
#import "DDSignQRcodeViewController.h"  //二维码签到页面
#import "DDBottomView.h"                //底部视图
#import "DDBigDeskView.h"               //桌子视图
#import "DDTableInfoModel.h"            //桌子信息model
#import "DDParticipantModel.h"          //参与者model
#import "DDNoticeModel.h"               //公告model

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
                    //桌子----公告
                    [weakSelf popNotice];
                }else if ([_tModel.type intValue] == 2){
                    //参加者----联系桌主
                    [weakSelf callMaster];
                }else if ([_tModel.type intValue] == 3){
                    //未参加者----申请加入
                }else{}
            }
            if (index == 2) {
                if ([_tModel.type intValue] == 1) {
                    //---桌主签到
                    [weakSelf holderShowSign];
                }else if ([_tModel.type intValue] == 2){
                    //参加者----签到
                }else if ([_tModel.type intValue] == 3){
                    //未参加者----感兴趣
                }else{}
            }
            if (index == 3) {
                //邀请
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
    self.view.backgroundColor = kWhiteColor;
    [self.view addSubview:self.deskShowView];
    [self.view addSubview:self.bottomView];
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
//签到
-(void)holderShowSign{
    DDSignQRcodeViewController *showSignVc = [[DDSignQRcodeViewController alloc] init];
    showSignVc.hosterAvatar = _tModel.image;
    [self.navigationController pushViewController:showSignVc animated:YES];
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
        [DDTJHttpRequest masterSendNoticeWithToken:TOKEN tid:tmpModel.id nid:nmodel.nid block:^(NSDictionary *dict) {
            
            [self.deskShowView updateNoticeWith:title];
        } failure:^{
            //
        }];
    }];
}
#pragma mark - 分享
-(void)share{
    
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        WeakSelf(weakSelf);
        [[DDTJShareManager sharedManager] manageShareWithSharedType:platformType title:@"双12从头做起" desc:@"就在长安街某理发店个人哦，均价只要800元。" image:@"AppIcon" shareUrl:@"http://www.itexamprep.com/cn/microsoft/exam/" controller:weakSelf];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

















