//
//  LSRegionDumpsVC.m
//  TongParty
//
//  Created by 刘帅 on 2017/12/27.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSRegionDumpsVC.h"
#import "LSRegionDumpsView.h"
@interface LSRegionDumpsVC ()
@property (nonatomic, strong)LSRegionDumpsView *regionDumpsView;
@end

@implementation LSRegionDumpsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}
- (void)setupViews {
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.regionDumpsView];
}

- (LSRegionDumpsView *)regionDumpsView {
    if (!_regionDumpsView) {
        _regionDumpsView = [[LSRegionDumpsView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kScreenHeight*2/3)];
    }
    return _regionDumpsView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
