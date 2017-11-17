
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
@end

@implementation DDPsdSettingVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"密码设置";
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
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end







