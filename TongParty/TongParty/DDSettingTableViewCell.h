//
//  DDSettingTableViewCell.h
//  TongParty
//
//  Created by 方冬冬 on 2017/9/26.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDBaseTableViewCell.h"
#import "DDRadioButton.h"
typedef NS_ENUM(NSUInteger, DDSettingCellStyle) {
    /** 常规*/
    DDSettingCellStyleNormal,
    /** 退出按钮*/
    DDSettingCellStyleCentertext,
    /** 开关*/
    DDSettingCellStyleSwitch,
    /** 权限选择 */
    DDSettingCellStyleSelectImg,
    /** 单选 */
    DDSingleSelectStyleSelectImg
};

@interface DDSettingTableViewCell : DDBaseTableViewCell
@property (nonatomic, copy) NSString *namestring;
@property (nonatomic, copy) NSString *valuestring;
@property (nonatomic, strong) UIColor *valueColor;
@property (nonatomic, copy) NSString *centerText;
@property (nonatomic, assign) DDSettingCellStyle style;
@property (nonatomic, strong) DDRadioButton  *ra_btn;
@property (nonatomic,   copy) void(^setPrivacy)(NSString *statu);
@end

