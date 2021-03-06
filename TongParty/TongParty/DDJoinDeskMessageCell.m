//
//  DDJoinDeskMessageCell.m
//  TongParty
//
//  Created by 方冬冬 on 2017/11/28.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDJoinDeskMessageCell.h"

@interface DDJoinDeskMessageCell()
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *positionLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UILabel *startTimeLabel;
@property (nonatomic, strong) UILabel *timeLabel;     
@end

@implementation DDJoinDeskMessageCell

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
//    _iconView.image = kImage(@"hoster_message");
    
    _nameLabel = [UILabel new];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(_iconView.mas_right).offset(10);
        make.height.mas_equalTo(20);
    }];
//    _nameLabel.text = @"KTV";
    _nameLabel.textColor = kBlackColor;
    _nameLabel.font = kFont(15);
    
    _positionLabel = [UILabel new];
    [self.contentView addSubview:_positionLabel];
    [_positionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameLabel);
        make.left.mas_equalTo(_nameLabel.mas_right).offset(5);
        make.height.mas_equalTo(_nameLabel);
    }];
//    _positionLabel.text = @" 我是桌主 ";
    _positionLabel.textColor = kWhiteColor;
    _positionLabel.backgroundColor = kBgGreenColor;
    _positionLabel.font = kFont(12);
    _positionLabel.layerCornerRadius = 5;
    
    _startTimeLabel = [UILabel new];
    [self.contentView addSubview:_startTimeLabel];
    [_startTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_positionLabel);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(_positionLabel);
    }];
//    _startTimeLabel.text = @"11月25号 11：11开桌";
    _startTimeLabel.textColor = kGrayColor;
    _startTimeLabel.font = kFont(12);
    _startTimeLabel.textAlignment = NSTextAlignmentRight;
    
    _messageLabel = [UILabel new];
    [self.contentView addSubview:_messageLabel];
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameLabel);
        make.top.mas_equalTo(_nameLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
        make.right.mas_equalTo(-5);
    }];
//    _messageLabel.text = @"学长等5人进入了桌子";
    _messageLabel.textColor = kGrayColor;
    _messageLabel.font = kFont(14);
    _messageLabel.textAlignment = NSTextAlignmentLeft;
    
    _timeLabel = [UILabel new];
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_messageLabel);
        make.top.mas_equalTo(_messageLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
    }];
//    _timeLabel.text = @"昨天下午19：30";
    _timeLabel.textColor = kGrayColor;
    _timeLabel.font = kFont(14);
    _timeLabel.textAlignment = NSTextAlignmentLeft;
}

-(void)updateMessageCellWithModel:(DDMessageModel *)model{
    self.nameLabel.text = model.custom;
    self.messageLabel.text = model.msg_text;
    self.timeLabel.text = model.uptime;
    
    if ([model.mid isEqualToString:MSG_TYPE_SYS]) {
        _iconView.image = kImage(@"system_message");
        _positionLabel.hidden = YES;
        _startTimeLabel.hidden = YES;
    }
   else if ([model.mid isEqualToString:MSG_TYPE_REWORD]) {
        _iconView.image = kImage(@"reward_message");
       _positionLabel.hidden = YES;
       _startTimeLabel.hidden = YES;
    }
   else if ([model.mid isEqualToString:MSG_TYPE_ATTENTION]) {
        _iconView.image = kImage(@"cared_message");
       _positionLabel.hidden = YES;
       _startTimeLabel.hidden = YES;
    }
   else if ([model.mid isEqualToString:MSG_TYPE_APPLY]) {
        _iconView.image = kImage(@"apply_message");
       _positionLabel.hidden = YES;
       _startTimeLabel.hidden = YES;
    }
   else if ([model.mid isEqualToString:MSG_TYPE_INVITE]) {
        _iconView.image = kImage(@"invite_message");
       _positionLabel.hidden = YES;
       _startTimeLabel.hidden = YES;
    }
   else if ([model.mid isEqualToString:MSG_TYPE_HOST]) {
        _iconView.image = kImage(@"hoster_message");
       _positionLabel.text = @" 我是桌主 ";
       _startTimeLabel.text = model.begin_time;
       _positionLabel.hidden = NO;
       _startTimeLabel.hidden = NO;
    }
   else if ([model.mid isEqualToString:MSG_TYPE_JOIN]) {
        _iconView.image = kImage(@"joined_message");
       _positionLabel.text = @" 参加的 ";
       _startTimeLabel.text = model.begin_time;
       _positionLabel.hidden = NO;
       _startTimeLabel.hidden = NO;
    }else{}
}

//重新设置的UITableViewCellframe,---->改变row之间的间距。
//- (void)setFrame:(CGRect)frame{
////    frame.origin.x += 5;
//    frame.origin.y += 2;
//    frame.size.height -= 2;
////    frame.size.width -= 10;
//    [super setFrame:frame];
//}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end











