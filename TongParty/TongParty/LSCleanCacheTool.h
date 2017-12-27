//
//  LSCleanCacheTool.h
//  TongParty
//
//  Created by 刘帅 on 2017/12/18.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^cleanCacheBlock)();
@interface LSCleanCacheTool : NSObject

/**
 *  清理缓存
 */
+(void)cleanCache:(cleanCacheBlock)block;
/**
 *  整个缓存目录的大小
 */
+(float)folderSizeAtPath;

@end
