//
//  AppDelegate+AppLocation.m
//  TongParty
//
//  Created by 方冬冬 on 2017/9/13.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "AppDelegate+AppLocation.h"
#import <objc/runtime.h>

static const NSString *locationBlockKey   = @"locationBlockKey";
static const NSString *locationManagerKey = @"locationManagerKey";

@implementation AppDelegate (AppLocation)

/**
 *  动态关联属性
 */
-(void)setLocationBlock:(LocationPosition)locationBlock{

    objc_setAssociatedObject(self, &locationBlockKey , locationBlock, OBJC_ASSOCIATION_RETAIN);
}

-(LocationPosition)locationBlock{

    return objc_getAssociatedObject(self, &locationBlockKey);
}

-(void)setLocationManager:(AMapLocationManager *)locationManager{

    objc_setAssociatedObject(self, &locationManagerKey , locationManager, OBJC_ASSOCIATION_RETAIN);
}

-(AMapLocationManager *)locationManager{

    return objc_getAssociatedObject(self, &locationManagerKey);
}

/**
 *  启动定位服务
 */
-(void)startLocation{

    //2、设置定位精度
    self.locationManager = [[AMapLocationManager alloc] init];
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    // 定位超时时间，最低2s，此处设置为2s
    self.locationManager.locationTimeout = 2;
    // 逆地理请求超时时间，最低2s，此处设置为2s
    self.locationManager.reGeocodeTimeout = 2;
    
    [self.locationManager setAllowsBackgroundLocationUpdates:NO];

    //3.创建定位管理者
    //带逆地理（返回坐标和地址信息。将下面代码中的 YES改成NO,则不会返回地址信息。
    // MBProgressHUD *hud = [MBProgressHUD showMessage:@"正在定位"];
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {

        if (error){
            if (error.code == AMapLocationErrorLocateFailed){
                self.locationBlock(nil, nil, NO, nil); return;
            }
        }
        NSLog(@"经度longitude：%f",location.coordinate.longitude); //经度
        NSLog(@"纬度latitude：%f",location.coordinate.latitude);   //纬度
        //逆向编码、传值(定位成功)
        NSLog(@"位置：%@",regeocode);
        if(regeocode){ self.locationBlock(location, regeocode, YES, nil); }
    }];
}

//接收block
-(void)receiveLocationBlock:(LocationPosition)block{
    if (block) {
        self.locationBlock = [block copy];
    }
}

@end

