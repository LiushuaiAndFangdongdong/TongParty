//
//  DDLocationAddressVC.h
//  TongParty
//
//  Created by 方冬冬 on 2017/11/15.
//  Copyright © 2017年 桐聚. All rights reserved.
//
//定位地址并选择地址

#import "DDBaseViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

@interface DDLocationAddressVC : DDBaseViewController
@property (nonatomic, copy) void(^locationAddressSelectBlcok)(AMapPOI *POI);
@end
