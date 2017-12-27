

//
//  DDReplyMessageCell.m
//  TongParty
//
//  Created by 方冬冬 on 2017/12/18.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDReplyMessageCell.h"

@interface DDReplyMessageCell()
@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UILabel *namelbl;
@property (nonatomic, strong) UIImageView *sexView;
@property (nonatomic, strong) UILabel *distanceLbl;
@property (nonatomic, strong) UILabel *messageLbl;
@property (nonatomic, strong) UIButton *agreeBtn;
@property (nonatomic, strong) UIButton *disagreeBtn;
@end

@implementation DDReplyMessageCell

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
    _messageLbl.text = @"学长同意了你加入群";
    _messageLbl.textColor = kGrayColor;
    _messageLbl.font = kFont(14);
    
    _disagreeBtn = [UIButton new];
    [self.contentView addSubview:_disagreeBtn];
    [_disagreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(_messageLbl.centerY);
        make.bottom.mas_equalTo(_avatarView.mas_bottom);
        make.right.mas_equalTo(-10);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    [_disagreeBtn setTitle:@"不同意" forState:UIControlStateNormal];
    [_disagreeBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [_disagreeBtn setTitleColor:kBgGreenColor forState:UIControlStateHighlighted];
    [_disagreeBtn setBackgroundColor:kGrayColor];
    _disagreeBtn.layerCornerRadius = 8;
    _disagreeBtn.titleLabel.font = kFont(12);
    
    _agreeBtn = [UIButton new];
    [self.contentView addSubview:_agreeBtn];
    [_agreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(_messageLbl.centerY);
        make.bottom.mas_equalTo(_disagreeBtn.mas_bottom);
        make.right.mas_equalTo(_disagreeBtn.mas_left).offset(-5);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    [_agreeBtn setTitle:@"同意" forState:UIControlStateNormal];
    [_agreeBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [_agreeBtn setBackgroundColor:kBgGreenColor];
    _agreeBtn.layerCornerRadius = 8;
    _agreeBtn.titleLabel.font = kFont(12);
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end



