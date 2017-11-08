//
//  DDPickerSingle.h
//  WitCity
//
//  Created by 方冬冬 on 16/8/23.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDPickerView.h"

NS_ASSUME_NONNULL_BEGIN
@class DDPickerSingle;
@protocol  DDPickerSingleDelegate<NSObject>
- (void)pickerSingle:(DDPickerSingle *)pickerSingle selectedTitle:(NSString *)selectedTitle;
@end

@interface DDPickerSingle : DDPickerView

/** 1.设置字符串数据数组 */
@property (nonatomic, strong)NSMutableArray<NSString *> *arrayData;
/** 2.设置单位标题 */
@property (nonatomic, strong)NSString *titleUnit;
/** 3.中间选择框的高度，default is 44*/
@property (nonatomic, assign)CGFloat heightPickerComponent;
/** 4.中间选择框的宽度，default is 32*/
@property (nonatomic, assign)CGFloat widthPickerComponent;
@property(nonatomic, weak)id <DDPickerSingleDelegate>delegate;

@end
NS_ASSUME_NONNULL_END