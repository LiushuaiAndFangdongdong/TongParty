//
////
////  DDLocationManager.m
////  TongParty
////
////  Created by 方冬冬 on 2017/9/14.
////  Copyright © 2017年 桐聚. All rights reserved.
////
//
//#import "DDLocationManager.h"
//#import <AMapLocationKit/AMapLocationKit.h>
//
//@interface DDLocationManager()<AMapLocationManagerDelegate>
//@property (nonatomic, strong) AMapLocationManager *locationManager;
//@end
//
//
//
//static DDLocationManager *_singleton = nil;
//
//@implementation DDLocationManager
//{
//    DDLocationManagerDidUpdateLocationHandle _updateLocationHandle;
//}
//+ (instancetype)sharedManager {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _singleton = [[DDLocationManager alloc] init];
//    });
//    return _singleton;
//}
//
//- (void)setUpLocationManagerUpdateLocationHandle:(DDLocationManagerDidUpdateLocationHandle)updateLocationHandle {
//    _updateLocationHandle = updateLocationHandle;
//}
//
//// 开始定位
//- (void)startSerialLocation {
//    
//    if (self.canLocationFlag == NO) {
//        return ;
//    }
//    [self.locationManager startUpdatingLocation];
//}
//
//// 停止定位
//- (void)stopSerialLocation {
//    [self.locationManager stopUpdatingLocation];
//}
//
//#pragma mark - AMapLocationManager
//// 定位错误
//- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error {
//    NSLog(@"error = %@",  error);
//}
//
//// 定位结果
//- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)newLocation {
//    
//    
//    // 纬度
//    NSString *currentLatitude = [[NSString alloc]
//                                 initWithFormat:@"%f",
//                                 newLocation.coordinate.latitude];
//    
//    // 经度
//    NSString *currentLongitude = [[NSString alloc]
//                                  initWithFormat:@"%f",
//                                  newLocation.coordinate.longitude];
//    
//    [[NSUserDefaults standardUserDefaults] setObject:currentLatitude forKey:kNHUserCurrentLatitude];
//    [[NSUserDefaults standardUserDefaults] setObject:currentLongitude forKey:kNHUserCurrentLongitude];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    
//    if (_updateLocationHandle) {
//        _updateLocationHandle(newLocation, currentLatitude, currentLongitude);
//    }
//    
//}
//
//- (AMapLocationManager *)locationManager {
//    if (!_locationManager) {
//        AMapLocationManager *locationManager = [[AMapLocationManager alloc] init];
//        locationManager.delegate = self;
//        locationManager.pausesLocationUpdatesAutomatically = NO;
//        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
//        locationManager.allowsBackgroundLocationUpdates = NO;
//    }
//    return _locationManager;
//}
//
//- (BOOL)isCanLocationFlag {
//    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse)) {
//        return YES;
//    } else {
//        return NO;
//    }
//}
//
//- (BOOL)hasLocation {
//    return [[[NSUserDefaults standardUserDefaults] objectForKey:kNHUserCurrentLongitude] length] && [[[NSUserDefaults standardUserDefaults] objectForKey:kNHUserCurrentLatitude] length];
//}
//@end
