//
//  DDRealNameAuthVc.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/28.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDRealNameAuthVc.h"
#import "DDTitletxtFieldView.h"

#define kIdCardGap   20
#define kIdCardWidth (kScreenWidth/2 - 1.5*kIdCardGap)

@interface DDRealNameAuthVc ()
@property (nonatomic, strong) DDTitletxtFieldView *nameField;  //姓名
@property (nonatomic, strong) DDTitletxtFieldView *idcardField;//身份证号
@property (nonatomic, strong) DDTitletxtFieldView *phoneField; //手机号码
@property (nonatomic, strong) UILabel *messageLabel;     //上传信息证
@property (nonatomic, strong) UIView *bgView;            //背景
@property (nonatomic, strong) UILabel *frontCardLabel;   //正面标签
@property (nonatomic, strong) UILabel *backCardLabel;    //反面标签
@property (nonatomic, strong) UIImageView *frontCardView;//正面图
@property (nonatomic, strong) UIImageView *backCardView; //反面图
@property (nonatomic, strong) UILabel *alertLabel;       //提示语
@property (nonatomic, strong) UIButton *submitBtn;        //提交按钮

@end

@implementation DDRealNameAuthVc
//身份证宽高之比：321/208 = 1.54
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实名认证";
    [self setupViews];
}
-(void)setupViews{
    self.nameField = [[DDTitletxtFieldView alloc] init];
    [self.view addSubview:self.nameField];
    [self.nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(1);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    self.nameField.style = DDTextFieldStyleText;
    self.nameField.titlestring  = @"真实姓名";
    self.nameField.ploceholderstr  = @"请输入您的真实姓名";
    
    self.idcardField = [[DDTitletxtFieldView alloc] init];
    [self.view addSubview:self.idcardField];
    [self.idcardField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameField.mas_bottom).offset(1);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    self.idcardField.style = DDTextFieldStyleText;
    self.idcardField.titlestring  = @"身份证号";
    self.idcardField.ploceholderstr  = @"请输入您的身份证号";
    
    self.phoneField = [[DDTitletxtFieldView alloc] init];
    [self.view addSubview:self.phoneField];
    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.idcardField.mas_bottom).offset(1);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    self.phoneField.style = DDTextFieldStyleText;
    self.phoneField.titlestring  = @"手机号码";
    self.phoneField.ploceholderstr  = @"请输入您的手机号码";
    
    self.messageLabel = [[UILabel alloc] init];
    [self.view addSubview:self.messageLabel];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneField.mas_bottom).offset(5);
        make.left.mas_equalTo(10);
    }];
    self.messageLabel.text = @"上传身份证";
    self.messageLabel.textAlignment = NSTextAlignmentLeft;
    self.messageLabel.textColor = kGrayColor;
    self.messageLabel.font = kFont(13);
    
    self.bgView = [[UIView alloc] init];
    [self.view addSubview:self.bgView];
    self.bgView.backgroundColor = kWhiteColor;
    
    self.frontCardLabel = [[UILabel alloc] init];
    [self.bgView addSubview:self.frontCardLabel];
    [self.frontCardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kScreenWidth/2);
    }];
    self.frontCardLabel.text = @"证件正面照";
    self.frontCardLabel.textAlignment = NSTextAlignmentCenter;
    self.frontCardLabel.font = kFont(13);
    self.frontCardLabel.textColor = kBlackColor;
    
    self.backCardLabel = [[UILabel alloc] init];
    [self.bgView  addSubview:self.backCardLabel];
    [self.backCardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(self.frontCardLabel.mas_right);
        make.width.mas_equalTo(kScreenWidth/2);
    }];
    self.backCardLabel.text = @"证件反面照";
    self.backCardLabel.textAlignment = NSTextAlignmentCenter;
    self.backCardLabel.font = kFont(13);
    self.backCardLabel.textColor = kBlackColor;
    
    self.frontCardView = [[UIImageView alloc] init];
    [self.bgView addSubview:self.frontCardView];
    [self.frontCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.frontCardLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(kIdCardGap);
        make.width.mas_equalTo(kIdCardWidth);
        make.height.mas_equalTo(kIdCardWidth/1.54);
    }];
    self.frontCardView.image = kImage(@"person_idcard_zheng");
    
    self.backCardView = [[UIImageView alloc] init];
    [self.bgView addSubview:self.backCardView];
    [self.backCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.frontCardView);
        make.left.mas_equalTo(self.frontCardView.mas_right).offset(kIdCardGap);
        make.width.mas_equalTo(self.frontCardView);
        make.height.mas_equalTo(self.frontCardView);
    }];
    self.backCardView.image = kImage(@"person_idcard_fan");
    
    self.alertLabel = [[UILabel alloc] init];
    [self.bgView addSubview:self.alertLabel];
    [self.alertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backCardView.mas_bottom).offset(10);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    self.alertLabel.text = @"请保证身份证号码清晰可见。遮挡、模糊\n或上传不相关照片都将导致审核不通过";
    self.alertLabel.textColor = kGrayColor;
    self.alertLabel.numberOfLines = 2;
    self.alertLabel.font = kFont(11);
    self.alertLabel.textAlignment = NSTextAlignmentCenter;
    
    self.submitBtn = [[UIButton alloc] init];
    [self.view addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_bottom).offset(40);
        make.left.mas_equalTo(DDFitWidth(110));
        make.right.mas_equalTo(-DDFitWidth(110));
        make.height.mas_equalTo((kScreenWidth - DDFitWidth(110)*2)/3.75);
    }];
    [self.submitBtn setTitle:@"提交信息" forState:UIControlStateNormal];
    self.submitBtn.backgroundColor = kLightGreenColor;
    [self.submitBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    self.submitBtn.layerCornerRadius = (kScreenWidth - DDFitWidth(110)*2)/7.75;
    
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.messageLabel.mas_bottom).offset(5);
        make.left.and.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.alertLabel.mas_bottom).offset(10);
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end













