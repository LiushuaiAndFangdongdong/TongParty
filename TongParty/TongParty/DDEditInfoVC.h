//
//  DDEditInfoVC.h
//  TongParty
//
//  Created by 方冬冬 on 2017/9/26.
//  Copyright © 2017年 桐聚. All rights reserved.
//
//信息编辑

#import "DDBaseViewController.h"

@interface DDEditInfoVC : DDBaseViewController
@property (nonatomic, copy) void(^editResult)(NSString *result);
@end

