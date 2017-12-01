//
//  LSCDDescriptionCellView.h
//  TongParty
//
//  Created by 刘帅 on 2017/10/28.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSCDPhotoIV.h"

@interface LSCDDescriptionCellView : UIView
@property (nonatomic,   copy) void(^selectPhotos)(LSCDPhotoIV *iv_photo);
@property (nonatomic,   copy) void(^deleteUpdate)(NSInteger index);
- (void)putPhotosWhitModel:(id )obj;
@end
