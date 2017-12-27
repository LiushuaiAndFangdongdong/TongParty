//
//  DDFriendsTableViewCell.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/27.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDFriendsTableViewCell.h"
#import "DDBaseImageView.h"
#import "UIView+Layer.h"
#import "LSPlayRewardEntity.h"
#import "LSFriendEntity.h"
#import "LSTableEntity.h"
#import "LSCareEntity.h"
#import "LSBlacklistEntity.h"
@interface DDFriendsTableViewCell()
@property (nonatomic, strong) DDBaseImageView *avatarView; //头像
@property (nonatomic, strong) UILabel *nameLabel;      //名称
@property (nonatomic, strong) UILabel *desLabel;       //描述
@property (nonatomic, strong) UIButton *followBtn;     //跟随
@property (nonatomic, strong) UILabel *timeLabel;      //时间
@end

@implementation DDFriendsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
-(DDBaseImageView *)avatarView{
    if(!_avatarView){
        _avatarView = [[DDBaseImageView alloc] init];
        _avatarView.image = kImage(@"AppIcon");
    }
    return _avatarView;
}
-(UILabel *)nameLabel{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = kFont(14.f);
        _nameLabel.textColor = kBlackColor;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.text = @"方习冬";
    }
    return _nameLabel;
}
-(UILabel *)desLabel{
    if(!_desLabel){
        _desLabel = [[UILabel alloc] init];
        _desLabel.font = kFont(12);
        _desLabel.textColor = kGrayColor;
        _desLabel.textAlignment = NSTextAlignmentLeft;
        _desLabel.text = @"打牌克，今晚十点三里屯不见不散哦,你会来吗，c";
        _desLabel.numberOfLines = 2;
    }
    return _desLabel;
}
-(UIButton *)followBtn{
    if(!_followBtn){
        _followBtn = [UIButton new];
        _followBtn.backgroundColor = kLightGreenColor;
        [_followBtn setTitle:@"跟随" forState:UIControlStateNormal];
        [_followBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _followBtn.titleLabel.font = kFont(12);
    }
    return _followBtn;
}
-(UILabel *)timeLabel{
    if(!_timeLabel){
        _timeLabel = [UILabel new];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.font = kFont(12);
        _timeLabel.textColor = kGrayColor;
        _timeLabel.text = @"2017-09-27";
    }
    return _timeLabel;
}
-(void)setStyle:(DDFriendsCellStyle)style{
    _style = style;
    [self.contentView addSubview:self.avatarView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.desLabel];
    
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(self.contentView);
        make.width.height.mas_equalTo(DDFitWidth(50.f));
    }];
    _avatarView.layer.cornerRadius = DDFitWidth(50.f)/2;
    _avatarView.layer.masksToBounds = YES;
    switch (style) {
        case DDFriendsCellStyleNormal: {
            [self.contentView addSubview:self.followBtn];
            [_followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.contentView);
                make.right.mas_equalTo(-DDFitWidth(20.f));;
                make.height.mas_equalTo(DDFitHeight(40.f));
                make.width.mas_equalTo(60.f);
            }];
            _followBtn.layer.cornerRadius = 20.f;
            [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_avatarView.mas_right).offset(10.f);
                make.top.equalTo(_avatarView).offset(-DDFitHeight(5.f));
                make.height.mas_equalTo(DDFitHeight(25.f));
            }];
            [_desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_avatarView.mas_right).offset(10.f);
                make.top.equalTo(_nameLabel.mas_bottom).offset(5.f);
                make.height.mas_equalTo(DDFitHeight(30.f));
                make.right.equalTo(_followBtn.mas_left).offset(-10.f);
            }];
        }
            break;
        case DDFriendsCellStyleCare:{
            [self.contentView addSubview:self.followBtn];
            [_followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.contentView);
                make.right.mas_equalTo(-DDFitWidth(20.f));;
                make.height.mas_equalTo(DDFitHeight(40.f));
                make.width.mas_equalTo(60.f);
            }];
            _followBtn.layer.cornerRadius = 20.f;
            [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_avatarView.mas_right).offset(10.f);
                make.top.equalTo(_avatarView).offset(-DDFitHeight(5.f));
                make.height.mas_equalTo(DDFitHeight(25.f));
            }];
            [_desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_avatarView.mas_right).offset(10.f);
                make.top.equalTo(_nameLabel.mas_bottom).offset(5.f);
                make.height.mas_equalTo(DDFitHeight(30.f));
                make.right.equalTo(_followBtn.mas_left).offset(-10.f);
            }];
        }break;
        case DDFriendsCellStyleCared: {
            [self.contentView addSubview:self.followBtn];
            [_followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.contentView);
                make.right.mas_equalTo(-DDFitWidth(20.f));;
                make.height.mas_equalTo(DDFitHeight(40.f));
                make.width.mas_equalTo(60.f);
            }];
            _followBtn.layer.cornerRadius = 20.f;
            [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_avatarView.mas_right).offset(10.f);
                make.top.equalTo(_avatarView).offset(-DDFitHeight(5.f));
                make.height.mas_equalTo(DDFitHeight(25.f));
            }];
            [_desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_avatarView.mas_right).offset(10.f);
                make.top.equalTo(_nameLabel.mas_bottom).offset(5.f);
                make.height.mas_equalTo(DDFitHeight(30.f));
                make.right.equalTo(_followBtn.mas_left).offset(-10.f);
            }];
        }break;
        case DDFriendsCellStyleReward:
        {
            _desLabel.frame = CGRectMake(70, 36, kScreenWidth - 150, 30);
            _nameLabel.frame = CGRectMake(70, 4, kScreenWidth - 150, 30);
            [self.contentView addSubview:self.timeLabel];
        }break;
        case DDFriendsCellStyleBlackList:
        {
            [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.avatarView.mas_right).offset(10);
                make.centerY.mas_equalTo(self.contentView);
            }];
        }
            break;
        default:
            break;
    }
}

