//
//  LSQRScanView.h
//  TongParty
//
//  Created by 刘帅 on 2017/12/11.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSQRScanView : UIView
@property(nonatomic,strong)UIButton *lightButton;
@property(nonatomic,copy)void(^openPhotoLibrary)();
@property(nonatomic,copy)void(^openFlash)();
- (instancetype)initWithFrame:(CGRect)frame leftEdge:(CGFloat)edge;
- (void)lineStartAnimation;
- (void)lineStopAnimation;
@end
