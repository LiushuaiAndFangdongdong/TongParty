

//
//  DDDeskShowViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/10/10.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDDeskShowViewController.h"
#import <UShareUI/UShareUI.h>
#import "DDTJShareManager.h"
#import "DDCustomActionSheet.h"
#import "DDSignQRcodeViewController.h"
//#import "DDDeskShowView.h"
#import "DDBottomView.h"
#import "DDBigDeskView.h"

@interface DDDeskShowViewController ()

@end

@implementation DDDeskShowViewController

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
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}
-(void)setupUI{

    self.view.backgroundColor = kWhiteColor;
    DDBigDeskView *deskShowView = [[DDBigDeskView alloc] init];
    [self.view addSubview:deskShowView];
    [deskShowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-55);
    }];
    deskShowView.type = DDDeskShowTypeNormal;
    
    DDBottomView *bottomView = [[DDBottomView alloc] init];
    [self.view addSubview:bottomView];
    bottomView.bottomFunctionClickBlcok = ^(NSInteger index) {
        if (index == 0) {
            //分享
            [self share];
        }
        if (index == 1) {
            //发送公告
            [self popNotice];
        }
        if (index == 2) {
            //签到
            [self holderShowSign];
            NSLog(@"2");
        }
        if (index == 3) {
            //邀请
            
        }
    };
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(deskShowView.mas_bottom);
        make.left.and.bottom.and.right.mas_equalTo(0);
    }];
}

//签到
-(void)holderShowSign{
    DDSignQRcodeViewController *showSignVc = [[DDSignQRcodeViewController alloc] init];
    [self.navigationController pushViewController:showSignVc animated:YES];
}
//发布公告
-(void)popNotice{
    DDCustomActionSheet *actionSheet = [DDCustomActionSheet actionSheetWithCancelTitle:@"取消" alertTitle:nil SubTitles:@"我马上到！！！",@"餐桌的朋友麻烦都电联一下我！！！",@"ok",@"你是MM还是GG",@"dsadsa", nil];
    [actionSheet show];
    //            WeakSelf(weakSelf);
    [actionSheet setCustomActionSheetItemClickHandle:^(DDCustomActionSheet *actionSheet, NSInteger currentIndex, NSString *title) {
        if (currentIndex == 0) {
            NSLog(@"相机");
        }
    }];
}
#pragma mark - 分享
-(void)share{
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        WeakSelf(weakSelf);
        [[DDTJShareManager sharedManager] manageShareWithSharedType:platformType title:@"今晚8点西直门撸串拉" desc:@"15个人用的杯,碟(一次性纸制品),烤炉,烧烤叉15个,两至三斤碳.保鲜袋和垃圾袋适量.扫调料用的扫子三个以上.两卷纸.两瓶汽水(可乐,新期士,雪碧),王老吉或清凉茶(清热解火,现在是夏天),除了楼主的备用外,还可以加些别的,如茄瓜,通菜,番茄(切片),鱼类,生豪,鱿雨,冬姑(先泡好,挑大的才好烤),可以备一个西瓜.调料：盐、酱油、辣椒、烤酱等外可备蜂蜜,番茄汁,别忘了带没了这个可不行.大概每人100-150元啦,请记得要搞好防火工作哦,安全第一嘛!" image:@"refreshjoke_loading_16" shareUrl:@"http://www.itexamprep.com/cn/microsoft/exam/" controller:weakSelf];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

















