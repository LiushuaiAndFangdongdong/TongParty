//
//  DDBaseHttpUtil.h
//  TongParty
//
//  Created by 方冬冬 on 2017/10/30.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"

typedef NS_ENUM(NSInteger, DDHttpResponseType) {
    kDDHttpResponseTypeJson,
    kDDHttpResponseTypeText
};

@interface DDBaseHttpUtil : NSObject

+(void)getWithUrl:(NSString *)url action:(NSString *)action params:(NSDictionary *)params type:(DDHttpResponseType)type block:(void (^)(id))block failure:(void(^)())failure;

+(void)postWithUrl:(NSString *)url action:(NSString *)action params:(NSDictionary *)params type:(DDHttpResponseType)type block:(void (^)(id))block failure:(void(^)())failure;


+ (void)uploadImageWithUrl:(NSString *)url action:(NSString *)action params:(NSDictionary *)params image:(UIImage *)image success:(void (^)(id responseObject))success fail:(void (^)())fail;

//多图上传
+ (void)uploadMultiImageWithUrl:(NSString *)url action:(NSString *)action params:(NSDictionary *)params image:(NSArray *)imageDatas success:(void (^)(id responseObject))success fail:(void (^)())fail;

// 上传带图信息
+ (void)uploadInfoContainImageWithUrl:(NSString *)url action:(NSString *)action params:(NSDictionary *)params image:(NSArray *)imageDatas success:(void (^)(id responseObject))success fail:(void (^)())fail;

+ (void)setWithMutableDict:(NSMutableDictionary *)dict key:(NSString *)key value:(id)value;

@end

