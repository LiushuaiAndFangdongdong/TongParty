
//
//  DDLoveDeskViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/11/1.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDLoveDeskViewController.h"
#import "DDLoveDeskView.h"
#import "DDDeskMatchViewController.h"
#import "DDPickerSingle.h"
#import "LSCreateDeskContentSortVC.h"
#import "DDMatchFailedView.h"
#import "DDDeskShowViewController.h"

@interface DDLoveDeskViewController ()<DDPickerSingleDelegate>
@property (nonatomic, strong) DDLoveDeskView *loveView;
@property (nonatomic, strong) LSCreateDeskContentSortVC *contenSortVc;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, copy) NSString *timeStr;
@property (nonatomic, copy) NSString *activityName;
@property (nonatomic, copy) NSString *rangeStr;
@property (nonatomic, copy) NSString *averagePriceStr;
@property (nonatomic, copy) NSString *activityId;
@property (nonatomic, strong) DDMatchFailedView *failedView;
@end

@implementation DDLoveDeskViewController

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
    _timeStr = @"选择时间";
    _activityName = @"筛选活动";
    _rangeStr = @"选择距离";
    _averagePriceStr = @"选择人均";
    _activityId = @"";
    [self customNavi];
    [self setupViews];
}

- (void)setupViews{
    self.view.backgroundColor = kBgWhiteGrayColor;
    [self.view addSubview:self.loveView];
}

- (DDLoveDeskView *)loveView{
    if (!_loveView) {
        _loveView = [[DDLoveDeskView alloc] initWithFrame:self.view.bounds];
        _titleArray = @[@"选择时间",@"选择距离",@"筛选活动",@"选择人均"];
        [_loveView updateFunctionBtnWithArray:_titleArray];
        WeakSelf(weakSelf);
        _loveView.selectClickBlcok = ^(NSInteger index) {
            [weakSelf popPickerWithNsinter:index];
        };
        _loveView.joinLoveClickBlcok = ^{
            //立即加入
            [weakSelf beginMatch];
        };
    }
    return _loveView;
}

- (LSCreateDeskContentSortVC *)contenSortVc {
    if (!_contenSortVc) {
        _contenSortVc = [[LSCreateDeskContentSortVC alloc] init];
    }
    return _contenSortVc;
}

- (DDMatchFailedView *)failedView{
    if (!_failedView) {
        WeakSelf(weakSelf);
        _failedView = [[DDMatchFailedView alloc] initWithFrame:self.view.bounds];
        _failedView.backHomeClickBlcok = ^{
            //返回首页
            [weakSelf dismiss];
        };
    }
    return _failedView;
}

//开始匹配，加入桌子
- (void)beginMatch{

    //分割时间和人均字符串
    NSString *begin_time = @"";
    NSString *end_time = @"";
    NSString *average_price = @"";
    NSString *end_price = @"";
    
    if (![_timeStr isEqualToString:@"选择时间"]) {
        NSArray *timeArr;
        if ([_timeStr isEqualToString:@"21：00~次日凌晨"]) {
            timeArr = @[@"21:00",@"23:59"];
        }else{
            timeArr=[_timeStr componentsSeparatedByString:@"~"];
        }
        begin_time = timeArr[0];
        end_time = timeArr[1];
    }
    
    if (![_averagePriceStr isEqualToString:@"选择人均"]) {
        NSArray *priceArr;
        if ([_averagePriceStr isEqualToString:@"50以下"]) {
            priceArr = @[@"0",@"50"];
        }else if ([_averagePriceStr isEqualToString:@"300以上"]){
            priceArr = @[@"300",@MAXFLOAT];
        }else{
            priceArr=[_averagePriceStr componentsSeparatedByString:@"-"];
        }
        average_price = priceArr[0];
        end_price = priceArr[1];
    }
    [MBProgressHUD showLoading:@"匹配中..." toView:self.view];
    [DDTJHttpRequest matchJoinLoveDeskWithToken:TOKEN activity:_activityId begin_time:begin_time end_time:end_time average_price:average_price end_price:end_price lat:[DDUserSingleton shareInstance].latitude lon:[DDUserSingleton shareInstance].longitude range:_rangeStr block:^(NSDictionary *dict) {
        [MBProgressHUD hideAllHUDsInView:self.view];
        if (dict == NULL || dict == nil) {
            //没有匹配的桌子
            [self clearNavi];
            [self.loveView removeFromSuperview];
            [self.view addSubview:self.failedView];
        }else{
            //匹配成功
            [self pushDeskDetailVCWithTid:dict[@"tid"]];
        }
    } failure:^{
        //
    }];
}

