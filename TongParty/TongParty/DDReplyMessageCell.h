//
//  DDReplyMessageCell.h
//  TongParty
//
//  Created by 方冬冬 on 2017/12/18.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDBaseTableViewCell.h"
#import "LSPersonEntity.h"
@interface DDReplyMessageCell : DDBaseTableViewCell
- (void)updateWithModel:(LSPersonEntity *)entity;
@property (nonatomic, copy)void(^disagree)(NSString *sid);
@property (nonatomic, copy)void(^agree)(NSString *sid);
@end


