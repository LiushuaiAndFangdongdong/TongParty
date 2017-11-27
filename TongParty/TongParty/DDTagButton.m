//
//  DDTagButton.m
//  TongParty
//
//  Created by 方冬冬 on 2017/11/22.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDTagButton.h"
#import "DDTag.h"

@implementation DDTagButton

+ (instancetype)buttonWithTag: (DDTag *)tag {
    DDTagButton *btn = [super buttonWithType:UIButtonTypeCustom];
    
    if (tag.attributedText) {
        [btn setAttributedTitle: tag.attributedText forState: UIControlStateNormal];
    } else {
        [btn setTitle: tag.text forState:UIControlStateNormal];
        [btn setTitleColor: tag.textColor forState: UIControlStateNormal];
        btn.titleLabel.font = tag.font ?: [UIFont systemFontOfSize: tag.fontSize];
    }
    
    if (tag.slcTextColor) {
        [btn setTitleColor: tag.slcTextColor forState: UIControlStateSelected];
    }
    if (tag.bgColor) {
        btn.backgroundColor = tag.bgColor;
    }
    
    if (tag.slcColor) {
        [btn setBackgroundImage:[self imageWithColor:tag.slcColor] forState:UIControlStateSelected];
    }
    if (tag.nrmColor) {
        [btn setBackgroundImage:[self imageWithColor:tag.nrmColor] forState:UIControlStateNormal];
    }
    
    
    btn.contentEdgeInsets = tag.padding;
    btn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    if (tag.bgImg) {
        [btn setBackgroundImage: tag.bgImg forState: UIControlStateNormal];
    }
    
    if (tag.borderColor) {
        btn.layer.borderColor = tag.borderColor.CGColor;
    }
    
    if (tag.borderWidth) {
        btn.layer.borderWidth = tag.borderWidth;
    }
    
    btn.userInteractionEnabled = tag.enable;
    if (tag.enable) {
        UIColor *highlightedBgColor = tag.highlightedBgColor ?: [self darkerColor:btn.backgroundColor];
        [btn setBackgroundImage:[self imageWithColor:highlightedBgColor] forState:UIControlStateHighlighted];
    }
    
    btn.layer.cornerRadius = tag.cornerRadius;
    btn.layer.masksToBounds = YES;
    
    return btn;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIColor *)darkerColor:(UIColor *)color {
    CGFloat h, s, b, a;
    if ([color getHue:&h saturation:&s brightness:&b alpha:&a])
        return [UIColor colorWithHue:h
                          saturation:s
                          brightness:b * 0.85
                               alpha:a];
    return color;
}


@end
