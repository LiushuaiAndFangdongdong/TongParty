//
//  LSMACustomCalloutView.m
//  TongParty
//
//  Created by 刘帅 on 2018/1/13.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "LSMACustomCalloutView.h"
#import "LSMapTableEntity.h"
@interface LSMACustomCalloutView ()
@property (nonatomic, strong)UILabel  *lbl_time;
@property (nonatomic, strong)UILabel  *lbl_begin;
@property (nonatomic, strong)UILabel  *lbl_distace;
@property (nonatomic, strong)UIButton *btn_join;
@end
@implementation LSMACustomCalloutView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = DDFitHeight(8.f);
        self.backgroundColor = kWhiteColor;
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    [self addSubview:self.lbl_time];
    [self.lbl_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(DDFitHeight(5.f));
        make.left.mas_equalTo(DDFitWidth(5.f));
    }];
    self.lbl_time.text = @"还有3:14:13";
    self.lbl_time.font = DDFitFont(12.f);
    
    [self addSubview:self.lbl_begin];
    [self.lbl_begin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbl_time.mas_right).offset(5.f);
        make.centerY.equalTo(self.lbl_time);
    }];
    self.lbl_begin.text = @"开始";
    self.lbl_begin.font = DDFitFont(12.f);
    
    [self addSubview:self.lbl_distace];
    [self.lbl_distace mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.lbl_time.mas_bottom).offset(DDFitHeight(5.f));
    }];
    
    self.lbl_distace.font = DDFitFont(12.f);
    self.lbl_distace.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:self.btn_join];
    [self.btn_join mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.centerX.bottom.equalTo(self);
        make.top.equalTo(self.lbl_distace.mas_bottom);
    }];
    [self.btn_join setTitle:@"桌子详情" forState:UIControlStateNormal];
    [self.btn_join setTitleColor:kRGBColor(157.f, 222.f, 150.f) forState:UIControlStateNormal];
    self.btn_join.titleLabel.font = DDFitFont(12.f);
    [self.btn_join addTarget:self action:@selector(toDeskDetail:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)updateValueWith:(id)model onMapView:(MAMapView *)mapView{
    if (!model) {
        return;
    }
    LSMapTableEntity *entity = (LSMapTableEntity *)model;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *begin_date = [dateFormatter dateFromString:entity.begin_time];
    NSDate *now_date = [dateFormatter dateFromString:entity.serviceTime];
    NSTimeInterval dtime = [begin_date timeIntervalSinceDate:now_date];
    if (dtime > 3600*3) {
        // 绿
        self.lbl_time.textColor = kRGBColor(157.f, 222.f, 150.f);
    }
    if (dtime > 3600 && dtime < 3600*3) {
        // 黄
        self.lbl_time.textColor = kRGBColor(243.f, 216.f, 110.f);
    }
    if (dtime < 3600) {
       // 蓝
        self.lbl_time.textColor = kRGBColor(116.f, 203.f, 250.f);
    }
    
    double distance = [self distanceBetweenOrderBy:mapView.userLocation.location.coordinate.latitude :entity.latitude.doubleValue :mapView.userLocation.location.coordinate.longitude :entity.longitude.doubleValue];
    self.lbl_distace.text = [NSString stringWithFormat:@"距离%d米",(int)distance];
    [self timingStarTime:entity.begin_time endTime:entity.serviceTime];
}

- (void)timingStarTime:(NSString *)startTime endTime:(NSString *)endTime {
    if (_timer) {
        dispatch_source_cancel(_timer);
    }
    NSString *timeCount = [self dateTimeDifferenceWithStartTime:endTime endTime:startTime];
    
    __block NSInteger time = [timeCount integerValue]; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                self.lbl_time.text = [NSString stringWithFormat:@"%@",[self getMMSSFromSS:time]];
                NSLog(@"我在跑！%@f",[self getMMSSFromSS:time]);
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

// 秒数换算成时分秒
-(NSString *)getMMSSFromSS:(NSInteger )seconds{
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    return format_time;
}

// 计算时间间隔秒数
- (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime{
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *startD =[date dateFromString:startTime];
    NSDate *endD = [date dateFromString:endTime];
    NSTimeInterval start = [startD timeIntervalSince1970]*1;
    NSTimeInterval end = [endD timeIntervalSince1970]*1;
    NSTimeInterval value = end - start;
    int second = (int)value;//秒
    
    NSString *str;
    str = [NSString stringWithFormat:@"%d",second];
    
    return str;
}

// 计算两坐标点之间的距离
-(double)distanceBetweenOrderBy:(double) lat1 :(double) lat2 :(double) lng1 :(double) lng2{
    //地球半径
    int R = 6378137;
    //将角度转为弧度
    float radLat1 = [self radians:lat1];
    float radLat2 = [self radians:lat2];
    float radLng1 = [self radians:lng1];
    float radLng2 = [self radians:lng2];
    //结果
    float s = acos(cos(radLat1)*cos(radLat2)*cos(radLng1-radLng2)+sin(radLat1)*sin(radLat2))*R;
    //精度
    s = round(s* 10000)/10000;
    return  round(s);
}

- (float)radians:(float)degrees{
    return (degrees*3.14159265)/180.0;
}

- (void)toDeskDetail:(UIButton *)sender {    
    if (_toDeskDetail) {
        _toDeskDetail();
    }
}

- (UILabel *)lbl_distace {
    if (!_lbl_distace) {
        _lbl_distace = [UILabel new];
    }
    return _lbl_distace;
}

- (UILabel *)lbl_time {
    if (!_lbl_time) {
        _lbl_time = [UILabel new];
    }
    return _lbl_time;
}

- (UILabel *)lbl_begin {
    if (!_lbl_begin) {
        _lbl_begin = [UILabel new];
    }
    return _lbl_begin;
}

- (UIButton *)btn_join {
    if (!_btn_join) {
        _btn_join = [UIButton new];
    }
    return _btn_join;
}

// 定时器消除
- (void)dealloc {
    dispatch_source_cancel(_timer);
    _timer = nil;
}

@end
