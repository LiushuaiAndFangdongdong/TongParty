//
//  DDJoinDeskMessageCell.h
//  TongParty
//
//  Created by 方冬冬 on 2017/11/28.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDBaseTableViewCell.h"
#import "DDMessageModel.h"

@interface DDJoinDeskMessageCell : DDBaseTableViewCell
-(void)updateMessageCellWithModel:(DDMessageModel *)model;
@end
