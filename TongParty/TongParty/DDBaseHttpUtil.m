
//
//  DDBaseHttpUtil.m
//  TongParty
//
//  Created by 方冬冬 on 2017/10/30.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDBaseHttpUtil.h"
#import "DDResponseModel.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#define Api_secret @"cc0aa948-6b7e-11e7-8e3a-408d5c21834b"

@implementation DDBaseHttpUtil
//时间转时间戳
+(NSString *)unixTime{
    //    //简写之
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[[NSDate  date] timeIntervalSince1970]];
    NSLog(@"timeSp:%@",timeSp); //时间戳的值
    return timeSp;
}

//生成签名
+ (NSString *)hmac:(NSString *)plaintext withKey:(NSString *)key
{
    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [plaintext cStringUsingEncoding:NSASCIIStringEncoding];
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    NSData *HMACData = [NSData dataWithBytes:cHMAC length:sizeof(cHMAC)];
    const unsigned char *buffer = (const unsigned char *)[HMACData bytes];
    NSMutableString *HMAC = [NSMutableString stringWithCapacity:HMACData.length * 2];
    for (int i = 0; i < HMACData.length; ++i){
        [HMAC appendFormat:@"%02x", buffer[i]];
    }
    return HMAC;
}

//&拼接参数中的键值对
+(NSString *)keyValueWithNSDictionary:(NSDictionary *)dict{
    NSArray *keyArray = [dict allKeys];
    NSMutableArray *valueArray = [NSMutableArray array];
    for (NSString *sortString in keyArray) {
        [valueArray addObject:[dict objectForKey: sortString]];
    }
    NSMutableArray *signArray = [NSMutableArray array];
    for (int i =0; i < keyArray.count; i++) {
        NSString *keyValueStr = [NSString stringWithFormat:@"%@=%@",keyArray[i],valueArray[i]];
        [signArray addObject: keyValueStr];
    }
    NSString *sign = [signArray componentsJoinedByString:@"&"];
    return sign;
}

+(void)getWithUrl:(NSString *)url action:(NSString *)action params:(NSDictionary *)params  type:(DDHttpResponseType)type block:(void (^)(id))block failure:(void(^)())failure
{
    NSString *string0 = [NSString stringWithFormat:@"%@%@", url, action];
    NSString *string1 = [NSString stringWithFormat:@"%@%@",@"GET",action];
    NSString *string2 = [self unixTime];
    NSString *string3 = [NSString stringWithFormat:@"%@%@",string1,string2];
    NSString *string4 = [self keyValueWithNSDictionary:params];
    NSString *paraStr = [NSString stringWithFormat:@"%@%@",string3,string4];
    //汉字要encode
    NSString *encodePara = [paraStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *encryPara = [self hmac:encodePara withKey:Api_secret];
    
    //    NSString *encryPara = [self hmac:paraStr withKey:Api_secret];
    
    NSLog(@"时间戳：%@",string2);
    NSLog(@"需要加密的：%@",paraStr);
    NSLog(@"加密后==%@",encryPara);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置请求内容的类型
    [manager.requestSerializer setValue:string2 forHTTPHeaderField:@"api-expires"];
    //设置请求的编码类型
    [manager.requestSerializer setValue:encryPara forHTTPHeaderField:@"api-signature"];
    
    if (type == kDDHttpResponseTypeText) {
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    } else {
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    }
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    [manager GET:string0 parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code != -1009 || error.code != -1001) {
            NSLog(@"error.userInfo = %@", error.userInfo);
        }
        failure();
    }];
}


+(void)postWithUrl:(NSString *)url action:(NSString *)action params:(NSDictionary *)params type:(DDHttpResponseType)type block:(void (^)(id))block failure:(void(^)())failure
{
    NSString *string0 = [NSString stringWithFormat:@"%@%@", url, action];
    NSString *string1 = [NSString stringWithFormat:@"%@%@",@"POST",action];
    NSString *string2 = [self unixTime];
    NSString *string3 = [NSString stringWithFormat:@"%@%@",string1,string2];
    
    NSString *string4 = [self keyValueWithNSDictionary:params];
    NSString *paraStr = [NSString stringWithFormat:@"%@%@",string3,string4];
    //汉字要encode
    //    NSString *encodePara = [paraStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //post参数不参与加密
    NSString *encryPara = [self hmac:string3 withKey:Api_secret];
    
    //    NSString *encryPara = [self hmac:paraStr withKey:Api_secret];
    
    NSLog(@"时间戳：%@",string2);
    NSLog(@"需要加密的：%@",paraStr);
    NSLog(@"加密后==%@",encryPara);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置请求内容的类型
    [manager.requestSerializer setValue:string2 forHTTPHeaderField:@"api-expires"];
    //设置请求的编码类型
    [manager.requestSerializer setValue:encryPara forHTTPHeaderField:@"api-signature"];
    if (type == kDDHttpResponseTypeText) {
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    } else {
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        //        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    }
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    //    NSString *urlStr = [NSString stringWithFormat:@"%@%@", url, action];
    
    [manager POST:string0 parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code != -1009 || error.code != -1001) {
            NSLog(@"error.userInfo = %@", error.userInfo);
        }
        failure();
    }];
}



