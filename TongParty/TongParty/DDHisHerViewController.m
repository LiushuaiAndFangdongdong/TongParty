//
//  DDHisHerViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/10/31.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDHisHerViewController.h"
#import "DDLabelView.h"
#import "DDCustomActionSheet.h"
#import "DDHisUsercenterTableViewCell.h"
#import "DDSettingVc.h"
#import "DDTongCoinVC.h"
#import "DDFriendsViewController.h"
#import "DDAlbumViewController.h"
#import "DDDeskShowViewController.h"
#import "FDDMenu.h"
#import "LSHisUserInfoModel.h"
#import "TSActionDemoView.h"
#import "LSPlayRewardGiftVC.h"
#import "LSAlbumEtity.h"
#define kAvatarWidth   50
#define kMarginGapWidth 18
#define kActivityItemWidth (kScreenWidth - kMarginGapWidth*6)/5

//不支持横屏的情况下
#define kTopViewHeight(SCREEN_MAX_LENGTH) \
({\
float height = 0;\
if (SCREEN_MAX_LENGTH==568)\
height=170;\
else if (SCREEN_MAX_LENGTH==667)\
height=235;\
else if(SCREEN_MAX_LENGTH==736)\
height=250;\
else if(SCREEN_MAX_LENGTH==812)\
height=305;\
(height);\
})\

@interface DDHisHerViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) UIImageView *heagderImageV;
@property (nonatomic , strong) NSMutableArray *menusTitles;  //下拉菜单数组
@property (nonatomic, strong) LSHisUserInfoModel *model;
@property (nonatomic, strong)LSPlayRewardGiftVC *giftVc;
// UI
@property (nonatomic, strong)UIImageView *avatar;
@property (nonatomic, strong)UILabel *nameLbl;
@property (nonatomic, strong)DDLabelView *labelView;
@property (nonatomic, strong)DDLabelView *labelView1;
@property (nonatomic, strong)DDLabelView *labelView2;
@property (nonatomic, strong)DDLabelView *labelView3;
@property (nonatomic, strong)UILabel *creditLbl;
@property (nonatomic, strong)UILabel *joinRateLbl;
@end

@implementation DDHisHerViewController
@synthesize menusTitles = _menusTitles;

#pragma mark -  懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, - kNavigationBarHeight, kScreenWidth, kScreenHeight+ 10 +kNavigationBarHeight ) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //内边距
        self.tableView.contentInset = UIEdgeInsetsMake(kTopViewHeight(SCREEN_MAX_LENGTH), 0, 0, 0);
        [self.tableView addSubview:self.heagderImageV];
    }
    return _tableView;
}

- (UIImageView *)heagderImageV{
    if (!_heagderImageV) {
        self.heagderImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, -kTopViewHeight(SCREEN_MAX_LENGTH), kScreenWidth, kTopViewHeight(SCREEN_MAX_LENGTH))];
        _heagderImageV.image = [UIImage imageNamed:@"person_bg_image"];
        _heagderImageV.contentMode = UIViewContentModeScaleAspectFill;
        _heagderImageV.userInteractionEnabled = YES;
        [_heagderImageV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeBgClick:)]];
    }
    return _heagderImageV;
}

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
    [self customNavi];
    [self setupViews];
    [self getUserdetailInfo];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuWillAppear) name:DDMenuWillAppearNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuDidAppear) name:DDMenuDidAppearNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuWillDisappear) name:DDMenuWillDisappearNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuDidDisappear) name:DDMenuDidDisappearNotification object:nil];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)getUserdetailInfo{
    //开启异步并行线程请求用户详情数据
    [DDTJHttpRequest getOtherUserDetailInfoWithToken:[DDUserSingleton shareInstance].token fid:_fid block:^(NSDictionary *dict) {
        self.model = [LSHisUserInfoModel mj_objectWithKeyValues:dict];
        self.model.photo = [LSAlbumEtity mj_objectArrayWithKeyValuesArray:self.model.photo];
        [self.tableView reloadData];
    } failure:^{
        
    }];
    
}

