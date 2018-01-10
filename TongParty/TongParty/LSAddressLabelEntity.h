//
//  LSAddressLabelEntity.h
//  TongParty
//
//  Created by 刘帅 on 2017/12/29.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDModel.h"

@interface LSAddressLabelEntity : DDModel

/**
 标签id
 */
@property (nonatomic, copy) NSString *id;

/**
 标签名称
 */
@property (nonatomic, copy) NSString *name;
@end
