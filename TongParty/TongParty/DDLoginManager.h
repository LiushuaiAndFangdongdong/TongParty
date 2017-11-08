//
//  DDLoginManager.h
//  TongParty
//
//  Created by 方冬冬 on 2017/10/30.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDBaseViewController.h"

@interface DDLoginManager : DDBaseViewController

- (instancetype)initWithController:(UIViewController *)controller;
- (void)pushCheckedLoginWithPopToRoot:(BOOL)popToRoot block:(void(^)())block;
- (void)loginWithUsername:(NSString *)username password:(NSString *)password block:(void(^)(NSDictionary *dict))block failure:(void(^)())failure;
@end
