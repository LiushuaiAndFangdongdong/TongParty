//
//  DDTicketModel.h
//  TongParty
//
//  Created by 方冬冬 on 2018/1/16.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "DDModel.h"

@interface DDTicketModel : DDModel
@property (nonatomic, copy) NSString *name;  //道具名称
@property (nonatomic, copy) NSString *coin;  //价值
@property (nonatomic, copy) NSString *my_coin;//当前用户余额
@end
