//
//  DDMAAnnotationView.h
//  TongParty
//
//  Created by 方冬冬 on 2017/9/19.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import "LSMapAnnotationModel.h"

@interface DDMAAnnotationView : MAAnnotationView
- (void)updateValueWith:(id)model;
@property (nonatomic, copy) void(^onClicked)(void);
@end
