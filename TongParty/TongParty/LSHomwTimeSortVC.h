//
//  LSHomwTimeSortVC.h
//  TongParty
//
//  Created by 刘帅 on 2018/1/3.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "DDBaseViewController.h"

@interface LSHomwTimeSortVC : DDBaseViewController
@property (nonatomic, copy) void(^confirmSort)(NSString *begin_time, NSString *end_time);
@end
