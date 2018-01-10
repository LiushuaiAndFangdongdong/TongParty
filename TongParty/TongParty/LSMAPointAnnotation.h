//
//  LSMAPointAnnotation.h
//  TongParty
//
//  Created by 刘帅 on 2018/1/4.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "LSMapTableEntity.h"
@interface LSMAPointAnnotation : MAPointAnnotation
@property(nonatomic, strong)LSMapTableEntity *entity;
@end
