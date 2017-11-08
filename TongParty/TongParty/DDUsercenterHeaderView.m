//
//  DDUsercenterHeaderView.m
//  TongParty
//
//  Created by 方冬冬 on 2017/11/1.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDUsercenterHeaderView.h"
#import "DDLabelView.h"
#import "UIView+Layer.h"

#define kAvatarWidth   50
#define kMarginGapWidth 18
#define kActivityItemWidth (kScreenWidth - kMarginGapWidth*6)/5

//不支持横屏的情况下
#define kTopViewHeight(SCREEN_MAX_LENGTH) \
({\
float height = 0;\
if (SCREEN_MAX_LENGTH==568)\
height=170;\
else if (SCREEN_MAX_LENGTH==667)\
height=235;\
else if(SCREEN_MAX_LENGTH==736)\
height=250;\
else if(SCREEN_MAX_LENGTH==812)\
height=305;\
(height);\
})\

@interface DDUsercenterHeaderView()
@property (nonatomic, strong) UIView *loginedView;  //登录下的view
@property (nonatomic, strong) UIView*unloginedView; //未登录下的view
@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UILabel *nameLbl;
@property (nonatomic, strong) DDLabelView *labelView;
@property (nonatomic, strong) DDLabelView *labelView1;
@property (nonatomic, strong) DDLabelView *labelView2;
@property (nonatomic, strong) DDLabelView *labelView3;
@property (nonatomic, strong) UILabel *creditLbl;
@property (nonatomic, strong) UILabel *joinRateLbl;
@property (nonatomic, strong) UIImageView *avatarUn;
@property (nonatomic, strong) UILabel *joinRateLblUn;
@property (nonatomic, copy) NSString *joinString;
@end

