//
//  LSRecommendAddressCell.m
//  TongParty
//
//  Created by 刘帅 on 2017/10/29.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSRecommendAddressCell.h"
#import "LSShopEntity.h"
@interface LSRecommendAddressCell ()

@property (nonatomic, strong)UIImageView      *iv_header;
@property (nonatomic, strong)UILabel          *lbl_addressType;
@property (nonatomic, strong)UIImageView      *iv_star_highLight1;
@property (nonatomic, strong)UIImageView      *iv_star_highLight2;
@property (nonatomic, strong)UIImageView      *iv_star_highLight3;
@property (nonatomic, strong)UIImageView      *iv_star_highLight4;
@property (nonatomic, strong)UIImageView      *iv_star_highLight5;
@property (nonatomic, strong)UIImageView      *iv_star_normal1;
@property (nonatomic, strong)UIImageView      *iv_star_normal2;
@property (nonatomic, strong)UIImageView      *iv_star_normal3;
@property (nonatomic, strong)UIImageView      *iv_star_normal4;
@property (nonatomic, strong)UIImageView      *iv_star_normal5;
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
    
    _iv_star_normal1 = [UIImageView new];
    [self.contentView addSubview:self.iv_star_normal1];
    [_iv_star_normal1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(DDFitHeight(10.f));
        make.left.equalTo(_lbl_addressType);
        make.top.equalTo(_lbl_addressType.mas_bottom).offset(DDFitHeight(5.f));
        make.width.mas_equalTo(DDFitHeight(10.f));
    }];
    _iv_star_normal1.image = kImage(@"merchant_star_unlight");
    
    _iv_star_normal2 = [UIImageView new];
    [self.contentView addSubview:self.iv_star_normal2];
    [_iv_star_normal2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.top.equalTo(_iv_star_normal1);
        make.left.equalTo(_iv_star_normal1.mas_right).offset(2.f);
    }];
    _iv_star_normal2.image = kImage(@"merchant_star_unlight");
    
    _iv_star_normal3 = [UIImageView new];
    [self.contentView addSubview:self.iv_star_normal3];
    [_iv_star_normal3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.top.equalTo(_iv_star_normal2);
        make.left.equalTo(_iv_star_normal2.mas_right).offset(2.f);
    }];
    _iv_star_normal3.image = kImage(@"merchant_star_unlight");
    
    _iv_star_normal4 = [UIImageView new];
    [self.contentView addSubview:self.iv_star_normal4];
    [_iv_star_normal4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.top.equalTo(_iv_star_normal3);
        make.left.equalTo(_iv_star_normal3.mas_right).offset(2.f);
    }];
    _iv_star_normal4.image = kImage(@"merchant_star_unlight");
    
    _iv_star_normal5 = [UIImageView new];
    [self.contentView addSubview:self.iv_star_normal5];
    [_iv_star_normal5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.top.equalTo(_iv_star_normal4);
        make.left.equalTo(_iv_star_normal4.mas_right).offset(2.f);
    }];
    _iv_star_normal5.image = kImage(@"merchant_star_unlight");
    
    _iv_star_highLight1 = [UIImageView new];
    [self.contentView addSubview:self.iv_star_highLight1];
    [_iv_star_highLight1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_iv_star_normal1);
    }];
    _iv_star_highLight1.image = kImage(@"merchant_star_light");
    
    _iv_star_highLight2 = [UIImageView new];
    [self.contentView addSubview:self.iv_star_highLight2];
    [_iv_star_highLight2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_iv_star_normal2);
    }];
    _iv_star_highLight2.image = kImage(@"merchant_star_light");
    
    _iv_star_highLight3 = [UIImageView new];
    [self.contentView addSubview:self.iv_star_highLight3];
    [_iv_star_highLight3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_iv_star_normal3);
    }];
    _iv_star_highLight3.image = kImage(@"merchant_star_light");
    
    _iv_star_highLight4 = [UIImageView new];
    [self.contentView addSubview:self.iv_star_highLight4];
    [_iv_star_highLight4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_iv_star_normal4);
    }];
    _iv_star_highLight4.image = kImage(@"merchant_star_light");
    
    _iv_star_highLight5 = [UIImageView new];
    [self.contentView addSubview:self.iv_star_highLight5];
    [_iv_star_highLight5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_iv_star_normal5);
    }];
    _iv_star_highLight5.image = kImage(@"merchant_star_light");
    
    _lbl_pricePer = [UILabel new];
    [self.contentView addSubview:self.lbl_pricePer];
    [_lbl_pricePer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.equalTo(_iv_star_highLight1);
        make.top.equalTo(_iv_star_highLight1.mas_bottom).offset(5.f);
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
    _iv_BusinessHours.image = kImage(@"merchant_store");
    
    _lbl_BusinessHours = [UILabel new];
    [self.contentView addSubview:self.lbl_BusinessHours];
    [_lbl_BusinessHours mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iv_BusinessHours.mas_right).offset(DDFitWidth(5.f));
        make.height.centerY.equalTo(_iv_BusinessHours);
    }];
    _lbl_BusinessHours.text = @"营业时间10:00-22:00";
    _lbl_BusinessHours.textColor = kCommonGrayTextColor;
    _lbl_BusinessHours.font = DDFitFont(12.f);
    
    NSArray *hightlight_star_array = @[_iv_star_highLight1,_iv_star_highLight2,_iv_star_highLight3,_iv_star_highLight4,_iv_star_highLight5];
    for (UIImageView *iv_star in hightlight_star_array) {
        iv_star.hidden = YES;
    }
    
    // starCount -- 评分对应点亮星星个数
    for (int starCount = 0; starCount < hightlight_star_array.count; starCount ++) {
        if (starCount <= 3) {
            UIImageView *iv = hightlight_star_array[starCount];
            iv.hidden = NO;
        }
    }
}

- (void)updateValueWith:(id)model {
    LSShopEntity *shop = (LSShopEntity *)model;
    if (!shop) {
        return;
    }
    [_iv_header sd_setImageWithURL:[NSURL URLWithString:shop.image] placeholderImage:kImage(@"")];
    _lbl_addressType.text = shop.name;
    _lbl_pricePer.text = [NSString stringWithFormat:@"¥ %@/人",shop.average_price];
    _lbl_road_distance.text = shop.address;
    NSArray *hightlight_star_array = @[_iv_star_highLight1,_iv_star_highLight2,_iv_star_highLight3,_iv_star_highLight4,_iv_star_highLight5];
    for (int starCount = 0; starCount < hightlight_star_array.count; starCount ++) {
        if (starCount <= shop.star.intValue) {
            UIImageView *iv = hightlight_star_array[starCount];
            iv.hidden = NO;
        }
    }
    _lbl_BusinessHours.text = [NSString stringWithFormat:@"营业时间 %@-%@",shop.star_time,shop.end_time];
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

