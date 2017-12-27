//
//  DDPersonInfoTableViewCell.h
//  TongParty
//
//  Created by 方冬冬 on 2017/9/26.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDBaseTableViewCell.h"

typedef NS_ENUM(NSUInteger, DDPersonInfoCellStyle) {
    /** 常规*/
    DDPersonInfoCellStyleNormal,
    /** 头像*/
    DDPersonInfoCellStyleAvatar,
    /** 标签*/
    DDPersonInfoCellStyleLabel
};


@interface DDPersonInfoTableViewCell : DDBaseTableViewCell
@property (nonatomic, copy) NSString *namestring;
@property (nonatomic, copy) NSString *valuestring;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, strong) UILabel *valueLbl;
@property (nonatomic, assign) DDPersonInfoCellStyle style;
@end

