//
//  LSSortingView.m
//  TongParty
//
//  Created by 刘帅 on 2017/11/4.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSSortingView.h"
#import "LSRegionDumpsView.h"
#import "LSContentSortView.h"
@interface LSSortingView ()
@property (nonatomic, strong)UIView    *view_bg;
@property (nonatomic, strong)UILabel   *lbl_temp;
@property (nonatomic, strong)UIButton  *btn_temp;
@property (nonatomic, strong)LSRegionDumpsView  *regionView;
@property (nonatomic, strong)LSContentSortView  *contentSortView;
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
    if (_lbl_temp) {
        _lbl_temp.textColor = kCommonGrayTextColor;
    }
    UILabel *lbltap = (UILabel *)[tap view];
    lbltap.textColor = kBlackColor;
    if (_onTapBlcok) {
        _onTapBlcok([tap.view tag] - baseTag);
    }
    _lbl_temp = lbltap;
}

// 创建数据
- (NSArray *)getSecondaryViewDataByTag:(NSInteger)tag {
    switch (tag) {
        case 0:{
            
        }break;
        case 1:{
            return @[@"24小时",@"11:00-14:00",@"17:00-21:30",@"17:10-03:30"];
        }break;
        case 2:{
            
        }break;
        default:
            break;
    }
    return nil;
}

static NSInteger lastTag;
- (void)showSecondaryViewWithTag:(NSInteger)tag onView:(UIView *)fatherView{
    
    if (_view_bg && lastTag && lastTag == tag) {
        [_view_bg removeFromSuperview];
        _view_bg = nil;
        lastTag = tag; // 最好设随机 记录当前次级菜单加载内容及隐藏
        return;
    }
    if (_view_bg) {
        [_view_bg removeFromSuperview];
        _view_bg = nil;
    }
    
    _view_bg = [[UIView alloc] initWithFrame:CGRectMake(0, self.bottom, self.frame.size.width,0)];
    _view_bg.backgroundColor = kBgWhiteGrayColor;
    [fatherView addSubview:_view_bg];
    NSArray *array = [self  getSecondaryViewDataByTag:tag];
    switch (tag) {
        case 0:{
            [self showContentSelectionViewWithdataArray:array tag:tag];
            }break;
        case 1:{
            [self showTimeSelectionViewWithdataArray:array tag:tag];
        }break;
        case 2:{
            [self showAddressSelectionViewWithdataArray:array tag:tag];
        }break;
        default:
            break;
    }
}

// 内容二级检索栏
- (void)showContentSelectionViewWithdataArray:(NSArray *)array tag:(NSInteger)tag{
    
    [UIView animateWithDuration:0.3f animations:^{
        _view_bg.frame = CGRectMake(0, self.bottom, self.frame.size.width, DDFitHeight(480.f));
    } completion:^(BOOL finished) {
        WeakSelf(weakSelf);
        _contentSortView = [[LSContentSortView alloc] initWithFrame:CGRectMake(0, 0, _view_bg.width, _view_bg.height)];
        [weakSelf.view_bg addSubview:_contentSortView];
        lastTag = tag;
    }];
}

// 时间二级检索栏
- (void)showTimeSelectionViewWithdataArray:(NSArray *)array tag:(NSInteger)tag{
    
    [UIView animateWithDuration:0.3f animations:^{
        _view_bg.frame = CGRectMake(0, self.bottom, self.frame.size.width,DDFitHeight(40.f));
    } completion:^(BOOL finished) {
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
            [_view_bg addSubview:btn_label];
        }
        lastTag = tag;
    }];
}

- (void)chooseSecondaryLabel:(UIButton *)sender {
    if (_btn_temp) {
        _btn_temp.backgroundColor = kWhiteColor;
        [_btn_temp setTitleColor:kCommonGrayTextColor forState:UIControlStateNormal];
    }
    [sender setTitleColor:kWhiteColor forState:UIControlStateNormal];
    sender.backgroundColor = kRGBColor(118.f, 213.f, 113.f);
    if (_onClickBlcok) {
        _onClickBlcok(sender);
    }
    _btn_temp = sender;
}


// 位置二级检索栏
- (void)showAddressSelectionViewWithdataArray:(NSArray *)array tag:(NSInteger)tag{
    [UIView animateWithDuration:0.3f animations:^{
        _view_bg.frame = CGRectMake(0, self.bottom, self.frame.size.width, DDFitHeight(450.f));
    } completion:^(BOOL finished) {
        WeakSelf(weakSelf);
        _regionView = [[LSRegionDumpsView alloc] initWithFrame:CGRectMake(0, 0, _view_bg.width, _view_bg.height)];
        _regionView.onSelected = ^(NSString *addString) {
            if (weakSelf.onAddressSelected) {
                weakSelf.onAddressSelected(addString);
            }
        };
        [weakSelf.view_bg addSubview:_regionView];
        lastTag = tag;
    }];
}

@end
