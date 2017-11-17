//
//  DDCircleView.h
//  TongParty
//
//  Created by 方冬冬 on 2017/9/21.
//  Copyright © 2017年 桐聚. All rights reserved.
//
//旋转罗盘

#import <UIKit/UIKit.h>
#import "DDDragImageView.h"

@interface DDCircleView : UIView
<
UIGestureRecognizerDelegate
>{
@private
    //圆的半径
    CGFloat radius;
    //圆心（在CircleView上的位置）
    CGPoint center;
    //平均角度
    CGFloat average_radina;
    //拖动的点
    CGPoint pointDrag;
    //拖动结束后间隔的个数
    NSInteger step;
}

@property(nonatomic, retain) NSMutableArray *arrImages;
// 中心view
@property (nonatomic, strong)UIImageView *centerImgView;
- (void)loadView;

@end
