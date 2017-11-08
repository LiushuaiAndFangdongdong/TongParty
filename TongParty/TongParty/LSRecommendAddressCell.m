//
//  LSRecommendAddressCell.m
//  TongParty
//
//  Created by 刘帅 on 2017/10/29.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSRecommendAddressCell.h"

@interface LSRecommendAddressCell ()

@property (nonatomic, strong)UIImageView      *iv_header;
@property (nonatomic, strong)UILabel          *lbl_addressType;
@property (nonatomic, strong)UIImageView      *iv_star_highLight;
@property (nonatomic, strong)UIImageView      *iv_star_normal;
@property (nonatomic, strong)UILabel          *lbl_line;
@property (nonatomic, strong)UILabel          *lbl_pricePer;
@property (nonatomic, strong)UILabel          *lbl_road_distance;
@property (nonatomic, strong)UIImageView      *iv_BusinessHours;
@property (nonatomic, strong)UILabel          *lbl_BusinessHours;

@end

@implementation LSRecommendAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    
    _iv_header = [UIImageView new];
    [self.contentView addSubview:self.iv_header];
    [_iv_header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(DDFitWidth(10.f));
        make.centerY.equalTo(self);
        make.height.width.mas_equalTo(self.contentView.mas_height).multipliedBy(0.8f);
    }];
    _iv_header.image = kImage(@"person_bg_image");
    
    _lbl_addressType = [UILabel new];
    [self.contentView addSubview:self.lbl_addressType];
    [_lbl_addressType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iv_header.mas_right).offset(DDFitWidth(10.f));
        make.top.equalTo(_iv_header).offset(-DDFitHeight(5.f));
        make.height.mas_equalTo(DDFitHeight(20.f));
    }];
    _lbl_addressType.text = @"星猫网咖";
    _lbl_addressType.textColor = kBlackColor;
    _lbl_addressType.font = DDFitFont(15.f);
    
    _iv_star_normal = [UIImageView new];
    [self.contentView addSubview:self.iv_star_normal];
    [_iv_star_normal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(DDFitHeight(10.f));
        make.left.equalTo(_lbl_addressType);
        make.top.equalTo(_lbl_addressType.mas_bottom).offset(DDFitHeight(5.f));
        make.width.mas_equalTo(DDFitWidth(60.f));
    }];
    _iv_star_normal.backgroundColor = kBlackColor;
    
    _iv_star_highLight = [UIImageView new];
    [self.contentView addSubview:self.iv_star_highLight];
    [_iv_star_highLight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_iv_star_normal);
    }];
    _iv_star_highLight.backgroundColor = kBlackColor;
    
    _lbl_pricePer = [UILabel new];
    [self.contentView addSubview:self.lbl_pricePer];
    [_lbl_pricePer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.equalTo(_iv_star_highLight);
        make.top.equalTo(_iv_star_highLight.mas_bottom).offset(5.f);
    }];
    _lbl_pricePer.textColor = kCommonGrayTextColor;
    _lbl_pricePer.text = @"¥ 96/人";
    _lbl_pricePer.font = DDFitFont(12.f);
    
    _lbl_road_distance = [UILabel new];
    [self.contentView addSubview:self.lbl_road_distance];
    [_lbl_road_distance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.equalTo(_lbl_pricePer);
        make.right.mas_equalTo(-DDFitWidth(10.f));
    }];
    _lbl_road_distance.text = @"阜成路北／0.4km";
    _lbl_road_distance.textColor = kCommonGrayTextColor;
    _lbl_road_distance.font = DDFitFont(12.f);
    _lbl_road_distance.textAlignment = NSTextAlignmentRight;
    
    _lbl_line = [UILabel new];
    [self.contentView addSubview:self.lbl_line];
    [_lbl_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lbl_pricePer);
        make.height.mas_equalTo(kLineHeight);
        make.right.equalTo(_lbl_road_distance);
        make.top.equalTo(_lbl_road_distance.mas_bottom).offset(DDFitHeight(5.f));
    }];
    _lbl_line.backgroundColor = kCommonGrayTextColor;
    
    _iv_BusinessHours = [UIImageView new];
    [self.contentView addSubview:self.iv_BusinessHours];
    [_iv_BusinessHours mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lbl_line.mas_bottom).offset(DDFitHeight(5.f));
        make.left.equalTo(_lbl_line);
        make.height.width.mas_equalTo(DDFitHeight(10.f));
    }];
    _iv_BusinessHours.backgroundColor = kBlueColor;
    
    _lbl_BusinessHours = [UILabel new];
    [self.contentView addSubview:self.lbl_BusinessHours];
    [_lbl_BusinessHours mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iv_BusinessHours.mas_right).offset(DDFitWidth(5.f));
        make.height.centerY.equalTo(_iv_BusinessHours);
    }];
    _lbl_BusinessHours.text = @"营业时间10:00-22:00";
    _lbl_BusinessHours.textColor = kCommonGrayTextColor;
    _lbl_BusinessHours.font = DDFitFont(12.f);
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
