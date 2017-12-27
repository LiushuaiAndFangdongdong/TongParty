//
//  DDSesameAuthVc.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/28.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDSesameAuthVc.h"
#import "DDTitletxtFieldView.h"

@interface DDSesameAuthVc ()
@property (nonatomic, strong) DDTitletxtFieldView *txtFieldView;
@property (nonatomic, strong) UIButton *nextBtn;
@end

@implementation DDSesameAuthVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationWithTitle:@"芝麻认证"];
    self.navigationItem.leftBarButtonItem = [self backButtonForNavigationBarWithAction:@selector(pop)];
    [self setupViews];
}
-(void)setupViews{
    self.txtFieldView = [[DDTitletxtFieldView alloc] init];
    [self.view addSubview:self.txtFieldView];
    [self.txtFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(1);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    self.txtFieldView.style = DDTextFieldStyleImage;
    self.txtFieldView.titleImagestr = @"personAuth_real_phone";
    self.txtFieldView.ploceholderstr = @"请输入支付宝实名认证的手机号";
    
    self.nextBtn = [[UIButton alloc] init];
    [self.view addSubview:self.nextBtn];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.txtFieldView.mas_bottom).offset(60);
        make.left.mas_equalTo(DDFitWidth(110));
        make.right.mas_equalTo(-DDFitWidth(110));
        make.height.mas_equalTo((kScreenWidth - DDFitWidth(110)*2)/3.75);
    }];
    self.nextBtn.backgroundColor = kLightGreenColor;
    [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [self.nextBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    self.nextBtn.layerCornerRadius = (kScreenWidth - DDFitWidth(110)*2)/7.75;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end









