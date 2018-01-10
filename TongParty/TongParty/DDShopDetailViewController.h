//
//  DDShopDetailViewController.h
//  TongParty
//
//  Created by 方冬冬 on 2017/12/1.
//  Copyright © 2017年 桐聚. All rights reserved.
//
//商家详情页

#import "DDBaseViewController.h"
#import "LSShopEntity.h"
#import "LSShopDetailEntity.h"
@interface DDShopDetailViewController : DDBaseViewController
@property (nonatomic, copy) void(^selectedAddressResult)(LSShopDetailEntity *shop);
@property (nonatomic, strong) LSShopEntity *shop_entity;
@end
