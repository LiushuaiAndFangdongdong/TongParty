//
//  DDNoticeMessageCell.m
//  TongParty
//
//  Created by 方冬冬 on 2017/11/28.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDNoticeMessageCell.h"

@interface DDNoticeMessageCell()
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UILabel *timeLabel;  
@end

@implementation DDNoticeMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    
    _iconView = [UIImageView new];
    [self.contentView addSubview:_iconView];
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(10);
        make.width.and.height.mas_equalTo(60);
    }];
    _iconView.image = kImage(@"invite_message");
    
    _nameLabel = [UILabel new];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(_iconView.mas_right).offset(10);
        make.height.mas_equalTo(20);
    }];
    _nameLabel.text = @"申请回复";
    _nameLabel.textColor = kBlackColor;
    _nameLabel.font = kFont(15);
    
    _messageLabel = [UILabel new];
    [self.contentView addSubview:_messageLabel];
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameLabel);
        make.top.mas_equalTo(_nameLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(20);
        make.right.mas_equalTo(-5);
    }];
    _messageLabel.text = @"学长同意你加入斗地主";
    _messageLabel.textColor = kGrayColor;
    _messageLabel.font = kFont(14);
    _messageLabel.textAlignment = NSTextAlignmentLeft;
    
    _timeLabel = [UILabel new];
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_messageLabel);
        make.top.mas_equalTo(_messageLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(20);
    }];
    _timeLabel.text = @"昨天下午19：30";
    _timeLabel.textColor = kGrayColor;
    _timeLabel.font = kFont(14);
    _timeLabel.textAlignment = NSTextAlignmentLeft;
}

//重新设置的UITableViewCellframe,---->改变row之间的间距。
- (void)setFrame:(CGRect)frame{
//    frame.origin.x += 5;
    frame.origin.y += 2;
    frame.size.height -= 2;
//    frame.size.width -= 10;
    [super setFrame:frame];
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
