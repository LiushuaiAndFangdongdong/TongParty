//
//  DDUserSingleton.m
//  TongParty
//
//  Created by 方冬冬 on 2017/10/30.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDUserSingleton.h"

static DDUserSingleton *_instance;

@implementation DDUserSingleton

+(instancetype)mj_objectWithKeyValues:(id)keyValues
{
    _instance = [super mj_objectWithKeyValues:keyValues];
    return _instance;
}

-(void)clearUserInfo
{
    _instance = nil;
}

+(DDUserSingleton *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[[self class] alloc] init];
    });
    return _instance;
}

@end
