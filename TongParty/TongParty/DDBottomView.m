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
@property (nonatomic, strong) NSArray *imageArr;
@property (nonatomic, strong) NSArray *titleArr;
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
}
-(void)functionAction:(UIButton *)sender{
    if (_bottomFunctionClickBlcok) {
        _bottomFunctionClickBlcok(sender.tag - 10);
    }
}

- (void)updateBtnImageWithType:(NSString *)type{
    if ([type intValue] == 1) {
        //桌主
        _imageArr = @[@"desk_share",@"notice_notes",@"desk_sign",@"desk_invite"];
        _titleArr = @[@"分享",@"发送公告",@"签到",@"邀请"];
    }else if ([type intValue] == 2){
        //参加者
        _imageArr = @[@"desk_share",@"desk_callHolder",@"desk_interest_default",@"desk_invite"];
        _titleArr = @[@"分享",@"联系桌主",@"感兴趣",@"邀请"];
    }else if ([type intValue] == 3){
        //未参与
        _imageArr = @[@"desk_share",@"desk_join",@"desk_interest_default",@"desk_invite"];
        _titleArr = @[@"分享",@"加入",@"感兴趣",@"邀请"];
    }else{
    }

    for (int i = 0; i< _imageArr.count; i++) {
        UIButton *functionBtn = [[UIButton alloc] init];
        [self addSubview:functionBtn];
        [functionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(kBtnMargin*(i+1)+i*kBtnItemWidth);
            make.width.mas_equalTo(kBtnItemWidth);
        }];
        functionBtn.tag = i+10;
        [functionBtn setImage:[UIImage imageNamed:_imageArr[i]] forState:UIControlStateNormal];
        [functionBtn setTitle:_titleArr[i] forState:UIControlStateNormal];
        [functionBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
        functionBtn.titleLabel.font = kFont(12);
        [functionBtn layoutButtonWithEdgeInsetsStyle:DDButtonEdgeInsetsStyleTop imageTitleSpace:10];
        [functionBtn addTarget:self action:@selector(functionAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}
@end







