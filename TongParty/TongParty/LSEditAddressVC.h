//
//  LSEditAddressVC.h
//  TongParty
//
//  Created by 刘帅 on 2017/10/29.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDBaseViewController.h"

@interface LSEditAddressVC : DDBaseViewController
// 判断控制器是编辑还是添加车位
@property (nonatomic, assign)BOOL  isEditAddress;

/** 需要修改的地址的id*/
@property (nonatomic,   copy)NSString  *aid;
@end
