//
//  DDLoginViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/10/28.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDLoginViewController.h"
#import "DDRegisterViewController.h"
#import "FXDAnimationField.h"
#import <UMSocialCore/UMSocialCore.h>

#define kLeftPadding    30
#define kThirdBtnWidth  60
#define kThirdBtnPadding (kScreenWidth - 3*DDFitHeight(kThirdBtnWidth))/4

@interface DDLoginViewController ()
@property (strong, nonatomic) FXDAnimationField *emailAnimationField;
@property (strong, nonatomic) FXDAnimationField *passwordAnimationField;
@property (nonatomic, strong) UIButton *registerBtn;
@property (nonatomic, strong) UIButton *forgetBtn;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) DDLoginManager *loginManager;
@end

@implementation DDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"登录";
    [self navigationWithTitle:@"登录"];
    [self.view addSubview:self.emailAnimationField];
    [self.view addSubview:self.passwordAnimationField];
    [self.view addSubview:self.registerBtn];
    [self.view addSubview:self.forgetBtn];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.messageLabel];
    [self setupThirdLogin];
}

- (void)setupThirdLogin{
    NSArray *thirdImageArr = @[@"personAuth_blind_wx",@"personAuth_blind_QQ",@"personAuth_blind_weibo"];
    for (int i = 0; i < 3; i++) {
        UIButton *thirdBtn = [[UIButton alloc] init];
        thirdBtn.frame = CGRectMake(kThirdBtnPadding*(i+1)+i*DDFitHeight(kThirdBtnWidth), 310, DDFitHeight(kThirdBtnWidth), DDFitHeight(kThirdBtnWidth));
        [thirdBtn setBackgroundImage:[UIImage imageNamed:thirdImageArr[i]] forState:UIControlStateNormal];
        thirdBtn.tag = 10+i;
        [thirdBtn addTarget:self action:@selector(thirdLogin:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:thirdBtn];
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (UILabel *)messageLabel{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 280, kScreenWidth, 20)];
        _messageLabel.text = @"——————— 您还可以用以下方式登录/注册 ———————";
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.font = kFont(11);
        _messageLabel.textColor = kGrayColor;
    }
    return _messageLabel;
}

- (UIButton *)registerBtn{
    if (!_registerBtn) {
        _registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(kLeftPadding, 175, 100, 20)];
        [_registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
        [_registerBtn setTitleColor:kBgGreenColor forState:UIControlStateNormal];
        _registerBtn.titleLabel.font = kFont(13);
        _registerBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_registerBtn addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerBtn;
}

- (UIButton *)forgetBtn{
    if (!_forgetBtn) {
        _forgetBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100 - kLeftPadding, 175, 100, 20)];
        [_forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [_forgetBtn setTitleColor:kGrayColor forState:UIControlStateNormal];
        _forgetBtn.titleLabel.font = kFont(13);
        _forgetBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _forgetBtn;
}

- (UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(kLeftPadding, 210, self.view.size.width - kLeftPadding*2, DDFitHeight(40))];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _loginBtn.backgroundColor = kBgGreenColor;
        _loginBtn.layerCornerRadius = 15;
        [_loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}
- (FXDAnimationField *)emailAnimationField {
    if (!_emailAnimationField) {
        _emailAnimationField = [[FXDAnimationField alloc]initWithFrame:CGRectMake(kLeftPadding, 40, self.view.frame.size.width - kLeftPadding*2, DDFitHeight(40))];
        _emailAnimationField.textFiled.borderStyle =  UITextBorderStyleNone;
        _emailAnimationField.placeholderColor = [UIColor lightGrayColor];
        _emailAnimationField.placeStr = @"请输入手机号码";
        _emailAnimationField.placeholderFont = [UIFont systemFontOfSize:13];
        //_emailAnimationField.textColor = [UIColor greenColor];
        _emailAnimationField.animationType = FXDAnimationTypeUp;
        _emailAnimationField.leftImage = @"login_phone";
        _emailAnimationField.textFeildType =  FXDTextFeildTypeNormal;
        _emailAnimationField.keyboardType = UIKeyboardTypePhonePad;
    }
    return _emailAnimationField;
}

- (FXDAnimationField *)passwordAnimationField {
    if (!_passwordAnimationField) {
        _passwordAnimationField = [[FXDAnimationField alloc]initWithFrame:CGRectMake(kLeftPadding, 120, self.view.frame.size.width - kLeftPadding*2, DDFitHeight(40))];
        _passwordAnimationField.textFiled.borderStyle =  UITextBorderStyleNone;
        _passwordAnimationField.placeholderColor = [UIColor lightGrayColor];
        _passwordAnimationField.placeStr = @"请输入密码";
        _passwordAnimationField.placeholderFont = [UIFont systemFontOfSize:13];
        //_passwordAnimationField.textColor = [UIColor greenColor];
        _passwordAnimationField.animationType = FXDAnimationTypeUp;
        _passwordAnimationField.leftImage = @"login_password";
        _passwordAnimationField.textFeildType = FXDTextFeildTypeSecurtyPsd;
    }
    return _passwordAnimationField;
}
-(DDLoginManager *)loginManager
{
    if(!_loginManager) {
        _loginManager = [[DDLoginManager alloc]initWithController:self];
    }
    return _loginManager;
}

#pragma mark  -login
-(void)loginAction:(UIButton *)sender{
    [self.loginManager loginWithUsername:self.emailAnimationField.textFiled.text password:self.passwordAnimationField.textFiled.text block:^(NSDictionary *dict) {
        [DDUserDefault setObject:dict[@"token"] forKey:@"token"];
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            [self popViewController];
        });
    } failure:^{
        //
    }];
}
#pragma  mark - 第三方登录
- (void)thirdLogin:(UIButton *)sender{
    switch ((sender.tag-10)) {
        case 0:
        {
            //微信登录
            [self wxLogin];
        }
        break;
        case 1:
        {
            //QQ登录
            [self QQLogin];
        }break;
        case 2:
        {
            //微博登录
            [self weiboLogin];
        }break;
        default:
            break;
    }
}

