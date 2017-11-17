//
//  LSCDTimeAddressView.h
//  TongParty
//
//  Created by 刘帅 on 2017/10/28.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSCDTimeAddressView : UIView
@property (nonatomic, copy) void(^onClickBlcok)(NSInteger index);
@property (nonatomic, copy) void(^expandMoreBlcok)(NSInteger index);
- (void)putDataToViewWith:(id)obj returnHeight:(void(^)(CGFloat height))height;
//@property (nonatomic, assign)CGFloat height;
@end

