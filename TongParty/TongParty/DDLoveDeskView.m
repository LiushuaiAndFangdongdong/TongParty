
//
//  DDLoveDeskView.m
//  TongParty
//
//  Created by 方冬冬 on 2017/11/28.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDLoveDeskView.h"
#import "UIButton+DDImagePosition.h"

#define kBtnItemWidth   80
#define kBtnWidthMargin  (kScreenWidth - 2*kBtnItemWidth)/3
#define kBtnHeightMargin (kScreenHeight/2 - 2*kBtnItemWidth)/3

@interface DDLoveDeskView()
@property (nonatomic, strong) UIImageView *catView;
@property (nonatomic, strong) UIImageView *bottomView;
@property (nonatomic, strong) UIImageView *joinView;
@property (nonatomic, strong) UIButton *joinBtn;
@property (nonatomic, strong) NSArray *imageArr;
//@property (nonatomic, strong) NSArray *titleArr;
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
        make.top.mas_equalTo((kScreenHeight/2 -kScreenWidth/2)/2 + 30);
    }];
    _catView.image = kImage(@"lovedesk_cat_withText");
    
    _bottomView = [UIImageView new];
    [self addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_catView.mas_bottom).offset((kScreenHeight/2 -kScreenWidth/2)/2);
        make.left.and.bottom.and.right.mas_equalTo(0);
    }];
    _bottomView.image = kImage(@"lovedesk_bottomView");
    _bottomView.userInteractionEnabled = YES;
}

- (void)updateFunctionBtnWithArray:(NSArray *)array{
    
    NSArray *views = [_bottomView subviews];
    for (UIView *v in views) {
        [v removeFromSuperview];
    }
    
    _joinView = [UIImageView new];
    [self.bottomView addSubview:_joinView];
    [_joinView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(DDFitWidth(200));
        make.height.mas_equalTo(DDFitHeight(100));
        make.top.mas_equalTo(-30);
    }];
    _joinView.image = kImage(@"lovedesk_joinBntBg");
    _joinView.userInteractionEnabled = YES;
    
    _joinBtn =[ UIButton new];
    [_joinView addSubview:_joinBtn];
    [_joinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_joinView.centerX);
        make.centerY.mas_equalTo(_joinView.centerY).offset(-3);
    }];
    [_joinBtn setTitle:@"立即加入" forState:UIControlStateNormal];
    [_joinBtn setTitleColor:kSubjectPinkRedColor forState:UIControlStateNormal];
    _joinBtn.titleLabel.font = kFont(16);
    [_joinBtn addTarget:self action:@selector(loveJoinAction) forControlEvents:UIControlEventTouchUpInside];
    
    _imageArr = @[@"lovedesk_time",@"lovedesk_distance",@"lovedesk_activity",@"lovedesk_avePrice"];
//    _titleArr = @[@"选择时间",@"选择距离",@"筛选活动",@"选择人均"];
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 2; j++) {
            UIButton *functionBtn = [[UIButton alloc] init];
            [_bottomView addSubview:functionBtn];
            [functionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(kBtnHeightMargin*(j+1)+j*kBtnItemWidth);
                make.left.mas_equalTo(kBtnWidthMargin*(i+1)+i*kBtnItemWidth);
                make.width.mas_equalTo(kBtnItemWidth  + 10);
                make.height.mas_equalTo(kBtnItemWidth + 10);
            }];
            functionBtn.tag = i*10+j;//(0 、 10 、 1、 11)
            [functionBtn setImage:[UIImage imageNamed:_imageArr[2*i+j]] forState:UIControlStateNormal];
            [functionBtn setTitle:array[2*i+j] forState:UIControlStateNormal];
            [functionBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
            functionBtn.titleLabel.font = kFont(12);
            [functionBtn layoutButtonWithEdgeInsetsStyle:DDButtonEdgeInsetsStyleTop imageTitleSpace:10];
            [functionBtn addTarget:self action:@selector(functionAction:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

- (void)functionAction:(UIButton *)sender{
    if (_selectClickBlcok) {
        _selectClickBlcok(sender.tag);
    }
}

- (void)loveJoinAction{
    if (_joinLoveClickBlcok) {
        _joinLoveClickBlcok();
    }
}
@end