- (void)setModel:(LSHisUserInfoModel *)model {
    
    _model = model;
    [_avatar sd_setImageWithURL:[NSURL URLWithString:_model.image] placeholderImage:kDefaultAvatar];
    _nameLbl.text = _model.name;
    NSArray *label_arr = [model.label componentsSeparatedByString:@","];
    NSArray *lbl_labels = @[_labelView,_labelView1,_labelView2,_labelView3];
    if (label_arr) {
        for (int l = 0 ; l < label_arr.count; l++) {
            DDLabelView *lblView = lbl_labels[l];
            lblView.textstring = label_arr[l];
        }
    }
    NSString *string = [NSString stringWithFormat:@"完成%@/%@创建       实到%@/%@参与",_model.cft_num,_model.ct_num,_model.jft_num,_model.jt_num];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange strRange = {2,3};
    NSRange strRange1 = {16,3};
    [str addAttributes:@{
                         NSFontAttributeName:kFont(17)
                         } range:strRange];
    [str addAttributes:@{
                         NSFontAttributeName:kFont(15)
                         } range:strRange1];
    _joinRateLbl.attributedText  = str;
}
#pragma mark - Notification

- (void)menuWillAppear {
    NSLog(@"menu will appear");
}

- (void)menuDidAppear {
    NSLog(@"menu did appear");
}

- (void)menuWillDisappear {
    NSLog(@"menu will disappear");
}

- (void)menuDidDisappear {
    NSLog(@"menu did disappear");
}

-(void)customNavi{
    
    UIBarButtonItem *leftBtn = [self backButtonForNavigationBarWithAction:@selector(pop)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    UIBarButtonItem *rightBtn = [self customTitleButtonForNavigationWithAction:@selector(moreAction:) title:@"更多" CGSize:CGSizeMake(35,20)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    barView.tag = 120;
    barView.backgroundColor = [UIColor whiteColor];
    [self.navigationController.view insertSubview:barView belowSubview:self.navigationController.navigationBar];
    barView.alpha = 0;
}

#pragma mark - UITableViewDelegate\UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    headView.backgroundColor = kBgWhiteGrayColor;
    return headView;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.001)];
    return headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (!self.model.photo || section == 3) {
        return 0.00000000001;
    }
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 3) {
        if (_model.photo) {
            return 120;
        }else{
            return 60;
        }
    }else if (indexPath.section == 4){
        return 60+kActivityItemWidth+20;
    }else{
        return 60;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    
    DDHisUsercenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[DDHisUsercenterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.variousNumberClickBlcok = ^(NSInteger index) {
        if (index == 0) {
            // 桐币
            [self pushTongCoinVC];
        }
        if (index == 1) {
            // 关注
            [self pushFriendsVCWithStyle:DDFriendsStyleCare];
        }
        if (index == 2) {
            // 被关注
            [self pushFriendsVCWithStyle:DDFriendsStyleCared];
        }
        if (index == 3) {
            // 好友
            [self pushFriendsVCWithStyle:DDFriendsStyleNormal];
        }
    };
    cell.activityHistoryClickBlcok = ^(NSInteger index) {
        [self pushDeskVC];
    };
    cell.careBtnClickBlcok = ^(BOOL isCare) {
        [self careFriendBy:isCare];
    };
    switch (indexPath.section) {
        case 0: {
            cell.style = DDHisUserCellStyleUserInfo;
        }
            break;
        case 1: {
            cell.style = DDHisUserCellStyleVariousNumbers;
        }
            break;
        case 2: {
            cell.style = DDHisUserCellStyleTongCoin;
        }
            break;
        case 3: {
            if (self.model.photo) {
                cell.style = DDHisUserCellStyleAlbum;
            }
        }
            break;
        case 4: {
            cell.style = DDHisUserCellStyleActivities;
        }
            break;
        default:
            break;
    }
    cell.playReward = ^{
        self.giftVc.view.hidden = NO;
    };
    [cell updateValueWith:_model];
    //单元格内容动画
    static CGFloat initialDelay = 0.2f;
    static CGFloat stutter = 0.06f;
    cell.contentView.transform =  CGAffineTransformMakeTranslation(self.view.bounds.size.width, 0);
    [UIView animateWithDuration:1. delay:initialDelay + ((indexPath.row) * stutter) usingSpringWithDamping:0.6 initialSpringVelocity:0 options:0 animations:^{
        cell.contentView.transform = CGAffineTransformIdentity;
    } completion:NULL];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {}break;
        case 1:
        {
            //打赏明细
            [self pushFriendsVCWithStyle:DDFriendsStyleReward];
        }break;
        case 2:
        {
            
        }break;
        case 3: {//我的相册
            if (self.model.photo) {
                [self pushAlbumVC];
            }
        }break;
        case 4: {//活动历史
            
        }break;
        default:
            break;
    }
}
#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    UIView *barView = [self.navigationController.view viewWithTag:120];
    CGFloat offsetY = scrollView.contentOffset.y+200;
    if (offsetY < 0) {
        barView.alpha = 0;
    }else{
        if (offsetY < 64) {
            barView.alpha = offsetY/64;
        }else{
            barView.alpha = 1;
        }
    }
    
    CGPoint point = scrollView.contentOffset;
    NSLog(@"%f",point.y);
    if (point.y + 64 <=  - 200) {
        CGRect rect = self.heagderImageV.frame;
        rect.origin.y = point.y;
        rect.size.height = -point.y;
        self.heagderImageV.frame = rect;
    }
}

