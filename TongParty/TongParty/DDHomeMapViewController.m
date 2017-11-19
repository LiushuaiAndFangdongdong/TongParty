//
//  DDHomeMapViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/19.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDHomeMapViewController.h"
#import "DDMAAnnotationView.h"
#import "LSSortingView.h"
#import <pop/pop.h>

@interface DDHomeMapViewController ()<MAMapViewDelegate>
@property (nonatomic, strong)UIImageView *iv_mark;
@property (nonatomic, strong)MAMapView *mapView;
@property (nonatomic, strong)LSSortingView *sortingView;
@end

@implementation DDHomeMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [AMapServices sharedServices].enableHTTPS = YES;
    [self.view addSubview:self.mapView];
    [self.view addSubview:self.iv_mark];
    [self.view addSubview:self.sortingView];
}

- (LSSortingView *)sortingView {
    WeakSelf(weakSelf);
    if (!_sortingView) {
        _sortingView = [[LSSortingView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        _sortingView.onTapBlcok = ^(NSInteger index) {
            [weakSelf.sortingView showSecondaryViewWithTag:index onView:weakSelf.view];
        };
        _sortingView.onClickBlcok = ^(UIButton *sender) {
            NSLog(@"%@",sender.titleLabel.text);
        };
        _sortingView.onAddressSelected = ^(NSString *addString) {
            // 根据商圈搜索数据后回调
            // 模拟请求需要一秒钟
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0* NSEC_PER_SEC));
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                [weakSelf.sortingView showSecondaryViewWithTag:2 onView:weakSelf.view];
            });
            NSLog(@"选择～～～%@",addString);
        };
    }
    return _sortingView;
}

- (MAMapView *)mapView {
    
    if (!_mapView) {
        _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
        _mapView.showsBuildings = YES;
        _mapView.mapType = MAMapTypeStandard;
        [_mapView setZoomLevel:5000];
        // 去掉比例尺
        _mapView.showsScale = NO;
        //后台定位
        _mapView.pausesLocationUpdatesAutomatically = NO;
        _mapView.allowsBackgroundLocationUpdates = NO;
        // 开启蓝点定位
        _mapView.showsUserLocation = YES;
        //_mapView.userTrackingMode = MAUserTrackingModeFollow;
        _mapView.delegate = self;
        
        CLLocationCoordinate2D coor ;
        coor.latitude = 39.923924;
        coor.longitude = 116.325767;
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        pointAnnotation.coordinate = coor;
        
        //设置地图的定位中心点坐标
        _mapView.centerCoordinate = coor;
        [_mapView addAnnotation:pointAnnotation];
    }
    
    return _mapView;
}

- (UIImageView *)iv_mark {
    if (!_iv_mark) {
        _iv_mark = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - DDFitWidth(7.5f), kScreenHeight/2 - DDFitHeight(150.f), DDFitWidth(15.f), DDFitHeight(30.f))];
        _iv_mark.image = kImage(@"map_mark");
    }
    return _iv_mark;
}
#pragma mark - MAMapViewDelegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation {
    static NSString* kPin = @"pin";
    DDMAAnnotationView* pinView = (DDMAAnnotationView *)
    [mapView dequeueReusableAnnotationViewWithIdentifier:kPin];
    //判断是否是自己的定位气泡，如果是自己的定位气泡，不做任何设置，显示为蓝点，如果不是自己的定位气泡，比如大头针就会进入
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        if (!pinView) {
            pinView = [[DDMAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:kPin];
            [pinView setDraggable:YES];
        }
    }
    return pinView;
}

- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
    CLLocationCoordinate2D markCoordinate = [self.mapView convertPoint:_iv_mark.frame.origin toCoordinateFromView:self.view];
    [self addMarkAnimation];
}

// 给棒棒糖加动画
- (void)addMarkAnimation{
    POPSpringAnimation *scaleAnim3 = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnim3.beginTime = CACurrentMediaTime();
    scaleAnim3.toValue = [NSValue valueWithCGPoint:CGPointMake(1.3, 1.3)];
    scaleAnim3.springSpeed = 20;
    scaleAnim3.springBounciness = 16;
    [self.iv_mark.layer pop_addAnimation:scaleAnim3 forKey:@"scaleAnim3"];
    POPSpringAnimation *scaleAnim33 = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnim33.beginTime = CACurrentMediaTime()+0.1;
    scaleAnim33.toValue = [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
    scaleAnim33.springSpeed = 20;
    scaleAnim33.springBounciness = 16;
    [self.iv_mark.layer pop_addAnimation:scaleAnim33 forKey:@"scaleAnim33"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end




