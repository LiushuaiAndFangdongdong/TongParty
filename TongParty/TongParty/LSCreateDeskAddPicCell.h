//
//  LSCreateDeskAddPicCell.h
//  TongParty
//
//  Created by 刘帅 on 2017/12/23.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDBaseTableViewCell.h"
#import "LSCDPhotoIV.h"
@interface LSCreateDeskAddPicCell : DDBaseTableViewCell
- (void)updatePhotoWithArray:(NSArray *)photosArr;
@property (nonatomic,   copy) void(^deleteClicked)(NSInteger indx);
@property (nonatomic,   copy) void(^selectPhotos)(LSCDPhotoIV *iv_photo);
@end
