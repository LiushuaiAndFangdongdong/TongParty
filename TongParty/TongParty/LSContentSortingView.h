//
//  LSContentSortingView.h
//  TongParty
//
//  Created by 刘帅 on 2017/12/27.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSContentSortingView : UIView
@property (nonatomic, copy) void(^addCustomActivity)(void);
@property (nonatomic, copy) void(^confirmSort)(NSArray *selectedArray);
@property (nonatomic, strong)NSMutableDictionary *dataDict;

@end
