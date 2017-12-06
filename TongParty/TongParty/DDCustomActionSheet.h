//
//  DDCustomActionSheet.h
//  TongParty
//
//  Created by 方冬冬 on 2017/9/14.
//  Copyright © 2017年 桐聚. All rights reserved.
//
//  自定义ActionSheet，类似于系统的UIActionSheet

#import <UIKit/UIKit.h>

@class DDCustomActionSheet;
typedef void(^DDCustomActionSheetItemClickHandle)(DDCustomActionSheet *actionSheet, NSInteger currentIndex, NSString *title);

@interface DDCustomActionSheet : UIView

/**
 *  初始化
 *
 *  @param cancelTitle 取消
 *  @param alertTitle  提示文字
 *  @param title       子控件文本
 */
+ (instancetype)actionSheetWithCancelTitle:(NSString *)cancelTitle alertTitle:(NSString *)alertTitle SubTitles:(NSArray *)title,...NS_REQUIRES_NIL_TERMINATION;

- (void)setCustomActionSheetItemClickHandle:(DDCustomActionSheetItemClickHandle)itemClickHandle;

- (void)setActionSheetDismissItemClickHandle:(DDCustomActionSheetItemClickHandle)dismissItemClickHandle;

- (void)show;
@end







