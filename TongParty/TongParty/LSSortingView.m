//
//  LSSortingView.m
//  TongParty
//
//  Created by 刘帅 on 2017/11/4.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSSortingView.h"


@interface LSSortingView ()

@end

@implementation LSSortingView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    return self;
}


- (void)setupViews {
    
    NSArray *titleArr = @[@"内容",@"时间",@"位置",@"其他"];
    CGFloat tap_viewW = kScreenWidth/4.f;
    CGFloat tap_viewH = 44.f;
    for (int i = 0; i < titleArr.count; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(tap_viewW*i, 0, tap_viewW, tap_viewH)];
        [self addSubview:view];
        UILabel *lbl_title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tap_viewW/3.f, tap_viewH/3.f)];
        lbl_title.center = view.center;
        lbl_title.text = titleArr[i];
        lbl_title.textColor = kCommonGrayTextColor;
        lbl_title.font = DDFitFont(14.f);
        [view addSubview:lbl_title];
    }
}

@end
