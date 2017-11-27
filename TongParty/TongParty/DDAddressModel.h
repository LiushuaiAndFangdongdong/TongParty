//
//  DDAddressModel.h
//  TongParty
//
//  Created by 方冬冬 on 2017/11/20.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDModel.h"

@interface DDAddressModel : DDModel
@property (nonatomic, copy) NSString *id;   //id
@property (nonatomic, copy) NSString *is_default;  //是否是默认
@property (nonatomic, copy) NSString *longitude;   //经度
@property (nonatomic, copy) NSString *latitude;    //纬度
@property (nonatomic, copy) NSString *detail;      //地址详细地址
@property (nonatomic, copy) NSString *addr;       //地址位置
@property (nonatomic, copy) NSString *label;     //标签
@end
