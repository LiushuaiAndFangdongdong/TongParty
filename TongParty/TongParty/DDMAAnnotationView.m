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
#import "LSMapTableEntity.h"

@interface DDMAAnnotationView ()
@property (nonatomic, strong)UIView      *view_bg;
@property (nonatomic, strong)UIImageView *iv_kindOfAction;
@property (nonatomic, strong)UILabel     *lbl_actionName;
@property (nonatomic, strong)UIImageView *iv_bg;
@property (nonatomic, strong)LSMapTableEntity *tempEntity;
@property (nonatomic, strong)MAMapView   *tempMapView;
@end
@implementation DDMAAnnotationView

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0, 0, 65, 75);
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews {
    [self addSubview:self.iv_bg];
    [_iv_bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self addSubview:self.iv_kindOfAction];
    [_iv_kindOfAction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.iv_bg);
        make.top.mas_equalTo(DDFitHeight(8.f));
        make.height.width.mas_equalTo(DDFitHeight(25.f));
    }];
    
    [self addSubview:self.lbl_actionName];
    [_lbl_actionName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_iv_kindOfAction);
        make.top.equalTo(_iv_kindOfAction.mas_bottom);
        make.width.equalTo(self.iv_bg);
    }];
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

- (void)updateValueWith:(id)model onMapView:(MAMapView *)mapView {
    
    if (!model) {
        return;
    }
    LSMapTableEntity *entity = (LSMapTableEntity *)model;
    _lbl_actionName.text = entity.custom;
    [_iv_kindOfAction sd_setImageWithURL:[NSURL URLWithString:entity.image] placeholderImage:kDefaultAvatar];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *begin_date = [dateFormatter dateFromString:entity.begin_time];
    NSDate *now_date = [dateFormatter dateFromString:entity.serviceTime];
    NSTimeInterval dtime = [begin_date timeIntervalSinceDate:now_date];
    if (dtime > 3600*3) {
        _iv_bg.image = kImage(@"map_3hoursmore");
    }
    if (dtime > 3600 && dtime < 3600*3) {
        _iv_bg.image = kImage(@"map_hour23");
    }
    if (dtime < 3600) {
        _iv_bg.image = kImage(@"map_hour");
    }
    _tempEntity = entity;
    _tempMapView = mapView;
}

- (void)setSelected:(BOOL)selected {
    [self setSelected:selected animated:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    if (self.selected == selected) {
        return;
    }
    WeakSelf(weakSelf);
    if (selected){
        if (self.calloutView == nil) {
            self.calloutView = [[LSMACustomCalloutView alloc] initWithFrame:CGRectMake(0, 0, DDFitWidth(110.f), DDFitHeight(70.f))];
            self.calloutView.toDeskDetail = ^{
                if (weakSelf.onClicked) {
                    weakSelf.onClicked();
                }
            };
            [self.calloutView updateValueWith:_tempEntity onMapView:_tempMapView];
            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                                  -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
        }
        
        [self addSubview:self.calloutView];
    } else {
        // 全部清理!
        [self.calloutView removeFromSuperview];
        
    }
    [super setSelected:selected animated:animated];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL inside = [super pointInside:point withEvent:event];
    if (!inside && self.selected) {
        inside = [self.calloutView pointInside:[self convertPoint:point toView:self.calloutView] withEvent:event];
    }
    return inside;
}
@end

