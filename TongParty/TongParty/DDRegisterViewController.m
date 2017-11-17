
//
//  DDRegisterViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/10/29.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDRegisterViewController.h"
#import "FXDAnimationField.h"
#import "DDValidateManager.h"

#define kLeftPadding    30

@interface DDRegisterViewController ()
@property (nonatomic, strong) FXDAnimationField *phoneTxt;
@property (nonatomic, strong) FXDAnimationField *psdTxt;
@property (nonatomic, strong) FXDAnimationField *checkCodeTxt;
@property (nonatomic, strong) UIButton *regiterBtn;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) DDValidateManager *validateManager;
@end

@implementation DDRegisterViewController

- (void)viewDidLoad {
    [self navigationWithTitle:@"注册"];
    [self.view addSubview:self.phoneTxt];
     [self.view addSubview:self.psdTxt];
     [self.view addSubview:self.checkCodeTxt];
     [self.view addSubview:self.regiterBtn];
    [self.view addSubview:self.messageLabel];
}
- (FXDAnimationField *)phoneTxt{
    if (!_phoneTxt) {
        _phoneTxt = [[FXDAnimationField alloc] initWithFrame:CGRectMake(kLeftPadding, 40, kScreenWidth - kLeftPadding*2, DDFitHeight(40))];
        _phoneTxt.textFiled.borderStyle =  UITextBorderStyleNone;
        _phoneTxt.placeholderColor = [UIColor lightGrayColor];
        _phoneTxt.placeStr = @"请输入手机号码";
        _phoneTxt.placeholderFont = [UIFont systemFontOfSize:13];
        //_phoneTxt.textColor = [UIColor greenColor];
        _phoneTxt.animationType = FXDAnimationTypeUp;
        _phoneTxt.leftImage = @"login_phone";
        _phoneTxt.textFeildType = FXDTextFeildTypeNormal;
        _phoneTxt.keyboardType = UIKeyboardTypePhonePad;
    }
    return _phoneTxt;
}
- (FXDAnimationField *)psdTxt{
    if (!_psdTxt) {
        _psdTxt = [[FXDAnimationField alloc] initWithFrame:CGRectMake(kLeftPadding, 120, kScreenWidth - kLeftPadding*2, DDFitHeight(40))];
        _psdTxt.textFiled.borderStyle =  UITextBorderStyleNone;
        _psdTxt.placeholderColor = [UIColor lightGrayColor];
        _psdTxt.placeStr = @"请输入密码";
        _psdTxt.placeholderFont = [UIFont systemFontOfSize:13];
        //_psdTxt.textColor = [UIColor greenColor];
        _psdTxt.animationType = FXDAnimationTypeUp;
        _psdTxt.leftImage = @"login_password";
        _psdTxt.textFeildType = FXDTextFeildTypeSecurtyPsd;
    }
    return _psdTxt;
}

- (FXDAnimationField *)checkCodeTxt{
    if (!_checkCodeTxt) {
        _checkCodeTxt = [[FXDAnimationField alloc] initWithFrame:CGRectMake(kLeftPadding, 200, kScreenWidth - kLeftPadding*2, DDFitHeight(40))];
        _checkCodeTxt.textFiled.borderStyle =  UITextBorderStyleNone;
        _checkCodeTxt.placeholderColor = [UIColor lightGrayColor];
        _checkCodeTxt.placeStr = @"请输入手机验证码";
        _checkCodeTxt.placeholderFont = [UIFont systemFontOfSize:13];
        //_checkCodeTxt.textColor = [UIColor greenColor];
        _checkCodeTxt.animationType = FXDAnimationTypeUp;
        _checkCodeTxt.leftImage = @"login_checkcode";
        _checkCodeTxt.textFeildType = FXDTextFeildTypeSendCode;
        WeakSelf(weakSelf);
        _checkCodeTxt.sendverifyCodeBlcok = ^(NSString *verifyCode) {
            [weakSelf sendMsgVerifycodeWithCode:verifyCode];
        };
    }
    return _checkCodeTxt;
}

- (UIButton *)regiterBtn{
    if (!_regiterBtn) {
        _regiterBtn = [[UIButton alloc] initWithFrame:CGRectMake(kLeftPadding, 270, kScreenWidth - kLeftPadding*2, DDFitHeight(40))];
        [_regiterBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_regiterBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _regiterBtn.backgroundColor = kBgGreenColor;
        _regiterBtn.layerCornerRadius = 15;
        [_regiterBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _regiterBtn;
}

- (UILabel *)messageLabel{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLeftPadding, 320, kScreenWidth - kLeftPadding*2, DDFitHeight(20))];
//        _messageLabel.text = @"登录后即表示同意桐聚《用户协议》";
        _messageLabel.font = kFont(13);
        _messageLabel.textColor = kGrayColor;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"登录后即表示同意桐聚《用户协议》"];
        NSRange strRange = {10,6};
        [str addAttributes:@{
                             NSForegroundColorAttributeName:kBgGreenColor
                             } range:strRange];
        _messageLabel.attributedText  = str;
    }
    return _messageLabel;
}
-(DDValidateManager *)validateManager
{
    if(!_validateManager) {
        _validateManager = [[DDValidateManager alloc]initWithController:self];
    }
    return _validateManager;
}

#pragma mark - 发送验证码
-(void)sendMsgVerifycodeWithCode:mobile{
    if ([self.validateManager validateVercodeWithPhone:_phoneTxt.textFiled.text]) {
        [self.checkCodeTxt disabledStatus];
        
        [DDTJHttpRequest msgCodeWithUsername:_phoneTxt.textFiled.text block:^(NSDictionary *dict) {
            [MBProgressHUD showMessage:dict[@"msg_cn"] toView:self.view];
            NSLog(@"对的" );
        } failure:^{
            //
        }];
    }
}

#pragma mark - 注册
-(void)registerAction{
    DDLoginModel *model = [[DDLoginModel alloc] init];
    model.username = self.phoneTxt.textFiled.text;
    model.password = self.psdTxt.textFiled.text;
    model.vercode  = self.checkCodeTxt.textFiled.text;
    if ([self.validateManager validateLoginWithModel:model]) {
        [DDTJHttpRequest registerWithMobile:model.username passwd:model.password code:model.vercode block:^(NSDictionary *dict) {
            
        } failure:^{
            //
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end





