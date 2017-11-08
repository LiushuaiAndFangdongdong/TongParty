//
//  DDValidateManager.h
//  TongParty
//
//  Created by 方冬冬 on 2017/10/30.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DDLoginModel.h"

@interface DDValidateManager : NSObject

-(instancetype)initWithController:(UIViewController *)vc;

- (BOOL)validateForgetPasswordWithModel:(DDLoginModel *)model;
- (BOOL)validateRegisterWithModel:(DDLoginModel *)model;
- (BOOL)validateVercodeWithPhone:(NSString *)phone;
- (BOOL)validateLoginWithModel:(DDLoginModel *)model;
- (BOOL)validatePhoneWithPhone:(NSString *)phone;
@end
