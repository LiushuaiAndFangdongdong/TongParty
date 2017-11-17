//
//  DDPersonLabelVc.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/27.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDPersonLabelVc.h"

#define kPersonLabelItemGapWidth 15
#define kPersonLabelItemWidth  (kScreenWidth - kPersonLabelItemGapWidth *4)/3
#define kPersonLabelItemHeight  kPersonLabelItemWidth/2.7

@interface DDPersonLabelVc ()
@property (nonatomic, strong) UIImageView *topView;
@end
// 216/80=2.7    962/281= 3.4
@implementation DDPersonLabelVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人标签";
    [self setupViews];
}

-(void)setupViews{
    
    //上部介绍
    self.topView = [UIImageView new];
    [self.view addSubview:self.topView];
     [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(15);
         make.left.mas_equalTo(20);
         make.right.mas_equalTo(-20);
         make.height.mas_equalTo((kScreenWidth-40)/3.4);
     }];
    self.topView.image  =[UIImage imageNamed:@"person_label_topView"];
    
    //循环创建个人标签
    for (int i = 0; i < 3; i++) {
        
        for (int j = 0; j < 3; j++) {
            //一排三个的按钮，三排
            UIButton *threeBtn = [UIButton new];
            [self.view addSubview:threeBtn];
            [threeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo((i+1)*kPersonLabelItemGapWidth + i*kPersonLabelItemWidth);
                make.top.mas_equalTo(self.topView.mas_bottom).offset(kPersonLabelItemGapWidth *((j+1)*2-1) + kPersonLabelItemHeight*(j*2));
                make.width.mas_equalTo(kPersonLabelItemWidth);
                make.height.mas_equalTo(kPersonLabelItemHeight);
            }];
            [threeBtn setTitle:@"活泼开朗" forState:UIControlStateNormal];
            [threeBtn setTitleColor:kDDRandColor forState:UIControlStateNormal];
            threeBtn.titleLabel.font = kFont(13);
            threeBtn.layerCornerRadius = kPersonLabelItemHeight/2;
            threeBtn.layerBorderWidth = 1;
            threeBtn.layerBorderColor = kDDRandColor;
            if(i == 2){
                continue;
            }
            //一排两列的按钮，三排
            UIButton *twoBtn = [UIButton new];
            [self.view addSubview:twoBtn];
            [twoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(kPersonLabelItemWidth);
                make.height.mas_equalTo(kPersonLabelItemHeight);
                make.left.mas_equalTo((0.5+i)*kPersonLabelItemWidth+(1.5+i)*kPersonLabelItemGapWidth);
                make.top.mas_equalTo(threeBtn.mas_bottom).offset(kPersonLabelItemGapWidth);
            }];
            [twoBtn setTitle:@"与国同庆" forState:UIControlStateNormal];
            [twoBtn setTitleColor:kDDRandColor forState:UIControlStateNormal];
            twoBtn.titleLabel.font = kFont(13);
            twoBtn.layerCornerRadius = kPersonLabelItemHeight/2;
            twoBtn.layerBorderWidth = 1;
            twoBtn.layerBorderColor = kDDRandColor;
        }
    }
    
        UIButton *customBtn = [UIButton new];
        [self.view addSubview:customBtn];
        [customBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kPersonLabelItemWidth);
            make.height.mas_equalTo(kPersonLabelItemHeight);
        make.top.mas_equalTo(self.topView.mas_bottom).offset(6*kPersonLabelItemHeight+7*kPersonLabelItemGapWidth);
            make.left.mas_equalTo((kScreenWidth - kPersonLabelItemWidth)/2);
        }];
        [customBtn setTitle:@"自定义标签" forState:UIControlStateNormal];
        [customBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        customBtn.backgroundColor = kLightGreenColor;
        customBtn.titleLabel.font = kFont(13);
        customBtn.layerCornerRadius = kPersonLabelItemHeight/2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end






