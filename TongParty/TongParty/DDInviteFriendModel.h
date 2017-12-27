//
//  DDInviteFriendModel.h
//  TongParty
//
//  Created by 方冬冬 on 2017/12/7.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDModel.h"

@interface DDInviteFriendModel : DDModel
@property (nonatomic, copy) NSString *friend_id; //好友id
@property (nonatomic, copy) NSString *remark;    //好友备注
@property (nonatomic, copy) NSString *name;      //好友昵称
@property (nonatomic, copy) NSString *image;     //好友头像
@property (nonatomic, copy) NSString *score;     //好友积分
@property (nonatomic, copy) NSString *is_send;   //是否发送过邀请：0-未邀请，1-已邀请
@end
