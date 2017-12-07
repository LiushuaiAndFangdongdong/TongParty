//
//  DDInviteFriendCell.m
//  TongParty
//
//  Created by 方冬冬 on 2017/12/7.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDInviteFriendCell.h"

@interface DDInviteFriendCell()
@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UILabel *nickName;
@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, strong) UIButton *inviteBtn;
@end

@implementation DDInviteFriendCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    self.avatarView = [UIImageView new];
    [self.contentView addSubview:self.avatarView];
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(10);
        make.width.and.height.mas_equalTo(45);
    }];
    self.avatarView.layerCornerRadius = 45/2;
    
    self.nickName = [UILabel new];
    [self.contentView addSubview:self.nickName];
    [self.nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12.5);
        make.left.mas_equalTo(self.avatarView.mas_right).offset(10);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(150);
    }];
    self.nickName.font = kFont(15);
    self.nickName.textColor = kBlackColor;
    
    self.scoreLabel = [UILabel new];
    [self.contentView addSubview:self.scoreLabel];
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nickName.mas_bottom).offset(5);
        make.left.mas_equalTo(self.nickName);
        make.height.and.width.mas_equalTo(self.nickName);
    }];
    self.scoreLabel.font = kFont(13);
    self.scoreLabel.textColor = kGrayColor;
    
    self.inviteBtn = [UIButton new];
    [self.contentView addSubview:self.inviteBtn];
    [self.inviteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(-10);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60/2);
    }];
    self.inviteBtn.layerCornerRadius = 5;
    self.inviteBtn.titleLabel.font = kFont(15);
    self.inviteBtn.backgroundColor = kBgGreenColor;
    [self.inviteBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [self.inviteBtn setTitle:@"邀请" forState:UIControlStateNormal];
    [self.inviteBtn addTarget:self action:@selector(inviteFriendAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)updateDataWithModel:(DDInviteFriendModel *)model{
    [self.avatarView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:kDefaultAvatar];
    if (model.remark == nil || model.remark == NULL) {
        self.nickName.text = model.name;
    }else{
        self.nickName.text = [NSString stringWithFormat:@"%@(%@)",model.name,model.remark];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"积分：%@",model.score];
}

//邀请好友
- (void)inviteFriendAction{
    if (_inviteClickBlcok) {
        _inviteClickBlcok();
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end







