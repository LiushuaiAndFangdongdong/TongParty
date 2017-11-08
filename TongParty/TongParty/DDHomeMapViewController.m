//
//  DDHomeMapViewController.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/19.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDHomeMapViewController.h"
#import "DDMAAnnotationView.h"

@interface DDHomeMapViewController ()<MAMapViewDelegate>

@property (nonatomic, strong)MAMapView *mapView;
@end

@implementation DDHomeMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [AMapServices sharedServices].enableHTTPS = YES;
    [self.view addSubview:self.mapView];
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
        _mapView.allowsBackgroundLocationUpdates = NO;//iOS9以上系统必须配置(若YES，则plist中Privacy - Location When In Use Usage Description)
        // 开启蓝点定位
        _mapView.showsUserLocation = YES;
        _mapView.userTrackingMode = MAUserTrackingModeFollow;
        _mapView.delegate = self;
        
        CLLocationCoordinate2D coor ;
        coor.latitude = 22.529252;
        coor.longitude = 113.871265;
        
        CLLocationCoordinate2D coor1 ;
        coor1.latitude = 22.539961;
        coor1.longitude = 113.871469;
        
        CLLocationCoordinate2D coor2 ;
        coor2.latitude = 22.549073;
        coor2.longitude = 113.871372;
        
        CLLocationCoordinate2D coor3 ;
        coor3.latitude = 22.589550;
        coor3.longitude = 113.851783;
        
        CLLocationCoordinate2D coor4 ;
        coor4.latitude = 22.589349;
        coor4.longitude = 113.861634;
        
        
        MAPointAnnotation *pointAnnotation1 = [[MAPointAnnotation alloc] init];
        pointAnnotation1.coordinate = coor1;
        
        MAPointAnnotation *pointAnnotation2 = [[MAPointAnnotation alloc] init];
        pointAnnotation2.coordinate = coor2;
        
        MAPointAnnotation *pointAnnotation3 = [[MAPointAnnotation alloc] init];
        pointAnnotation3.coordinate = coor3;
        
        MAPointAnnotation *pointAnnotation4 = [[MAPointAnnotation alloc] init];
        pointAnnotation4.coordinate = coor4;
        
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        pointAnnotation.coordinate = coor;
        
        
        
        //        //设置地图的定位中心点坐标
        //        self.mapView.centerCoordinate = coor;
        //将点添加到地图上，即所谓的大头针
        [self.mapView addAnnotations:@[pointAnnotation,pointAnnotation1,pointAnnotation2,pointAnnotation3,pointAnnotation4]];
    }
    
    return _mapView;
}


#pragma mark - MAMapViewDelegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation {
    
    static NSString* kPin = @"pin";
    DDMAAnnotationView* pinView = (DDMAAnnotationView *)
    [mapView dequeueReusableAnnotationViewWithIdentifier:kPin];
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {//判断是否是自己的定位气泡，如果是自己的定位气泡，不做任何设置，显示为蓝点，如果不是自己的定位气泡，比如大头针就会进入
        if (!pinView) {
            pinView = [[DDMAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:kPin];
            
            [pinView setDraggable:YES];
            
        }
    }
    return pinView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end




