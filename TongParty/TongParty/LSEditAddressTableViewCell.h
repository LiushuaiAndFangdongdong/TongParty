//
//  LSEditAddressTableViewCell.h
//  TongParty
//
//  Created by 刘帅 on 2017/10/29.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDBaseTableViewCell.h"

typedef NS_ENUM(NSUInteger, LSEditCellStyle) {
    /** 详细地址*/
    LSCreateCellSytleAddressLable,
    /** 编辑详细地址*/
    LSCreateCellSytleEditAddress,
    /** 标签管理*/
    LSCreateCellSytleLableManager,
};

@interface LSEditAddressTableViewCell : DDBaseTableViewCell

@property (nonatomic, copy) void(^onClickBlcok)(NSInteger index);

@property (nonatomic, assign)LSEditCellStyle style;

@end
