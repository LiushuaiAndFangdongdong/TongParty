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
        _nameLabel.font = kFont(13);
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
        _followBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 65, 25, 55, 20)];
        _followBtn.backgroundColor = kLightGreenColor;
        [_followBtn setTitle:@"跟随" forState:UIControlStateNormal];
        [_followBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _followBtn.titleLabel.font = kFont(12);
    }
    return _followBtn;
}
-(UILabel *)timeLabel{
    if(!_timeLabel){
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 80, 25, 70, 20)];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.font = kFont(12);
        _timeLabel.textColor = kGrayColor;
        _timeLabel.text = @"2017-09-27";
    }
    return _timeLabel;
}
-(void)setStyle:(DDFriendsCellStyle)style{
    
    [self.contentView addSubview:self.avatarView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.desLabel];
    
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(self.avatarView.mas_height);
    }];
    _avatarView.layerCornerRadius = self.avatarView.width/2;
    
    switch (style) {
        case DDFriendsCellStyleNormal:
        {
            _desLabel.frame = CGRectMake(70, 36, kScreenWidth - 150, 30);
            _nameLabel.frame = CGRectMake(70, 4, kScreenWidth - 150, 30);
            [self.contentView addSubview:self.followBtn];
        }
        break;
        case DDFriendsCellStyleCare:
        {
            _desLabel.frame = CGRectMake(70, 36, kScreenWidth - 150, 30);
            _nameLabel.frame = CGRectMake(70, 4, kScreenWidth - 150, 30);
            [self.contentView addSubview:self.followBtn];
        }break;
            case DDFriendsCellStyleCared:
        {
            _desLabel.frame = CGRectMake(70, 36, kScreenWidth - 75, 30);
            _nameLabel.frame = CGRectMake(70, 4, kScreenWidth - 150, 30);
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end














