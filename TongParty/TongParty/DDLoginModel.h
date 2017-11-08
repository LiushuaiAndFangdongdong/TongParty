//
//  DDLoginModel.h
//  TongParty
//
//  Created by 方冬冬 on 2017/10/30.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDModel.h"

@interface DDLoginModel : DDModel
@property (nonatomic, copy) NSString *username;       //用户名
@property (nonatomic, copy) NSString *vercode;        //验证码
@property (nonatomic, copy) NSString *password;       //密码
@property (nonatomic, copy) NSString *passwordConfirm;//确认密码
@end
