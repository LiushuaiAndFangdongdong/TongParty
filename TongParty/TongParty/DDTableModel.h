//
//  DDTableModel.h
//  TongParty
//
//  Created by 方冬冬 on 2017/11/29.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDModel.h"

@interface DDTableModel : DDModel
@property (nonatomic, copy) NSString *activity;      //活动id 自定义的话为0
@property (nonatomic, copy) NSString *average_price; //人均消费
@property (nonatomic, copy) NSString *begin_time;  //开始时间
@property (nonatomic, copy) NSString *custom;   //自定义活动
@property (nonatomic, copy) NSString *id;     //id
@property (nonatomic, copy) NSString *image;  //图片
@property (nonatomic, copy) NSString *distance;  //距离/米
@property (nonatomic, copy) NSString *shop_name; //商户名称
@property (nonatomic, copy) NSString *num;        //已经参加人数
@property (nonatomic, copy) NSString *person_num; //限制的人数
@property (nonatomic, copy) NSString *place;      //地点
@property (nonatomic, copy) NSString *title;      //标题
@property (nonatomic, copy) NSString *type;     //1.创建的桌子 2.加入的桌子  3.申请的桌子
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *status; // 是否可以点击
@property (nonatomic, copy) NSString *name;
@end


