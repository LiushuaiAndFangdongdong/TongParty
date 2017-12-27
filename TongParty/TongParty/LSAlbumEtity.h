//
//  LSAlbumEtity.h
//  TongParty
//
//  Created by 刘帅 on 2017/12/4.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSAlbumEtity : NSObject

/**
 图片id
 */
@property(nonatomic,copy)NSString *id;

/**
 抓拍年月日
 */
@property(nonatomic,copy)NSString *uptime;

/**
 图片地址
 */
@property(nonatomic,copy)NSString *image;

/**
 图片标识
 */
@property(nonatomic,strong)NSIndexPath *indexpath;

@end

