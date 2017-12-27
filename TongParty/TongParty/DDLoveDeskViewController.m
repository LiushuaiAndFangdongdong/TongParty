
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

@interface DDLoveDeskViewController ()<DDPickerSingleDelegate>
@property (nonatomic, strong) DDLoveDeskView *loveView;
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
        WeakSelf(weakSelf);
        _loveView.selectClickBlcok = ^(NSInteger index) {
            [weakSelf popPickerWithNsinter:index];
        };
        _loveView.joinLoveClickBlcok = ^{
            //立即加入
        };
    }
    return _loveView;
}

- (void)popPickerWithNsinter:(NSInteger)index{
    NSArray *arr = @[@"8：00~11：00",@"12：00~14：00",@"14：30~16：30",@"17：00~20：00",@"21：00~次日凌晨"];
    NSMutableArray *selectArr = [NSMutableArray arrayWithArray:arr];
    DDPickerSingle* _pickerSingle = [[DDPickerSingle alloc]init];
    [_pickerSingle setArrayData:selectArr];
    [_pickerSingle setTitle:@"选择时间"];
    [_pickerSingle setContentMode:DDPickerContentModeCenter];
    [_pickerSingle setDelegate:self];
    [_pickerSingle  show];
}

- (void)pickerSingle:(DDPickerSingle *)pickerSingle selectedTitle:(NSString *)selectedTitle{
    
}

- (void)customNavi{
    [self navigationWithTitle:@"心跳桌"];
    //返回
    UIBarButtonItem *leftBtn = [self customButtonForNavigationBarWithAction:@selector(dismiss) imageNamed:@"lovedesk_cancel" isRedPoint:NO pointValue:@"9" CGSizeMake:CGSizeMake(18, 18)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    //右边说明
    UIBarButtonItem *rightBtn = [self customButtonForNavigationBarWithAction:@selector(introduceAction) imageNamed:@"lovedesk_introduce" isRedPoint:NO pointValue:nil CGSizeMake:CGSizeMake(7*4.75, 7)];
    self.navigationItem.rightBarButtonItem = rightBtn;
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








