//
//  DDInviteFriendCell.h
//  TongParty
//
//  Created by 方冬冬 on 2017/12/7.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDBaseTableViewCell.h"
#import "DDInviteFriendModel.h"

@interface DDInviteFriendCell : DDBaseTableViewCell
- (void)updateDataWithModel:(DDInviteFriendModel *)model;
@property (nonatomic, copy) void(^inviteClickBlcok)();
@end
