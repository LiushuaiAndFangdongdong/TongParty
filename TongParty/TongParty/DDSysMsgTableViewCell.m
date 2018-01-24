
//
//  DDSysMsgTableViewCell.m
//  TongParty
//
//  Created by 方冬冬 on 2017/12/18.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDSysMsgTableViewCell.h"

@interface DDSysMsgTableViewCell()

@property (nonatomic, strong) UILabel *uptimeLbl;
@property (nonatomic, strong) UIView  *bgView;
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *descLbl;
@end

@implementation DDSysMsgTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    self.contentView.backgroundColor = kBgWhiteGrayColor;
    
    _uptimeLbl = [UILabel new];
    [self.contentView addSubview:_uptimeLbl];
    [_uptimeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.centerX.mas_equalTo(self);
    }];
    _uptimeLbl.font = kFont(13);
    _uptimeLbl.textColor = kBlackColor;
    _uptimeLbl.textAlignment = NSTextAlignmentCenter;
    
    _bgView = [UIView new];
    [self.contentView addSubview:_bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_uptimeLbl.mas_bottom).offset(5);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-10);
        //        make.height.mas_equalTo(150);
    }];
    _bgView.backgroundColor = kWhiteColor;
    _bgView.layerCornerRadius = 10;
    
    _imageV = [UIImageView new];
    [_bgView addSubview:_imageV];
    [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
        make.height.mas_equalTo(150);
    }];
    _imageV.layerCornerRadius = 10;
    
    _descLbl = [UILabel new];
    [_bgView addSubview:_descLbl];
    [_descLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_imageV.mas_bottom).offset(10);
        make.left.mas_equalTo(_imageV.mas_left);
        make.right.mas_equalTo(_imageV.mas_right);
        make.bottom.mas_equalTo(-10);
    }];
    _descLbl.textColor = kGrayColor;
    _descLbl.font = kFont(14);
    _descLbl.numberOfLines = 0;
}

- (void)updateWithModel:(LSSystemMessageEntity *)model {
    
    _descLbl.text = model.msg_text;
    [_imageV sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:kImage(@"banner_image")];
    _uptimeLbl.text = model.uptime;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end










