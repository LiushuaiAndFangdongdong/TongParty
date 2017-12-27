//
//  DDResponseBaseHttp.h
//  TongParty
//
//  Created by 方冬冬 on 2017/10/30.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDBaseHttpUtil.h"
#import "DDResponseModel.h"

@interface DDResponseBaseHttp : DDBaseHttpUtil

//post
+(void)postWithAction:(NSString *)action params:(NSDictionary *)params type:(DDHttpResponseType)type block:(void (^)(DDResponseModel *result))block failure:(void(^)())failure;
//get
+(void)getWithAction:(NSString *)action params:(NSDictionary *)params  type:(DDHttpResponseType)type block:(void (^)(DDResponseModel *result))block failure:(void(^)())failure;
//多图
+ (void)uploadMultiImageWithAction:(NSString *)action params:(NSDictionary *)params images:(NSArray *)images  success:(void (^)(DDResponseModel *result))success fail:(void (^)())fail;
//单图
+ (void)uploadImageWithAction:(NSString *)action params:(NSDictionary *)params image:(UIImage *)image  success:(void (^)(DDResponseModel *result))success fail:(void (^)())fail;
//post文字
+(void)postTextWithAction:(NSString *)action params:(NSDictionary *)params type:(DDHttpResponseType)type block:(void (^)(NSString *text))block failure:(void(^)())failure;
+ (void)uploadInfoContainImageWithAction:(NSString *)action params:(NSDictionary *)params images:(NSArray *)images  success:(void (^)(DDResponseModel *result))success fail:(void (^)())fail;

@end

