//
//  DDTableInfoModel.h
//  TongParty
//
//  Created by 方冬冬 on 2017/12/5.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDModel.h"

@interface DDTableInfoModel : DDModel
@property (nonatomic, copy) NSString *activity;      //活动id 自定义的话为0
@property (nonatomic, copy) NSString *average_price; //人均消费
@property (nonatomic, copy) NSString *begin_time;  //开始时间
@property (nonatomic, copy) NSString *custom;   //自定义活动
@property (nonatomic, copy) NSString *ID;     //id
@property (nonatomic, copy) NSString *image;  //桌主头像
@property (nonatomic, copy) NSString *person_num; //限制的人数
@property (nonatomic, copy) NSString *place;      //地点
@property (nonatomic, copy) NSString *text;       //公告
@property (nonatomic, copy) NSString *title;      //标题
@property (nonatomic, copy) NSString *serviceTime; //系统时间
@property (nonatomic, copy) NSString *mobile;     //桌主手机号
@property (nonatomic, copy) NSString *desc; //描述
@property (nonatomic, copy) NSString *uid;     //桌主id
@property (nonatomic, copy) NSString *uname;   //桌主名称
@property (nonatomic, copy) NSString *type;  // 1桌主 2参与者 0未参与
@property (nonatomic, copy) NSString *status;  //申请的状态，1-可以点击申请加入，0-不可以
@property (nonatomic, copy) NSString *is_sign; //桌主是否签到，1-是，0-否
@end



