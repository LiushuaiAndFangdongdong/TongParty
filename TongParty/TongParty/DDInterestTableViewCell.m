
//
//  DDInterestTableViewCell.m
//  TongParty
//
//  Created by 方冬冬 on 2017/11/3.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDInterestTableViewCell.h"
#import "DDStatusAvatar.h"
#import "UIButton+DDImagePosition.h"

@interface DDInterestTableViewCell()
@property (nonatomic, strong) DDStatusAvatar *sAvatar;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subjectLabel;
@property (nonatomic, strong) UIButton *timeBtn;
@property (nonatomic, strong) UIButton *numPerople;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UILabel *horizontalLine;
@property (nonatomic, strong) UIButton*storeBtn;
@property (nonatomic, strong) UIButton *addressBtn;
@end

@implementation DDInterestTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    _sAvatar = [DDStatusAvatar new];
    [self.contentView addSubview:_sAvatar];
    [_sAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.width.and.height.mas_equalTo(80);
    }];
    _sAvatar.avatarstring  = @"avatar_default";
    _sAvatar.statusstring  = @"desklist_status_host";
    
    
    _titleLabel = [UILabel new];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_sAvatar);
        make.left.mas_equalTo(_sAvatar.right).mas_equalTo(10);
        make.height.mas_equalTo(20);
        make.right.mas_equalTo(-5);
    }];
    _titleLabel.text = @"狼人杀";
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.font = kFont(15);
    
    _subjectLabel = [UILabel new];
    [self.contentView addSubview:_subjectLabel];
    [_subjectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(_titleLabel);
        make.right.mas_equalTo(-5);
        make.height.mas_equalTo(20);
    }];
    _subjectLabel.text = @"主题：大家一起嗨，祖居懒跟啥";
    _subjectLabel.font = kFont(13);
    
    _timeBtn = [UIButton new];
    [self.contentView addSubview:_timeBtn];
    [_timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_subjectLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(_subjectLabel);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    [_timeBtn setTitle:@"09:00" forState:UIControlStateNormal];
    [_timeBtn setBackgroundImage:kImage(@"desklist_clock") forState:UIControlStateNormal];
    [_timeBtn layoutButtonWithEdgeInsetsStyle:DDButtonEdgeInsetsStyleLeft imageTitleSpace:5];
    
    _numPerople = [UIButton new];
    [self.contentView addSubview:_numPerople];
    [_numPerople mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.mas_equalTo(_timeBtn.mas_bottom).offset(5);
        make.left.mas_equalTo(_subjectLabel.mas_right).offset(5);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    [_numPerople setTitle:@"10人" forState:UIControlStateNormal];
    [_numPerople setBackgroundImage:kImage(@"desklist_people") forState:UIControlStateNormal];
    [_numPerople layoutButtonWithEdgeInsetsStyle:DDButtonEdgeInsetsStyleLeft imageTitleSpace:5];
    
    _distanceLabel = [UILabel new];
    [self.contentView addSubview:_distanceLabel];
    [_distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_numPerople);
        make.left.mas_equalTo(_numPerople.mas_right).offset(10);
        make.right.mas_equalTo(-5);
        make.height.mas_equalTo(20);
    }];
    _distanceLabel.textAlignment = NSTextAlignmentRight;
    _distanceLabel.text = @"198m | 10人已参加";
    
    _horizontalLine = [UILabel new];
    [self.contentView addSubview:_horizontalLine];
    [_horizontalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_numPerople.mas_bottom).offset(5);
        make.left.mas_equalTo(_titleLabel);
        make.right.mas_equalTo(-5);
        make.height.mas_equalTo(1);
    }];
    _horizontalLine.backgroundColor = kGrayColor;
    
    _storeBtn = [UIButton new];
    [self.contentView addSubview:_storeBtn];
    [_storeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_horizontalLine.mas_bottom).offset(5);
        make.left.mas_equalTo(_titleLabel);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    [_storeBtn setTitle:@"望京咖啡厅" forState:UIControlStateNormal];
    [_storeBtn setBackgroundImage:kImage(@"merchant_store") forState:UIControlStateNormal];
    [_storeBtn layoutButtonWithEdgeInsetsStyle:DDButtonEdgeInsetsStyleLeft imageTitleSpace:5];
    
    
    _addressBtn = [UIButton new];
    [self.contentView addSubview:_addressBtn];
    [_addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_storeBtn.mas_bottom).offset(5);
        make.left.mas_equalTo(_subjectLabel);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    [_addressBtn setTitle:@"北京市海淀区中关村" forState:UIControlStateNormal];
    [_addressBtn setBackgroundImage:kImage(@"desklist_address") forState:UIControlStateNormal];
    [_addressBtn layoutButtonWithEdgeInsetsStyle:DDButtonEdgeInsetsStyleLeft imageTitleSpace:5];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end














