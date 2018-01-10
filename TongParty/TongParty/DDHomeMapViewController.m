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
#import "LSContenSortVC.h"
#import "LSRegionDumpsVC.h"
#import "LSHomwTimeSortVC.h"
#import "LSMAPointAnnotation.h"
#import "LSMapTableEntity.h"
#import "LSActivityEntity.h"
#import "DDDeskShowViewController.h"
@interface DDHomeMapViewController ()<MAMapViewDelegate> {
    CLLocationCoordinate2D oldCoordinate;
}
@property (nonatomic, strong)UIImageView *iv_mark;
@property (nonatomic, strong)MAMapView *mapView;
@property (nonatomic, strong)LSSortingView *sortingView;
@property (nonatomic, strong)LSContenSortVC *contentsortVc;
@property (nonatomic, strong)LSRegionDumpsVC *regionDumpsVc;
@property (nonatomic, strong)LSHomwTimeSortVC *timesortVc;
@property (nonatomic, strong)NSArray *dataArray;
@property (nonatomic, strong)MAAnnotationView *userLocationAnnotationView;
@property (nonatomic, strong)UIButton *btn_localSelf;
@end

@implementation DDHomeMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [kNotificationCenter addObserver:self selector:@selector(loadData) name:kUpdateUserInfoNotification object:nil];
    [AMapServices sharedServices].enableHTTPS = YES;
    [self.view addSubview:self.sortingView];
    [self.view addSubview:self.mapView];
    [self.view addSubview:self.iv_mark];
    [self.view addSubview:self.btn_localSelf];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


#pragma mark - 懒加载
- (UIButton *)btn_localSelf {
    if (!_btn_localSelf) {
        _btn_localSelf = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - DDFitWidth(42.f), kScreenHeight - DDFitHeight(160.f), DDFitHeight(38.f), DDFitHeight(38.f))];
        [_btn_localSelf setBackgroundImage:kImage(@"back_userLocation") forState:UIControlStateNormal];
        [_btn_localSelf addTarget:self action:@selector(backSelfLocation) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_localSelf;
}


- (LSSortingView *)sortingView {
    WeakSelf(weakSelf);
    if (!_sortingView) {
        _sortingView = [[LSSortingView alloc] initWithFrame:CGRectMake(0, 1.0, kScreenWidth, 40)];
        _sortingView.onTapBlcok = ^(NSInteger index) {
            switch (index) {
                case 0:{
                    weakSelf.regionDumpsVc.view.hidden = YES;
                    weakSelf.timesortVc.view.hidden = YES;
                    weakSelf.contentsortVc.view.hidden = !weakSelf.contentsortVc.view.isHidden;
                }break;
                case 1:{
                    weakSelf.contentsortVc.view.hidden = YES;
                    weakSelf.regionDumpsVc.view.hidden = YES;
                    weakSelf.timesortVc.view.hidden = !weakSelf.timesortVc.view.isHidden;;
                }break;
                case 2:{
                    weakSelf.contentsortVc.view.hidden = YES;
                    weakSelf.timesortVc.view.hidden = YES;
                    weakSelf.regionDumpsVc.view.hidden = !weakSelf.regionDumpsVc.view.isHidden;;
                }break;
                default:
                    break;
            }
            if (weakSelf.regionDumpsVc.view.isHidden == YES &&
                weakSelf.timesortVc.view.isHidden == YES &&
                weakSelf.contentsortVc.view.isHidden == YES) {
                [weakSelf.sortingView clean];
            }
        };
    }
    return _sortingView;
}

- (LSContenSortVC *)contentsortVc {
    WeakSelf(weakSelf);
    
    if (!_contentsortVc) {
        _contentsortVc = [[LSContenSortVC alloc] init];
        _contentsortVc.confirmSort = ^(NSArray *selectedArray) {
            CLLocationCoordinate2D markCoordinate = [weakSelf.mapView convertPoint:weakSelf.iv_mark.frame.origin toCoordinateFromView:weakSelf.view];
            NSMutableArray *idArr = [NSMutableArray array];
            for (LSActivityEntity *at in selectedArray) {
                [idArr addObject:at.id];
            }
            if (idArr.count == 0) {
                [weakSelf updateDataWith:markCoordinate withActivities:nil text:nil begin_time:nil end_time:nil];
            } else {
                [weakSelf updateDataWith:markCoordinate withActivities:idArr text:nil begin_time:nil end_time:nil];
            }
            weakSelf.contentsortVc.view.hidden = YES;
            [weakSelf.sortingView clean];
        };
        [self addChildVc:_contentsortVc];
        _contentsortVc.view.frame = CGRectMake(0, self.sortingView.bottom, self.view.frame.size.width, kScreenHeight);
        [self.view addSubview:_contentsortVc.view];
        _contentsortVc.view.hidden = YES;
    }
    return _contentsortVc;
}

