

//
//  DDMatchFailedView.m
//  TongParty
//
//  Created by 方冬冬 on 2018/1/18.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "DDMatchFailedView.h"

@interface DDMatchFailedView()
@property (nonatomic, strong) UILabel *failedTitle;     //标题
@property (nonatomic, strong) UILabel *failedDesc;      //描述
@property (nonatomic, strong) UIImageView *failedImage; //图片
@property (nonatomic, strong) UIButton *backHomeBtn;    //返回首页按钮
@end

@implementation DDMatchFailedView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    _failedTitle = [UILabel new];
    [self addSubview:_failedTitle];
    [_failedTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(50);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(20);
    }];
    _failedTitle.text = @"匹配失败";
    _failedTitle.textColor = kBlackColor;
    _failedTitle.font = kFont(18);
    _failedTitle.textAlignment = NSTextAlignmentCenter;
    
    _failedDesc = [UILabel new];
    [self addSubview:_failedDesc];
    [_failedDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_failedTitle.mas_bottom).offset(40);
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
    }];
    _failedDesc.text = @"很抱歉，桐聚猫未能找到最合你心意的桌子";
    _failedDesc.numberOfLines = 2;
    _failedDesc.textColor = kGrayColor;
    _failedDesc.font = kFont(15);
    
    _failedImage = [UIImageView new];
    [self addSubview:_failedImage];
    [_failedImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_failedDesc.mas_bottom).offset(50);
        make.left.mas_equalTo(DDFitWidth(40));
        make.width.and.height.mas_equalTo(kScreenWidth - 2*DDFitWidth(40));
    }];
    _failedImage.image = kImage(@"lovedesk_match_failed");
    
    _backHomeBtn = [UIButton new];
    [self addSubview:_backHomeBtn];
    [_backHomeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_failedImage.mas_bottom).offset(50);
        make.width.mas_equalTo(DDFitWidth(150));
        make.height.mas_equalTo(DDFitHeight(50));
        make.centerX.mas_equalTo(self);
    }];
    [_backHomeBtn setTitle:@"返回首页" forState:UIControlStateNormal];
    _backHomeBtn.layerCornerRadius = 7;
    _backHomeBtn.titleLabel.font = kFont(18);
    [_backHomeBtn setTitleColor:kGrayColor forState:UIControlStateNormal];
    //阴影
    _backHomeBtn.backgroundColor = kWhiteColor;
    _backHomeBtn.layer.shadowOffset =  CGSizeMake(1, 1);
    _backHomeBtn.layer.shadowOpacity = 0.8;
    _backHomeBtn.layer.shadowColor =  [UIColor blackColor].CGColor;
    [_backHomeBtn addTarget:self action:@selector(backHomeAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)backHomeAction{
    if (_backHomeClickBlcok) {
        _backHomeClickBlcok();
    }
}
@end

















