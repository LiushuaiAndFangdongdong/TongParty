//
//  DDBannerModel.h
//  TongParty
//
//  Created by 方冬冬 on 2017/11/29.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDModel.h"

@interface DDBannerModel : DDModel
@property (nonatomic, copy) NSString *id;    //图片id
@property (nonatomic, copy) NSString *title; //标题
@property (nonatomic, copy) NSString *image; //图片地址
@property (nonatomic, copy) NSString *adurl; //链接地址
@end
