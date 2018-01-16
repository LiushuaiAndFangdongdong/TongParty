//
//  DDResponseBaseHttp.m
//  TongParty
//
//  Created by 方冬冬 on 2017/10/30.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDResponseBaseHttp.h"

@implementation DDResponseBaseHttp


+(void)postWithAction:(NSString *)action params:(NSDictionary *)params type:(DDHttpResponseType)type block:(void (^)(DDResponseModel *result))block failure:(void(^)())failure
{
    [super postWithUrl:kTJHostAPI action:action params:params type:type block:^(id responseObject) {
        DDResponseModel *result = [DDResponseModel mj_objectWithKeyValues:responseObject];
        block(result);
    } failure:^{
        failure();
    }];
}


+(void)getWithAction:(NSString *)action params:(NSDictionary *)params type:(DDHttpResponseType)type block:(void (^)(DDResponseModel *result))block failure:(void(^)())failure{
    
    [super getWithUrl:kTJHostAPI action:action params:params type:type block:^(id responseObject) {
        DDResponseModel *result = [DDResponseModel mj_objectWithKeyValues:responseObject];
        block(result);
    } failure:^{
        failure();
    }];
}

//多图上传
+ (void)uploadMultiImageWithAction:(NSString *)action params:(NSDictionary *)params images:(NSArray *)images  success:(void (^)(DDResponseModel *result))success fail:(void (^)())fail
{
    //    [super uploadMultiImageWithUrl:HTTP_HOST action:action params:params image:images success:success fail:fail];
    [super uploadMultiImageWithUrl:kTJHostAPI action:action params:params image:images success:^(id responseObject) {
        DDResponseModel *result = [DDResponseModel mj_objectWithKeyValues:responseObject];
        success(result);
    } fail:^{
        fail();
    }];
}

+ (void)uploadImageWithAction:(NSString *)action params:(NSDictionary *)params image:(UIImage *)image  success:(void (^)(DDResponseModel *result))success fail:(void (^)())fail
{
    //    [super uploadImageWithUrl:HTTP_HOST action:action params:params image:image success:success fail:fail];
    [super uploadImageWithUrl:kTJHostAPI action:action params:params image:image success:^(id responseObject) {
        DDResponseModel *result = [DDResponseModel mj_objectWithKeyValues:responseObject];
        success(result);
    } fail:^{
        fail();
    }];
}

+(void)postTextWithAction:(NSString *)action params:(NSDictionary *)params type:(DDHttpResponseType)type block:(void (^)(NSString *text))block failure:(void(^)())failure
{
    [super postWithUrl:kTJHostAPI action:action params:params type:type block:^(id responseObject) {
        NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        block(str);
    } failure:^{
        failure();
    }];
}


+ (void)uploadInfoContainImageWithAction:(NSString *)action params:(NSDictionary *)params images:(NSArray *)images  success:(void (^)(DDResponseModel *result))success fail:(void (^)())fail {
    
    [super uploadInfoContainImageWithUrl:kTJHostAPI action:action params:params image:images success:^(id responseObject) {
        DDResponseModel *result = [DDResponseModel mj_objectWithKeyValues:responseObject];
        success(result);
    } fail:^{
        fail();
    }];
}


@end

