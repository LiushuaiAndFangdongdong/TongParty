
//
//  DDLoveDeskViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/11/1.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDLoveDeskViewController.h"
#import "DDLoveDeskView.h"

@interface DDLoveDeskViewController ()
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
    self.view.backgroundColor = kSeperatorColor;
    [self.view addSubview:self.loveView];
}

- (DDLoveDeskView *)loveView{
    if (!_loveView) {
        _loveView = [[DDLoveDeskView alloc] initWithFrame:self.view.bounds];
    }
    return _loveView;
}

- (void)customNavi{
    [self navigationWithTitle:@"心跳桌"];
    //左边消息按钮
    UIBarButtonItem *leftBtn = [self customButtonForNavigationBarWithAction:@selector(messageAction) imageNamed:@"lovedesk_cancel" isRedPoint:YES pointValue:@"9" CGSizeMake:CGSizeMake(20, 20)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    //右边设置按钮
    UIBarButtonItem *rightBtn = [self customButtonForNavigationBarWithAction:@selector(settingAction) imageNamed:@"lovedesk_introduce" isRedPoint:NO pointValue:nil CGSizeMake:CGSizeMake(7*4.75, 7)];
    self.navigationItem.rightBarButtonItem = rightBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end








