//
//  DDBottomView.h
//  TongParty
//
//  Created by 方冬冬 on 2017/10/12.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDBottomView : UIView
@property (nonatomic, copy) void(^bottomFunctionClickBlcok)(NSInteger index);
@end