#pragma mark - 关注 或者 取关
- (void)careFriendBy:(BOOL)isCare {
    if (isCare) {
        [DDTJHttpRequest careOtherUserByfid:_fid is_special:@"1" block:^(NSDictionary *dict) {
            [self reFreshUserdetailInfoOnSection:1];
        } failure:^{
            
        }];
    } else {
        [DDTJHttpRequest cancelCareOtherUserByfid:_fid block:^(NSDictionary *dict) {
            [self reFreshUserdetailInfoOnSection:1];
        } failure:^{
            
        }];
    }
}

- (void)reFreshUserdetailInfoOnSection:(NSInteger)section{
    //开启异步并行线程请求用户详情数据
    [DDTJHttpRequest getOtherUserDetailInfoWithToken:[DDUserSingleton shareInstance].token fid:_fid block:^(NSDictionary *dict) {
        self.model = [LSHisUserInfoModel mj_objectWithKeyValues:dict];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
    } failure:^{
        
    }];
    
}

#pragma mark - UI
//背景图切换
-(void)changeBgClick:(UITapGestureRecognizer *)tap{
    DDCustomActionSheet *actionSheet = [DDCustomActionSheet actionSheetWithCancelTitle:@"取消" alertTitle:@"选择个人中心背景图" SubTitles:@"相机",@"相册"];
    [actionSheet show];
    //    WeakSelf(weakSelf);
    [actionSheet setCustomActionSheetItemClickHandle:^(DDCustomActionSheet *actionSheet, NSInteger currentIndex, NSString *title) {
        if (currentIndex == 0) {
            NSLog(@"相机");
        }
    }];
}

