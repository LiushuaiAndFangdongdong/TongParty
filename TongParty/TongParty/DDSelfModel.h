//
//  DDSelfModel.h
//  TongParty
//
//  Created by 方冬冬 on 2018/1/18.
//  Copyright © 2018年 桐聚. All rights reserved.
//

//非桌主桌子的用户浏览桌子显示

#import "DDModel.h"

@interface DDSelfModel : DDModel
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *is_like;  //是否关注桌子：0-否，1-是
@property (nonatomic, copy) NSString *is_sign;  //是否签到：2-是，0否
@end
