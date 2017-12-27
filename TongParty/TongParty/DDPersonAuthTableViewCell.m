//
//  DDPersonAuthTableViewCell.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/28.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDPersonAuthTableViewCell.h"

@interface DDPersonAuthTableViewCell ()
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *statuLabel;
@end

@implementation DDPersonAuthTableViewCell
//宽高之比29/32
- (void)awakeFromNib {
    [super awakeFromNib];
}
-(UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.iconView];
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.left.mas_equalTo(10);
            make.bottom.mas_equalTo(-15);
            make.width.mas_equalTo(20*0.91);
        }];
    }
    return _iconView;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconView.mas_right).offset(10);
            make.centerY.mas_equalTo(self.iconView.centerY);
        }];
        _nameLabel.font = kFont(13);
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.textColor = kBlackColor;
    }
    return _nameLabel;
}

-(UILabel *)statuLabel{
    if (!_statuLabel) {
        _statuLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.statuLabel];
        [self.statuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView.mas_right).offset(-5);
            make.centerY.mas_equalTo(self.iconView.centerY);
        }];
        _statuLabel.font = kFont(13);
        _statuLabel.textAlignment = NSTextAlignmentLeft;
        _statuLabel.textColor = kBlackColor;
    }
    return _statuLabel;
}
-(void)setIconstring:(NSString *)iconstring{
    self.iconView.image = kImage(iconstring);
}
-(void)setNamestring:(NSString *)namestring{
    self.nameLabel.text = namestring;
}
-(void)setStatustring:(NSString *)statustring {
    self.statuLabel.text = statustring;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end







