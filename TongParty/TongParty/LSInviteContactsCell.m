//
//  LSInviteContactsCell.m
//  TongParty
//
//  Created by 刘帅 on 2017/12/13.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSInviteContactsCell.h"
#import "LSContactsEntity.h"

@interface LSInviteContactsCell ()
@property (weak, nonatomic) IBOutlet UILabel *lbl_userName;
@property (weak, nonatomic) IBOutlet UILabel *_lbl_description;

@end
@implementation LSInviteContactsCell

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
        _lbl_userName.text = entity.name;
        __lbl_description.text = entity.mobile;
    }
}

@end
