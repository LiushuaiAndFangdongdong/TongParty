//
//  DDRecomCardViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/10/13.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDRecomCardViewController.h"
#import "CCDraggableContainer.h"
#import "CustomCardView.h"
#import "DDRecommendCardModel.h"
#import "DDPartiantsModel.h"
#import "DDTableInfoModel.h"
#import "DDCustomCommonEmptyView.h"
#import "LSCouponView.h"                //弹窗加入券和申请券
#import "DDTicketModel.h"
#import "LXAlertView.h"

@interface DDRecomCardViewController ()
<
CCDraggableContainerDataSource,
CCDraggableContainerDelegate
>
@property (nonatomic, strong) CCDraggableContainer *container;
@property (nonatomic, strong) NSArray *cardsArr;
@property (nonatomic, weak) DDCustomCommonEmptyView *emptyView;
@property (nonatomic, strong) DDTableInfoModel *model;
@property (nonatomic, strong) DDTicketModel *ticketModel;
@end

@implementation DDRecomCardViewController

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

- (DDCustomCommonEmptyView *)emptyView {
    if (!_emptyView) {
        DDCustomCommonEmptyView *empty = [[DDCustomCommonEmptyView alloc] initWithTitle:@"当前没有推荐的桌子卡片" secondTitle:@"" iconname:@"nocontent"];
        [self.view addSubview:empty];
        _emptyView = empty;
    }
    return _emptyView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationWithTitle:@""];
    [self loadData];
}
- (void)loadData {
        [self showLoadingView];
        [DDTJHttpRequest getNearRecommendCardsWithLat:[DDUserSingleton shareInstance].latitude lon:[DDUserSingleton shareInstance].longitude page:0 block:^(NSDictionary *dict) {
            NSLog(@"附近卡片推荐%@",dict);
            [self hideLoadingView];
            _cardsArr = [DDTableInfoModel mj_objectArrayWithKeyValuesArray:dict[@"tablecord"]];
            if (_cardsArr.count == 0) {
                [self.emptyView showInView:self.view];
            }else{
                [self loadUI];
            }
        } failure:^{
            //
        }];
}

