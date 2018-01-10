//
//  LSTimeSortTableViewCell.m
//  TongParty
//
//  Created by 刘帅 on 2018/1/3.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "LSTimeSortTableViewCell.h"

@implementation LSTimeSortTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.textLabel.textColor = kGreenColor;
    } else {
        self.textLabel.textColor = [UIColor darkGrayColor];
    }
}

@end
