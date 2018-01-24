//
//  DDSysMsgTableViewCell.h
//  TongParty
//
//  Created by 方冬冬 on 2017/12/18.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDBaseTableViewCell.h"
#import "LSSystemMessageEntity.h"
@interface DDSysMsgTableViewCell : DDBaseTableViewCell
- (void)updateWithModel:(LSSystemMessageEntity *)model;
@end


