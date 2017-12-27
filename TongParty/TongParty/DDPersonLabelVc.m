//
//  DDPersonLabelVc.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/27.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDPersonLabelVc.h"
#import "LSPersonLabelCollectionCell.h"
#import "LSPersonLabelGroup.h"
#import "LXAlertView.h"
#import "TSActionDemoView.h"
#define kPersonLabelItemGapWidth 15
#define kPersonLabelItemWidth  (kScreenWidth - kPersonLabelItemGapWidth *4)/3
#define kPersonLabelItemHeight  kPersonLabelItemWidth/2.7

@interface DDPersonLabelVc ()
@property (nonatomic, strong) UIView *view_btn;
@property (nonatomic, strong) UIView *topTopView;
@property (nonatomic, strong) UIImageView *topView;
@end
// 216/80=2.7    962/281= 3.4
@implementation DDPersonLabelVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *rBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
    rBtn.titleLabel.font = DDFitFont(14.f);
    rBtn.frame = CGRectMake(0, 0, DDFitWidth(50.f),DDFitWidth(50.f));
    [rBtn setTitle:@"保存" forState:UIControlStateNormal];
    [rBtn addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rBtn];
    [self navigationWithTitle:@"个人标签"];
    self.navigationItem.leftBarButtonItem = [self backButtonForNavigationBarWithAction:@selector(pop)];
    [self setupViews];
}

