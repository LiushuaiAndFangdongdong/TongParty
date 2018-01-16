//
//  LSMACustomCalloutView.h
//  TongParty
//
//  Created by 刘帅 on 2018/1/13.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSMACustomCalloutView : UIView
@property (nonatomic, copy) void(^toDeskDetail)();
@property (nonatomic, strong)dispatch_source_t timer;
- (void)updateValueWith:(id)model onMapView:(MAMapView *)mapView;
@end
