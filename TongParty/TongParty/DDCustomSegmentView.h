//
//  DDCustomSegmentView.h
//  TongParty
//
//  Created by 方冬冬 on 2017/9/14.
//  Copyright © 2017年 桐聚. All rights reserved.
//
//  切换视图，类似于系统的UISegmentControl

#import <UIKit/UIKit.h>

@interface DDCustomSegmentView : UIView

- (instancetype)initWithItemTitles:(NSArray *)itemTitles;

/**
 *  从0开始
 */
@property (nonatomic, copy) void(^DDCustomSegmentViewBtnClickHandle)(DDCustomSegmentView *segment, NSString *currentTitle, NSInteger currentIndex);

- (void)clickDefault;
@end
