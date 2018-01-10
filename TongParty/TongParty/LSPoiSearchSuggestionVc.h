//
//  LSPoiSearchSuggestionVc.h
//  TongParty
//
//  Created by 刘帅 on 2018/1/9.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "DDBaseViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
@interface LSPoiSearchSuggestionVc : DDBaseViewController
@property (nonatomic, strong)UITableView *tv_suggestions;
@property (nonatomic, copy) void(^suggestionResultBlock)(AMapTip *tip);
@end
