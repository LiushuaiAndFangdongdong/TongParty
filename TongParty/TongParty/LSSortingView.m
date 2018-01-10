//
//  LSSortingView.m
//  TongParty
//
//  Created by 刘帅 on 2017/11/4.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSSortingView.h"
#import "LSContentSortingView.h"
@interface LSSortingView ()
@property (nonatomic, strong)UILabel   *lbl_temp;
@property (nonatomic, strong)UIButton  *btn_temp;
@property (nonatomic, strong)LSContentSortingView  *contentSortView;
@end
static NSInteger baseTag = 171;
static NSInteger btn_baseTag = 253;
@implementation LSSortingView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    return self;
}


// 一级分类栏
- (void)setupViews {
    NSArray *titleArr = @[@"内容",@"时间",@"位置"];
    CGFloat tap_viewW = kScreenWidth/3.f;
    CGFloat tap_viewH = 40.f;
    for (int i = 0; i < titleArr.count; i++) {
        UILabel *lbl_title = [[UILabel alloc] initWithFrame:CGRectMake(tap_viewW*i, 0, tap_viewW, tap_viewH)];
        lbl_title.text = titleArr[i];
        lbl_title.textColor = kCommonGrayTextColor;
        lbl_title.textAlignment = NSTextAlignmentCenter;
        lbl_title.font = DDFitFont(13.f);
        lbl_title.tag = baseTag + i;
        lbl_title.userInteractionEnabled = YES;
        [lbl_title addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
        [self addSubview:lbl_title];
        UIImageView *iv_arrow = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DDFitWidth(10.f), DDFitHeight(5.f))];
        iv_arrow.centerY = lbl_title.centerY;
        iv_arrow.left = lbl_title.centerX + DDFitWidth(15.f);
        iv_arrow.image = kImage(@"desk_addr_more");
        [self addSubview:iv_arrow];
        if (i < 2) {
            UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(tap_viewW*(i+1), 0, kLineHeight, tap_viewH/2.f)];
            line.centerY = self.centerY;
            line.backgroundColor = kCommonGrayTextColor;
            [self addSubview:line];
        }
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    for (id obj in self.subviews) {
        if ([obj isKindOfClass:[UILabel class]]) {
            UILabel* theLabel = (UILabel*)obj;
            theLabel.textColor = kCommonGrayTextColor;
        }
    }
    UILabel *lbltap = (UILabel *)[tap view];
    lbltap.textColor = kBlackColor;
    if (_onTapBlcok) {
        _onTapBlcok([tap.view tag] - baseTag);
    }
}

- (void)clean {
    for (id obj in self.subviews) {
        if ([obj isKindOfClass:[UILabel class]]) {
            UILabel* theLabel = (UILabel*)obj;
            theLabel.textColor = kCommonGrayTextColor;
        }
    }
}
@end