- (void)loadUI {
    // 防止视图变黑
    self.view.backgroundColor = kBgWhiteGrayColor;
    // 初始化Container
    self.container = [[CCDraggableContainer alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight, kScreenWidth, kScreenWidth*970/650) style:CCDraggableStyleUpOverlay];
    self.container.delegate = self;
    self.container.dataSource = self;
    self.container.backgroundColor = kBgWhiteGrayColor;
    [self.view addSubview:self.container];
    // 重启加载
    [self.container reloadData];

    CGFloat padding = (kScreenWidth - DDFitWidth(80) * 3)/4;
    NSArray *btnImageArr = @[@"recommend_card_cancel",@"recommend_card_add",@"recommend_card_interest"];
    for (int i = 0; i < 3; i++) {
        UIButton *variousBtn = [[UIButton alloc] initWithFrame:CGRectMake(padding*(i+1)+DDFitWidth(80)*i, self.container.height - DDFitWidth(80) - 10, DDFitWidth(80), DDFitWidth(80))];
        [variousBtn setBackgroundImage:kImage(btnImageArr[i]) forState:UIControlStateNormal];
        variousBtn.tag = 50 + i;
        [self.container addSubview:variousBtn];
        [variousBtn addTarget:self action:@selector(likeDisLikeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)likeDisLikeAction:(UIButton *)sender{
    if (sender.tag == 50) {
        //不喜欢
        NSLog(@"不喜欢");
        [self.container  removeForDirection:CCDraggableDirectionLeft];
    }else if (sender.tag == 51){
        //申请加入
        NSLog(@"申请加入");
        [self prepareApplyTicket];
    }else if (sender.tag == 52){
        //喜欢
        NSLog(@"喜欢");
        [self.container   removeForDirection:CCDraggableDirectionRight];
        [self vistorCareDesk];
    }else{}
}
//游客关注桌子
-(void)vistorCareDesk{
    [MBProgressHUD showLoading:@"关注中..." toView:self.view];
    [DDTJHttpRequest vistorCaredDeskWithToken:TOKEN tid:_model.ID block:^(NSDictionary *dict) {
        [MBProgressHUD hideAllHUDsInView:self.view];
        NSLog(@"关注桌子  %@",dict);
    } failure:^{
        //
    }];
}

//获取道具加入券的数量值
- (void)prepareApplyTicket{
    // 1邀请  0加入 // 控件中信息被打包成dict 返回。。
    [[LSCouponView shareInstance] showCouponViewOnWindowWithType:0 doneBlock:^(NSDictionary *dict) {
        [MBProgressHUD showLoading:@"申请中..." toView:self.view];
        if ([dict[@"isUseJoinCoupon"] intValue] == 0) {
            //关
            _ticketModel = [DDTicketModel new];
            _ticketModel.coin = @"0";
            [self vistorApplyForJoinDesk];
        }else if ([dict[@"isUseJoinCoupon"] intValue] == 1){
            //开
            //m = 2为加入券
            [DDTJHttpRequest getTicketsInfoWithToken:TOKEN m:@"2" block:^(NSDictionary *dict) {
                _ticketModel = [DDTicketModel mj_objectWithKeyValues:dict];
                if ([_ticketModel.my_coin intValue] < [_ticketModel.coin intValue]) {
                    [self messageInAppPurchase];
                }else{
                    [self vistorApplyForJoinDesk];
                }
            } failure:^{
                //
            }];
        }{}
    }];
}

//余额不足提示内购
- (void)messageInAppPurchase{
    NSString *message = [NSString stringWithFormat:@"当前使用%@价值%@，您余额%@，是否要充值？",_ticketModel.name,_ticketModel.coin,_ticketModel.my_coin];
    LXAlertView *alert=[[LXAlertView alloc] initWithTitle:@"提示" message:message cancelBtnTitle:@"取消" otherBtnTitle:@"确定" clickIndexBlock:^(NSInteger clickIndex) {
        
        if (clickIndex == 1) {
            NSLog(@"去内购");
        }
    }];
    alert.animationStyle=LXASAnimationDefault;
    [alert showLXAlertView];
}
//申请加入桌子
- (void)vistorApplyForJoinDesk{
    [DDTJHttpRequest applyJoinDeskWithToken:TOKEN tid:_model.ID t_uid:_model.uid prop:_ticketModel.coin block:^(NSDictionary *dict) {
        [MBProgressHUD hideAllHUDsInView:self.view];
        NSLog(@"申请加桌  %@",dict);
    } failure:^{
        //
    }];
}

#pragma mark - CCDraggableContainer DataSource

- (CCDraggableCardView *)draggableContainer:(CCDraggableContainer *)draggableContainer viewForIndex:(NSInteger)index {
    
    CustomCardView *cardView = [[CustomCardView alloc] initWithFrame:draggableContainer.bounds];
    _model = [_cardsArr objectAtIndex:index];
    [cardView installData:_model];

    return cardView;
}

- (NSInteger)numberOfIndexs {
    return _cardsArr.count;
}

#pragma mark - CCDraggableContainer Delegate

- (void)draggableContainer:(CCDraggableContainer *)draggableContainer draggableDirection:(CCDraggableDirection)draggableDirection widthRatio:(CGFloat)widthRatio heightRatio:(CGFloat)heightRatio {
    
    UIButton *dislikeButton = [self.container viewWithTag:50];
    UIButton *likeButton = [self.container viewWithTag:52];
    
    CGFloat scale = 1 + ((kBoundaryRatio > fabs(widthRatio) ? fabs(widthRatio) : kBoundaryRatio)) / 4;
    if (draggableDirection == CCDraggableDirectionLeft) {
        dislikeButton.transform = CGAffineTransformMakeScale(scale, scale);
    }
    if (draggableDirection == CCDraggableDirectionRight) {
        likeButton.transform = CGAffineTransformMakeScale(scale, scale);
    }
}

- (void)draggableContainer:(CCDraggableContainer *)draggableContainer cardView:(CCDraggableCardView *)cardView didSelectIndex:(NSInteger)didSelectIndex {
    
    NSLog(@"点击了Tag为%ld的Card", (long)didSelectIndex);
}

- (void)draggableContainer:(CCDraggableContainer *)draggableContainer finishedDraggableLastCard:(BOOL)finishedDraggableLastCard {
    
//    [draggableContainer reloadData];

    [self loadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end