//匹配成功，跳转桌子详情
- (void)pushDeskDetailVCWithTid:(NSString *)tid{
    DDDeskShowViewController *deskVc = [[DDDeskShowViewController alloc] init];
    deskVc.tmpModel.id = tid;
    [self.navigationController pushViewController:deskVc animated:YES];
}

- (void)clearNavi{
    [self navigationWithTitle:@""];
    //返回
    self.navigationItem.leftBarButtonItem = [self customButtonForNavigationBarWithAction:@selector(kuo) imageNamed:@"" isRedPoint:NO pointValue:nil CGSizeMake:CGSizeMake(18, 18)];
    //右边说明
    self.navigationItem.rightBarButtonItem = [self customButtonForNavigationBarWithAction:@selector(kuo) imageNamed:@"" isRedPoint:NO pointValue:nil CGSizeMake:CGSizeMake(7*4.75, 7)];
}

-(void)kuo{
    NSLog(@"没用的");
}

- (void)popPickerWithNsinter:(NSInteger)index{
    NSArray *arr;
    NSString *title;
    NSString *unitTitle;
    if (index == 10) {
        //筛选活动
        WeakSelf(weakSelf);
        self.contenSortVc.selectActivity = ^(LSActivityEntity *entity) {
            _activityId = entity.id;
            _activityName = entity.name;
            _titleArray = @[_timeStr,_rangeStr,weakSelf.activityName,_averagePriceStr];
            [weakSelf.loveView updateFunctionBtnWithArray:weakSelf.titleArray];
        };
        [self pushVc:self.contenSortVc];
    }else{
        if (index == 0) {
            //选择时间
            arr  = @[@"8:00~11:00",@"12:00~14:00",@"14:30~16:30",@"17:00~20:00",@"21:00~次日凌晨"];
            title = @"选择时间";
            unitTitle = @"时";
        }else if (index == 1){
            //选择距离
            arr  = @[@"500",@"1000",@"2000",@"5000"];
            title = @"选择距离";
            unitTitle = @"米";
        }else if (index == 11){
            //选择人均
            arr  = @[@"50以下",@"50-100",@"100-300",@"300以上"];
            title = @"选择人均";
            unitTitle = @"元";
        }else{}
        
        NSMutableArray *selectArr = [NSMutableArray arrayWithArray:arr];
        DDPickerSingle* _pickerSingle = [[DDPickerSingle alloc]init];
        [_pickerSingle setArrayData:selectArr];
        [_pickerSingle setTitle:title];
        [_pickerSingle setTitleUnit:unitTitle];
        [_pickerSingle setContentMode:DDPickerContentModeBottom];
        [_pickerSingle setDelegate:self];
        [_pickerSingle  show];
    }
}

- (void)pickerSingle:(DDPickerSingle *)pickerSingle selectedTitle:(NSString *)selectedTitle{
    NSLog(@"%@",selectedTitle);
    if ([pickerSingle.title isEqualToString:@"选择时间"]) {
        _timeStr = selectedTitle;
    }else if ([pickerSingle.title isEqualToString:@"选择距离"]){
        _rangeStr = selectedTitle;
    }else if ([pickerSingle.title isEqualToString:@"选择人均"]){
        _averagePriceStr = selectedTitle;
    }else{}
    _titleArray = @[_timeStr,_rangeStr,@"筛选活动",_averagePriceStr];
    [self.loveView updateFunctionBtnWithArray:_titleArray];
}

- (void)customNavi{
    [self navigationWithTitle:@"心跳桌"];
    //返回
    self.navigationItem.leftBarButtonItem = [self customButtonForNavigationBarWithAction:@selector(dismiss) imageNamed:@"lovedesk_cancel" isRedPoint:NO pointValue:@"9" CGSizeMake:CGSizeMake(18, 18)];
    //右边说明
    self.navigationItem.rightBarButtonItem = [self customButtonForNavigationBarWithAction:@selector(introduceAction) imageNamed:@"lovedesk_introduce" isRedPoint:NO pointValue:nil CGSizeMake:CGSizeMake(7*4.75, 7)];
}


-(void)introduceAction{
    NSLog(@"活动说明");
    DDDeskMatchViewController *matchVC =  [[DDDeskMatchViewController alloc] init];
    [self.navigationController pushViewController:matchVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end








