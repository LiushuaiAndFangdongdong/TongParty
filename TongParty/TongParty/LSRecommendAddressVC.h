//
//  LSRecommendAddressVC.h
//  TongParty
//
//  Created by 刘帅 on 2017/10/29.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDBaseTableViewController.h"
#import "LSShopDetailEntity.h"
@interface LSRecommendAddressVC : DDBaseTableViewController
@property (nonatomic, copy) void(^selectedAddressResult)(LSShopDetailEntity *shop);

@end
