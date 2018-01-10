//
//  DDNearUserModel.h
//  TongParty
//
//  Created by 方冬冬 on 2018/1/8.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "DDModel.h"

@interface DDNearUserModel : DDModel
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sex;//1-男；2-女
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *tid;
@property (nonatomic, copy) NSString *custom;   //活动
@property (nonatomic, copy) NSString *person_num;
@property (nonatomic, copy) NSString *begin_time;
@property (nonatomic, copy) NSString *activeIcon;//活动图标
@property (nonatomic, copy) NSString *levelStr;  //头衔
@property (nonatomic, copy) NSString *serviceTime;
@property (nonatomic, copy) NSString *distance;
@end
