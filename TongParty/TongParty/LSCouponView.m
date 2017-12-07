//
//  LSCouponView.m
//  TongParty
//
//  Created by 刘帅 on 2017/12/6.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSCouponView.h"
@interface LSCouponView (){
    void(^tmp_block)(NSDictionary *);
}
@property (nonatomic, strong)UIView *backgroundView;
@property (nonatomic, strong)UIView *couponView;
@property (nonatomic, strong)UILabel *lbl_count;
@property (nonatomic, strong)UILabel *lbl_couponCount;
@property (nonatomic, strong)UISwitch *sw_use;
@property (nonatomic, strong)NSMutableDictionary *reslutDict;
@property (nonatomic, strong)UILabel *lbl_des;
@property (nonatomic, strong)UILabel *lbl_line;
@property (nonatomic, strong)UIButton *btn_confirm;
@property (nonatomic, strong)UILabel *lbl_ask;
@property (nonatomic, strong)UIButton *btn_add;
@property (nonatomic, strong)UIButton *btn_min;
@property (nonatomic, strong)UIButton *btn_close;
@property (nonatomic, strong)UIImageView *iv_coupon;
@end
static LSCouponView *_instance;
@implementation LSCouponView

+(LSCouponView *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[[self class] alloc] init];
    });
    return _instance;
}

- (void)showCouponViewOnWindowWithType:(LSCouponViewShowType)type doneBlock:(void (^)(NSDictionary *dict))doneDict{
    _reslutDict = [NSMutableDictionary new];
    tmp_block = doneDict;
    couponCount = 0;
    _iv_coupon = [UIImageView new];
    [KEY_WINDOW addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.couponView];
    [self.couponView addSubview:_iv_coupon];
    [_iv_coupon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.couponView).multipliedBy(0.75f);
        make.centerX.equalTo(self.couponView);
        make.height.mas_equalTo(DDFitHeight(180.f));
        make.top.mas_equalTo(-DDFitHeight(30.f));
    }];
    
    _lbl_count = [UILabel new];
    [_iv_coupon addSubview:_lbl_count];
    [_lbl_count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_iv_coupon.mas_bottom).offset(-DDFitHeight(23.f));
        make.left.equalTo(_iv_coupon.mas_centerX).offset(-DDFitWidth(5.f));
        make.height.mas_equalTo(DDFitHeight(60.f));
        make.width.mas_equalTo(DDFitWidth(45.f));
    }];
    _lbl_count.font = DDFitFont(30.f);
    _lbl_count.textColor = kWhiteColor;
    _lbl_count.text = @"5";
    
    _btn_close = [UIButton new];
    [self.couponView addSubview:_btn_close];
    [_btn_close mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.couponView);
        make.height.mas_equalTo(DDFitHeight(30.f));
        make.width.mas_equalTo(DDFitWidth(25.f));
        make.right.mas_equalTo(-DDFitWidth(10.f));
    }];
    [_btn_close setBackgroundImage:kImage(@"coupon_close") forState:UIControlStateNormal];
    [_btn_close addTarget:self action:@selector(hiddeCouponView) forControlEvents:UIControlEventTouchUpInside];

    _lbl_des = [UILabel new];
    [self.couponView addSubview:_lbl_des];
    [_lbl_des mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iv_coupon).offset(DDFitHeight(10.f));
        make.right.equalTo(_iv_coupon).offset(-DDFitHeight(10.f));
        make.top.equalTo(_iv_coupon.mas_bottom).offset(DDFitHeight(20.f));
    }];
    _lbl_des.numberOfLines = 0;
    _lbl_des.font = DDFitFont(15.f);
    _lbl_des.textColor = kBlackColor;
    _lbl_des.textAlignment = NSTextAlignmentCenter;
    
    _lbl_line = [UILabel new];
    [self.couponView addSubview:_lbl_line];
    [_lbl_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.couponView);
        make.top.equalTo(_lbl_des.mas_bottom).offset(DDFitHeight(30.f));
        make.height.mas_equalTo(kLineHeight);
    }];
    _lbl_line.backgroundColor = kCommonGrayTextColor;
    
    _btn_confirm = [UIButton new];
    [self.couponView addSubview:_btn_confirm];
    [_btn_confirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.couponView);
        make.bottom.mas_equalTo(DDFitHeight(-15.f));
        make.height.mas_equalTo(DDFitHeight(40.f));
        make.width.equalTo(self.couponView).multipliedBy(0.70f);
    }];
    [_btn_confirm setBackgroundImage:kImage(@"desk_manage_address") forState:UIControlStateNormal];
    _btn_confirm.titleLabel.font = DDFitFont(15.f);
    
    _lbl_ask = [UILabel new];
    [self.couponView addSubview:_lbl_ask];
    [_lbl_ask mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iv_coupon);
        make.bottom.equalTo(_btn_confirm.mas_top).offset(-DDFitHeight(20.f));
        make.height.mas_equalTo(DDFitHeight(20.f));
    }];
    _lbl_ask.font = DDFitFont(13.f);
    if (type == DDDeskShowTypeJoinCoupon) {
        _iv_coupon.image = kImage(@"join_coupon");
        _lbl_des.text = @"Hi~桐友，确定加入张桌子吗，参与桌子后，不能失约哦！！";
        _lbl_ask.text = @"OS: 要使用加入券吗？";
        _lbl_ask.textColor = kBlackColor;
        [_btn_confirm setTitle:@"立即加入" forState:UIControlStateNormal];
        
        _sw_use = [UISwitch new];
        [self.couponView addSubview:_sw_use];
        [_sw_use mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_lbl_ask).offset(-5);
            make.height.mas_equalTo(DDFitHeight(20.f));
            make.width.mas_equalTo(DDFitWidth(50.f));
            make.right.mas_equalTo(-DDFitWidth(20.f));
        }];
        [_sw_use addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        [_btn_confirm addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        _btn_add = [UIButton new];
        [self.couponView addSubview:_btn_add];
        [_btn_add mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_lbl_ask);
            make.height.width.mas_equalTo(DDFitWidth(20.f));
            make.right.mas_equalTo(DDFitWidth(-20.f));
        }];
        [_btn_add setTitle:@"+" forState:UIControlStateNormal];
        [_btn_add setTitleColor:kCommonGrayTextColor forState:UIControlStateNormal];
        _btn_add.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
        [_btn_add addTarget:self action:@selector(addCoupon:) forControlEvents:UIControlEventTouchUpInside];
        
        _lbl_couponCount = [UILabel new];
        [self.couponView addSubview:_lbl_couponCount];
        [_lbl_couponCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_btn_add);
            make.height.mas_equalTo(DDFitWidth(13.f));
            make.right.equalTo(_btn_add.mas_left).offset(DDFitWidth(-10.f));
        }];
        _lbl_couponCount.textColor = kCommonGrayTextColor;
        _lbl_couponCount.textAlignment = NSTextAlignmentCenter;
        _lbl_couponCount.text = @"0";
        
        _btn_min = [UIButton new];
        [self.couponView addSubview:_btn_min];
        [_btn_min mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_btn_add);
            make.height.width.mas_equalTo(DDFitWidth(20.f));
            make.right.equalTo(_lbl_couponCount.mas_left).offset(DDFitWidth(-10.f));
        }];
        [_btn_min setTitle:@"-" forState:UIControlStateNormal];
        [_btn_min setTitleColor:kCommonGrayTextColor forState:UIControlStateNormal];
        _btn_min.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
        [_btn_min addTarget:self action:@selector(minCoupon:) forControlEvents:UIControlEventTouchUpInside];
        
        _lbl_des.text = @"为了提高邀请成功率\n是否使用邀请券？";
        _iv_coupon.image = kImage(@"invite_coupon");
        _lbl_ask.text = @"可选择邀请券数量";
        _lbl_ask.textColor = kCommonGrayTextColor;
        [_btn_confirm setTitle:@"立即使用" forState:UIControlStateNormal];
        [_btn_confirm addTarget:self action:@selector(useNow:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)showCouponViewOnView:(UIView *)view WithType:(LSCouponViewShowType)type doneBlock:(void(^)())done{}


- (void)hiddeCouponView {
    // 清空,这种以后别用单例！
    [_sw_use removeFromSuperview];
    [_couponView removeFromSuperview];
    [_lbl_couponCount removeFromSuperview];
    [_lbl_count removeFromSuperview];
    [_backgroundView removeFromSuperview];
    [_lbl_des removeFromSuperview];
    [_lbl_line removeFromSuperview];
    [_btn_confirm removeFromSuperview];
    [_lbl_ask removeFromSuperview];
    [_btn_add removeFromSuperview];
    [_btn_min removeFromSuperview];
    [_iv_coupon removeFromSuperview];
    [_btn_close removeFromSuperview];
    _reslutDict = nil;
}

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _backgroundView.backgroundColor = [kBlackColor colorWithAlphaComponent:0.7f];

    }
    return _backgroundView;
}

