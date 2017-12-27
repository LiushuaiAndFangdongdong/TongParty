//
//  DDPermissonViewController.h
//  TongParty
//
//  Created by 方冬冬 on 2017/9/29.
//  Copyright © 2017年 桐聚. All rights reserved.
//
//设置隐私,权限

#import "DDBaseTableViewController.h"

@interface DDPermissonViewController : DDBaseTableViewController

/**
 隐私设置名称
 */
@property (nonatomic, strong)NSString *name;

/**
 隐私权限
 */
@property (nonatomic, strong)NSString *statu;
@end

