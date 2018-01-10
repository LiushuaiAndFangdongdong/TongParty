//
//  DDNearTableModel.h
//  TongParty
//
//  Created by 方冬冬 on 2018/1/8.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "DDModel.h"

@interface DDNearTableModel : DDModel
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *person_num;
@property (nonatomic, copy) NSString *num;
@property (nonatomic, copy) NSString *custom;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *distance;
@property (nonatomic, copy) NSString *image;//活动图标
@end

