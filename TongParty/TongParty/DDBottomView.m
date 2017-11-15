//
//  DDBottomView.m
//  TongParty
//
//  Created by 方冬冬 on 2017/10/12.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDBottomView.h"
#import "UIButton+DDImagePosition.h"

#define kBtnItemWidth   50
#define kBtnMargin  (kScreenWidth - 4*kBtnItemWidth)/5

@interface DDBottomView()
@end

@implementation DDBottomView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initViews];
    }
    return self;
}
-(void)initViews{
    NSArray *imageArr = @[@"desk_share",@"notice_notes",@"desk_sign",@"desk_invite"];
    NSArray *titleArr = @[@"分享",@"发送公告",@"签到",@"邀请"];
    for (int i = 0; i< 4; i++) {
        UIButton *functionBtn = [[UIButton alloc] init];
        [self addSubview:functionBtn];
        [functionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(kBtnMargin*(i+1)+i*kBtnItemWidth);
            make.width.mas_equalTo(kBtnItemWidth);
        }];
        functionBtn.tag = i+10;
        [functionBtn setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
        [functionBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        [functionBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
        functionBtn.titleLabel.font = kFont(12);
        [functionBtn layoutButtonWithEdgeInsetsStyle:DDButtonEdgeInsetsStyleTop imageTitleSpace:30];
        [functionBtn addTarget:self action:@selector(functionAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}
-(void)functionAction:(UIButton *)sender{
    if (_bottomFunctionClickBlcok) {
        _bottomFunctionClickBlcok(sender.tag - 10);
    }
}
@end





