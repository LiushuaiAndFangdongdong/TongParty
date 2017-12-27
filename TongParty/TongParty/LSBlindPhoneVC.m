//
//  LSBlindPhoneVC.m
//  TongParty
//
//  Created by 刘帅 on 2017/12/19.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSBlindPhoneVC.h"

@interface LSBlindPhoneVC ()
@property (weak, nonatomic) IBOutlet UITextField *tf_mobile;
@property (weak, nonatomic) IBOutlet UITextField *tf_psd;
@property (weak, nonatomic) IBOutlet UITextField *tf_vrCode;
@property (weak, nonatomic) IBOutlet UIButton *btn_showPsd;
@property (weak, nonatomic) IBOutlet UIButton *btn_getVrcode;
@property (weak, nonatomic) IBOutlet UIButton *btn_confirm;

@end

@implementation LSBlindPhoneVC

- (void)awakeFromNib {
    [super awakeFromNib];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [self backButtonForNavigationBarWithAction:@selector(pop)];
    self.view.backgroundColor = kWhiteColor;
    [self navigationWithTitle:@"绑定手机号"];
    
    [self configActions];
}

- (void)configActions {
    [_btn_getVrcode addTarget:self action:@selector(getVcode:) forControlEvents:UIControlEventTouchUpInside];
    [_btn_showPsd addTarget:self action:@selector(showPsw:) forControlEvents:UIControlEventTouchUpInside];
    [_btn_confirm addTarget:self action:@selector(confirmBindMolbie:) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - actions
- (void)showPsw:(UIButton *)sender {
    if (_tf_psd.secureTextEntry == YES) {
        _tf_psd.secureTextEntry = NO;
        [sender setImage:kImage(@"login_psd_show") forState:UIControlStateNormal];
    } else {
        _tf_psd.secureTextEntry = YES;
        [sender setImage:kImage(@"login_psd_notshow") forState:UIControlStateNormal];
    }
}

- (void)getVcode:(UIButton *)sender {
    if (![self validatePhoneWithPhone:_tf_mobile.text]) {
        [MBProgressHUD showError:@"请输入正确手机号！" toView:KEY_WINDOW];
        return;
    }
    [DDTJHttpRequest msgCodeWithUsername:_tf_mobile.text block:^(NSDictionary *dict) {
        // 获取验证码成功
    } failure:^{
        
    }];
}

- (void)confirmBindMolbie:(UIButton *)sender {
    [DDTJHttpRequest bindMobile:_tf_mobile.text code:_tf_vrCode.text block:^(NSDictionary *dict) {
        
    } failure:^{
        
    }];
}

- (BOOL)validatePhoneWithPhone:(NSString *)phone {
    phone = [phone stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (phone.length != 11)
    {
        return NO;
    }else{
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:phone];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:phone];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:phone];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
