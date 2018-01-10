//
//  LSDateSortCell.m
//  TongParty
//
//  Created by 刘帅 on 2018/1/3.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "LSDateSortCell.h"

@implementation LSDateSortCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.contentView.backgroundColor = kBgWhiteGrayColor;
        self.backgroundColor = kBgWhiteGrayColor;
    }
}

@end
