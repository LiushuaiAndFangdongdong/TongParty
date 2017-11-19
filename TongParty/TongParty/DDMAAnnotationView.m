//
//  DDMAAnnotationView.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/19.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDMAAnnotationView.h"
#import "DDLoopProgressView.h"
#import "UIView+Layer.h"

@interface DDMAAnnotationView ()
@property (nonatomic, strong)UIView      *view_bg;
@property (nonatomic, strong)UIImageView *iv_bg;
@property (nonatomic, strong)UIImageView *iv_kindOfAction;
@property (nonatomic, strong)UILabel     *lbl_actionName;
@end
@implementation DDMAAnnotationView

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.view_bg.frame = CGRectMake(0, 0, 55, 65);
        [self addSubview:self.view_bg];
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews {
    
    [self.view_bg addSubview:self.iv_bg];
    [_iv_bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view_bg);
    }];
    _iv_bg.image = kImage(@"map_3hoursmore");
    
    [self.iv_bg addSubview:self.iv_kindOfAction];
    [_iv_kindOfAction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.iv_bg);
        make.top.mas_equalTo(DDFitHeight(8.f));
        make.height.width.mas_equalTo(DDFitHeight(25.f));
    }];
    _iv_kindOfAction.image = kImage(@"map_mahjong");
    
    [self.iv_bg addSubview:self.lbl_actionName];
    [_lbl_actionName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_iv_kindOfAction);
        make.top.equalTo(_iv_kindOfAction.mas_bottom);
        make.width.equalTo(self.iv_bg);
    }];
    _lbl_actionName.text = @"麻将";
    _lbl_actionName.textColor = kBlackColor;
    _lbl_actionName.font = DDFitFont(10.f);
    _lbl_actionName.textAlignment = NSTextAlignmentCenter;
}

- (UIView *)view_bg {
    if (!_view_bg) {
        _view_bg = [UIView new];
    }
    return _view_bg;
}

- (UIImageView *)iv_bg {
    if (!_iv_bg) {
        _iv_bg = [UIImageView new];
    }
    return _iv_bg;
}

- (UIImageView *)iv_kindOfAction {
    if (!_iv_kindOfAction) {
        _iv_kindOfAction = [UIImageView new];
    }
    return _iv_kindOfAction;
}

- (UILabel *)lbl_actionName {
    if (!_lbl_actionName) {
        _lbl_actionName = [UILabel new];
    }
    return _lbl_actionName;
}
@end