- (UIView *)topTopView {
    if (!_topTopView) {
        _topTopView = [UIView new];
        [self.view addSubview:_topTopView];
        [_topTopView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.left.equalTo(self.view);
            make.height.mas_equalTo(DDFitHeight(80.f));
        }];
        UILabel *lbl = [UILabel new];
        [self.topTopView addSubview:lbl];
        [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5.f);
            make.left.mas_equalTo(5.f);
            make.height.mas_equalTo(20.f);
        }];
        lbl.text = @"我的标签";
        lbl.font = DDFitFont(13.f);
        lbl.backgroundColor = kBgWhiteGrayColor;
        _view_btn = [UIView new];
        [self.topTopView addSubview:_view_btn];
        [_view_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lbl.mas_bottom);
            make.left.bottom.right.equalTo(_topTopView);;
        }];
        _view_btn.backgroundColor = kWhiteColor;
        
        if (self.selectedArray && self.selectedArray.count > 0) {
            for (int i = 0; i < self.selectedArray.count; i++) {
                UIButton *new_btn = self.selectedArray[i];
                [_view_btn addSubview:new_btn];
                [new_btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(_view_btn);
                    make.height.equalTo(_view_btn).multipliedBy(0.45f);
                    make.width.mas_equalTo((kScreenWidth - DDFitWidth(70.f))/4);
                    make.left.mas_equalTo(DDFitWidth(20.f) + ((kScreenWidth - DDFitWidth(70.f))/4 + DDFitWidth(10.f))*i);
                }];
                [new_btn addTarget:self action:@selector(deleteLabel:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
    }
    return _topTopView;
}

-(void)setupViews{
    
    [self topTopView];
    //上部介绍
    self.topView = [UIImageView new];
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topTopView.mas_bottom).offset(DDFitHeight(10.f));
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo((kScreenWidth-40)/3.4);
    }];
    self.topView.image  =[UIImage imageNamed:@"person_label_topView"];
    
    [DDTJHttpRequest getUserLabelListsWithToken:[DDUserSingleton shareInstance].token block:^(NSDictionary *dict) {
        // label_name
        NSMutableArray *label_list = [NSMutableArray array];
        for (NSDictionary *labelDic in dict) {
            NSString *label = labelDic[@"label_name"];
            [label_list addObject:label];
        }
        
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
                
                [threeBtn setTitleColor:kDDRandColor forState:UIControlStateNormal];
                threeBtn.titleLabel.font = kFont(13);
                threeBtn.layerCornerRadius = kPersonLabelItemHeight/2;
                threeBtn.layerBorderWidth = 1;
                threeBtn.layerBorderColor = kDDRandColor;
                [threeBtn addTarget:self action:@selector(chooseLabel:) forControlEvents:UIControlEventTouchUpInside];
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
                
                [twoBtn setTitleColor:kDDRandColor forState:UIControlStateNormal];
                twoBtn.titleLabel.font = kFont(13);
                twoBtn.layerCornerRadius = kPersonLabelItemHeight/2;
                twoBtn.layerBorderWidth = 1;
                twoBtn.layerBorderColor = kDDRandColor;
                [twoBtn addTarget:self action:@selector(chooseLabel:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
        int count = 0;
        for (id obj in self.view.subviews) {
            if ([obj isKindOfClass:[UIButton class]]) {
                if (count >= label_list.count) {
                    break;
                }
                UIButton* theButton = (UIButton*)obj;
                if (![theButton.titleLabel.text isEqualToString:@"自定义标签"]) {
                    [theButton setTitle:label_list[count] forState:UIControlStateNormal];
                }
                count ++;
                
            }
        }
    } failure:^{
        
    }];
    
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
    [customBtn addTarget:self action:@selector(customLabel:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)customLabel:(UIButton *)sender {
    TSActionDemoView * demoAlertView  = [TSActionDemoView actionAlertViewWithAnimationStyle:TSActionAlertViewTransitionStyleBounce];
    demoAlertView.backgroundStyle = TSActionAlertViewBackgroundStyleSolid;;
    demoAlertView.isAutoHidden = YES;
    demoAlertView.titleString = @"自定义标签";
    demoAlertView.ploceHolderString = @"";
    typeof(TSActionDemoView) __weak *weakView = demoAlertView;
    [demoAlertView setStringHandler:^(TSActionAlertView *alertView,NSString * string){
        typeof(TSActionDemoView) __strong *strongView = weakView;
        if (self.selectedArray.count < 4) {
            UIButton *btn_label = [UIButton new];
            [btn_label setTitle:string forState:UIControlStateNormal];
            [btn_label setTitleColor:kDDRandColor forState:UIControlStateNormal];
            btn_label.titleLabel.font = kFont(13);
            btn_label.layerCornerRadius = 15.f;
            btn_label.layerBorderWidth = 1;
            btn_label.layerBorderColor = kDDRandColor;
            [self.selectedArray addObject:btn_label];
            [self reloadTopTopView];
        }
        [strongView dismissAnimated:YES];
    }];
    [demoAlertView show];
}

- (void)chooseLabel:(UIButton *)sender {
    if (self.selectedArray.count < 4) {
        UIButton *copy_btn = [UIButton new];
        [copy_btn setTitleColor:sender.titleLabel.textColor forState:UIControlStateNormal];
        copy_btn.titleLabel.font = kFont(13);
        copy_btn.layerCornerRadius = 15.f;
        copy_btn.layerBorderWidth = sender.layerBorderWidth;
        copy_btn.layerBorderColor = sender.layerBorderColor;
        [copy_btn setTitle:sender.titleLabel.text forState:UIControlStateNormal];
        [self.selectedArray addObject:copy_btn];
        [self reloadTopTopView];
    } else {
        return;
    }
}

- (void)rightAction:(UIButton *)sender {
    NSMutableString *labelString = [NSMutableString string];
    if (self.selectedArray && self.selectedArray.count > 0) {
        for (int i = 0; i < self.selectedArray.count; i++) {
            UIButton *btn = self.selectedArray[i];
            if (i == self.selectedArray.count - 1) {
                [labelString appendFormat:@"%@",btn.titleLabel.text];
            } else {
                [labelString appendFormat:@"%@,",btn.titleLabel.text];
            }
        }
    }
    
    [DDTJHttpRequest addUserLabels:labelString block:^(NSDictionary *dict) {
        [self pop];
    } failure:^{
        
    }];
}

- (void)deleteLabel:(UIButton *)sender {
    
    LXAlertView *alert = [[LXAlertView alloc] initWithTitle:@"提示" message:@"确定要删除此标签吗？" cancelBtnTitle:@"取消" otherBtnTitle:@"确定" clickIndexBlock:^(NSInteger clickIndex) {
        if (clickIndex == 1) {
            [self.selectedArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj == sender) {
                    *stop = YES;
                    [self.selectedArray removeObject:obj];
                }
            }];
            [self reloadTopTopView];
        }
    }];
    alert.animationStyle = LXASAnimationDefault;
    [alert showLXAlertView];
}

- (void)reloadTopTopView {
    
    // 清空
    for (id obj in _view_btn.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton* theButton = (UIButton*)obj;
            [theButton removeFromSuperview];
        }
    }
    
    for (int i = 0; i < self.selectedArray.count; i++) {
        UIButton *new_btn = self.selectedArray[i];
        [_view_btn addSubview:new_btn];
        [new_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_view_btn);
            make.height.equalTo(_view_btn).multipliedBy(0.45f);
            make.width.mas_equalTo((kScreenWidth - DDFitWidth(70.f))/4);
            make.left.mas_equalTo(DDFitWidth(20.f) + ((kScreenWidth - DDFitWidth(70.f))/4 + DDFitWidth(10.f))*i);
        }];
        [new_btn addTarget:self action:@selector(deleteLabel:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [kNotificationCenter postNotificationName:@"updateLabels" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end






