//
//  DDUserSingleton.h
//  TongParty
//
//  Created by 方冬冬 on 2017/10/30.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDModel.h"

@interface DDUserSingleton : DDModel

/**唯一标示*/
@property (nonatomic, copy) NSString *token;
/**名字*/
@property (nonatomic, copy) NSString *name;
/**手机号*/
@property (nonatomic, copy) NSString *mobile;
/**头像*/
@property (nonatomic, copy) NSString *image;
/**唯一标示
 * (0保密,1男,2女)
 */
@property (nonatomic, copy) NSString *sex;
/**签名*/
@property (nonatomic, copy) NSString *signature;
/**城市*/
@property (nonatomic, copy) NSString *city;

/**经度*/
@property (nonatomic, copy) NSString *longitude;
/**纬度*/
@property (nonatomic, copy) NSString *latitude;


- (void)clearUserInfo;

+(DDUserSingleton *)shareInstance;
@end







