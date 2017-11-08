//
//  DDPickerDate.h
//  WitCity
//
//  Created by 方冬冬 on 16/8/23.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDPickerView.h"

NS_ASSUME_NONNULL_BEGIN
@class DDPickerDate;
@protocol  DDPickerDateDelegate<NSObject>
- (void)pickerDate:(DDPickerDate *)pickerDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

@end
@interface DDPickerDate : DDPickerView

/** 1.最小的年份，default is 1900 */
@property (nonatomic, assign)NSInteger yearLeast;
/** 2.显示年份数量，default is 200 */
@property (nonatomic, assign)NSInteger yearSum;
/** 3.中间选择框的高度，default is 28*/
@property (nonatomic, assign)CGFloat heightPickerComponent;

@property(nonatomic, weak)id <DDPickerDateDelegate>delegate ;

@end
NS_ASSUME_NONNULL_END
