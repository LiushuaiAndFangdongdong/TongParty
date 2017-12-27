//
//  LSHomeQRcodeVC.h
//  TongParty
//
//  Created by 刘帅 on 2017/12/11.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDBaseViewController.h"
@class LSQRScanView;

// 统一用prasent入场
@interface LSHomeQRcodeVC : DDBaseViewController

@property(nonatomic, strong)LSQRScanView  *scanView;
@property (nonatomic, copy) void(^allBlock)(NSString *scanResult);

@end
