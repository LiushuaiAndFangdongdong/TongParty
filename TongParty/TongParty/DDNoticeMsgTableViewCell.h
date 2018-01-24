//
//  DDNoticeMsgTableViewCell.h
//  TongParty
//
//  Created by 方冬冬 on 2017/12/19.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDBaseTableViewCell.h"
#import "LSNoticeMessageEntity.h"
@interface DDNoticeMsgTableViewCell : DDBaseTableViewCell
- (void)updateWithModel:(LSNoticeMessageEntity *)entity;
@end


