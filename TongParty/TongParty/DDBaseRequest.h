//
//  DDBaseRequest.h
//  TongParty
//
//  Created by 方冬冬 on 2017/9/15.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol DDBaseRequestReponseDelegate <NSObject>
@required
/** 如果不用block返回数据的话，这个方法必须实现*/
- (void)requestSuccessReponse:(BOOL)success response:(id)response message:(NSString *)message;
@end


typedef void(^DDAPIDicCompletion)(id response, BOOL success, NSString *message);


@interface DDBaseRequest : NSObject
@property (nonatomic, weak) id <DDBaseRequestReponseDelegate> tj_delegate;
/** 链接*/
@property (nonatomic, copy) NSString *tj_url;
/** 默认GET*/
@property (nonatomic, assign) BOOL tj_isPost;
/** 图片数组*/
@property (nonatomic, strong) NSArray <UIImage *>*tj_imageArray;

/** 构造方法*/
+ (instancetype)tj_request;
+ (instancetype)tj_requestWithUrl:(NSString *)tj_url;
+ (instancetype)tj_requestWithUrl:(NSString *)tj_url isPost:(BOOL)tj_isPost;
+ (instancetype)tj_requestWithUrl:(NSString *)tj_url isPost:(BOOL)tj_isPost delegate:(id <DDBaseRequestReponseDelegate>)nh_delegate;

/** 开始请求，如果设置了代理，不需要block回调*/
- (void)tj_sendRequest;
/** 开始请求，没有设置代理，或者设置了代理，需要block回调，block回调优先级高于代理*/
- (void)tj_sendRequestWithCompletion:(DDAPIDicCompletion)completion;

@end












