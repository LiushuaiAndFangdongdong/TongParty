//
//  DDPickerArea.h
//  WitCity
//
//  Created by 方冬冬 on 16/8/23.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDPickerView.h"
NS_ASSUME_NONNULL_BEGIN
@class DDPickerArea;
@protocol  DDPickerAreaDelegate<NSObject>

- (void)pickerArea:(DDPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area;

@end
@interface DDPickerArea : DDPickerView
/** 1.中间选择框的高度，default is 32*/
@property (nonatomic, assign)CGFloat heightPickerComponent;

@property(nonatomic, weak)id <DDPickerAreaDelegate>delegate ;
@end
NS_ASSUME_NONNULL_END