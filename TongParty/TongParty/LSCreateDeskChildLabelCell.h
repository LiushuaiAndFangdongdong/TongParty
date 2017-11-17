//
//  LSCreateDeskChildLabelCell.h
//  TongParty
//
//  Created by 刘帅 on 2017/11/12.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDBaseTableViewCell.h"

@interface LSCreateDeskChildLabelCell : DDBaseTableViewCell
@property (nonatomic, copy) void(^onClickBlcok)(NSInteger index);
@property (nonatomic, copy) void(^expandMoreBlcok)(CGFloat final_height);
- (void)updateWithObj:(id)obj;
@end
