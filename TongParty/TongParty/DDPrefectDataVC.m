
//
//  DDPrefectDataVC.m
//  TongParty
//
//  Created by 方冬冬 on 2017/12/25.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDPrefectDataVC.h"
#import "DDPrefectDataView.h"

@interface DDPrefectDataVC ()
@property (nonatomic, strong) DDPrefectDataView *dataView;
@end

@implementation DDPrefectDataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationWithTitle:@"完善基本信息"];
    [self.view addSubview:self.dataView];
}

- (DDPrefectDataView *)dataView{
    if (!_dataView) {
        _dataView = [[DDPrefectDataView alloc] initWithFrame:self.view.bounds];
        _dataView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight * 2);
    }
    return _dataView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end











