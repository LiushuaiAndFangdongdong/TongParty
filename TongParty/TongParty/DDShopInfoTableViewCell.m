

//
//  DDShopInfoTableViewCell.m
//  TongParty
//
//  Created by 方冬冬 on 2017/12/21.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDShopInfoTableViewCell.h"
#import "DDStarView.h"
#import "UIButton+DDImagePosition.h"
#import "LSShopDetailEntity.h"
@interface DDShopInfoTableViewCell()
@property (nonatomic, strong) UILabel *recommendLbl;
@property (nonatomic, strong) UILabel *shopNameLbl;
@property (nonatomic, strong) DDStarView *starView;
@property (nonatomic, strong) UILabel *distanceLbl;
@property (nonatomic, strong) UILabel *verLineLbl;
@property (nonatomic, strong) UIImageView *phoneView;
@property (nonatomic, strong) UIButton *addressBtn;
@end

@implementation DDShopInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    return self;
}

-(void)setupView{
    
    _recommendLbl = [UILabel new];
    [self.contentView addSubview:_recommendLbl];
    [_recommendLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    _recommendLbl.text = @"推荐地点";
    _recommendLbl.textColor = kBlackColor;
    _recommendLbl.font = kFont(15);
    
    _shopNameLbl = [UILabel new];
    [self.contentView addSubview:_shopNameLbl];
    [_shopNameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_recommendLbl.mas_bottom).offset(20);
        make.left.mas_equalTo(_recommendLbl.mas_left);
        make.height.mas_equalTo(20);
    }];
    
    _starView = [DDStarView new];
    [self.contentView addSubview:_starView];
    [_starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_shopNameLbl.mas_bottom).offset(10);
        make.left.mas_equalTo(_shopNameLbl.mas_left);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
    //_starView.showStar = 3*20;
    
    
    _phoneView = [UIImageView new];
    [self.contentView addSubview:_phoneView];
    [_phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(30);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(_shopNameLbl.mas_bottom).offset(10);
    }];
    _phoneView.image = kImage(@"merchant_phone");
    
    _verLineLbl = [UILabel new];
    [self.contentView addSubview:_verLineLbl];
    [_verLineLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_phoneView.mas_top);
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(30);
        make.right.mas_equalTo(_phoneView.mas_left).offset(-20);
    }];
    _verLineLbl.backgroundColor = kGrayColor;
    
    _distanceLbl = [UILabel new];
    [self.contentView addSubview:_distanceLbl];
    [_distanceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_phoneView.mas_top);
        make.height.mas_equalTo(20);
        make.right.mas_equalTo(_verLineLbl.mas_left).offset(-20);
    }];
    _distanceLbl.textColor = kBlackColor;
    _distanceLbl.font = kFont(13);
    
    _addressBtn = [UIButton new];
    [self.contentView addSubview:_addressBtn];
    [_addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_starView.mas_bottom).offset(20);
        make.left.mas_equalTo(_starView.mas_left);
        make.height.mas_equalTo(20);
    }];
    [_addressBtn setImage:kImage(@"desk_address") forState:UIControlStateNormal];
    _addressBtn.titleLabel.font = kFont(12);
    [_addressBtn setTitleColor:kBgGreenColor forState:UIControlStateNormal];
    [_addressBtn layoutButtonWithEdgeInsetsStyle:DDButtonEdgeInsetsStyleLeft imageTitleSpace:5];
}

- (void)updateValueWithModel:(id)model {
    if (!model) {
        return;
    }
    LSShopDetailEntity *shop = (LSShopDetailEntity *)model;
    _shopNameLbl.text = [NSString stringWithFormat:@"%@%@/人均¥%@",shop.trad_area,shop.name,shop.average_price];
    [_addressBtn setTitle:[NSString stringWithFormat:@"%@",shop.address] forState:UIControlStateNormal];
    _distanceLbl.text = [NSString stringWithFormat:@"%.fkm",[self distanceBetweenOrderBy:[DDUserSingleton shareInstance].latitude.doubleValue :shop.latitude.doubleValue :[DDUserSingleton shareInstance].longitude.doubleValue :shop.longitude.doubleValue]/1000.f];
    _starView.showStar = (shop.star.doubleValue)*20;
}

// 计算两坐标点之间的距离
-(double)distanceBetweenOrderBy:(double) lat1 :(double) lat2 :(double) lng1 :(double) lng2{
    //地球半径
    int R = 6378137;
    //将角度转为弧度
    float radLat1 = [self radians:lat1];
    float radLat2 = [self radians:lat2];
    float radLng1 = [self radians:lng1];
    float radLng2 = [self radians:lng2];
    //结果
    float s = acos(cos(radLat1)*cos(radLat2)*cos(radLng1-radLng2)+sin(radLat1)*sin(radLat2))*R;
    //精度
    s = round(s* 10000)/10000;
    return  round(s);
}

- (float)radians:(float)degrees{
    return (degrees*3.14159265)/180.0;
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end







