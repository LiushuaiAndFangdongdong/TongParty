//
//  DDInterestTableViewCell.h
//  TongParty
//
//  Created by 方冬冬 on 2017/11/3.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDBaseTableViewCell.h"
#import "DDTableModel.h"

@interface DDInterestTableViewCell : DDBaseTableViewCell
@property (nonatomic, strong) UIButton *joinedBtn;
-(void)updateWithModel:(DDTableModel *)model;
@end
