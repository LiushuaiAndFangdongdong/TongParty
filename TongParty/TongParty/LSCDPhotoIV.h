//
//  LSCDPhotoIV.h
//  TongParty
//
//  Created by 刘帅 on 2017/11/27.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSCDPhotoIV : UIImageView
@property (nonatomic,   copy) void(^deleteClicked)(NSInteger idx);
@property (nonatomic, copy)NSString *imageUrl;
@property (nonatomic, assign)BOOL   isClose;
@property (nonatomic, assign)NSInteger   index;
@end