+ (void)uploadImageWithUrl:(NSString *)url action:(NSString *)action params:(NSDictionary *)params image:(UIImage *)image success:(void (^)(id responseObject))success fail:(void (^)())fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", url, action];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", @"image/png", nil];
    
    [manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if (image!=nil) {
            NSData *data = UIImagePNGRepresentation(image);
            NSInputStream *stream = [NSInputStream inputStreamWithData:data];
            [formData appendPartWithInputStream:stream name:@"avatar" fileName:@"witcity.png" length:data.length mimeType:@"image/png"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSDictionary *dict =  [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            success(dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"image error = %@", error);
        if (fail) {
            fail();
        }
    }];
}

//多图上传
+ (void)uploadMultiImageWithUrl:(NSString *)url action:(NSString *)action params:(NSDictionary *)params image:(NSArray *)imageDatas success:(void (^)(id responseObject))success fail:(void (^)())fail{
    
    NSString *string0 = [NSString stringWithFormat:@"%@%@", url, action];
    NSString *string1 = [NSString stringWithFormat:@"%@%@",@"POST",action];
    NSString *string2 = [self unixTime];
    NSString *string3 = [NSString stringWithFormat:@"%@%@",string1,string2];
    
    NSString *string4 = [self keyValueWithNSDictionary:params];
    NSString *paraStr = [NSString stringWithFormat:@"%@%@",string3,string4];
    
    //post参数不参与加密
    NSString *encryPara = [self hmac:string3 withKey:Api_secret];
    
    NSLog(@"时间戳：%@",string2);
    NSLog(@"需要加密的：%@",paraStr);
    NSLog(@"加密后==%@",encryPara);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置请求内容的类型
    [manager.requestSerializer setValue:string2 forHTTPHeaderField:@"api-expires"];
    //设置请求的编码类型
    [manager.requestSerializer setValue:encryPara forHTTPHeaderField:@"api-signature"];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    
    [manager POST:string0 parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i = 0; i < imageDatas.count; i++) {
            
            UIImage *image = imageDatas[i];
            //把图片转换为二进制流
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统事件作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *dateString = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString  stringWithFormat:@"%@.png", dateString];
            /*
             *该方法的参数
             1. appendPartWithFileData：要上传的照片[二进制流]
             2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
             3. fileName：要保存在服务器上的文件名
             4. mimeType：上传的文件的类型
             */
            NSString *name = [NSString stringWithFormat:@"image[%d]",i];
            //按照表单格式把二进制文件写入formData表单
            [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:@"image/png"]; //
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"---上传进度--- %@",uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"```上传成功``` %@",responseObject);
        if (success) {
            //            NSDictionary *dict =  [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            //            success(dict);
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"image error = %@", error);
        if (fail) {
            fail();
        }
    }];
}


// 上传带图信息
+ (void)uploadInfoContainImageWithUrl:(NSString *)url action:(NSString *)action params:(NSDictionary *)params image:(NSArray *)imageDatas success:(void (^)(id responseObject))success fail:(void (^)())fail{
    
    NSString *string0 = [NSString stringWithFormat:@"%@%@", url, action];
    NSString *string1 = [NSString stringWithFormat:@"%@%@",@"POST",action];
    NSString *string2 = [self unixTime];
    NSString *string3 = [NSString stringWithFormat:@"%@%@",string1,string2];
    
    NSString *string4 = [self keyValueWithNSDictionary:params];
    NSString *paraStr = [NSString stringWithFormat:@"%@%@",string3,string4];
    
    //post参数不参与加密
    NSString *encryPara = [self hmac:string3 withKey:Api_secret];
    
    NSLog(@"时间戳：%@",string2);
    NSLog(@"需要加密的：%@",paraStr);
    NSLog(@"加密后==%@",encryPara);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置请求内容的类型
    [manager.requestSerializer setValue:string2 forHTTPHeaderField:@"api-expires"];
    //设置请求的编码类型
    [manager.requestSerializer setValue:encryPara forHTTPHeaderField:@"api-signature"];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    
    [manager POST:string0 parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i = 0; i < imageDatas.count; i++) {
            NSDictionary *imageDic = imageDatas[i];
            //NSString *key = imageDatas key
            //UIImage *image = imageDatas[];
            //把图片转换为二进制流
            NSData *imageData = UIImageJPEGRepresentation(imageDic[@"image"], 0.5);
            
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统事件作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *dateString = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString  stringWithFormat:@"%@.png", dateString];
            /*
             *该方法的参数
             1. appendPartWithFileData：要上传的照片[二进制流]
             2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
             3. fileName：要保存在服务器上的文件名
             4. mimeType：上传的文件的类型
             */
            NSString *name = imageDic[@"name"];
            //按照表单格式把二进制文件写入formData表单
            [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:@"image/png"]; //
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"---上传进度--- %@",uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"```上传成功``` %@",responseObject);
        if (success) {
            //            NSDictionary *dict =  [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            //            success(dict);
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"image error = %@", error);
        if (fail) {
            fail();
        }
    }];
}



+ (void)setWithMutableDict:(NSMutableDictionary *)dict key:(NSString *)key value:(id)value
{
    NSString *v = value;
    if (value != nil) {
        [dict setObject:v forKey:key];
    }
}

//时间戳转时间
+(NSString *)getTimeFromSp{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:1363948516];
    //    NSLog(@"1363948516  = %@",confromTimesp); //之后就可以对NSDate进行格式或处理
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSString *nowtimeStr = [formatter stringFromDate:confromTimesp];
    return nowtimeStr;
}

@end






