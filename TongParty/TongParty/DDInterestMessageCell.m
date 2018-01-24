//
//  DDInterestMessageCell.m
//  TongParty
//
//  Created by 方冬冬 on 2017/12/18.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDInterestMessageCell.h"

@interface DDInterestMessageCell()
@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UILabel *namelbl;
@property (nonatomic, strong) UIImageView *sexView;
@property (nonatomic, strong) UILabel *distanceLbl;
@property (nonatomic, strong) UILabel *messageLbl;
@property (nonatomic, strong) UIButton *inviteBtn;
@property (nonatomic, copy) NSString *to_id;
@end

@implementation DDInterestMessageCell

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
    
    _distanceLbl = [UILabel new];
    [self.contentView addSubview:_distanceLbl];
    [_distanceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        //        make.centerY.mas_equalTo(_namelbl.centerY);
        make.top.mas_equalTo(_namelbl.mas_top);
    }];
    _distanceLbl.text = @"距离12km·5分钟前";
    _distanceLbl.textColor = kBlackColor;
    _distanceLbl.font = kFont(13);
    
    
    _messageLbl = [UILabel new];
    [self.contentView addSubview:_messageLbl];
    [_messageLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.mas_equalTo(_namelbl.mas_bottom).offset(5);
        make.bottom.mas_equalTo(_avatarView.mas_bottom);
        make.left.mas_equalTo(_namelbl.mas_left);
    }];
    _messageLbl.text = @"对您的桌子产生了兴趣";
    _messageLbl.textColor = kGrayColor;
    _messageLbl.font = kFont(14);
    
    _inviteBtn = [UIButton new];
    [self.contentView addSubview:_inviteBtn];
    [_inviteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.centerY.mas_equalTo(_messageLbl.centerY);
        make.bottom.mas_equalTo(_avatarView.mas_bottom);
        make.right.mas_equalTo(-10);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    [_inviteBtn setTitle:@"邀请" forState:UIControlStateNormal];
    [_inviteBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [_inviteBtn setBackgroundColor:kBgGreenColor];
    _inviteBtn.layerCornerRadius = 8;
    _inviteBtn.titleLabel.font = kFont(12);
}

-(void)updateWithModel:(LSPersonEntity *)entity {
    _namelbl.text = entity.name;
    _to_id = entity.uid;
    _distanceLbl.text = [NSString stringWithFormat:@"%.fkm·%@",entity.distance.integerValue/1000.f,entity.uptime];
    [_avatarView sd_setImageWithURL:[NSURL URLWithString:entity.image] placeholderImage:kImage(@"avatar_default")];
    if (entity.is_send.integerValue == 0) {
        [_inviteBtn setTitle:@"邀请" forState:UIControlStateNormal];
        [_inviteBtn addTarget:self action:@selector(inviteJoin:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [_inviteBtn setTitle:@"已邀请" forState:UIControlStateNormal];
    }
    
    if (entity.status.integerValue == 0) {
        _inviteBtn.hidden = YES;
    } else {
        _inviteBtn.hidden = NO;
    }
}

- (void)inviteJoin:(UIButton *)sender {
    if (!_to_id) {
        return;
    }
    if (_inviteJoin) {
        _inviteJoin(_to_id);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end


