//
//  LSRegionDumpsVC.m
//  TongParty
//
//  Created by 刘帅 on 2017/12/27.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSRegionDumpsVC.h"
#import "LSRegionDumpsView.h"
#import "LSSubwayEntity.h"
#import "LSAdmRegionEntity.h"
@interface LSRegionDumpsVC ()
@property (nonatomic, strong)LSRegionDumpsView *regionDumpsView;
@end

@implementation LSRegionDumpsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self setupViews];
}

- (void)loadData {
    [super loadData];
    
//    [DDTJHttpRequest getAdministrativeRegionWith:@"0" block:^(NSDictionary *dict) {
//
//    } failure:^{
//
//    }];
    
    // 目前只支持北京
    [MBProgressHUD showLoading:self.regionDumpsView];
    [DDTJHttpRequest getAdministrativeChildRegionWith:@"1" block:^(NSDictionary *dict) {
        [MBProgressHUD hideAllHUDsInView:self.regionDumpsView];
        NSArray *citys = [LSAdmRegionEntity mj_objectArrayWithKeyValuesArray:dict];
        for (LSAdmRegionEntity *entity in citys) {
            if (entity.pid.integerValue == 1) {
                _regionDumpsView.regionArray = [LSAdmRegionEntity mj_objectArrayWithKeyValuesArray:entity.children];
                _regionDumpsView.dataArray = _regionDumpsView.regionArray;
            }
        }
    } failure:^{
        
    }];
}


- (void)setupViews {
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.regionDumpsView];
}

- (LSRegionDumpsView *)regionDumpsView {
    WeakSelf(weakSelf);
    if (!_regionDumpsView) {
        _regionDumpsView = [[LSRegionDumpsView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kScreenHeight*2/2.8f)];
        _regionDumpsView.switchToRefionDumps = ^{
            [weakSelf loadRegionData];
        };
        _regionDumpsView.onSelected = ^(NSString *lat, NSString *lon) {
            if (weakSelf.confirmSort) {
                weakSelf.confirmSort(lon, lat);
            }
        };
        _regionDumpsView.onSelectedRange = ^(NSString *range) {
            weakSelf.selectRangeSort(range);
        };
        _regionDumpsView.switchToSubway = ^{
            [weakSelf loadSubwayData];
        };
    }
    return _regionDumpsView;
}

- (void)loadRegionData {
    // 目前只支持北京
    [DDTJHttpRequest getAdministrativeChildRegionWith:@"1" block:^(NSDictionary *dict) {
        NSArray *citys = [LSAdmRegionEntity mj_objectArrayWithKeyValuesArray:dict];
        for (LSAdmRegionEntity *entity in citys) {
            if (entity.pid.integerValue == 1) {
                _regionDumpsView.regionArray = [LSAdmRegionEntity mj_objectArrayWithKeyValuesArray:entity.children];
            }
        }
    } failure:^{
        
    }];
}

- (void)loadSubwayData {
    // 地铁数据
    [DDTJHttpRequest getSubwayDataWithAid:@"2" block:^(NSDictionary *dict) {
        _regionDumpsView.subwayArray = [LSSubwayEntity mj_objectArrayWithKeyValuesArray:dict];
        _regionDumpsView.dataArray = _regionDumpsView.subwayArray;
    } failure:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
