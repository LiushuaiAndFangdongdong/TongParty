//
//  DDSignQRcodeViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/10/12.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDSignQRcodeViewController.h"

#define kAvatarWidth  50

@interface DDSignQRcodeViewController ()
@property (nonatomic, strong) UIImageView *topView;
@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UIImageView *QRView;
@end
// 宽高：710/249
@implementation DDSignQRcodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

-(void)setupUI{
    self.topView = [[UIImageView alloc] init];
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(60);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo((kScreenWidth - 20)*249/710);
    }];
    self.topView.image = kImage(@"desk_QR_descr");
    
    self.avatarView = [[UIImageView alloc] init];
    [self.view addSubview:self.avatarView];
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(kAvatarWidth);
        make.top.mas_equalTo(self.topView.mas_top).offset(-kAvatarWidth/2);
        make.centerX.mas_equalTo(self.topView.centerX);
    }];
    self.avatarView.layerCornerRadius = 25;
    self.avatarView.backgroundColor = kRedColor;
    
    self.QRView = [[UIImageView alloc] init];
    [self.view addSubview:self.QRView];
    [self.QRView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView.mas_bottom).offset(40);
        make.left.mas_equalTo(80);
        make.right.mas_equalTo(-80);
        make.height.mas_equalTo(kScreenWidth - 160);
    }];
//    self.QRView.image = kImage(@"QR_fdd");
    self.QRView.layerBorderWidth = 1;
    self.QRView.layerBorderColor = kBlackColor;
}
-(void)setHosterAvatar:(NSString *)hosterAvatar{
    [self.QRView sd_setImageWithURL:[NSURL URLWithString:hosterAvatar] placeholderImage:kDefaultAvatar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end










