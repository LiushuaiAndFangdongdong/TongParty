//
//  LSTimeSortVC.m
//  TongParty
//
//  Created by 刘帅 on 2017/12/27.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSTimeSortVC.h"

@interface LSTimeSortVC ()
@property (nonatomic, strong)UIButton  *btn_temp;
@end
static NSInteger btn_baseTag = 253;
@implementation LSTimeSortVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}

- (void)setupViews {
    NSArray *array = @[@"24小时",@"11:00-14:00",@"17:00-21:30",@"22:00-03:30"];
    CGFloat btn_lableH = DDFitHeight(25.f);
    CGFloat btn_lableW = (kScreenWidth - DDFitWidth(70.f))/4.f;
    for (int btn_count = 0; btn_count < array.count; btn_count++) {
        UIButton *btn_label = [UIButton new];
        btn_label.frame = CGRectMake(DDFitWidth(20.f) + (btn_lableW + DDFitWidth(10.f))  * btn_count, DDFitHeight(6.25f), btn_lableW, btn_lableH);
        [btn_label setTitle:array[btn_count] forState:UIControlStateNormal];
        btn_label.layer.borderColor = kCommonGrayTextColor.CGColor;
        btn_label.layer.borderWidth = kLineHeight;
        btn_label.layer.cornerRadius = 3.f;
        [btn_label setTitleColor:kCommonGrayTextColor forState:UIControlStateNormal];
        btn_label.titleLabel.font = DDFitFont(12.f);
        btn_label.tag = btn_baseTag + btn_count;
        btn_label.backgroundColor = kWhiteColor;
        [btn_label addTarget:self action:@selector(chooseSecondaryLabel:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn_label];
    }
}

- (void)chooseSecondaryLabel:(UIButton *)sender {
    if (_btn_temp) {
        _btn_temp.backgroundColor = kWhiteColor;
        [_btn_temp setTitleColor:kCommonGrayTextColor forState:UIControlStateNormal];
    }
    [sender setTitleColor:kWhiteColor forState:UIControlStateNormal];
    sender.backgroundColor = kRGBColor(118.f, 213.f, 113.f);
    _btn_temp = sender;
    if (!_onTimeClickBlcok) {
        return;
    }
    switch (sender.tag - btn_baseTag) {
        case 0:{
            _onTimeClickBlcok(nil,nil);
            }break;
        case 1:{
            _onTimeClickBlcok(@"11:00",@"14:00");
        }break;
        case 2:{
            _onTimeClickBlcok(@"17:00",@"21:30");
        }break;
        case 3:{
            _onTimeClickBlcok(@"22:00",@"03:00");
        }break;

        default:
            break;
    }
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