- (LSRegionDumpsVC *)regionDumpsVc {
    WeakSelf(weakSelf);
    if (!_regionDumpsVc) {
        _regionDumpsVc = [[LSRegionDumpsVC alloc] init];
        _regionDumpsVc.confirmSort = ^(NSString *lon, NSString *lat) {
            CLLocationCoordinate2D markCoordinate;
            markCoordinate.latitude = lat.floatValue;
            markCoordinate.longitude = lon.floatValue;
            // 在进行地理搜索时将地图中心点移至目标点并显示周边数据
            weakSelf.mapView.centerCoordinate = markCoordinate;
            [weakSelf updateDataWith:markCoordinate withActivities:nil text:nil begin_time:nil end_time:nil];
            weakSelf.regionDumpsVc.view.hidden = YES;
            [weakSelf.sortingView clean];
        };
        [self addChildVc:_regionDumpsVc];
        _regionDumpsVc.view.frame = CGRectMake(0, self.sortingView.bottom, self.view.frame.size.width, kScreenHeight);
        [self.view addSubview:_contentsortVc.view];
        _regionDumpsVc.view.hidden = YES;
    }
    return _regionDumpsVc;
}

- (LSHomwTimeSortVC *)timesortVc {
    WeakSelf(weakSelf);
    if (!_timesortVc) {
        _timesortVc = [[LSHomwTimeSortVC alloc] init];
        _timesortVc.confirmSort = ^(NSString *begin_time, NSString *end_time) {
            CLLocationCoordinate2D markCoordinate = [weakSelf.mapView convertPoint:weakSelf.iv_mark.frame.origin toCoordinateFromView:weakSelf.view];
            [weakSelf updateDataWith:markCoordinate withActivities:nil text:nil begin_time:begin_time end_time:end_time];
            weakSelf.timesortVc.view.hidden = YES;
            [weakSelf.sortingView clean];
        };
        [self addChildVc:_timesortVc];
        _timesortVc.view.frame = CGRectMake(0, self.sortingView.bottom, self.view.frame.size.width, kScreenHeight - kNavigationBarHeight);
        [self.view addSubview:_timesortVc.view];
        _timesortVc.view.hidden = YES;
    }
    return _timesortVc;
}


- (MAMapView *)mapView {
    if (!_mapView) {
        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, self.sortingView.bottom, kScreenWidth, kScreenHeight - self.sortingView.bottom)];
        _mapView.showsBuildings = YES;
        _mapView.rotateCameraEnabled = NO;
        _mapView.rotateEnabled = NO;
        _mapView.mapType = MAMapTypeStandard;
        [_mapView setZoomLevel:18.f];
        _mapView.showsScale = NO;
        _mapView.pausesLocationUpdatesAutomatically = NO;
        _mapView.allowsBackgroundLocationUpdates = NO;
        _mapView.showsUserLocation = YES;
        _mapView.userTrackingMode = MAUserTrackingModeFollow;

        MAUserLocationRepresentation *r = [[MAUserLocationRepresentation alloc] init];
        r.showsAccuracyRing = NO;
        [self.mapView updateUserLocationRepresentation:r];
        _mapView.delegate = self;
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

#pragma mark - 加载数据
- (void)loadData {
    [super loadData];
    CLLocationCoordinate2D coor ;
    coor = _mapView.centerCoordinate;
    oldCoordinate = coor;
    dispatch_queue_t queue= dispatch_queue_create("loadMapInfo", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        [DDTJHttpRequest getMapTablesWithRange:@"1500" activity:nil begin_time:nil end_time:nil text:nil lon:[NSString stringWithFormat:@"%lf",oldCoordinate.longitude] lat:[NSString stringWithFormat:@"%lf",oldCoordinate.latitude] block:^(NSDictionary *dict) {
            dispatch_async(dispatch_get_main_queue(), ^(){
                self.dataArray = [LSMapTableEntity mj_objectArrayWithKeyValuesArray:dict];
                [self addAnnotationsToMapView:self.mapView withArray:self.dataArray];
            });
        } failure:^{
            
        }];
    });
}

