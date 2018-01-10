//
//  LSCreatDeskEntity.h
//  TongParty
//
//  Created by 刘帅 on 2017/11/27.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSCreatDeskEntity : NSObject
/**商户id*/
@property (nonatomic, copy)NSString *sid;
/**活动id*/
@property (nonatomic, copy)NSString *activity;
/**活动名称*/
@property (nonatomic, copy)NSString *custom;
/**桌子标题*/
@property (nonatomic, copy)NSString *title;
/**桌子地点*/
@property (nonatomic, copy)NSString *place;
/**开始时间*/
@property (nonatomic, copy)NSString *begin_time;
/**限制人数*/
@property (nonatomic, copy)NSString *person_num;
/**限制市场*/
@property (nonatomic, copy)NSString *time_range;
/**人均消费*/
@property (nonatomic, copy)NSString *average_price;
/**描述*/
@property (nonatomic, copy)NSString *dEscription;
/**是否为心跳桌*/
@property (nonatomic, copy)NSString *is_heart;
/**纬度*/
@property (nonatomic, copy)NSString *latitude;
/**经度*/
@property (nonatomic, copy)NSString *longitude;
/**桌子图片 file*/
@property (nonatomic, strong)NSMutableArray *Images;
/**地址标签 */
@property (nonatomic, strong)NSArray *labels;
@end
