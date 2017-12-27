//
//  DDAlbumCellView.h
//  TongParty
//
//  Created by 方冬冬 on 2017/9/25.
//  Copyright © 2017年 桐聚. All rights reserved.
//
//我的相册

#import <UIKit/UIKit.h>
#import "LSHisUserInfoModel.h"

@interface DDAlbumCellView : UIView
- (void)updateWithModel:(LSHisUserInfoModel *)model;
@end

