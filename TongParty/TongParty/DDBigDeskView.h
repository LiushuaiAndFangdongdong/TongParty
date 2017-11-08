//
//  DDBigDeskView.h
//  TongParty
//
//  Created by 方冬冬 on 2017/10/13.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DDDeskShowType) {
    /**常规展示(有公告，无下边椅子)**/
    DDDeskShowTypeNormal     = 0,
    /**卡片展示(没有公告)**/
    DDDeskShowTypeCard       = 1,
    /**游客展示(有下边椅子)**/
    DDDeskShowTypeVisitor    = 2,
};

@interface DDBigDeskView : UIView
@property (nonatomic, assign) DDDeskShowType type;
@end
