//
//  DDChairView.h
//  TongParty
//
//  Created by 方冬冬 on 2017/10/11.
//  Copyright © 2017年 桐聚. All rights reserved.
//
//椅子

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DDChairType) {
    /** 桌主椅子*/
    DDChairTypeHolder,
    /** 左边*/
    DDChairTypeLeft,
    /** 右边*/
    DDChairTypeRight,
    /** 下边*/
    DDChairTypeBottom
};

@interface DDChairView : UIView
@property (nonatomic, assign) DDChairType type;
- (void)updateAvatarWithImage:(NSString *)imagestr;
@end
