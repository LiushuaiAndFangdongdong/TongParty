
//
//  DDLocationAddressVC.m
//  TongParty
//
//  Created by 方冬冬 on 2017/11/15.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDLocationAddressVC.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

@interface DDLocationAddressVC ()<AMapSearchDelegate>
@property (nonatomic, strong) AMapSearchAPI *search;
@end

@implementation DDLocationAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    
    request.location            = [AMapGeoPoint locationWithLatitude:39.990459 longitude:116.481476];
    request.keywords            = @"电影院";
    /* 按照距离排序. */
    request.sortrule            = 0;
    request.requireExtension    = YES;
    [self.search AMapPOIAroundSearch:request];
}
/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
        return;
    }
    
    //解析response获取POI信息，具体解析见 Demo
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end













