//
//  LSCreateDeskActionCellView.m
//  TongParty
//
//  Created by 刘帅 on 2017/10/28.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSCreateDeskActionCellView.h"
#import "LSCDTitleItemView.h"

@interface LSCreateDeskActionCellView ()
@property (nonatomic, strong)LSCDTitleItemView *ti_action;
@property (nonatomic, strong)UITextField       *tf_action_content;
@property (nonatomic, strong)UILabel           *lbl_action_line;
@property (nonatomic, strong)LSCDTitleItemView *ti_theme;
@property (nonatomic, strong)UITextField       *tf_theme_content;
@property (nonatomic, strong)UILabel           *lbl_theme_line;

@end

@implementation LSCreateDeskActionCellView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}
-(void)initViews{
    WeakSelf(weakSelf);
    
    self.backgroundColor = kWhiteColor;
    // 活动
    _ti_action = [LSCDTitleItemView new];
    [self addSubview:self.ti_action];
    [_ti_action mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(weakSelf);
        make.height.mas_equalTo(DDFitHeight(30.f));
    }];
    _ti_action.image = kImage(@"desk_activity");
    _ti_action.title = @"活动：";

    _tf_action_content = [UITextField new];
    [self addSubview:self.tf_action_content];
    [_tf_action_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_ti_action.mas_bottom);
        make.left.mas_equalTo(DDFitWidth(37.f));
        make.height.equalTo(_ti_action);
        make.right.equalTo(weakSelf);
    }];
    _tf_action_content.placeholder = @"请选择创建桌子的内容";
    _tf_action_content.font = DDFitFont(14.f);
    
    _lbl_action_line = [UILabel new];
    [self addSubview:self.lbl_action_line];
    [_lbl_action_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_tf_action_content);
        make.height.mas_equalTo(kLineHeight);
        make.right.mas_offset(-DDFitWidth(10.f));
        make.top.equalTo(_tf_action_content.mas_bottom).offset(DDFitHeight(1.f));
    }];
    _lbl_action_line.backgroundColor = kLineBgColor;
    
    
    // 主题
    _ti_theme = [LSCDTitleItemView new];
    [self addSubview:self.ti_theme];
    [_ti_theme mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lbl_action_line.mas_bottom);
        make.left.equalTo(weakSelf);
        make.height.mas_equalTo(DDFitHeight(30.f));
    }];
    _ti_theme.image = kImage(@"desk_subject");
    _ti_theme.title = @"主题：";
    
    _tf_theme_content = [UITextField new];
    [self addSubview:self.tf_theme_content];
    [_tf_theme_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_ti_theme.mas_bottom).offset(DDFitHeight(3.f));
        make.left.mas_equalTo(DDFitWidth(37.f));
        make.height.equalTo(_ti_theme);
        make.right.equalTo(weakSelf);
    }];
    _tf_theme_content.placeholder = @"比如：狼人杀大神桌";
    _tf_theme_content.font = DDFitFont(14.f);
    
    _lbl_theme_line = [UILabel new];
    [self addSubview:self.lbl_theme_line];
    [_lbl_theme_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_tf_theme_content);
        make.height.mas_equalTo(kLineHeight);
        make.right.mas_offset(-DDFitWidth(10.f));
        make.top.equalTo(_tf_theme_content.mas_bottom).offset(DDFitHeight(5.f));
    }];
    _lbl_theme_line.backgroundColor = kLineBgColor;
}



@end
