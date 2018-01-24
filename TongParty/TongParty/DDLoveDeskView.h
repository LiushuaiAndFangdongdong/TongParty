//
//  DDLoveDeskView.h
//  TongParty
//
//  Created by 方冬冬 on 2017/11/28.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDLoveDeskView : UIView
@property (nonatomic, copy) void(^selectClickBlcok)(NSInteger index);
@property (nonatomic, copy) void(^joinLoveClickBlcok)();
- (void)updateFunctionBtnWithArray:(NSArray *)array;
@end
