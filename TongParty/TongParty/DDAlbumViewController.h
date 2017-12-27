//
//  DDAlbumViewController.h
//  TongParty
//
//  Created by 方冬冬 on 2017/10/9.
//  Copyright © 2017年 桐聚. All rights reserved.
//
//我的相册

#import "DDBaseViewController.h"
typedef NS_ENUM(NSUInteger, DDAlbumViewControllerStyle) {
    /** 个人相册*/
    DDAlbumCurrentUserStyle = 0,
    /** 他人相册*/
    DDAlbumOtherUserStyle,
};
@interface DDAlbumViewController : DDBaseViewController
@property (nonatomic, assign)DDAlbumViewControllerStyle style;
@property (nonatomic, copy)NSString *fid;
@end

