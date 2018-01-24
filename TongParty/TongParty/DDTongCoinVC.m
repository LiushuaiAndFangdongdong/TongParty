//
//  DDTongCoinVC.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/26.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDTongCoinVC.h"
#import "DDTongCoinView.h"
#import "POP.h"

#define kMarginGap  30
#define kCoinWidth  (kScreenWidth - 40 - 30*4)/3
#define kCoinHight  kCoinWidth/1.17

@interface DDTongCoinVC ()
@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) UILabel *balanceValue;
@property (nonatomic, strong) UILabel *balanceName;
@property (nonatomic, strong) UIButton *chargeBtn;
@end

@implementation DDTongCoinVC
//背景图宽高比例727/1015 = 0.7   充值铜币宽高比例 131/112 = 1.17  充值按钮宽高比例 428/80 = 5.35
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    UINavigationBar *appearance = [UINavigationBar appearance];
    [appearance setBarTintColor:kWhiteColor];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    UINavigationBar *appearance = [UINavigationBar appearance];
    [appearance setBarTintColor:kTongBiBgColor];
    //导航栏title格式
    NSMutableDictionary *textAttribute = [NSMutableDictionary dictionary];
    textAttribute[NSForegroundColorAttributeName] = kWhiteColor;
    textAttribute[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [appearance setTitleTextAttributes:textAttribute];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationWithTitle:@"桐币"];
    [self setupViews];
}

-(void)setupViews{
    self.view.backgroundColor = kLightGreenColor;
    //背景图
    self.bgView = [UIImageView new];
    [self.view addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(64);
        make.height.mas_equalTo(kScreenWidth/0.7);
    }];
    self.bgView.image = kImage(@"person_tongcoin_bg");
    
    //余额值
    self.balanceValue = [UILabel new];
    [self.bgView addSubview:self.balanceValue];
     [self.balanceValue mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(60);
         make.centerX.mas_equalTo(self.bgView.centerX);
         make.width.mas_equalTo(100);
     }];
    self.balanceValue.textAlignment = NSTextAlignmentCenter;
    self.balanceValue.textColor = kOrangeColor;
    self.balanceValue.font = kBoldFont(18);
    [self increseNum:@"1314"];
    
    //余额
    self.balanceName = [UILabel new];
    [self.bgView addSubview:self.balanceName];
    [self.balanceName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.balanceValue.mas_bottom).offset(10);
        make.centerX.mas_equalTo(self.balanceValue);
        make.width.mas_equalTo(self.balanceValue);
    }];
    self.balanceName.text = @"余额";
    self.balanceName.textAlignment = NSTextAlignmentCenter;
    self.balanceName.textColor = kBlackColor;
    self.balanceName.font = kFont(15);
    
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 2; j++) {
            
            DDTongCoinView *coinView = [[DDTongCoinView alloc] init];
            [self.bgView addSubview:coinView];
            [coinView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(kCoinWidth);
                make.height.mas_equalTo(kCoinHight);
                make.left.mas_equalTo(20+(i+1)*kMarginGap+i*kCoinWidth);
                make.top.mas_equalTo(self.balanceName.mas_bottom).offset((j+1)*kMarginGap + j*kCoinHight);
            }];
            coinView.tongstring = @"700TB";
            coinView.rmbstring  = @"70元";
        }
    }
    
    self.chargeBtn = [UIButton new];
    [self.bgView addSubview:self.chargeBtn];
     [self.chargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(80);
         make.right.mas_equalTo(-80);
         make.height.mas_equalTo((kScreenWidth - 160)/5.35);
         make.top.mas_equalTo(self.balanceName.mas_bottom).offset(2*(kMarginGap+kCoinHight) +60);
     }];
    self.chargeBtn.layerCornerRadius = 20;
    self.chargeBtn.backgroundColor = kLightGreenColor;
    [self.chargeBtn setTitle:@"确认充值" forState:UIControlStateNormal];
     [self.chargeBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    self.chargeBtn.titleLabel.font = kFont(14);
}

//实现数字增长动画
-(void)increseNum:(NSString *)num{
    int toValue = [num intValue];
    //动画效果数字增长
    POPBasicAnimation *animation = [POPBasicAnimation animation];
    animation.property = [self animationProperty];
    animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.12 :1: 0.11:0.94];
    animation.fromValue = @(0);
    animation.toValue = @(toValue);
    animation.duration = 1.2f;
    [self.balanceValue pop_addAnimation:animation forKey:@"numberLabelAnimation"];
}
//数字增长动画
- (POPMutableAnimatableProperty *)animationProperty {
    return [POPMutableAnimatableProperty
            propertyWithName:@"com.curer.test"
            initializer:^(POPMutableAnimatableProperty *prop) {
                prop.writeBlock = ^(id obj, const CGFloat values[]) {
                    UILabel *label = (UILabel *)obj;
                    NSNumber *number = @(values[0]);
                    //此处用int或者float控制小数点是否有和小数点后位数
                    int num = [number intValue];
                    label.text = [@(num) stringValue];
                };
            }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end














