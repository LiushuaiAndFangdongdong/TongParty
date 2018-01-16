//
//  DDRecommendCardModel.h
//  TongParty
//
//  Created by 方冬冬 on 2018/1/11.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "DDModel.h"

@interface DDRecommendCardModel : DDModel
@property (nonatomic, copy) NSString *ID; //桌子id
@property (nonatomic, copy) NSString *uid;//桌主id
@property (nonatomic, copy) NSString *uname;//桌主名字
@property (nonatomic, copy) NSString *image;//桌主头像
@property (nonatomic, copy) NSString *desc;//描述
@property (nonatomic, copy) NSString *person_num;//限制人数
@property (nonatomic, copy) NSString *custom;//活动名称
@property (nonatomic, copy) NSString *activity;//活动分类
@property (nonatomic, copy) NSString *title;//标题
@property (nonatomic, copy) NSString *place;//地址
@property (nonatomic, copy) NSString *average_price;//均价
@property (nonatomic, copy) NSString *latitude;//纬度
@property (nonatomic, copy) NSString *longitude;//经度
@property (nonatomic, copy) NSString *begin_time;//开始时间
@property (nonatomic, copy) NSString *seviceTime;//服务器时间
@end





