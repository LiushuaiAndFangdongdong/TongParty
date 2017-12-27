
//
//  DDPrefectDataView.m
//  TongParty
//
//  Created by 方冬冬 on 2017/12/25.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDPrefectDataView.h"

@interface DDPrefectDataView()
@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UILabel *nameKeyLbl;
@property (nonatomic, strong) UITextField *nameTxt;
@property (nonatomic, strong) UILabel *horLine1;
@property (nonatomic, strong) UILabel *sexLbl;
@property (nonatomic, strong) UIView *maleView;
@property (nonatomic, strong) UIButton *maleBtn;
@property (nonatomic, strong) UILabel *verLine1;
@property (nonatomic, strong) UIView *femaleView;
@property (nonatomic, strong) UIButton *femaleBtn;
@property (nonatomic, strong) UILabel *verLine2;
@property (nonatomic, strong) UIView *secretView;
@property (nonatomic, strong) UIButton *secretBtn;
@property (nonatomic, strong) UILabel *horLine2;
@property (nonatomic, strong) UIButton *completeBtn;
@end

@implementation DDPrefectDataView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    _avatarView = [UIImageView new];
    [self addSubview:_avatarView];
    [_avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(DDFitWidth(100));
        make.top.mas_equalTo(DDFitHeight(80));
        make.left.mas_equalTo((kScreenWidth - DDFitWidth(100))/2);
    }];
    _avatarView.userInteractionEnabled = YES;
    _avatarView.image = kImage(@"add_avatar_default");
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatarTap)];
    [_avatarView addGestureRecognizer:tap];
    
    _nameKeyLbl = [UILabel new];
    [self addSubview:_nameKeyLbl];
    [_nameKeyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_avatarView.mas_bottom).offset(20);
        make.left.mas_equalTo(DDFitWidth(60));
        make.height.mas_equalTo(DDFitWidth(40));
        make.width.mas_equalTo(50);
    }];
    _nameKeyLbl.text = @"昵称";
    _nameKeyLbl.textColor = kGrayColor;
    
    _nameTxt = [UITextField new];
    [self addSubview:_nameTxt];
    [_nameTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameKeyLbl.mas_top);
        make.height.mas_equalTo(_nameKeyLbl);
        make.left.mas_equalTo(_nameKeyLbl.mas_right).offset(10);
        make.width.mas_equalTo(kScreenWidth - 2*DDFitWidth(60) - 10 - 50);
    }];
    _nameTxt.placeholder = @"请输入昵称";
    
    _horLine1 = [UILabel new];
    [self addSubview:_horLine1];
    [_horLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameKeyLbl.mas_bottom).mas_equalTo(5);
        make.left.mas_equalTo(DDFitWidth(60));
        make.width.mas_equalTo(kScreenWidth - DDFitWidth(60)*2);
        make.height.mas_equalTo(1);
    }];
    _horLine1.backgroundColor = kBgGrayColor;
    
    _sexLbl = [UILabel new];
    [self addSubview:_sexLbl];
    [_sexLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_horLine1.mas_bottom).offset(20);
        make.left.mas_equalTo(_nameKeyLbl.mas_left);
        make.height.mas_equalTo(_nameKeyLbl.mas_height);
        make.width.mas_equalTo(DDFitWidth(50));
    }];
    _sexLbl.text = @"性别";
    _sexLbl.textColor = kGrayColor;
    
    _maleView = [UIView new];
    [self addSubview:_maleView];
    [_maleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_sexLbl.mas_top);
        make.left.mas_equalTo(_sexLbl.mas_right).offset(0);
        make.height.mas_equalTo(_sexLbl.mas_height);
        make.width.mas_equalTo((kScreenWidth - DDFitWidth(60)*2 - DDFitWidth(50) - 2)/3);
    }];
    
    _maleBtn = [UIButton new];
    [_maleView addSubview:_maleBtn];
    [_maleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(10);
        make.bottom.mas_equalTo(-5);
        make.right.mas_equalTo(-10);
    }];
    [_maleBtn setTitle:@"男" forState:UIControlStateNormal];
    [_maleBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [_maleBtn setBackgroundColor:kBgGreenColor];
    _maleBtn.layerCornerRadius = 8;
    
    _verLine1 = [UILabel new];
    [self addSubview:_verLine1];
    [_verLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_maleView.mas_right);
        make.width.mas_equalTo(1);
        make.centerY.mas_equalTo(_maleView);
        make.height.mas_equalTo(20);
    }];
    _verLine1.backgroundColor = kBgGrayColor;
    
    _femaleView = [UIView new];
    [self addSubview:_femaleView];
    [_femaleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_maleView.mas_top);
        make.left.mas_equalTo(_verLine1.mas_right);
        make.height.mas_equalTo(_maleView.mas_height);
        make.width.mas_equalTo(_maleView.mas_width);
    }];
    
    _femaleBtn = [UIButton new];
    [_femaleView addSubview:_femaleBtn];
    [_femaleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(10);
        make.bottom.mas_equalTo(-5);
        make.right.mas_equalTo(-10);
    }];
    [_femaleBtn setTitle:@"女" forState:UIControlStateNormal];
    [_femaleBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [_femaleBtn setBackgroundColor:kBgGreenColor];
    _femaleBtn.layerCornerRadius = 8;
    
    _verLine2 = [UILabel new];
    [self addSubview:_verLine2];
    [_verLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_femaleView.mas_right);
        make.width.mas_equalTo(1);
        make.centerY.mas_equalTo(_femaleView);
        make.height.mas_equalTo(20);
    }];
    _verLine2.backgroundColor = kBgGrayColor;
    
    _secretView = [UIView new];
    [self addSubview:_secretView];
    [_secretView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_maleView.mas_top);
        make.left.mas_equalTo(_verLine2.mas_right);
        make.height.mas_equalTo(_maleView.mas_height);
        make.width.mas_equalTo(_maleView.mas_width);
    }];
    
    _secretBtn = [UIButton new];
    [_secretView addSubview:_secretBtn];
    [_secretBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(10);
        make.bottom.mas_equalTo(-5);
        make.right.mas_equalTo(-10);
    }];
    [_secretBtn setTitle:@"保密" forState:UIControlStateNormal];
    [_secretBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [_secretBtn setBackgroundColor:kBgGreenColor];
    _secretBtn.layerCornerRadius = 8;
    
    _horLine2 = [UILabel new];
    [self addSubview:_horLine2];
    [_horLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_sexLbl.mas_bottom).mas_equalTo(5);
        make.left.mas_equalTo(DDFitWidth(60));
        make.width.mas_equalTo(_horLine1.mas_width);
        make.height.mas_equalTo(1);
    }];
     _horLine2.backgroundColor = kBgGrayColor;
    
    _completeBtn = [UIButton new];
    [self addSubview:_completeBtn];
    [_completeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_horLine2.mas_bottom).offset(50);
        make.left.mas_equalTo(DDFitWidth(60));
        make.width.mas_equalTo(kScreenWidth- DDFitWidth(60)*2);
        make.height.mas_equalTo(DDFitWidth(45));
    }];
    [_completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    [_completeBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [_completeBtn setBackgroundColor:kBgGreenColor];
    _completeBtn.layerCornerRadius = DDFitWidth(15);
    [_completeBtn addTarget:self action:@selector(dataComplete) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)avatarTap{
    NSLog(@"上传头像");
}

- (void)dataComplete{
    NSLog(@"完成资料完善");
}

@end





















