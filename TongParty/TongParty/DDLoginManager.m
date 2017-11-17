//
//  DDLoginManager.m
//  TongParty
//
//  Created by 方冬冬 on 2017/10/30.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDLoginManager.h"
#import "DDLoginViewController.h"
#import "DDTJHttpRequest.h"

@interface DDLoginManager ()

@property (nonatomic, strong) UIViewController *controller;
@end

@implementation DDLoginManager

- (instancetype)initWithController:(UIViewController *)controller
{
    self = [super init];
    if (self) {
        self.controller = controller;
    }
    return self;
}


- (void)pushCheckedLoginWithPopToRoot:(BOOL)popToRoot block:(void(^)())block
{
    if ([DDUserSingleton shareInstance].token.length > 0) {
        block();
    } else {
        DDLoginViewController *vc = [[DDLoginViewController alloc]init];
        vc.isPopToRoot = popToRoot;
//        vc.hidesBottomBarWhenPushed = YES;
        [self.controller.navigationController pushViewController:vc animated:YES];
    }
}


- (void)loginWithUsername:(NSString *)username password:(NSString *)password block:(void(^)(NSDictionary *dict))block failure:(void(^)())failure
{
    [DDTJHttpRequest loginWithMobile:username password:password block:^(NSDictionary *dict) {
        [DDUserDefault setObject:username forKey:@"mobile"];
        [DDUserDefault setObject:password forKey:@"password"];
        [DDUserDefault setObject:dict[@"token"] forKey:@"token"];
        block(dict);
    } failure:^{
        //
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end






