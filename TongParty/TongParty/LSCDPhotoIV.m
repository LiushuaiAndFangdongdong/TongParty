//
//  LSCDPhotoIV.m
//  TongParty
//
//  Created by 刘帅 on 2017/11/27.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSCDPhotoIV.h"

@implementation LSCDPhotoIV

- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = imageUrl;
    if (_putImageOnImageView) {
        _putImageOnImageView(YES);
    }
}

@end
