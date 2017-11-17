
//
//  NSString+DDAdd.m
//  TongParty
//
//  Created by 方冬冬 on 2017/10/11.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "NSString+DDAdd.h"

@implementation NSString (DDAdd)
- (CGFloat)widthWithStringAttribute:(NSDictionary <NSString *, id> *)attribute {

    NSParameterAssert(attribute);

    CGFloat width = 0;

    if (self.length) {

        CGRect rect = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, 0)
                                         options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |
                       NSStringDrawingUsesFontLeading
                                      attributes:attribute
                                         context:nil];

        width = rect.size.width;
    }

    return width;
}
@end

