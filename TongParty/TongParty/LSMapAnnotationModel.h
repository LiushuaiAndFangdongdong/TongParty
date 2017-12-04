//
//  LSMapAnnotationModel.h
//  TongParty
//
//  Created by 刘帅 on 2017/11/23.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSMapAnnotationModel : NSObject
/**桌子id*/
@property (nonatomic, copy)NSString *id;
/**桌子分类*/
@property (nonatomic, copy)NSString *activity;
/**开始时间*/
@property (nonatomic, copy)NSString *begin_time;
/**限制人数*/
@property (nonatomic, copy)NSString *person_num;
/**纬度*/
@property (nonatomic, copy)NSString *latitude;
/**经度*/
@property (nonatomic, copy)NSString *longitude;
@end