-(void)setupViews{
    //头像的上间隔
    float topOriginY = 0;
    //参加次数与上面控件的间距
    float lastLabelMargin = 0;
    if (IS_IPHONE_5) {
        topOriginY = -140;
        lastLabelMargin = 10;
    }else if (IS_IPHONE_6){
        topOriginY = -180;
        lastLabelMargin = 40;
    }else if (IS_IPHONE_6P){
        topOriginY = -190;
        lastLabelMargin = 40;
    }else if (iPhoneX){
        topOriginY = -200;
        lastLabelMargin = 40;
    }else{
    }
    [self.view addSubview:self.tableView];
    //头像
    _avatar = [UIImageView new];
    [self.tableView addSubview:_avatar];
    [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(kAvatarWidth);
        make.centerX.mas_equalTo(self.tableView);
        make.top.mas_equalTo(topOriginY);
    }];
    _avatar.layerCornerRadius = 25;
    _avatar.image = [UIImage imageNamed:@"AppIcon"];
    //名称
    _nameLbl = [UILabel new];
    [self.tableView addSubview:_nameLbl];
    [_nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_avatar.mas_left).offset(-10);
        make.width.mas_equalTo(kAvatarWidth + 20);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(_avatar.mas_bottom).offset(5);
    }];
    _nameLbl.textAlignment = NSTextAlignmentCenter;
    _nameLbl.text = @"方习冬";
    _nameLbl.textColor = kWhiteColor;
    _nameLbl.font = [UIFont systemFontOfSize:14];
    
    //标签
    _labelView = [DDLabelView new];
    [self.tableView addSubview:_labelView];
    [_labelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_avatar.mas_left).offset(-70);
        make.width.and.height.mas_equalTo(40);
        make.top.mas_equalTo(_avatar);
    }];
    _labelView.textstring = @"爱生活";
    _labelView.layerCornerRadius = 20;
    _labelView.bgColor = kLabelBgBlackColor;
    [self ImageSpringWithLabel:_labelView];
    
    //标签
    _labelView1 = [DDLabelView new];
    [self.tableView addSubview:_labelView1];
    [_labelView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_avatar.mas_right).offset(30);
        make.width.and.height.mas_equalTo(40);
        make.top.mas_equalTo(_avatar);
    }];
    _labelView1.textstring = @"爱网购";
    _labelView1.layerCornerRadius = 20;
    _labelView1.bgColor = kLabelBgBlackColor;
    [self ImageSpringWithLabel:_labelView1];
    //标签
    _labelView2 = [DDLabelView new];
    [self.tableView addSubview:_labelView2];
    [_labelView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.width.and.height.mas_equalTo(40);
        make.top.mas_equalTo(_labelView.mas_bottom).offset(30);
    }];
    _labelView2.textstring = @"喜欢开黑";
    _labelView2.layerCornerRadius = 20;
    _labelView2.bgColor = kLabelBgBlackColor;
    [self ImageSpringWithLabel:_labelView2];
    //标签
    _labelView3 = [DDLabelView new];
    [self.tableView addSubview:_labelView3];
    [_labelView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScreenWidth-70);
        make.width.and.height.mas_equalTo(40);
        make.top.mas_equalTo(_labelView1.mas_bottom).offset(30);
    }];
    _labelView3.textstring = @"神秘人";
    _labelView3.layerCornerRadius = 20;
    _labelView3.bgColor = kLabelBgBlackColor;
    [self ImageSpringWithLabel:_labelView3];
    //信用度&活跃值
    _creditLbl = [UILabel new];
    [self.tableView addSubview:_creditLbl];
    [_creditLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameLbl.mas_bottom).offset(10);
        make.width.mas_equalTo(kAvatarWidth *3);
        make.centerX.mas_equalTo(_nameLbl.centerX);
        make.height.mas_equalTo(20);
    }];
    _creditLbl.text = @"信用度:50 | 活跃值:50";
    _creditLbl.textAlignment = NSTextAlignmentCenter;
    _creditLbl.textColor = kWhiteColor;
    _creditLbl.font = kFont(12);
    //活动参加率
    _joinRateLbl = [UILabel new];
    [self.tableView addSubview:_joinRateLbl];
    [_joinRateLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kAvatarWidth * 4);
        make.top.mas_equalTo(_creditLbl.mas_bottom).offset(lastLabelMargin);
        make.centerX.mas_equalTo(_creditLbl.centerX);
    }];
    //    joinRateLbl.text = @"实到6/7创建       实到7/9参与";
    _joinRateLbl.textAlignment = NSTextAlignmentCenter;
    _joinRateLbl.textColor = kWhiteColor;
    _joinRateLbl.font = kFont(12);
}
- (void)ImageSpringWithLabel:(DDLabelView *)label{
    //    [UIView animateWithDuration:1.5 animations:^{
    //        label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y+10, label.frame.size.width, label.frame.size.height);
    //    }];
    //    [UIView animateWithDuration:1.5 delay:1.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    //        label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y-10, label.frame.size.width, label.frame.size.height);
    //    } completion:^(BOOL finished) {
    //        [self ImageSpringWithLabel:label];
    //    }];
}
#pragma mark - push
-(void)pushDeskVC{
    DDDeskShowViewController *deskVC = [[DDDeskShowViewController alloc] init];
    [self.navigationController pushViewController:deskVC animated:YES];
}
//更多
-(void)moreAction:(UIBarButtonItem *)sender{
    // 通过NavigationBarItem显示Menu
    //        [FDDMenu setTintColor:kWhiteColor];
    [FDDMenu setSelectedColor:kBgGreenColor];
    if ([FDDMenu isShow]){
        [FDDMenu dismissMenu];
    } else {
        [FDDMenu showMenuInView:self.view fromRect:CGRectMake(self.view.frame.size.width - 50, kNavigationBarHeight -10, 50, 0) menuItems:self.menusTitles selected:^(NSInteger index, FDDMenuItem *item) {
            if (item.tag == 101) {
                // 拉黑
                [DDTJHttpRequest addBlacklistByfid:_fid block:^(NSDictionary *dict) {
                    
                } failure:^{
                    
                }];
            }
            if (item.tag == 100) {
                // 举报
                TSActionDemoView * demoAlertView  = [TSActionDemoView actionAlertViewWithAnimationStyle:TSActionAlertViewTransitionStyleBounce];
                demoAlertView.backgroundStyle = TSActionAlertViewBackgroundStyleSolid;;
                demoAlertView.isAutoHidden = YES;
                demoAlertView.titleString = @"举报内容";
                demoAlertView.ploceHolderString = @"请输入举报内容";
                typeof(TSActionDemoView) __weak *weakView = demoAlertView;
                [demoAlertView setStringHandler:^(TSActionAlertView *alertView,NSString * string){
                    typeof(TSActionDemoView) __strong *strongView = weakView;
                    [DDTJHttpRequest reportUserBybid:_fid text:string block:^(NSDictionary *dict) {
                        
                    } failure:^{
                        
                    }];
                    [strongView dismissAnimated:YES];
                }];
                [demoAlertView show];
            }
            if (item.tag == 102) {
                // 设置备注名
                TSActionDemoView * demoAlertView  = [TSActionDemoView actionAlertViewWithAnimationStyle:TSActionAlertViewTransitionStyleBounce];
                demoAlertView.backgroundStyle = TSActionAlertViewBackgroundStyleSolid;;
                demoAlertView.isAutoHidden = YES;
                demoAlertView.titleString = @"好友备注";
                demoAlertView.ploceHolderString = @"请输入备注名";
                typeof(TSActionDemoView) __weak *weakView = demoAlertView;
                [demoAlertView setStringHandler:^(TSActionAlertView *alertView,NSString * string){
                    typeof(TSActionDemoView) __strong *strongView = weakView;
                    [DDTJHttpRequest setUserRemark:string fid:_fid block:^(NSDictionary *dict) {
                    } failure:^{
                        
                    }];
                    [strongView dismissAnimated:YES];
                }];
                [demoAlertView show];
            }
        }];
    }
}
-(void)pushTongCoinVC{
    DDTongCoinVC *tcoinVC = [[DDTongCoinVC alloc] init];
    [self.navigationController pushViewController:tcoinVC animated:YES];
}
-(void)pushFriendsVCWithStyle:(DDFriendsStyle)style{
    DDFriendsViewController *fVc = [[DDFriendsViewController alloc] init];
    fVc.style = style;
    fVc.type = DDFriendOtherUserStyle;
    fVc.fid = _fid;
    [self.navigationController pushViewController:fVc animated:YES];
}
-(void)pushAlbumVC{
    DDAlbumViewController *albumVC = [[DDAlbumViewController alloc] init];
    albumVC.style = DDAlbumOtherUserStyle;
    albumVC.fid = _fid;
    [self.navigationController pushViewController:albumVC animated:YES];
}
-(void)messageAction{
    NSLog(@"消息");
}
#pragma mark - setter/getter
- (NSMutableArray *)menusTitles {
    if (!_menusTitles) {
        
        // set title
        //        FDDMenuItem *menuTitle = [FDDMenuItem menuTitle:@"menu" WithIcon:nil];
        //        menuTitle.foreColor = [UIColor whiteColor];
        //        menuTitle.titleFont = [UIFont boldSystemFontOfSize:20.0f];
        
        //set logout button
        //        FDDMenuItem *logoutItem = [FDDMenuItem menuItem:@"退出" image:nil target:self action:@selector(logout:)];
        //        logoutItem.foreColor = [UIColor redColor];
        //        logoutItem.alignment = NSTextAlignmentCenter;
        
        //set item
        _menusTitles = [@[
                          [FDDMenuItem menuItem:@"举报"
                                          image:nil
                                            tag:100
                                       userInfo:@{@"title":@"Menu"}],
                          [FDDMenuItem menuItem:@"拉黑"
                                          image:nil
                                            tag:101
                                       userInfo:@{@"title":@"Menu"}],
                          [FDDMenuItem menuItem:@"设置备注名"
                                          image:nil
                                            tag:102
                                       userInfo:@{@"title":@"Menu"}],
                          [FDDMenuItem menuItem:@"查看更多资料"
                                          image:nil
                                            tag:103
                                       userInfo:@{@"title":@"Menu"}],
                          
                          ] mutableCopy];
    }
    return _menusTitles;
}

- (LSPlayRewardGiftVC *)giftVc {
    if (!_giftVc) {
        _giftVc = [[LSPlayRewardGiftVC alloc] init];
        [self addChildVc:_giftVc];
        _giftVc.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight);
        [self.view addSubview:_giftVc.view];
        _giftVc.view.hidden = YES;
    }
    return _giftVc;
}

- (void)setMenusTitles:(NSMutableArray *)menusTitles{
    _menusTitles = menusTitles;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end










