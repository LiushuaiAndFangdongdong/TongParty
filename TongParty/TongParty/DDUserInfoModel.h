//
//  DDUserInfoModel.h
//  TongParty
//
//  Created by 方冬冬 on 2017/11/3.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDModel.h"

@interface DDUserInfoModel : DDModel

/**创建时间*/
@property (nonatomic, copy) NSString *create_time;
/**地区*/
@property (nonatomic, copy) NSString *district;
/**生日*/
@property (nonatomic, copy) NSString *birthday;
/**学校*/
@property (nonatomic, copy) NSString *school;
/**城市*/
@property (nonatomic, copy) NSString *city;
/**铜币*/
@property (nonatomic, copy) NSString *coin;
/**星座*/
@property (nonatomic, copy) NSString *constellation;
/**职业*/
@property (nonatomic, copy) NSString *occupation;
/**姓名*/
@property (nonatomic, copy) NSString *name;
/**手机号*/
@property (nonatomic, copy) NSString *mobile;
/**经度*/
@property (nonatomic, copy) NSString *longitude;
/**维度*/
@property (nonatomic, copy) NSString *latitude;
/**标签*/
@property (nonatomic, copy) NSString *label;
/**头像*/
@property (nonatomic, copy) NSString *image;
/**相册*/
@property (nonatomic, strong)NSArray *photo;
/**个性签名*/
@property (nonatomic, copy) NSString *signature;
/**性别*/
@property (nonatomic, copy) NSString *sex;
/**等级*/
@property (nonatomic, copy) NSString *score;
/**微信openid*/
@property (nonatomic, copy) NSString *wx_open_id;
/**微博openid*/
@property (nonatomic, copy) NSString *wb_open_id;
/**qqopenid*/
@property (nonatomic, copy) NSString *qq_open_id;
/**创建的桌子*/
@property (nonatomic, copy) NSString *ct_num;
/**参加的桌子*/
@property (nonatomic, copy) NSString *jt_num;
/**关注数量*/
@property (nonatomic, copy) NSString *bl_num;
/**粉丝数量*/
@property (nonatomic, copy) NSString *tl_num;
/**被打伤铜币数*/
@property (nonatomic, copy) NSString *be_coin;
/**好友数*/
@property (nonatomic, copy) NSString *f_num;
/**是否认证*/
@property (nonatomic, copy) NSString *is_valid;
/**活动历史*/
@property (nonatomic, strong) NSArray *table;

@end













