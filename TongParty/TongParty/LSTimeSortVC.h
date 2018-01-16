//
//  LSTimeSortVC.h
//  TongParty
//
//  Created by 刘帅 on 2017/12/27.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDBaseViewController.h"

@interface LSTimeSortVC : DDBaseViewController
@property (nonatomic, copy) void(^onTimeClickBlcok)(NSString *begin, NSString *end);
@end
