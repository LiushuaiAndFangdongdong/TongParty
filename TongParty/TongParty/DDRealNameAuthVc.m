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

@interface DDRealNameAuthVc ()<LSUpLoadImageManagerDelegate>
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
@property (nonatomic, strong) UIImageView *temp_iv;
@end

@implementation DDRealNameAuthVc
//身份证宽高之比：321/208 = 1.54
- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationWithTitle:@"实名认证"];
    self.navigationItem.leftBarButtonItem = [self backButtonForNavigationBarWithAction:@selector(pop)];
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
    self.frontCardView.userInteractionEnabled = YES;
    [self.frontCardView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(uploadImage:)]];
    
    self.backCardView = [[UIImageView alloc] init];
    [self.bgView addSubview:self.backCardView];
    [self.backCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.frontCardView);
        make.left.mas_equalTo(self.frontCardView.mas_right).offset(kIdCardGap);
        make.width.mas_equalTo(self.frontCardView);
        make.height.mas_equalTo(self.frontCardView);
    }];
    self.backCardView.image = kImage(@"person_idcard_fan");
    self.backCardView.userInteractionEnabled = YES;
    [self.backCardView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(uploadImage:)]];
    
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
    [self.submitBtn addTarget:self action:@selector(releaseRealName:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.messageLabel.mas_bottom).offset(5);
        make.left.and.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.alertLabel.mas_bottom).offset(10);
    }];
    
}


- (void)releaseRealName:(UIButton *)sender {
    // 这里做些信息提交时候的判断
    if (![self judgeIdentityStringValid:_idcardField.textView.text]) {
        [MBProgressHUD showError:@"请输入正确身份号码！" toView:KEY_WINDOW];
        return;
    }
    NSString *stringName = [_nameField.textView.text stringByReplacingOccurrencesOfString:@"" withString:@" "];
    if ([stringName isEqualToString:@""]) {
        [MBProgressHUD showError:@"姓名不能为空！" toView:KEY_WINDOW];
        return;
    }
    if (!_frontCardView.image || !_backCardView.image) {
        [MBProgressHUD showError:@"照片信息不能为空！" toView:KEY_WINDOW];
        return;
    }
    [DDTJHttpRequest realnameAuthWithToken:TOKEN real_name:_nameField.textView.text id_number:_idcardField.textView.text positive:_frontCardView.image negative:_backCardView.image block:^(NSDictionary *dict) {} failure:^{
    }];
}

- (void)uploadImage:(UITapGestureRecognizer *)tap {
    _temp_iv = (UIImageView *)[tap view];
    [LSUPLOAD_IMAGE showActionSheetInFatherViewController:self delegate:self];
}

#pragma mark - LSUpLoadImageManagerDelegate
- (void)uploadImageToServerWithImage:(UIImage *)image {
    _temp_iv.image = image;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// 判断身份证号是否合法
- (BOOL)judgeIdentityStringValid:(NSString *)identityString {
    NSString *idCarNum = [identityString uppercaseString];
    if (idCarNum.length != 18) return NO;
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
    //  NSString *regex = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:idCarNum]) return NO;
    
    //** 开始进行校验 *//
    
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex = [[idCarNum substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [idCarNum substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    }
    else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;
}

@end













