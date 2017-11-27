//
//  DDTag.m
//  TongParty
//
//  Created by 方冬冬 on 2017/11/22.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "DDTag.h"

static const CGFloat kDefaultFontSize = 13.0;

@implementation DDTag

- (instancetype)init {
    self = [super init];
    if (self) {
        _fontSize = kDefaultFontSize;
        _textColor = [UIColor blackColor];
        _bgColor = [UIColor whiteColor];
        _enable = YES;
    }
    return self;
}

- (instancetype)initWithText: (NSString *)text {
    self = [self init];
    if (self) {
        _text = text;
    }
    return self;
}

+ (instancetype)tagWithText: (NSString *)text {
    return [[self alloc] initWithText: text];
}

@end










