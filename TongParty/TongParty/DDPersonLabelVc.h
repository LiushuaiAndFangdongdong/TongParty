//
//  DDPersonLabelVc.h
//  TongParty
//
//  Created by 方冬冬 on 2017/9/27.
//  Copyright © 2017年 桐聚. All rights reserved.
//
//个人标签

#import "DDBaseViewController.h"

@interface DDPersonLabelVc : DDBaseViewController
@property (nonatomic, copy) void(^chosseLabelResult)(NSString *result);
@property (nonatomic, strong) NSMutableArray *selectedArray;
@end

