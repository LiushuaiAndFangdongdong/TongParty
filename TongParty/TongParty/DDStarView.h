//
//  DDStarView.h
//  TongParty
//
//  Created by 方冬冬 on 2017/12/21.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDStarView : UIView
// 根据字体大小来确定星星的大小
@property (nonatomic, assign) CGFloat starSize;
// 总共的长度
@property (nonatomic, assign) NSInteger maxStar;
//需要显示的星星的长度
@property (nonatomic, assign) NSInteger showStar;
//未点亮时候的颜色
@property (nonatomic, retain) UIColor *emptyColor;
//点亮的星星的颜色
@property (nonatomic, retain) UIColor *fullColor;
@end
