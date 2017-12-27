//
//  LSAddContactsCell.m
//  TongParty
//
//  Created by 刘帅 on 2017/12/13.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSAddContactsCell.h"
#import "LSContactsEntity.h"


@implementation LSAddContactsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)updateValueWith:(id)model {
    LSContactsEntity *entity = (LSContactsEntity *)model;
    if (entity) {
        [_headerImageView sd_setImageWithURL:[NSURL URLWithString:entity.image]];
        _lbl_userName.text = entity.name;
        _lbl_description.text = entity.mobile;
    }
}

@end
