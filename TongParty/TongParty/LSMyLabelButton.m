//
//  LSMyLabelButton.m
//  TongParty
//
//  Created by 刘帅 on 2017/12/21.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSMyLabelButton.h"

@implementation LSMyLabelButton

- (instancetype)init {
    if (self = [super init]) {
        UIButton *delete_btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, DDFitWidth(15.f), DDFitHeight(15.f))];
        [self addSubview:delete_btn];
        delete_btn.backgroundColor = kBlackColor;
    }
    
    return self;
}

@end
