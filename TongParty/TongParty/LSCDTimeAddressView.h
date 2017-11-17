//
//  LSCDTimeAddressView.h
//  TongParty
//
//  Created by 刘帅 on 2017/10/28.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSCDTimeAddressView : UIView
@property (nonatomic, assign) CGFloat           current_height;
@property (nonatomic,   copy) void(^onClickBlcok)(NSInteger index);
@property (nonatomic,   copy) void(^expandMoreBlcok)(CGFloat final_height);
- (void)putDataToViewWith:(id)obj returnHeight:(void(^)(CGFloat height))height;
- (void)putStringToChildView:(NSString *)string;
@end

