//
//  LSRegionDumpsView.h
//  TongParty
//
//  Created by 刘帅 on 2017/11/18.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSRegionDumpsView : UIView
@property (nonatomic, copy) void(^onSelected)(NSString *lat, NSString *lon);
@property (nonatomic, copy) void(^onSelectedRange)(NSString *range);
@property (nonatomic, copy) void(^switchToSubway)(void);
@property (nonatomic, copy) void(^switchToRefionDumps)(void);
@property (nonatomic, strong)NSArray  *regionArray;
@property (nonatomic, strong)NSArray  *subwayArray;
@property (nonatomic, strong)NSArray     *dataArray;
@end