- (void)updateWithEntity:(id)entity {
    switch (_style) {
        case DDFriendsCellStyleNormal:{
            LSFriendEntity *f_entity = (LSFriendEntity *)entity;
            [_avatarView setImageWithUrl:f_entity.image placeHolder:kDefaultAvatar];
            _nameLabel.text = f_entity.name;
            NSArray <LSTableEntity *>*table = [LSTableEntity mj_objectArrayWithKeyValuesArray:f_entity.table];
            if (table && table.count > 0) {
                _desLabel.text = [NSString stringWithFormat:@"%@ %@ %@",table[0].activity,table[0].begin_time,table[0].place];
            }
        }break;
        case DDFriendsCellStyleCare:{
            LSCareEntity *c_entity = (LSCareEntity *)entity;
            [_avatarView setImageWithUrl:c_entity.image placeHolder:kDefaultAvatar];
            _nameLabel.text = c_entity.name;
            _desLabel.text = [NSString stringWithFormat:@"%@ %@ %@",c_entity.activity,c_entity.begin_time,c_entity.place];
        }break;
        case DDFriendsCellStyleCared:{
            LSCareEntity *c_entity = (LSCareEntity *)entity;
            [_avatarView setImageWithUrl:c_entity.image placeHolder:kDefaultAvatar];
            _nameLabel.text = c_entity.name;
            _desLabel.text = [NSString stringWithFormat:@"%@ %@ %@",c_entity.activity,c_entity.begin_time,c_entity.place];
        }break;
        case DDFriendsCellStyleReward:{
            LSPlayRewardEntity *pr_entity = (LSPlayRewardEntity *)entity;
            [_avatarView setImageWithUrl:pr_entity.image placeHolder:kDefaultAvatar];
            _nameLabel.text = pr_entity.name;
            _desLabel.text = pr_entity.gift_text;
            
        }break;
        case DDFriendsCellStyleBlackList: {
            LSBlacklistEntity *bl_entity = (LSBlacklistEntity *)entity;
            [_avatarView setImageWithUrl:bl_entity.image placeHolder:kDefaultAvatar];
            _nameLabel.text = bl_entity.name;
        }
            break;
        default:
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end














