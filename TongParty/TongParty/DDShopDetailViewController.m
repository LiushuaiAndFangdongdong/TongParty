
//
//  DDShopDetailViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/12/1.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDShopDetailViewController.h"
#import "DDStretchableTableHeaderView.h"
#import "DDShopInfoTableViewCell.h"
#import "DDShopDescTableViewCell.h"
#import "LXAlertView.h"

@interface DDShopDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIImageView *bgImageView ;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic, strong) DDLoginManager *loginManager;
@property (nonatomic, strong) DDStretchableTableHeaderView *stretchHeaderView;
@property (nonatomic, strong) UIButton *confirmBtn;
@end

@implementation DDShopDetailViewController

static NSString *infoCell = @"infoCell";
static NSString *descriCell = @"descriCell";

#pragma mark -  懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, - kNavigationBarHeight, kScreenWidth, kScreenHeight + kNavigationBarHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[DDShopInfoTableViewCell class] forCellReuseIdentifier:infoCell];
        [_tableView registerClass:[DDShopDescTableViewCell class] forCellReuseIdentifier:descriCell];
        _tableView.tableFooterView = self.confirmBtn;
    }
    return _tableView;
}

- (UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        [_confirmBtn setTitle:@"确认地点" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_confirmBtn setBackgroundColor:kBgGreenColor];
        _confirmBtn.titleLabel.font = kFont(15);
        [_confirmBtn addTarget:self action:@selector(confirmAddress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

-(DDLoginManager *)loginManager
{
    if(!_loginManager) {
        _loginManager = [[DDLoginManager alloc]initWithController:self];
    }
    return _loginManager;
}

- (void)confirmAddress{
    LXAlertView *alert=[[LXAlertView alloc] initWithTitle:@"联系商户" message:@"我们建议您选择地点后联系商户订座确认，以免商户因位满，导致您的活动时间。" cancelBtnTitle:@"暂不联系" otherBtnTitle:@"拨打电话" clickIndexBlock:^(NSInteger clickIndex) {

        //拨打电话
        if (clickIndex == 1) {
            NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", @"15205145990"];
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
            } else {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
            }
        }
    }];
    alert.animationStyle=LXASAnimationDefault;
    [alert showLXAlertView];
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
//    self.navigationItem.leftBarButtonItem = [self whiteBackButtonForNavigationBarWithAction:@selector(dismiss)];
    [self WhiteBackNavigationWithTitle:@""];
    [self setUpViews];
    [self initStretchHeader];
}

// 设置子视图
- (void)setUpViews {
    [self.view addSubview:self.tableView];
}

- (void)initStretchHeader
{
    //背景
    _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 250)];
    _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    _bgImageView.clipsToBounds = YES;
    _bgImageView.userInteractionEnabled = YES;
    _bgImageView.image = kImage(@"person_bg_image");
    
    //背景之上的内容
    UIView *contentView = [[UIView alloc] initWithFrame:_bgImageView.bounds];
    contentView.backgroundColor = [UIColor clearColor];
    
    [contentView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(watchPic:)]];

    //    self.pageLabel = [[UILabel alloc] initWithFrame:CGRectMake(contentView.frame.size.width - 90, contentView.frame.size.height - 30, 80, 20)];
    //    self.pageLabel.textColor = [UIColor whiteColor];
    //    self.pageLabel.font = [UIFont systemFontOfSize:15];
    //    self.pageLabel.textAlignment = NSTextAlignmentRight;
    //    [contentView addSubview:self.pageLabel];
    
    self.stretchHeaderView = [DDStretchableTableHeaderView new];
    [self.stretchHeaderView stretchHeaderForTableView:self.tableView withView:_bgImageView subViews:contentView];
    
}

#pragma mark - stretchableTable delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.stretchHeaderView scrollViewDidScroll:scrollView];
}


#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *identifier = @"shopCell";
//    DDShopInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (cell == nil) {
//        cell = [[DDShopInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//    }
//
//    return cell;
    
    NSString *cellId;
    Class clazz;
    switch (indexPath.row) {
        case 0:
        {
            cellId = infoCell;
            clazz = [DDShopInfoTableViewCell class];
        }
            break;
        case 1:
        {
            cellId = descriCell;
            clazz = [DDShopDescTableViewCell class];
        }
            break;
        default:
            break;
    }
    DDBaseTableViewCell *cell =  [self createCellWithTableView:tableView indexPath:indexPath class:clazz cellId:cellId];
//    [cell updateWithModel:self.rodetailModel];
//    cell.sd_indexPath = indexPath;
    return cell;
    
}

- (DDBaseTableViewCell *)createCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath class:(Class)clazz cellId:(NSString *)cellId
{
    DDBaseTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    if (!cell) {
        cell = [[clazz alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    return cell;
}

    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end







