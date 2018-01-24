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

- (void)updateBtnImageWithType:(NSString *)type is_like:(NSString *)is_Like{
    
    NSArray *viewsArr = [self subviews];
    for (UIView *v in viewsArr) {
        [v removeFromSuperview];
    }
    
    NSLog(@"is_Like====%@",is_Like);
    //TYPE 1\2\0----桌主、参与者、游客
    if ([type intValue] == 1)
    {
        //桌主
        _imageArr = @[@"desk_share",@"notice_notes",@"desk_sign",@"desk_invite"];
        _titleArr = @[@"分享",@"发送公告",@"签到",@"邀请"];
    }else if ([type intValue] == 2)
    {
        //参加者
        _imageArr = @[@"desk_share",@"desk_callHolder",@"desk_sign",@"desk_invite"];
        _titleArr = @[@"分享",@"联系桌主",@"签到",@"邀请"];
    }else if ([type intValue] == 0)
    {
        //未参与
        NSString *loveImage;
        NSString *loveStr;
        if ([is_Like intValue] == 1) {
            loveImage = @"desk_interest_select";
            loveStr = @"不感兴趣";
        }else if ([is_Like intValue] == 0){
            loveImage = @"desk_interest_default";
            loveStr = @"感兴趣";
        }else{}
        _imageArr = @[@"desk_share",@"desk_join",loveImage,@"desk_invite"];
        _titleArr = @[@"分享",@"加入",loveStr,@"邀请"];
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