@implementation DDUsercenterHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    //头像的上间隔
    float topOriginY = 0;
    //参加次数与上面控件的间距
    float lastLabelMargin = 0;
    if (IS_IPHONE_5) {
        topOriginY = 30;
        lastLabelMargin = 8;
    }else if (IS_IPHONE_6){
        topOriginY = 60;
        lastLabelMargin = 40;
    }else if (IS_IPHONE_6P){
        topOriginY = 75;
        lastLabelMargin = 35;
    }else if (iPhoneX){
        topOriginY = 95;
        lastLabelMargin = 50;
    }else{
    }
    _loginedView = [UIView new];
    [self addSubview:_loginedView];
    [_loginedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    //头像
    _avatar = [UIImageView new];
    [_loginedView addSubview:_avatar];
    [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(kAvatarWidth);
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(topOriginY);
    }];
    _avatar.layerCornerRadius = 25;
    //名称
    _nameLbl = [UILabel new];
    [_loginedView addSubview:_nameLbl];
    [_nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_avatar.mas_left).offset(-10);
        make.width.mas_equalTo(4*kAvatarWidth);
        make.height.mas_equalTo(20);
        make.centerX.mas_equalTo(_avatar);
        make.top.mas_equalTo(_avatar.mas_bottom).offset(5);
    }];
    _nameLbl.textAlignment = NSTextAlignmentCenter;
    _nameLbl.textColor = kWhiteColor;
    _nameLbl.font = [UIFont systemFontOfSize:14];
    
    //标签
    _labelView = [DDLabelView new];
    [_loginedView addSubview:_labelView];
    [_labelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_avatar.mas_left).offset(-70);
        make.width.and.height.mas_equalTo(40);
        make.top.mas_equalTo(_avatar);
    }];
    _labelView.textstring = @"爱生活";
    _labelView.layerCornerRadius = 20;
    _labelView.bgColor = kLabelBgBlackColor;
    //        [self ImageSpringWithLabel:labelView];
    
    _labelView1 = [DDLabelView new];
    [_loginedView addSubview:_labelView1];
    [_labelView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_avatar.mas_right).offset(30);
        make.width.and.height.mas_equalTo(40);
        make.top.mas_equalTo(_avatar);
    }];
    _labelView1.textstring = @"爱网购";
    _labelView1.layerCornerRadius = 20;
    _labelView1.bgColor = kLabelBgBlackColor;
    //        [self ImageSpringWithLabel:labelView1];
    //标签
    _labelView2 = [DDLabelView new];
    [_loginedView addSubview:_labelView2];
    [_labelView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.width.and.height.mas_equalTo(40);
        make.top.mas_equalTo(_labelView.mas_bottom).offset(30);
    }];
    _labelView2.textstring = @"喜欢开黑";
    _labelView2.layerCornerRadius = 20;
    _labelView2.bgColor = kLabelBgBlackColor;
    //        [self ImageSpringWithLabel:labelView2];
    //标签
    _labelView3 = [DDLabelView new];
    [_loginedView addSubview:_labelView3];
    [_labelView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScreenWidth-70);
        make.width.and.height.mas_equalTo(40);
        make.top.mas_equalTo(_labelView1.mas_bottom).offset(30);
    }];
    _labelView3.textstring = @"神秘人";
    _labelView3.layerCornerRadius = 20;
    _labelView3.bgColor = kLabelBgBlackColor;
    //        [self ImageSpringWithLabel:labelView3];
    //信用度&活跃值
    _creditLbl = [UILabel new];
    [_loginedView addSubview:_creditLbl];
    [_creditLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameLbl.mas_bottom).offset(10);
        make.width.mas_equalTo(kAvatarWidth *3);
        make.centerX.mas_equalTo(_nameLbl.centerX);
        make.height.mas_equalTo(20);
    }];
    _creditLbl.text = @"信用度:50 | 活跃值:50";
    _creditLbl.textAlignment = NSTextAlignmentCenter;
    _creditLbl.textColor = kWhiteColor;
    _creditLbl.font = kFont(13);
    //活动参加率
    _joinRateLbl = [UILabel new];
    [_loginedView addSubview:_joinRateLbl];
    [_joinRateLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kAvatarWidth * 4);
        make.top.mas_equalTo(_creditLbl.mas_bottom).offset(lastLabelMargin);
        make.centerX.mas_equalTo(_creditLbl.centerX);
    }];
    //    joinRateLbl.text = @"实到6/7创建       实到7/9参与";
    _joinRateLbl.textAlignment = NSTextAlignmentCenter;
    _joinRateLbl.textColor = kWhiteColor;
    _joinRateLbl.font = kFont(12);
    
    NSRange strRange = {2,3};
    NSRange strRange1 = {16,3};
    _joinString = @"实到0/0创建       实到0/0参与";
    _joinRateLbl.attributedText = [self string:_joinString NSRange:strRange font1:kFont(17) ran2:strRange1 font2:kFont(15)];
    
    //--------------------- 未登录 ------------------
    _unloginedView = [UIView new];
    [self addSubview:_unloginedView];
    [_unloginedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    _avatarUn = [UIImageView new];
    [_unloginedView addSubview:_avatarUn];
    [_avatarUn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(kAvatarWidth);
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(topOriginY);
    }];
    _avatarUn.layerCornerRadius = 25;
    
    UILabel *lineUn = [UILabel new];
    [_unloginedView addSubview:lineUn];
    [lineUn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_avatar.mas_bottom).offset(45);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(10);
        make.centerX.mas_equalTo(self);
    }];
    lineUn.backgroundColor = kWhiteColor;
    
    
    UIButton *loginBtn = [UIButton new];
    [_unloginedView addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_avatar.mas_bottom).offset(35);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
        make.right.mas_equalTo(lineUn.mas_left).offset(-5);
    }];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [loginBtn setTitleColor:kBgGreenColor forState:UIControlStateHighlighted];
    loginBtn.titleLabel.font = kFont(15);
    loginBtn.tag = 20;
    [loginBtn addTarget:self action:@selector(enterLoginVC:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *registerBtn = [UIButton new];
    [_unloginedView addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_avatar.mas_bottom).offset(35);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
        make.left.mas_equalTo(lineUn.mas_right).offset(5);
    }];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [registerBtn setTitleColor:kBgGreenColor forState:UIControlStateHighlighted];
    registerBtn.titleLabel.font = kFont(15);
    registerBtn.tag = 21;
    [registerBtn addTarget:self action:@selector(enterLoginVC:) forControlEvents:UIControlEventTouchUpInside];
    
    //活动参加率
    _joinRateLblUn = [UILabel new];
    [_unloginedView addSubview:_joinRateLblUn];
    [_joinRateLblUn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kAvatarWidth * 4);
        make.top.mas_equalTo(loginBtn.mas_bottom).offset(lastLabelMargin);
        make.centerX.mas_equalTo(self);
    }];

    _joinRateLblUn.textAlignment = NSTextAlignmentCenter;
    _joinRateLblUn.textColor = kWhiteColor;
    _joinRateLblUn.font = kFont(12);
    _joinRateLblUn.attributedText = [self string:_joinString NSRange:strRange font1:kFont(17) ran2:strRange1 font2:kFont(15)];
    
}
- (NSMutableAttributedString *)string:(NSString *)string NSRange:(NSRange)ran1 font1:(UIFont *)font1 ran2:(NSRange)ran2 font2:(UIFont *)font2{
    
    NSMutableAttributedString *sr = [[NSMutableAttributedString alloc] initWithString:string];
    [sr addAttributes:@{
                         NSFontAttributeName:font1
                         } range:ran1];
    [sr addAttributes:@{
                         NSFontAttributeName:font2
                         } range:ran2];
    return sr;
}
//更新用户信息
-(void)updateUserInfoWith:(DDUserInfoModel *)model
{
    NSLog(@"======%@",model.name);
    DDUserSingleton *user = [DDUserSingleton shareInstance];
    if (user.token) {
        //已登录
        _unloginedView.hidden = YES;
        _loginedView.hidden = NO;
        [_avatar sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:kDefaultAvatar];
        _nameLbl.text = model.name;
//        _creditLbl.text
//        _joinString = [NSString stringWithFormat:@"实到%@/%@创建       实到%@/%@参与",];
    }else{
        //未登录
        _unloginedView.hidden = NO;
        _loginedView.hidden = YES;
        _avatarUn.image = kDefaultAvatar;
        
    }
}

-(void)enterLoginVC:(UIButton *)sender{
    if (_loginRegisterClickBlcok) {
        _loginRegisterClickBlcok(sender.tag - 20);
    }
}
@end












