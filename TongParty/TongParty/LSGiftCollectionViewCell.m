//
//  LSGiftCollectionViewCell.m
//  TongParty
//
//  Created by 刘帅 on 2017/12/31.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSGiftCollectionViewCell.h"
#import "LSGiftEntity.h"
@implementation LSGiftCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)updateValueWith:(id)entity {
    if (!entity) {
        return;
    }
    LSGiftEntity *gEntity = (LSGiftEntity *)entity;
    [_iv_image sd_setImageWithURL:[NSURL URLWithString:gEntity.image] placeholderImage:kImage(@"Gift_tail")];
    _lbl_name.text = gEntity.gift_text;
    _lbl_coin.text =  [NSString stringWithFormat:@"%@ 桐币",gEntity.coin];
}

- (void)setSelected:(BOOL)selected {
    if (selected) {
        self.layer.borderWidth = 1.5f;
        self.layer.borderColor = kGreenColor.CGColor;
    } else {
        self.layer.borderWidth = 0.5f;
        self.layer.borderColor = kBgWhiteGrayColor.CGColor;
    }
}

@end
