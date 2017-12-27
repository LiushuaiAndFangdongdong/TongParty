
//
//  DDPsdSettingVc.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/29.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDPsdSettingVc.h"
#import "DDTitletxtFieldView.h"

@interface DDPsdSettingVc ()
@property (nonatomic, strong) DDTitletxtFieldView *currentPsdFieldView;  //当前密码
@property (nonatomic, strong) DDTitletxtFieldView *settingPsdFieldView;  //新密码
@property (nonatomic, strong) DDTitletxtFieldView *confirmPsdPsdFieldView;//确认新密码
@property (nonatomic, strong) UIButton     *btn_confirm;//确认修改密码
@end

@implementation DDPsdSettingVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationWithTitle:@"密码设置"];
    self.navigationItem.leftBarButtonItem = [self backButtonForNavigationBarWithAction:@selector(pop)];
    [self setupViews];
}
-(void)setupViews{
    
    self.currentPsdFieldView  = [[DDTitletxtFieldView alloc] init];
    [self.view addSubview:self.currentPsdFieldView];
    [self.currentPsdFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(1);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    self.currentPsdFieldView.style = DDTextFieldStyleText;
    self.currentPsdFieldView.titlestring = @"密码";
    self.currentPsdFieldView.ploceholderstr = @"请输入当前密码";
    
    self.settingPsdFieldView = [[DDTitletxtFieldView alloc] init];
    [self.view addSubview:self.settingPsdFieldView];
    [self.settingPsdFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.currentPsdFieldView.mas_bottom).offset(5);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    self.settingPsdFieldView.style = DDTextFieldStyleText;
    self.settingPsdFieldView.titlestring = @"新密码";
    self.settingPsdFieldView.ploceholderstr = @"请输入新密码";
    
    self.confirmPsdPsdFieldView = [[DDTitletxtFieldView alloc] init];
    [self.view addSubview:self.confirmPsdPsdFieldView];
    [self.confirmPsdPsdFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.settingPsdFieldView.mas_bottom).offset(1);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    self.confirmPsdPsdFieldView.style = DDTextFieldStyleText;
    self.confirmPsdPsdFieldView.titlestring = @"确认密码";
    self.confirmPsdPsdFieldView.ploceholderstr = @"请再次确认";
    
    self.btn_confirm = [UIButton new];
    [self.view addSubview:self.btn_confirm];
    [self.btn_confirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.confirmPsdPsdFieldView.mas_bottom).offset(DDFitHeight(50));
        make.height.mas_equalTo(DDFitHeight(45.f));
        make.width.mas_equalTo(DDFitWidth(150));
    }];
    [self.btn_confirm setTitle:@"确认修改" forState:UIControlStateNormal];
    self.btn_confirm.backgroundColor = kGreenColor;
    self.btn_confirm.layer.cornerRadius = DDFitHeight(20.f);
    [self.btn_confirm setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [self.btn_confirm addTarget:self action:@selector(confirmToEditPsw:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)confirmToEditPsw:(UIButton *)sender {
    if (![self.settingPsdFieldView.textView.text isEqualToString:self.confirmPsdPsdFieldView.textView.text]) {
        [MBProgressHUD showError:@"两次密码必须一致" toView:[UIApplication sharedApplication].keyWindow];
        return;
    }
    if (self.settingPsdFieldView.textView.text.length < 7 || self.confirmPsdPsdFieldView.textView.text.length < 7) {
        [MBProgressHUD showError:@"密码不得小于6位数" toView:[UIApplication sharedApplication].keyWindow];
        return;
    }
    [DDTJHttpRequest editCurrentPwdwithNewpwd:self.confirmPsdPsdFieldView.textView.text block:^(NSDictionary *dict) {
        [self pop];
    } failure:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end







