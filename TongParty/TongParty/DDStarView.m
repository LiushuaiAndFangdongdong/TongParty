
//
//  DDStarView.m
//  TongParty
//
//  Created by 方冬冬 on 2017/12/21.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDStarView.h"

@interface DDStarView()
@property (nonatomic) CGRect oldRect;
@end

@implementation DDStarView

// 重写initWithFrame：方法
- (instancetype)initWithFrame:(CGRect)frame {
    
    if ( self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        // 星星的尺寸
        self.starSize = 20.0f;
        // 未点亮星星的颜色（可根据自己喜好设定）
        self.emptyColor = kRGBColor(167, 167, 167);
        // 点亮星星的颜色
        self.fullColor = kRGBColor(16, 130, 225);
        // 默认长度
        self.maxStar = 100;
    }
    return self;
}

//重绘视图
- (void)drawRect:(CGRect)rect {
    _oldRect = rect;

    CGContextRef context = UIGraphicsGetCurrentContext();

    NSString* stars = @"★★★★★";
    rect = self.bounds;
    UIFont *font = [UIFont boldSystemFontOfSize:_starSize];
    CGSize starSize = [stars sizeWithFont:font];
    rect.size = starSize;
    [_emptyColor set];
    [stars drawInRect:rect withFont:font];

    CGRect clip = rect;
    // 裁剪的宽度 = 点亮星星宽度 = （显示的星星数/总共星星数）*总星星的宽度
    clip.size.width = clip.size.width * _showStar / _maxStar;
    CGContextClipToRect(context,clip);
    [_fullColor set];
    [stars drawInRect:rect withFont:font];
}

- (void)setShowStar:(NSInteger)showStar {
    _showStar = showStar;
    [self setNeedsDisplay];
}

@end




