//
//  DDEditAddrView.h
//  TongParty
//
//  Created by 方冬冬 on 2017/11/23.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDAddressModel.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

@interface DDEditAddrView : UIView
@property (nonatomic, copy) void(^locationAddrBlcok)();
@property (nonatomic, copy) void(^saveAddrBlcok)(DDAddressModel *addrModel);
- (void)updateWithMap:(AMapPOI *)map;
- (void)tempEditValueWith:(DDAddressModel *)model;
@end
