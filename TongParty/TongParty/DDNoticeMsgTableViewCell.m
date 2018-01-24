

//
//  DDNoticeMsgTableViewCell.m
//  TongParty
//
//  Created by 方冬冬 on 2017/12/19.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDNoticeMsgTableViewCell.h"

@interface DDNoticeMsgTableViewCell()
@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UILabel *namelbl;
@property (nonatomic, strong) UIImageView *sexView;
@property (nonatomic, strong) UILabel *messageLbl;
@property (nonatomic, strong) UILabel *timeLbl;
@end

@implementation DDNoticeMsgTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    _avatarView = [UIImageView new];
    [self.contentView addSubview:_avatarView];
    [_avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(self);
        make.width.and.height.mas_equalTo(50);
    }];
    _avatarView.layerCornerRadius = 30/2;
    _avatarView.image = kDefaultAvatar;
    
    _namelbl = [UILabel new];
    [self.contentView addSubview:_namelbl];
    [_namelbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_avatarView.mas_top);
        make.left.mas_equalTo(_avatarView.mas_right).offset(10);
    }];
    _namelbl.text = @"方嘚瑟";
    _namelbl.textColor = kBlackColor;
    _namelbl.font = kFont(15);
    
    _sexView = [UIImageView new];
    [self.contentView addSubview:_sexView];
    [_sexView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_namelbl.mas_top);
        make.left.mas_equalTo(_namelbl.mas_right).offset(2);
        make.height.mas_equalTo(_namelbl.mas_height);
        make.width.mas_equalTo(_namelbl.mas_height);
    }];
    _sexView.image = kImage(@"info_male");
    
    _messageLbl = [UILabel new];
    [self.contentView addSubview:_messageLbl];
    [_messageLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.mas_equalTo(_namelbl.mas_bottom).offset(5);
        make.bottom.mas_equalTo(_avatarView.mas_bottom);
        make.left.mas_equalTo(_namelbl.mas_left);
    }];
    _messageLbl.text = @"学长同意了你加入群";
    _messageLbl.textColor = kGrayColor;
    _messageLbl.font = kFont(14);
    
    _timeLbl = [UILabel new];
    [self.contentView addSubview:_timeLbl];
    [_timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(-10);
        //        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    _timeLbl.text = @"18-28";
    _timeLbl.textColor = kGrayColor;
    _timeLbl.font = kFont(14);
}

- (void)updateWithModel:(LSNoticeMessageEntity *)entity {
    _timeLbl.text = entity.uptime;
    _namelbl.text = entity.name;
    // 保密
    if (entity.sex.integerValue == 0) {
        _sexView.hidden = YES;
        _sexView.image = kImage(@"info_male");
    }
    // 男
    if (entity.sex.integerValue == 1) {
        _sexView.hidden = NO;
        _sexView.image = kImage(@"info_male");
    }
    // 女
    if (entity.sex.integerValue == 2) {
        _sexView.hidden = NO;
        _sexView.image = kImage(@"info_female");
    }
    _messageLbl.text = entity.msg_text;
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