- (UIView *)couponView {
    if (!_couponView) {
        _couponView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/1.2f, DDFitHeight(350.f))];
        _couponView.backgroundColor = kWhiteColor;
        _couponView.layer.cornerRadius = 5.f;
        _couponView.alpha = 1.f;
        _couponView.center = KEY_WINDOW.center;
    }
    return _couponView;
}
static NSInteger couponCount;
-(void)switchAction:(id)sender {
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        NSLog(@"开");
        [_reslutDict setObject:@"1" forKey:@"isUseJoinCoupon"];
    }else {
        NSLog(@"关");
        [_reslutDict setObject:@"0" forKey:@"isUseJoinCoupon"];
    }
}

- (void)confirm:(UIButton *)sender {
    tmp_block(_reslutDict);
    [self hiddeCouponView];
}

- (void)useNow:(UIButton *)sender {
    tmp_block(_reslutDict);
    [self hiddeCouponView];
}

- (void)addCoupon:(UIButton *)sender {
    _lbl_couponCount.text = [NSString stringWithFormat:@"%ld",++couponCount];
    [_reslutDict setObject:@(couponCount) forKey:@"couponCount"];
    
}

- (void)minCoupon:(UIButton *)sender {
    // 设置封顶
    if (couponCount > 0) {
        _lbl_couponCount.text = [NSString stringWithFormat:@"%ld",--couponCount];
        [_reslutDict setObject:@(couponCount) forKey:@"couponCount"];
    }
}

- (void)dealloc {
    // 视图销毁
    NSLog(@"优惠券没了！");
}

@end
