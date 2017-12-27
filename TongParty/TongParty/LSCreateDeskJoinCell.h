//
//  LSCreateDeskJoinCell.h
//  TongParty
//
//  Created by 刘帅 on 2017/12/23.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDBaseTableViewCell.h"

@interface LSCreateDeskJoinCell : DDBaseTableViewCell
@property (nonatomic , copy)NSString *isHeart;
@property (nonatomic, copy) void(^selectIsHeart)(NSString *isheart);
@end
