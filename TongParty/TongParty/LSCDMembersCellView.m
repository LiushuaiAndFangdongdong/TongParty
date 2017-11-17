//
//  LSCDMembersCellView.m
//  TongParty
//
//  Created by 刘帅 on 2017/10/28.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSCDMembersCellView.h"
#import "LSCDTitleItemView.h"

@interface LSCDMembersCellView ()
@property (nonatomic, strong)LSCDTitleItemView *ti_members;
@property (nonatomic, strong)UITextField       *tf_members_content;
@property (nonatomic, strong)UILabel           *lbl_members_line;
@property (nonatomic, strong)LSCDTitleItemView *ti_estimate;
@property (nonatomic, strong)UITextField       *tf_estimate_content;
@property (nonatomic, strong)UILabel           *lbl_estimate_line;
@property (nonatomic, strong)LSCDTitleItemView *ti_perCapita;
@property (nonatomic, strong)UITextField       *tf_perCapita_content;
@property (nonatomic, strong)UILabel           *lbl_perCapita_line;
@end

@implementation LSCDMembersCellView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}
-(void)initViews{
    WeakSelf(weakSelf);
    
    self.backgroundColor = kWhiteColor;
    // 人数
    _ti_members = [LSCDTitleItemView new];
    [self addSubview:self.ti_members];
    [_ti_members mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(weakSelf);
        make.height.mas_equalTo(DDFitHeight(30.f));
    }];
    _ti_members.image = kImage(@"desk_person");
    _ti_members.title = @"人数：";
    
    _tf_members_content = [UITextField new];
    [self addSubview:self.tf_members_content];
    [_tf_members_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_ti_members.mas_bottom);
        make.left.mas_equalTo(DDFitWidth(37.f));
        make.height.equalTo(_ti_members);
        make.right.equalTo(weakSelf);
    }];
    _tf_members_content.placeholder = @"活动至少两人";
    _tf_members_content.font = DDFitFont(14.f);
    
    _lbl_members_line = [UILabel new];
    [self addSubview:self.lbl_members_line];
    [_lbl_members_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_tf_members_content);
        make.height.mas_equalTo(kLineHeight);
        make.right.mas_offset(-DDFitWidth(10.f));
        make.top.equalTo(_tf_members_content.mas_bottom).offset(DDFitHeight(1.f));
    }];
    _lbl_members_line.backgroundColor = kLineBgColor;
    
    
    // 预估时长
    _ti_estimate = [LSCDTitleItemView new];
    [self addSubview:self.ti_estimate];
    [_ti_estimate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lbl_members_line.mas_bottom);
        make.left.equalTo(weakSelf);
        make.height.mas_equalTo(DDFitHeight(30.f));
    }];
    _ti_estimate.image = kImage(@"desk_duration");
    _ti_estimate.title = @"预估时长：";
    
    _tf_estimate_content = [UITextField new];
    [self addSubview:self.tf_estimate_content];
    [_tf_estimate_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_ti_estimate.mas_bottom).offset(DDFitHeight(3.f));
        make.left.mas_equalTo(DDFitWidth(37.f));
        make.height.equalTo(_ti_estimate);
        make.right.equalTo(weakSelf);
    }];
    _tf_estimate_content.placeholder = @"1天1小时";
    _tf_estimate_content.font = DDFitFont(14.f);
    
    _lbl_estimate_line = [UILabel new];
    [self addSubview:self.lbl_estimate_line];
    [_lbl_estimate_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_tf_estimate_content);
        make.height.mas_equalTo(kLineHeight);
        make.right.mas_offset(-DDFitWidth(10.f));
        make.top.equalTo(_tf_estimate_content.mas_bottom).offset(DDFitHeight(5.f));
    }];
    _lbl_estimate_line.backgroundColor = kLineBgColor;
    
    // 预估人均
    _ti_perCapita = [LSCDTitleItemView new];
    [self addSubview:self.ti_perCapita];
    [_ti_perCapita mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lbl_estimate_line.mas_bottom);
        make.left.equalTo(weakSelf);
        make.height.mas_equalTo(DDFitHeight(30.f));
    }];
    _ti_perCapita.image = kImage(@"desk_average_price");
    _ti_perCapita.title = @"预估人均：";
    
    _tf_perCapita_content = [UITextField new];
    [self addSubview:self.tf_perCapita_content];
    [_tf_perCapita_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_ti_perCapita.mas_bottom).offset(DDFitHeight(3.f));
        make.left.mas_equalTo(DDFitWidth(37.f));
        make.height.equalTo(_ti_estimate);
        make.right.equalTo(weakSelf);
    }];
    _tf_perCapita_content.placeholder = @"60元／人";
    _tf_perCapita_content.font = DDFitFont(14.f);
    
    _lbl_perCapita_line = [UILabel new];
    [self addSubview:self.lbl_perCapita_line];
    [_lbl_perCapita_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_tf_perCapita_content);
        make.height.mas_equalTo(kLineHeight);
        make.right.mas_offset(-DDFitWidth(10.f));
        make.top.equalTo(_tf_estimate_content.mas_bottom).offset(DDFitHeight(5.f));
    }];
    _lbl_perCapita_line.backgroundColor = kLineBgColor;
}


@end