#pragma mark - 微信登录
-(void)wxLogin{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            // 授权信息
            NSLog(@"Wechat uid: %@", resp.uid);
            NSLog(@"Wechat openid: %@", resp.openid);
            NSLog(@"Wechat accessToken: %@", resp.accessToken);
            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
            NSLog(@"Wechat expiration: %@", resp.expiration);
            // 用户信息
            NSLog(@"Wechat name: %@", resp.name);
            NSLog(@"Wechat iconurl: %@", resp.iconurl);
            NSLog(@"Wechat gender: %@", resp.gender);
            // 第三方平台SDK源数据
            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
        }
    }];
}
#pragma mark - QQ登录
-(void)QQLogin{
    /**
     设置QQ授权登录
     
     @param platformType 平台
     @param result 授权成功
     @param error 授权失败
     */
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
        } else {
            UMSocialUserInfoResponse *resp = result;
            // 授权信息
            NSLog(@"QQ uid: %@", resp.uid);
            NSLog(@"QQ openid: %@", resp.openid);
            NSLog(@"QQ accessToken: %@", resp.accessToken);
            NSLog(@"QQ expiration: %@", resp.expiration);
            // 用户信息
            NSLog(@"QQ name: %@", resp.name);
            NSLog(@"QQ iconurl: %@", resp.iconurl);
            NSLog(@"QQ gender: %@", resp.gender);
            // 第三方平台SDK源数据
            NSLog(@"QQ originalResponse: %@", resp.originalResponse);
        }
    }];
}
#pragma mark - 微博登录
- (void)weiboLogin{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Sina currentViewController:self completion:^(id result, NSError *error) {
        UMSocialUserInfoResponse *resp = result;
        // 第三方登录数据(为空表示平台未提供)
        // 授权数据
        NSLog(@" uid: %@", resp.uid);
        NSLog(@" openid: %@", resp.openid);
        NSLog(@" accessToken: %@", resp.accessToken);
        NSLog(@" refreshToken: %@", resp.refreshToken);
        NSLog(@" expiration: %@", resp.expiration);
        // 用户数据
        NSLog(@" name: %@", resp.name);
        NSLog(@" iconurl: %@", resp.iconurl);
        NSLog(@" gender: %@", resp.gender);
        // 第三方平台SDK原始数据
        NSLog(@" originalResponse: %@", resp.originalResponse);
    }];
}

- (void)registerAction:(UIButton *)sender{
    DDRegisterViewController *rVC =  [[DDRegisterViewController alloc] init];
    [self.navigationController pushViewController:rVC animated:NO];
}
#pragma mark - other
-(void)popViewController
{
    if (self.isPopToRoot) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end







