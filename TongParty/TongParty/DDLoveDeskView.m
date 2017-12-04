
//
//  DDLoveDeskView.m
//  TongParty
//
//  Created by 方冬冬 on 2017/11/28.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDLoveDeskView.h"
#import "UIButton+DDImagePosition.h"

@interface DDLoveDeskView()
@property (nonatomic, strong) UIImageView *catView;
@property (nonatomic, strong) UIImageView *bottomView;
@property (nonatomic, strong) UIImageView *joinView;
@property (nonatomic, strong) UIButton *joinBtn;
@end

@implementation DDLoveDeskView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{

    _catView = [UIImageView new];
    [self addSubview:_catView];
    [_catView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(kScreenWidth/2);
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo((kScreenHeight/2 -kScreenWidth/2)/2);
    }];
    _catView.image = kImage(@"lovedesk_cat_withText");
    
    _bottomView = [UIImageView new];
    [self addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_catView.mas_bottom).offset((kScreenHeight/2 -kScreenWidth/2)/2);
        make.left.and.bottom.and.right.mas_equalTo(0);
    }];
    _bottomView.image = kImage(@"lovedesk_bottomView");
    
    _joinView = [UIImageView new];
    [self.bottomView addSubview:_joinView];
    [_joinView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(kScreenWidth/3);
        make.height.mas_equalTo(kScreenWidth/9);
        make.top.mas_equalTo(0);
    }];
    _joinView.image = kImage(@"lovedesk_joinBntBg");
    
//    _joinBtn =[ UIButton new];
//    [self.bottomView addSubview:_joinBtn];
//    [_joinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self);
//        make.width.mas_equalTo(kScreenWidth/3);
//        make.height.mas_equalTo(kScreenWidth/9);
//        make.top.mas_equalTo(0);
//    }];
////    _joinBtn.layerCornerRadius = 15;
//    _joinBtn.backgroundColor = kWhiteColor;
//    [_joinBtn setBackgroundImage:kImage(@"lovedesk_joinBntBg") forState:UIControlStateNormal];
////    [_joinBtn setTitle:@"立即加入" forState:UIControlStateNormal];
////    [_joinBtn setTitleColor:kRedColor forState:UIControlStateNormal];

    for (int i = 0; i< 4; i++) {
        
    }
}
@end











