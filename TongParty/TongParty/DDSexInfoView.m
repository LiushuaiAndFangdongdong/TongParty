//
//  DDSexInfoView.m
//  TongParty
//
//  Created by 方冬冬 on 2017/10/31.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDSexInfoView.h"
#import "UIButton+DDImagePosition.h"
#import "LSHisUserInfoModel.h"
@interface DDSexInfoView()
@property (nonatomic, strong) UIView   *bgView;
@property (nonatomic, strong) UIButton *mobileBtn;       //电话
@property (nonatomic, strong) UIButton *constellationBtn;//星座
@property (nonatomic, strong) UIButton *sexBtn;          //性别
@property (nonatomic, strong) UIButton *addressBtn;      //地址
@property (nonatomic, assign) CGSize size;
@end

@implementation DDSexInfoView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}
-(void)btn:(UIButton *)btn AttributeWithImage:(NSString *)image title:(NSString *)title titleColor:(UIColor *)color space:(CGFloat)space{
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font = kFont(12);
    [btn layoutButtonWithEdgeInsetsStyle:DDButtonEdgeInsetsStyleLeft imageTitleSpace:space];
}
-(void)layoutSubviews{
    _size = self.frame.size;
}
-(void)setupViews{
    //    [self layoutSubviews];
    //    [self setNeedsLayout];
    
    _bgView = [UIView new];
    [self addSubview:_bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    _mobileBtn = [UIButton new];
    [_bgView addSubview:_mobileBtn];
    [_mobileBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_bgView);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(5);
    }];
    [self btn:_mobileBtn AttributeWithImage:@"info_phone" title:@"15205145990" titleColor:kGrayColor space:10];
    
    _sexBtn = [UIButton new];
    [_bgView addSubview:_sexBtn];
    [_sexBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_mobileBtn.mas_bottom).offset(5);
        //        make.width.mas_equalTo(self.width/3);
        make.centerX.mas_equalTo(_bgView);
        make.height.mas_equalTo(20);
    }];
    [self btn:_sexBtn AttributeWithImage:@"info_male" title:@"男" titleColor:kGrayColor space:5];
    
    _constellationBtn = [UIButton new];
    [_bgView addSubview:_constellationBtn];
    [_constellationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_mobileBtn.mas_bottom).offset(5);
        //        make.width.mas_equalTo(self.width/3);
        make.right.mas_equalTo(_sexBtn.mas_left).offset(-20);
        make.height.mas_equalTo(20);
    }];
    [self btn:_constellationBtn AttributeWithImage:@"info_constellation_male" title:@"天蝎座" titleColor:kGrayColor space:5];
    
    _addressBtn = [UIButton new];
    [_bgView addSubview:_addressBtn];
    [_addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_mobileBtn.mas_bottom).offset(5);
        //        make.width.mas_equalTo(self.width/3);
        make.left.mas_equalTo(_sexBtn.mas_right).offset(20);
        make.height.mas_equalTo(20);
    }];
    [self btn:_addressBtn AttributeWithImage:@"info_address" title:@"北京市海淀区" titleColor:kGrayColor space:5];
}

- (void)updateValueWithModel:(id)model {
    LSHisUserInfoModel *hModel = (LSHisUserInfoModel *)model;
    [self btn:_mobileBtn AttributeWithImage:@"info_phone" title:hModel.mobile titleColor:kGrayColor space:10];
    [self btn:_constellationBtn AttributeWithImage:@"info_constellation_male" title:hModel.constellation titleColor:kGrayColor space:5];
    [self btn:_addressBtn AttributeWithImage:@"info_address" title:hModel.city titleColor:kGrayColor space:5];
    if (hModel.sex.integerValue == 0) {
        [self btn:_sexBtn AttributeWithImage:@"" title:@"保密" titleColor:kGrayColor space:5];
    }
    if (hModel.sex.integerValue == 1) {
        [self btn:_sexBtn AttributeWithImage:@"info_male" title:@"男" titleColor:kGrayColor space:5];
    }
    if (hModel.sex.integerValue == 2) {
        [self btn:_sexBtn AttributeWithImage:@"info_female" title:@"女" titleColor:kGrayColor space:5];
    }
}

@end










