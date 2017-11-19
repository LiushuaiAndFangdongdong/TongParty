//
//  LSContentSortModel.m
//  TongParty
//
//  Created by 刘帅 on 2017/11/19.
//  Copyright © 2017年 桐聚. All rights reserved.
//

#import "LSContentSortModel.h"

@implementation LSContentSortModel
- (instancetype)initWithArray:(NSArray *)array {
    self = [super init];
    if (self) {
        self.label_array = array;
        self.isShowMore = NO;
    }
    return self;
}
@end
