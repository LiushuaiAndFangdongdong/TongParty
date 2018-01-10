//
//  LSSortingView.h
//  TongParty
//
//  Created by 刘帅 on 2017/11/4.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSSortingView : UIView
@property (nonatomic, copy) void(^onTapBlcok)(NSInteger index);
- (void)clean;
@end
