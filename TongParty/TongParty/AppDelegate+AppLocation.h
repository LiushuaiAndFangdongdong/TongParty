//
//  AppDelegate+AppLocation.h
//  TongParty
//
//  Created by 方冬冬 on 2017/9/13.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "AppDelegate.h"


/**
 *  声明block,传递经纬度、反编码、定位是否成功、显示框
 */
typedef void (^LocationPosition)(CLLocation *currentLocation,AMapLocationReGeocode *regeocode,BOOL isLocationSuccess,MBProgressHUD *hud);

@interface AppDelegate (AppLocation) <AMapLocationManagerDelegate>

@property (copy,nonatomic) LocationPosition locationBlock;          //定位到位置的block
@property (strong,nonatomic) AMapLocationManager *locationManager;  //管理者

//启动定位服务
-(void)startLocation;

//接收位置block
-(void)receiveLocationBlock:(LocationPosition)block;

@end
