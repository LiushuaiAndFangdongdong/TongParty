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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuWillAppear) name:DDMenuWillAppearNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuDidAppear) name:DDMenuDidAppearNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuWillDisappear) name:DDMenuWillDisappearNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuDidDisappear) name:DDMenuDidDisappearNotification object:nil];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    
    //左边消息按钮
    UIBarButtonItem *leftBtn = [self customButtonForNavigationBarWithAction:@selector(messageAction) imageNamed:@"usercenter_message" isRedPoint:YES pointValue:@"9" CGSizeMake:CGSizeMake(26, 18)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    //右边更多按钮
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
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 3) {
        return 120;
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
            //桐币
            [self pushTongCoinVC];
        }
        if (index == 1) {
            //关注
            NSLog(@"1");
            [self pushFriendsVCWithStyle:DDFriendsStyleCare];
        }
        if (index == 2) {
            //被关注
            [self pushFriendsVCWithStyle:DDFriendsStyleCared];
            NSLog(@"2");
        }
        if (index == 3) {
            //好友
            NSLog(@"3");
            [self pushFriendsVCWithStyle:DDFriendsStyleNormal];
        }
    };
    cell.activityHistoryClickBlcok = ^(NSInteger index) {
        [self pushDeskVC];
    };
    switch (indexPath.section) {
        case 0:
        {
            cell.style = DDHisUserCellStyleUserInfo;
        }
            break;
        case 1:
        {
            cell.style = DDHisUserCellStyleVariousNumbers;
        }
            break;
        case 2:
        {
            cell.style = DDHisUserCellStyleTongCoin;
        }
            break;
        case 3:
        {
            cell.style = DDHisUserCellStyleAlbum;
        }
            break;
        case 4:
        {
            cell.style = DDHisUserCellStyleActivities;
        }
            break;
        default:
            break;
    }
    //    cell.textLabel.text = [NSString stringWithFormat:@"测试%ld行",indexPath.row];
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
            //我的相册
            [self pushAlbumVC];
        }break;
        case 3:
        {}break;
        default:
            break;
    }
}
#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
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

#pragma mark - UI
//背景图切换
-(void)changeBgClick:(UITapGestureRecognizer *)tap{
    DDCustomActionSheet *actionSheet = [DDCustomActionSheet actionSheetWithCancelTitle:@"取消" alertTitle:@"选择个人中心背景图" SubTitles:@"相机",@"相册", nil];
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
    UIImageView *_avatar = [UIImageView new];
    [self.tableView addSubview:_avatar];
    [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(kAvatarWidth);
        make.centerX.mas_equalTo(self.tableView);
        make.top.mas_equalTo(topOriginY);
    }];
    _avatar.layerCornerRadius = 25;
    _avatar.image = [UIImage imageNamed:@"AppIcon"];
    //名称
    UILabel *nameLbl = [UILabel new];
    [self.tableView addSubview:nameLbl];
    [nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_avatar.mas_left).offset(-10);
        make.width.mas_equalTo(kAvatarWidth + 20);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(_avatar.mas_bottom).offset(5);
    }];
    nameLbl.textAlignment = NSTextAlignmentCenter;
    nameLbl.text = @"方习冬";
    nameLbl.textColor = kWhiteColor;
    nameLbl.font = [UIFont systemFontOfSize:14];
    
    //标签
    DDLabelView *labelView = [DDLabelView new];
    [self.tableView addSubview:labelView];
    [labelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_avatar.mas_left).offset(-70);
        make.width.and.height.mas_equalTo(40);
        make.top.mas_equalTo(_avatar);
    }];
    labelView.textstring = @"爱生活";
    labelView.layerCornerRadius = 20;
    labelView.bgColor = kLabelBgBlackColor;
    [self ImageSpringWithLabel:labelView];
    
    //标签
    DDLabelView *labelView1 = [DDLabelView new];
    [self.tableView addSubview:labelView1];
    [labelView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_avatar.mas_right).offset(30);
        make.width.and.height.mas_equalTo(40);
        make.top.mas_equalTo(_avatar);
    }];
    labelView1.textstring = @"爱网购";
    labelView1.layerCornerRadius = 20;
    labelView1.bgColor = kLabelBgBlackColor;
    [self ImageSpringWithLabel:labelView1];
    //标签
    DDLabelView *labelView2 = [DDLabelView new];
    [self.tableView addSubview:labelView2];
    [labelView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.width.and.height.mas_equalTo(40);
        make.top.mas_equalTo(labelView.mas_bottom).offset(30);
    }];
    labelView2.textstring = @"喜欢开黑";
    labelView2.layerCornerRadius = 20;
    labelView2.bgColor = kLabelBgBlackColor;
    [self ImageSpringWithLabel:labelView2];
    //标签
    DDLabelView *labelView3 = [DDLabelView new];
    [self.tableView addSubview:labelView3];
    [labelView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScreenWidth-70);
        make.width.and.height.mas_equalTo(40);
        make.top.mas_equalTo(labelView1.mas_bottom).offset(30);
    }];
    labelView3.textstring = @"神秘人";
    labelView3.layerCornerRadius = 20;
    labelView3.bgColor = kLabelBgBlackColor;
    [self ImageSpringWithLabel:labelView3];
    //信用度&活跃值
    UILabel *creditLbl = [UILabel new];
    [self.tableView addSubview:creditLbl];
    [creditLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(nameLbl.mas_bottom).offset(10);
        make.width.mas_equalTo(kAvatarWidth *3);
        make.centerX.mas_equalTo(nameLbl.centerX);
        make.height.mas_equalTo(20);
    }];
    creditLbl.text = @"信用度:50 | 活跃值:50";
    creditLbl.textAlignment = NSTextAlignmentCenter;
    creditLbl.textColor = kWhiteColor;
    creditLbl.font = kFont(12);
    //活动参加率
    UILabel *joinRateLbl = [UILabel new];
    [self.tableView addSubview:joinRateLbl];
    [joinRateLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kAvatarWidth * 4);
        make.top.mas_equalTo(creditLbl.mas_bottom).offset(lastLabelMargin);
        make.centerX.mas_equalTo(creditLbl.centerX);
    }];
    //    joinRateLbl.text = @"实到6/7创建       实到7/9参与";
    joinRateLbl.textAlignment = NSTextAlignmentCenter;
    joinRateLbl.textColor = kWhiteColor;
    joinRateLbl.font = kFont(12);
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"实到6/7创建       实到7/9参与"];
    NSRange strRange = {2,3};
    NSRange strRange1 = {16,3};
    [str addAttributes:@{
                         NSFontAttributeName:kFont(17)
                         } range:strRange];
    [str addAttributes:@{
                         NSFontAttributeName:kFont(15)
                         } range:strRange1];
    joinRateLbl.attributedText  = str;
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
                NSLog(@"%@",item);
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
    [self.navigationController pushViewController:fVc animated:YES];
}
-(void)pushAlbumVC{
    DDAlbumViewController *albumVC = [[DDAlbumViewController alloc] init];
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

- (void)setMenusTitles:(NSMutableArray *)menusTitles{
    _menusTitles = menusTitles;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end










