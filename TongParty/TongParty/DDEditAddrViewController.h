//
//  DDEditAddrViewController.h
//  TongParty
//
//  Created by 方冬冬 on 2017/11/23.
//  Copyright © 2017年 桐聚. All rights reserved.
//
//新增地址/编辑地址

#import "DDBaseViewController.h"
#import "DDAddressModel.h"

@interface DDEditAddrViewController : DDBaseViewController
@property (nonatomic, copy)  NSString *titleStr;
@property (nonatomic, strong) DDAddressModel *tmpModel;
@end
