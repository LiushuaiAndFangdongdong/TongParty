//
//  LSHisUserInfoModel.h
//  TongParty
//
//  Created by 刘帅 on 2017/12/14.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDModel.h"

@interface LSHisUserInfoModel : DDModel
/**名字*/
@property (nonatomic, copy) NSString *name;
/**电话*/
@property (nonatomic, copy) NSString *mobile;
/**头像*/
@property (nonatomic, copy) NSString *image;
/**信用积分*/
@property (nonatomic, copy) NSString *score;
/**性别*/
@property (nonatomic, copy) NSString *sex;
/**生日*/
@property (nonatomic, copy) NSString *birthday;
/**星座*/
@property (nonatomic, copy) NSString *constellation;
/**个性签名*/
@property (nonatomic, copy) NSString *signature;
/**城市*/
@property (nonatomic, copy) NSString *city;
/**地区*/
@property (nonatomic, copy) NSString *district;
/**学校*/
@property (nonatomic, copy) NSString *school;
/**职业*/
@property (nonatomic, copy) NSString *occupation;
/**经度*/
@property (nonatomic, copy) NSString *longitude;
/**维度*/
@property (nonatomic, copy) NSString *latitude;
/**是否为好友*/
@property (nonatomic, copy) NSString *is_friend;
/**好友数*/
@property (nonatomic, copy) NSString *f_num;
/**是否关注*/
@property (nonatomic, copy) NSString *is_like;
/**是否可添加*/
@property (nonatomic, copy) NSString *is_gof;
/**创建的桌子数*/
@property (nonatomic, copy) NSString *ct_num;
/**创建并完成桌子数*/
@property (nonatomic, copy) NSString *cft_num;
/**参加的桌子数*/
@property (nonatomic, copy) NSString *jt_num;
/**参加并完成桌子*/
@property (nonatomic, copy) NSString *jft_num;
/**铜币*/
@property (nonatomic, copy) NSString *coin;
/**参加的桌子*/
@property (nonatomic, strong) NSArray *table;
/**相册*/
@property (nonatomic, strong) NSArray *photo;
/**标签*/
@property (nonatomic, copy) NSString *label;
/**关注数量*/
@property (nonatomic, copy) NSString *bl_num;
/**被关注数量*/
@property (nonatomic, copy) NSString *tl_num;

@end
