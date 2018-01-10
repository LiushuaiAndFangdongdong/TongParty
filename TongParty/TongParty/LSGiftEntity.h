//
//  LSGiftEntity.h
//  TongParty
//
//  Created by 刘帅 on 2018/1/2.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "DDModel.h"

@interface LSGiftEntity : DDModel

/**
 id
 */
@property (nonatomic, copy)NSString *gid;

/**
 费用
 */
@property (nonatomic, copy)NSString *coin;

/**
 图片
 */
@property (nonatomic, copy)NSString *image;

/**
 礼物名
 */
@property (nonatomic, copy)NSString *gift_text;
@end
