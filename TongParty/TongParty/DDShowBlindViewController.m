//
//  DDShowBlindViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/29.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDShowBlindViewController.h"

@interface DDShowBlindViewController ()
@property (nonatomic, strong) UIImageView *socialIcon;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *desLabel;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *des;
@end

@implementation DDShowBlindViewController
//图标宽 182/(182+284*2) = 0.24  高 182/(248+182+904)   顶点 248/(248+182+904)=0.186
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [self backButtonForNavigationBarWithAction:@selector(pop)];
    [self setupViews];
}
-(void)setupViews{
    
    self.view.backgroundColor = kWhiteColor;
    
    self.socialIcon = [[UIImageView alloc] init];
    [self.view addSubview:self.socialIcon];
    [self.socialIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenWidth*0.24);
        make.height.mas_equalTo(kScreenWidth*0.24);
        make.top.mas_equalTo(kScreenHeight*0.186);
        make.centerX.mas_equalTo(self.view);
    }];
    self.socialIcon.layerCornerRadius = kScreenWidth*0.24/2;
    
    self.nameLabel = [[UILabel alloc] init];
    [self.view addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.socialIcon.mas_bottom).offset(30);
        make.left.and.right.mas_equalTo(0);
    }];
    self.nameLabel.textColor = kBlackColor;
    self.nameLabel.font = kFont(15);
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    
    self.desLabel = [[UILabel alloc] init];
    [self.view addSubview:self.desLabel];
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(30);
    }];
    self.desLabel.textColor = kGrayColor;
    self.desLabel.font = kFont(13);
    self.desLabel.textAlignment = NSTextAlignmentCenter;
    self.desLabel.numberOfLines = 2;
    
    self.socialIcon.image = kImage(_img);
    self.nameLabel.text = _name;
    self.desLabel.text = _des;
}
-(void)setType:(DDSocialBlindType)type{
    switch (type) {
        case DDSocialBlindTypePhone:
        {
            _img = @"personAuth_blind_phone";
            _name = [NSString stringWithFormat:@"手机号码：%@",_userModel.mobile];
            _des = @"已绑定成功，现在您可以通过手机号码登录桐聚";
        }
            break;
        case DDSocialBlindTypeWx:
        {
            _img =@"personAuth_blind_wx";
            _name = @"微信";
            _des = @"已绑定成功，现在您可以通过微信登录桐聚";
        }break;
        case DDSocialBlindTypeQQ:
        {
            _img =@"personAuth_blind_QQ";
            _name = @"QQ";
            _des = @"已绑定成功，现在您可以通过QQ登录桐聚";
        }break;
        case DDSocialBlindTypeWeibo:
        {
            _img =@"personAuth_blind_weibo";
            _name = @"新浪微博";
            _des = @"已绑定成功，现在您可以通过微博登录桐聚";
        }break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end







