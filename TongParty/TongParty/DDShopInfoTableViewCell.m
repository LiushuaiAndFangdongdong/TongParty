

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
    _shopNameLbl.text = @"甘家口麦当劳/人均¥69";
    
    _starView = [DDStarView new];
    [self.contentView addSubview:_starView];
    [_starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_shopNameLbl.mas_bottom).offset(10);
        make.left.mas_equalTo(_shopNameLbl.mas_left);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
    _starView.showStar = 3*20;
    
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
    _distanceLbl.text = @"1.3km";
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
    [_addressBtn setTitle:@"酒仙桥路52号院东方科技园4号楼" forState:UIControlStateNormal];
    _addressBtn.titleLabel.font = kFont(12);
    [_addressBtn setTitleColor:kBgGreenColor forState:UIControlStateNormal];
    [_addressBtn layoutButtonWithEdgeInsetsStyle:DDButtonEdgeInsetsStyleLeft imageTitleSpace:5];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end







