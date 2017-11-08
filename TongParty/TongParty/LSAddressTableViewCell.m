//
//  LSAddressTableViewCell.m
//  TongParty
//
//  Created by 刘帅 on 2017/10/28.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSAddressTableViewCell.h"
#import "DDRadioButton.h"

@interface LSAddressTableViewCell ()<DDRadioButtonDelegate>
@property (nonatomic, strong)UILabel        *lbl_lable;
@property (nonatomic, strong)UILabel        *lbl_address;
@property (nonatomic, strong)UILabel        *lbl_line;
@property (nonatomic, strong)DDRadioButton  *ra_default;
@property (nonatomic, strong)UILabel        *lbl_default_des;
@property (nonatomic, strong)UIImageView    *iv_edit;
@property (nonatomic, strong)UIButton       *btn_edit;
@property (nonatomic, strong)UIImageView    *iv_delete;
@property (nonatomic, strong)UIButton       *btn_delete;
@end
static NSInteger baseTag = 88888;
@implementation LSAddressTableViewCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    
    _lbl_lable = [UILabel new];
    [self.contentView addSubview:self.lbl_lable];
    [_lbl_lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(DDFitWidth(10.f));
        make.height.mas_equalTo(DDFitHeight(14.f));
        make.top.mas_equalTo(DDFitHeight(5.f));
    }];
    _lbl_lable.text = @"公司    ";
    _lbl_lable.font = DDFitFont(10.f);
    _lbl_lable.textColor = kRGBColor(118.f, 213.f, 113.f);
    _lbl_lable.layer.borderColor = kRGBColor(118.f, 213.f, 113.f).CGColor;
    _lbl_lable.layer.borderWidth = 1.f;
    _lbl_lable.layer.cornerRadius = 3.f;
    _lbl_lable.textAlignment = NSTextAlignmentCenter;
    
    
    _lbl_address = [UILabel new];
    [self.contentView addSubview:self.lbl_address];
    [_lbl_address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lbl_lable.mas_bottom).offset(DDFitHeight(5.f));
        make.left.equalTo(_lbl_lable);
        make.height.mas_equalTo(30.f);
        make.right.mas_equalTo(-DDFitWidth(10.f));
    }];
    _lbl_address.text = @"北京市海淀区阜北社区41单元9号";
    _lbl_address.font = DDFitFont(16.f);
    _lbl_address.textColor = kBlackColor;
    
    
    _lbl_line = [UILabel new];
    [self addSubview:self.lbl_line];
    [_lbl_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lbl_address);
        make.height.mas_equalTo(kLineHeight);
        make.right.mas_offset(-DDFitWidth(10.f));
        make.top.equalTo(_lbl_address.mas_bottom).offset(DDFitHeight(5.f));
    }];
    _lbl_line.backgroundColor = kLineBgColor;
    
    _ra_default = [[DDRadioButton alloc] initWithDelegate:self groupId:@"default_address"];
    [self addSubview:self.ra_default];
    [_ra_default mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lbl_line.mas_bottom).offset(5.f);
        make.left.equalTo(_lbl_line);
        make.height.width.mas_equalTo(DDFitWidth(25.f));
    }];
    
    _lbl_default_des = [UILabel new];
    [self.contentView addSubview:self.lbl_default_des];
    [_lbl_default_des mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.centerY.equalTo(_ra_default);
        make.left.equalTo(_ra_default.mas_right).offset(DDFitWidth(1.f));
    }];
    _lbl_default_des.text = @"设为默认地址";
    _lbl_default_des.font = DDFitFont(12.f);
    _lbl_default_des.textColor = kCommonGrayTextColor;
    
    _btn_delete = [UIButton new];
    [self.contentView addSubview:self.btn_delete];
    [_btn_delete mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-DDFitWidth(10.f));
        make.centerY.equalTo(_lbl_default_des);
        make.height.mas_equalTo(DDFitHeight(15.f));
        make.width.mas_equalTo(DDFitWidth(25.f));
    }];
    [_btn_delete setTitle:@"删除" forState:UIControlStateNormal];
    [_btn_delete setTitleColor:kCommonGrayTextColor forState:UIControlStateNormal];
    _btn_delete.titleLabel.font = DDFitFont(12.f);
    _btn_delete.tag = baseTag + 1;
    [_btn_delete addTarget:self action:@selector(onClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    _iv_delete = [UIImageView new];
    [self.contentView addSubview:self.iv_delete];
    [_iv_delete mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_btn_delete);
        make.right.equalTo(_btn_delete.mas_left).offset(-DDFitWidth(2.f));
        make.height.width.mas_equalTo(DDFitHeight(15.f));
    }];
    _iv_delete.image = kImage(@"desk_address_delete");
    
    _btn_edit = [UIButton new];
    [self.contentView addSubview:self.btn_edit];
    [_btn_edit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_iv_delete.mas_left).offset(-DDFitWidth(10.f));
        make.centerY.equalTo(_lbl_default_des);
        make.height.mas_equalTo(DDFitHeight(15.f));
        make.width.mas_equalTo(DDFitWidth(25.f));
    }];
    [_btn_edit setTitle:@"编辑" forState:UIControlStateNormal];
    [_btn_edit setTitleColor:kCommonGrayTextColor forState:UIControlStateNormal];
    _btn_edit.titleLabel.font = DDFitFont(12.f);
    _btn_edit.tag = baseTag + 0;
    [_btn_edit addTarget:self action:@selector(onClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    _iv_edit = [UIImageView new];
    [self.contentView addSubview:self.iv_edit];
    [_iv_edit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_btn_edit);
        make.right.equalTo(_btn_edit.mas_left).offset(-DDFitWidth(2.f));
        make.height.width.mas_equalTo(DDFitHeight(15.f));
    }];
    _iv_edit.image = kImage(@"desk_address_edit");
    
}

- (void)onClicked:(UIButton *)sender {
    if (_onClickBlcok) {
        _onClickBlcok(sender.tag - baseTag);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