#pragma mark - 更新图标 annotation
- (void)addAnnotationsToMapView:(MAMapView *)mapView withArray:(NSArray *)array{
    NSMutableArray *annotations = [NSMutableArray array];
    for (int i = 0; i < array.count; i++) {
        LSMapTableEntity *entity = self.dataArray[i];
        LSMAPointAnnotation *annotation = [[LSMAPointAnnotation alloc] init];
        CLLocationDegrees latitude = entity.latitude.doubleValue;
        CLLocationDegrees longitude = entity.longitude.doubleValue;
        annotation.coordinate = CLLocationCoordinate2DMake(latitude,longitude);
        annotation.entity = entity;
        annotation.title = @" "; //
        [annotations addObject:annotation];
    }
    [self updateMapViewAnnotationsWithAnnotations:annotations];
}

- (void)updateMapViewAnnotationsWithAnnotations:(NSArray *)annotations{
    /* 用户滑动时，保留仍然可用的标注，去除屏幕外标注，添加新增区域的标注 */
    NSMutableSet *before = [NSMutableSet setWithArray:self.mapView.annotations]; // 已添加的标注
    [before removeObject:[self.mapView userLocation]];
    NSSet *after = [NSSet setWithArray:annotations];
    /* 保留仍然位于屏幕内的annotation. */
    NSMutableSet *toKeep = [NSMutableSet setWithSet:before];
    [toKeep intersectSet:after];
    /* 需要添加的annotation. */
    NSMutableSet *toAdd = [NSMutableSet setWithSet:after];
    [toAdd minusSet:toKeep];
    /* 删除位于屏幕外的annotation. */
    NSMutableSet *toRemove = [NSMutableSet setWithSet:before];
    [toRemove minusSet:after];
    /* 更新. */
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mapView addAnnotations:[toAdd allObjects]];
        [self.mapView removeAnnotations:[toRemove allObjects]];
    });
}

#pragma mark - MAMapViewDelegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation {
    WeakSelf(weakSelf);
    // 判断蓝点
    if ([annotation isKindOfClass:[MAUserLocation class]]) {
        static NSString *userLocationStyleReuseIndetifier = @"userLocationStyleReuseIndetifier";
        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:userLocationStyleReuseIndetifier];
        if (annotationView == nil) {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation
                                                             reuseIdentifier:userLocationStyleReuseIndetifier];
        }
        annotationView.image = [UIImage imageNamed:@"userLocation_icon"];
        self.userLocationAnnotationView = annotationView;
        return annotationView;
    }
    NSString* kPin = @"pin";
    DDMAAnnotationView* pinView = (DDMAAnnotationView *)
    [mapView dequeueReusableAnnotationViewWithIdentifier:kPin];
    //判断是否是自己的定位气泡，如果是自己的定位气泡，不做任何设置，显示为蓝点，如果不是自己的定位气泡，比如大头针就会进入
    if ([annotation isKindOfClass:[LSMAPointAnnotation class]]) {
        if (!pinView) {
            pinView = [[DDMAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:kPin];
            //[pinView setDraggable:YES];
            pinView.canShowCallout = YES;
            pinView.enabled = YES;
            pinView.userInteractionEnabled = YES;
        }
        //MAPinAnnotationView
        LSMAPointAnnotation *an = (LSMAPointAnnotation *)annotation;
        pinView.onClicked = ^{
            DDDeskShowViewController *deskShowVC = [[DDDeskShowViewController alloc] init];
            DDTableModel *model = [DDTableModel new];
            model.id = an.entity.id;
            deskShowVC.tmpModel = model;
            [weakSelf.navigationController pushViewController:deskShowVC animated:YES];
        };
        [pinView updateValueWith:an.entity];
        [self addMarkAnimationOn:pinView.layer];
    }
    return pinView;
}

- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    // 根据屏幕位置转换地图坐标经纬度
    CLLocationCoordinate2D markCoordinate = [self.mapView convertPoint:_iv_mark.frame.origin toCoordinateFromView:self.view];
    double distance = [self distanceBetweenOrderBy:markCoordinate.latitude :oldCoordinate.latitude :markCoordinate.longitude :oldCoordinate.longitude];
    if (distance > 1000) {
        [self updateDataWith:markCoordinate withActivities:nil text:nil begin_time:nil end_time:nil];
        [self addMarkAnimationOn:self.iv_mark.layer];
    }
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    // 让定位箭头随着方向旋转
    if (!updatingLocation && self.userLocationAnnotationView != nil) {
        [UIView animateWithDuration:0.1 animations:^{
            double degree = userLocation.heading.trueHeading - self.mapView.rotationDegree;
            self.userLocationAnnotationView.transform = CGAffineTransformMakeRotation(degree * M_PI / 180.f);
        }];
    }
}

// 点击大头针事件
//- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
//
//    if ([view.annotation isKindOfClass:[LSMAPointAnnotation class]]) {
//        LSMAPointAnnotation *annotation = (LSMAPointAnnotation *)view.annotation;
//        DDDeskShowViewController *deskShowVC = [[DDDeskShowViewController alloc] init];
//        DDTableModel *model = [DDTableModel new];
//        model.id = annotation.entity.id;
//        deskShowVC.tmpModel = model;
//        [self.navigationController pushViewController:deskShowVC animated:YES];
//    }
//}

#pragma mark - tools
// 给棒棒糖加动画
- (void)addMarkAnimationOn:(CALayer *)layer{
    POPSpringAnimation *scaleAnim3 = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnim3.beginTime = CACurrentMediaTime();
    scaleAnim3.toValue = [NSValue valueWithCGPoint:CGPointMake(1.3, 1.3)];
    scaleAnim3.springSpeed = 20;
    scaleAnim3.springBounciness = 16;
    [layer pop_addAnimation:scaleAnim3 forKey:@"scaleAnim3"];
    POPSpringAnimation *scaleAnim33 = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnim33.beginTime = CACurrentMediaTime()+0.1;
    scaleAnim33.toValue = [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
    scaleAnim33.springSpeed = 20;
    scaleAnim33.springBounciness = 16;
    [layer pop_addAnimation:scaleAnim33 forKey:@"scaleAnim33"];
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

#pragma mark - actions

- (void)updateDataWith:(CLLocationCoordinate2D)coorr withActivities:(NSArray *)activities text:(NSString *)text begin_time:(NSString *)begin_time end_time:(NSString *)end_time{
    oldCoordinate = coorr;
    //开启异步并行线程请求用户详情数据
    dispatch_queue_t queue= dispatch_queue_create("loadMapInfo", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        [DDTJHttpRequest getMapTablesWithRange:@"1500" activity:activities begin_time:begin_time end_time:end_time text:text lon:[NSString stringWithFormat:@"%lf",oldCoordinate.longitude] lat:[NSString stringWithFormat:@"%lf",oldCoordinate.latitude] block:^(NSDictionary *dict) {
            dispatch_async(dispatch_get_main_queue(), ^(){
                self.dataArray = [LSMapTableEntity mj_objectArrayWithKeyValuesArray:dict];
                [self addAnnotationsToMapView:self.mapView withArray:self.dataArray];
            });
        } failure:^{}];
    });
}

// 回到当前位置并加载周边数据
- (void)backSelfLocation {
    [self.mapView setCenterCoordinate:_mapView.userLocation.coordinate animated:YES];
    CLLocationCoordinate2D markCoordinate = [self.mapView convertPoint:self.iv_mark.frame.origin toCoordinateFromView:self.view];
    [self updateDataWith:markCoordinate withActivities:nil text:nil begin_time:nil end_time:nil];
}

// 根据文本搜索桌子地图
- (void)searchActivitiesByText:(NSString *)text {
    CLLocationCoordinate2D markCoordinate = [self.mapView convertPoint:_iv_mark.frame.origin toCoordinateFromView:self.view];
    [self updateDataWith:markCoordinate withActivities:nil text:text begin_time:nil end_time:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end




